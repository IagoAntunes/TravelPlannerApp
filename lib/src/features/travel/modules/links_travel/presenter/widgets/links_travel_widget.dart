import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:travelplannerapp/src/features/travel/modules/links_travel/presenter/states/links_travel_state.dart';

import '../../../../../../../core/components/c_button.dart';
import '../../../../../../../core/style/app_style_colors.dart';
import '../../../../../../../core/style/app_style_text.dart';
import '../../../../domain/model/link_model.dart';
import '../../../../presenter/blocs/travel_info_cubit.dart';
import '../links_travel_cubit.dart';
import 'create_link_bottom_sheet_widget.dart';

class LinksTravelWidget extends StatelessWidget {
  LinksTravelWidget({
    super.key,
    required this.travelInfoCubit,
  });

  final TravelInfoCubit travelInfoCubit;

  final _linksTravelCubit = GetIt.I.get<LinksTravelCubit>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LinksTravelCubit, ILinksTravelState>(
      bloc: _linksTravelCubit,
      listener: (context, state) async {
        if (state is SuccessDeletedLinkTravelListener) {
          travelInfoCubit.travel.links!
              .removeWhere((element) => element.id == state.linkId);
          _linksTravelCubit.emitIdle();
        }
      },
      listenWhen: (context, state) => state is ILinksTravelListener,
      buildWhen: (context, state) => state is! ILinksTravelListener,
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Links Importantes",
              style: AppStyleText.headingLg(context)
                  .copyWith(color: AppStyleColors.zinc50),
            ),
            if (travelInfoCubit.travel.links?.isEmpty ?? true)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.link_outlined,
                        color: AppStyleColors.zinc400,
                        size: 32,
                      ),
                      Text(
                        "Nenhum link adicionado",
                        style: AppStyleText.bodyMd(context)
                            .copyWith(color: AppStyleColors.zinc400),
                      ),
                    ],
                  ),
                ),
              ),
            ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: MediaQuery.sizeOf(context).height * 0.4,
              ),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: travelInfoCubit.travel.links?.length ?? 0,
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
                  key: Key(travelInfoCubit.travel.links![index].id.toString()),
                  onDismissed: (direction) {
                    _linksTravelCubit
                        .deleteLink(travelInfoCubit.travel.links![index].id);
                  },
                  child: ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text(
                      travelInfoCubit.travel.links![index].name,
                      style: AppStyleText.headingXs(context)
                          .copyWith(color: AppStyleColors.zinc100),
                    ),
                    subtitle: Text(
                      travelInfoCubit.travel.links![index].url,
                      style: AppStyleText.bodyMd(context)
                          .copyWith(color: AppStyleColors.zinc400),
                    ),
                    trailing: Icon(
                      Icons.link,
                      color: AppStyleColors.zinc400,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: CButton.icon(
                text: 'Cadastrar novo link',
                textColor: AppStyleColors.zinc200,
                icon: Icons.add_outlined,
                iconColor: AppStyleColors.zinc200,
                backgroundColor: AppStyleColors.zinc800,
                onPressed: () async {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    builder: (context) => CreateLinkModalBottomSheet(
                      travelId: travelInfoCubit.travel.id,
                    ),
                  ).then(
                    (value) {
                      if (value != null && value.runtimeType == LinkModel) {
                        travelInfoCubit.travel.links!.add(value);
                        _linksTravelCubit.emitIdle();
                      }
                    },
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
