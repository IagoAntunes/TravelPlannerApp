import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:travelplannerapp/core/components/c_button.dart';
import 'package:travelplannerapp/core/style/app_style_colors.dart';
import 'package:travelplannerapp/src/features/travel/domain/model/travel_model.dart';

import '../../../../../../../core/style/app_style_text.dart';
import '../blocs/activity_travel_cubit.dart';
import '../states/activity_travel_state.dart';

class ActivityTravelPage extends StatefulWidget {
  ActivityTravelPage({
    super.key,
    required this.travel,
  });

  final TravelModel travel;

  @override
  State<ActivityTravelPage> createState() => _ActivityTravelPageState();
}

class _ActivityTravelPageState extends State<ActivityTravelPage> {
  final _cubit = GetIt.I.get<ActivityTravelCubit>();

  List<String> dateList = [];

  @override
  void initState() {
    super.initState();
    generateDates();
    _cubit.fetchActivities(widget.travel.id);
  }

  void generateDates() {
    DateFormat dateFormat = DateFormat("dd/MM/yyyy");
    var startDate = dateFormat.parse(widget.travel.startDate);
    var endDate = dateFormat.parse(widget.travel.endDate);
    while (startDate.isBefore(endDate) || startDate.isAtSameMomentAs(endDate)) {
      dateList.add(dateFormat.format(startDate));
      startDate = startDate.add(const Duration(days: 1));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _cubit.fetchActivities(widget.travel.id);
        },
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.only(right: 16, bottom: 8, top: 8),
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
                    Text(
                      "${widget.travel.startDate.split('/')[0]}/${widget.travel.startDate.split('/')[1]} a ${widget.travel.endDate.split('/')[0]}/${widget.travel.endDate.split('/')[1]}",
                      style: AppStyleText.bodySm(context)
                          .copyWith(color: AppStyleColors.zinc100),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              Expanded(
                child: BlocBuilder<ActivityTravelCubit, IActivityTravelState>(
                  bloc: _cubit,
                  builder: (context, state) {
                    print(state);
                    return switch (state) {
                      LoadingActivityTravelState() => Center(
                          child: CircularProgressIndicator(
                            color: AppStyleColors.lime300,
                          ),
                        ),
                      (SuccessActivityTravelState successState) => switch (
                            successState.type) {
                          EnumActivityTravelType.activities => Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Atividades",
                                      style: AppStyleText.headingLg(context)
                                          .copyWith(
                                              color: AppStyleColors.zinc100),
                                    ),
                                    CButton.icon(
                                      text: 'Nova Atividade',
                                      icon: Icons.add,
                                      iconAlignment: IconAlignment.end,
                                      onPressed: () {
                                        //
                                      },
                                    )
                                  ],
                                ),
                                const SizedBox(height: 24),
                                Expanded(
                                  child: ListView.separated(
                                    itemCount: dateList.length,
                                    separatorBuilder: (context, index) =>
                                        const SizedBox(height: 16),
                                    itemBuilder: (_, indexDate) {
                                      return Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Dia ${dateList[indexDate].split('/')[0]}",
                                            style:
                                                AppStyleText.headingMd(context)
                                                    .copyWith(
                                              color: AppStyleColors.zinc100,
                                            ),
                                          ),
                                          const SizedBox(height: 8),
                                          ListView.builder(
                                            shrinkWrap: true,
                                            physics:
                                                const ClampingScrollPhysics(),
                                            itemCount: successState
                                                    .groupedActivities[
                                                        dateList[indexDate]]
                                                    ?.length ??
                                                0,
                                            itemBuilder:
                                                (_, indexDayActivity) =>
                                                    Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                horizontal: 16,
                                                vertical: 8,
                                              ),
                                              decoration: BoxDecoration(
                                                color: AppStyleColors.zinc900,
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                              ),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Icon(
                                                        Icons
                                                            .check_circle_outline,
                                                        color: AppStyleColors
                                                            .lime300,
                                                      ),
                                                      const SizedBox(width: 16),
                                                      Text(
                                                        successState
                                                            .groupedActivities[
                                                                dateList[
                                                                    indexDate]]!
                                                            .elementAt(
                                                                indexDayActivity)
                                                            .name,
                                                        style:
                                                            AppStyleText.bodyMd(
                                                                    context)
                                                                .copyWith(
                                                          color: AppStyleColors
                                                              .zinc100,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Text(
                                                    "${successState.groupedActivities[dateList[indexDate]]!.elementAt(indexDayActivity).date.split(' ')[1]}h",
                                                    style: AppStyleText.bodyMd(
                                                            context)
                                                        .copyWith(
                                                      color: AppStyleColors
                                                          .zinc100,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          )
                                        ],
                                      );
                                    },
                                  ),
                                )
                              ],
                            ),
                          EnumActivityTravelType.details => Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                    child: ListView.builder(
                                  itemCount:
                                      successState.groupedActivities.length,
                                  itemBuilder: (context, index) =>
                                      const Text("Oi"),
                                ))
                              ],
                            ),
                        },
                      _ => Container(),
                    };
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar:
          BlocBuilder<ActivityTravelCubit, IActivityTravelState>(
        bloc: _cubit,
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
                        _cubit.changeActivityTravelType(
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
                        _cubit.changeActivityTravelType(
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
      ),
    );
  }
}
