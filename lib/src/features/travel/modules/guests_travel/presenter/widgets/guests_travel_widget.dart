import 'package:flutter/material.dart';
import 'package:travelplannerapp/src/features/travel/presenter/blocs/travel_info_cubit.dart';

import '../../../../../../../core/style/app_style_colors.dart';
import '../../../../../../../core/style/app_style_text.dart';

class GuestsTravelWidget extends StatelessWidget {
  const GuestsTravelWidget({
    super.key,
    required this.travelInfoCubit,
  });

  final TravelInfoCubit travelInfoCubit;

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
    return ConstrainedBox(
      constraints:
          BoxConstraints(maxHeight: MediaQuery.sizeOf(context).height * 0.4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Convidados",
            style: AppStyleText.headingLg(context)
                .copyWith(color: AppStyleColors.zinc50),
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
              key: Key(travelInfoCubit.travel.guests![index].id.toString()),
              onDismissed: (direction) {
                //
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
          )
        ],
      ),
    );
  }
}
