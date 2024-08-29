import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:travelplannerapp/src/features/travel/modules/create_travel/presenter/widgets/select_guests_widget.dart';
import 'package:travelplannerapp/src/features/travel/modules/guests_travel/presenter/blocs/guest_travel_cubit.dart';
import 'package:travelplannerapp/src/features/travel/presenter/blocs/travel_info_cubit.dart';

import '../../../../../../../core/components/c_button.dart';
import '../../../../../../../core/style/app_style_colors.dart';
import '../../../../../../../core/style/app_style_text.dart';
import '../states/guest_travel_state.dart';

class GuestsTravelWidget extends StatelessWidget {
  GuestsTravelWidget({
    super.key,
    required this.travelInfoCubit,
  });

  final TravelInfoCubit travelInfoCubit;

  final _guestTravelCubit = GetIt.I.get<GuestTravelCubit>();

  IconData _statusIconGuest(String status) {
    if (status == "PENDING") {
      return Icons.circle_outlined;
    } else if (status == "ACCEPTED") {
      return Icons.check_circle;
    } else {
      return Icons.check_circle;
    }
  }

  Color _statusColorGuest(String status) {
    if (status == "PENDING") {
      return Colors.orange;
    } else if (status == "ACCEPTED") {
      return AppStyleColors.lime300;
    } else {
      return Colors.red;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer(
        bloc: _guestTravelCubit,
        listener: (context, state) {
          if (state is SuccessCreatedGuestTravelListener) {
            travelInfoCubit.travel.guests?.addAll(state.guests);
            _guestTravelCubit.updateList();
          } else if (state is SuccessDeletedGuestTravelListener) {
            travelInfoCubit.travel.guests
                ?.removeWhere((element) => element.id == state.guestId);
            _guestTravelCubit.updateList();
          }
        },
        listenWhen: (previous, current) => current is IGuestTravelListener,
        buildWhen: (previous, current) => current is! IGuestTravelListener,
        builder: (context, state) {
          return ConstrainedBox(
            constraints: BoxConstraints(
                maxHeight: MediaQuery.sizeOf(context).height * 0.4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Convidados",
                  style: AppStyleText.headingLg(context)
                      .copyWith(color: AppStyleColors.zinc50),
                ),
                if (travelInfoCubit.travel.guests?.isEmpty ?? true)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.group_outlined,
                            color: AppStyleColors.zinc400,
                            size: 32,
                          ),
                          Text(
                            "Nenhum Convidado",
                            style: AppStyleText.bodyMd(context)
                                .copyWith(color: AppStyleColors.zinc400),
                          ),
                        ],
                      ),
                    ),
                  ),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: travelInfoCubit.travel.guests?.length ?? 0,
                  itemBuilder: (context, index) => Dismissible(
                    direction: DismissDirection.startToEnd,
                    background: Container(
                      color: Theme.of(context).colorScheme.error,
                      alignment: Alignment.centerLeft,
                      child: Icon(
                        Icons.delete_outline,
                        color: AppStyleColors.white,
                      ),
                    ),
                    key: Key(
                        travelInfoCubit.travel.guests![index].id.toString()),
                    onDismissed: (direction) {
                      _guestTravelCubit.deleteGuest(
                          travelInfoCubit.travel.guests![index].id);
                    },
                    child: ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Text(
                        travelInfoCubit.travel.guests![index].name,
                        style: AppStyleText.headingXs(context)
                            .copyWith(color: AppStyleColors.zinc100),
                      ),
                      subtitle: Text(
                        travelInfoCubit.travel.guests![index].email,
                        style: AppStyleText.bodyMd(context)
                            .copyWith(color: AppStyleColors.zinc400),
                      ),
                      trailing: Icon(
                        _statusIconGuest(
                          travelInfoCubit.travel.guests![index].status,
                        ),
                        color: _statusColorGuest(
                          travelInfoCubit.travel.guests![index].status,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: CButton.icon(
                    text: 'Convidar',
                    textColor: AppStyleColors.zinc200,
                    icon: Icons.add_outlined,
                    iconColor: AppStyleColors.zinc200,
                    backgroundColor: AppStyleColors.zinc800,
                    onPressed: () async {
                      List<String> listEmails = [];
                      await showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        builder: (context) => SelectGuestsWidget(
                          emailGuests: listEmails,
                        ),
                      ).then(
                        (value) {
                          if (listEmails.isNotEmpty) {
                            _guestTravelCubit.createGuest(
                                listEmails, travelInfoCubit.travel.id);
                          }
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        });
  }
}
