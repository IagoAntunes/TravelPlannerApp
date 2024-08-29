import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travelplannerapp/src/features/travel/presenter/states/travel_info_state.dart';

import '../../src/features/travel/presenter/blocs/travel_info_cubit.dart';
import '../components/c_button.dart';
import '../style/app_style_colors.dart';

class BottomNavigationBarWidget extends StatelessWidget {
  const BottomNavigationBarWidget({
    super.key,
    required this.travelInfoCubit,
  });

  final TravelInfoCubit travelInfoCubit;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TravelInfoCubit, ITravelInfoState>(
      bloc: travelInfoCubit,
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.only(left: 32, right: 32, bottom: 16),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            decoration: BoxDecoration(
              color: AppStyleColors.zinc900,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: CButton.icon(
                    text: "Atividades",
                    icon: Icons.date_range,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    iconColor: state.type == EnumActivityTravelType.activities
                        ? null
                        : AppStyleColors.zinc200,
                    textColor: state.type == EnumActivityTravelType.activities
                        ? null
                        : AppStyleColors.zinc200,
                    backgroundColor:
                        state.type == EnumActivityTravelType.activities
                            ? null
                            : AppStyleColors.zinc800,
                    onPressed: () {
                      travelInfoCubit.changeActivityTravelType(
                        EnumActivityTravelType.activities,
                      );
                    },
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: CButton.icon(
                    text: "Detalhes",
                    icon: Icons.info_outline,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    iconColor: state.type == EnumActivityTravelType.details
                        ? null
                        : AppStyleColors.zinc200,
                    textColor: state.type == EnumActivityTravelType.details
                        ? null
                        : AppStyleColors.zinc200,
                    backgroundColor:
                        state.type == EnumActivityTravelType.details
                            ? null
                            : AppStyleColors.zinc800,
                    onPressed: () {
                      travelInfoCubit.changeActivityTravelType(
                        EnumActivityTravelType.details,
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
