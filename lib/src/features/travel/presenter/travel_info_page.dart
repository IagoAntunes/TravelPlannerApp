import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:travelplannerapp/core/style/app_style_colors.dart';
import 'package:travelplannerapp/src/features/travel/domain/model/travel_model.dart';
import 'package:travelplannerapp/src/features/travel/modules/activities_travel/presenter/widgets/list_activities_travel_widget.dart';
import 'package:travelplannerapp/src/features/travel/presenter/widgets/travel_details_widget.dart';
import 'package:travelplannerapp/src/features/travel/presenter/blocs/travel_info_cubit.dart';

import '../../../../core/style/app_style_text.dart';
import '../../../../core/widgets/bottom_navigation_bar_widget.dart';
import 'states/travel_info_state.dart';

class TravelInfoPage extends StatefulWidget {
  const TravelInfoPage({
    super.key,
    required this.travel,
  });

  final TravelModel travel;

  @override
  State<TravelInfoPage> createState() => _TravelInfoPageState();
}

class _TravelInfoPageState extends State<TravelInfoPage> {
  final _travelInfoCubit = GetIt.I.get<TravelInfoCubit>();

  @override
  void initState() {
    super.initState();
    _travelInfoCubit.initTravel(widget.travel);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: BlocConsumer<TravelInfoCubit, ITravelInfoState>(
              bloc: _travelInfoCubit,
              listener: (context, state) {
                if (state is LoadingDeleteTravelInfoListener) {
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (context) => const Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                } else if (state is SuccessDeleteTravelInfoListener) {
                  Navigator.pop(context);
                  Navigator.pop(context, true);
                }
              },
              listenWhen: (previous, current) => current is ITravelInfoListener,
              buildWhen: (previous, current) => current is! ITravelInfoListener,
              builder: (context, state) {
                return Column(
                  children: [
                    Container(
                      padding:
                          const EdgeInsets.only(right: 16, bottom: 8, top: 8),
                      decoration: BoxDecoration(
                        color: AppStyleColors.zinc900,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          const BackButton(),
                          Expanded(
                            child: Row(
                              children: [
                                Icon(
                                  Icons.location_on_outlined,
                                  color: AppStyleColors.zinc400,
                                ),
                                Text(
                                  widget.travel.localName,
                                  style: AppStyleText.bodyMd(context)
                                      .copyWith(color: AppStyleColors.zinc100),
                                ),
                              ],
                            ),
                          ),
                          Row(
                            children: [
                              Text(
                                "${widget.travel.startDate.split('/')[0]}/${widget.travel.startDate.split('/')[1]} a ${widget.travel.endDate.split('/')[0]}/${widget.travel.endDate.split('/')[1]}",
                                style: AppStyleText.bodySm(context)
                                    .copyWith(color: AppStyleColors.zinc100),
                              ),
                              const SizedBox(width: 8),
                              PopupMenuButton(
                                color: AppStyleColors.zinc800,
                                elevation: 0.0,
                                style: ButtonStyle(
                                  backgroundColor: WidgetStatePropertyAll(
                                      AppStyleColors.zinc800),
                                  shape: WidgetStatePropertyAll(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  iconColor: WidgetStatePropertyAll(
                                      AppStyleColors.zinc100),
                                ),
                                itemBuilder: (context) => [
                                  PopupMenuItem(
                                    onTap: () {
                                      _travelInfoCubit
                                          .deleteTravel(widget.travel.id);
                                    },
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.delete_outline,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .error,
                                        ),
                                        const SizedBox(width: 8),
                                        const Text(
                                          "Deletar",
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 32),
                    Expanded(
                      child: BlocBuilder<TravelInfoCubit, ITravelInfoState>(
                        bloc: _travelInfoCubit,
                        builder: (context, state) {
                          return switch (state.type) {
                            EnumActivityTravelType.activities =>
                              ListActivitiesTravelWidget(
                                travelInfoCubit: _travelInfoCubit,
                              ),
                            EnumActivityTravelType.details =>
                              TravelDetailsWidget(
                                travelInfoCubit: _travelInfoCubit,
                              ),
                          };
                        },
                      ),
                    ),
                  ],
                );
              }),
        ),
      ),
      bottomNavigationBar: BottomNavigationBarWidget(
        travelInfoCubit: _travelInfoCubit,
      ),
    );
  }
}
