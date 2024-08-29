import 'package:flutter/material.dart';
import 'package:travelplannerapp/src/features/travel/modules/guests_travel/presenter/widgets/guests_travel_widget.dart';
import '../../../../../core/style/app_style_colors.dart';
import '../blocs/travel_info_cubit.dart';
import '../../modules/links_travel/presenter/widgets/links_travel_widget.dart';

class TravelDetailsWidget extends StatelessWidget {
  const TravelDetailsWidget({
    super.key,
    required this.travelInfoCubit,
  });

  final TravelInfoCubit travelInfoCubit;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          LinksTravelWidget(
            travelInfoCubit: travelInfoCubit,
          ),
          Divider(
            color: AppStyleColors.zinc800,
          ),
          GuestsTravelWidget(
            travelInfoCubit: travelInfoCubit,
          )
        ],
      ),
    );
  }
}
