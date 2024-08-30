import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:travelplannerapp/src/features/travel/modules/activities_travel/presenter/states/activity_travel_state.dart';
import 'package:travelplannerapp/src/features/travel/presenter/blocs/travel_info_cubit.dart';

import '../../../../../../../core/components/c_button.dart';
import '../../../../../../../core/style/app_style_colors.dart';
import '../../../../../../../core/style/app_style_text.dart';
import '../blocs/activity_travel_cubit.dart';
import 'create_activity_widget.dart';

class ListActivitiesTravelWidget extends StatefulWidget {
  const ListActivitiesTravelWidget({
    super.key,
    required this.travelInfoCubit,
  });

  final TravelInfoCubit travelInfoCubit;

  @override
  State<ListActivitiesTravelWidget> createState() =>
      _ListActivitiesTravelWidgetState();
}

class _ListActivitiesTravelWidgetState
    extends State<ListActivitiesTravelWidget> {
  List<String> dateList = [];

  final _cubit = GetIt.I.get<ActivityTravelCubit>();

  @override
  void initState() {
    super.initState();
    _cubit.fetchActivities(widget.travelInfoCubit.travel.id);
    generateDates();
  }

  void generateDates() {
    DateFormat dateFormat = DateFormat("dd/MM/yyyy");
    var startDate = dateFormat.parse(widget.travelInfoCubit.travel.startDate);
    var endDate = dateFormat.parse(widget.travelInfoCubit.travel.endDate);
    while (startDate.isBefore(endDate) || startDate.isAtSameMomentAs(endDate)) {
      dateList.add(dateFormat.format(startDate));
      startDate = startDate.add(const Duration(days: 1));
    }
  }

  bool activityHasAlreadyPassed(String dateTime) {
    var now = DateTime.now();
    var aux = dateTime.split(' ');
    String date = aux[0];
    String hour = '23:59';
    if (aux.length > 1) {
      hour = aux[1];
    }
    var activityDate = DateFormat("dd/MM/yyyy HH:mm").parse("$date $hour");
    return now.isAfter(activityDate);
  }

  String _getWeekdayName(DateTime date) {
    const weekdays = [
      'Segunda-feira',
      'Terça-feira',
      'Quarta-feira',
      'Quinta-feira',
      'Sexta-feira',
      'Sábado',
      'Domingo'
    ];
    return weekdays[date.weekday - 1];
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ActivityTravelCubit, IActivityTravelState>(
      bloc: _cubit,
      builder: (context, state) {
        return switch (state) {
          LoadingActivityTravelState() => const Center(
              child: CircularProgressIndicator(),
            ),
          FailureActivityTravelState() => const Center(
              child: Text("Ocorreu um Problema"),
            ),
          (SuccessActivityTravelState successState) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Atividades",
                      style: AppStyleText.headingLg(context)
                          .copyWith(color: AppStyleColors.zinc100),
                    ),
                    CButton.icon(
                      text: 'Nova Atividade',
                      icon: Icons.add,
                      iconAlignment: IconAlignment.end,
                      stateTypeButton: widget.travelInfoCubit.hasPermission()
                          ? StateTypeButton.idle
                          : StateTypeButton.unable,
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          builder: (context) => CreateActivityWidget(
                            travelId: widget.travelInfoCubit.travel.id,
                            startDateTravel:
                                widget.travelInfoCubit.travel.startDate,
                            endDateTravel:
                                widget.travelInfoCubit.travel.endDate,
                          ),
                        ).then(
                          (value) {
                            if (value != null && value == true) {
                              _cubit.fetchActivities(
                                widget.travelInfoCubit.travel.id,
                              );
                            }
                          },
                        );
                      },
                    )
                  ],
                ),
                const SizedBox(height: 24),
                Expanded(
                  child: ListView.separated(
                    itemCount: dateList.length,
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 24),
                    itemBuilder: (_, indexDate) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                "Dia ${dateList[indexDate].split('/')[0]}",
                                style: AppStyleText.headingMd(context).copyWith(
                                  color: activityHasAlreadyPassed(
                                    dateList[indexDate],
                                  )
                                      ? AppStyleColors.zinc400
                                      : AppStyleColors.zinc100,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                _getWeekdayName(DateFormat("dd/MM/yyyy")
                                    .parse(dateList[indexDate])),
                                style: AppStyleText.bodySm(context).copyWith(
                                  color: AppStyleColors.zinc500,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          if (successState
                                  .groupedActivities[dateList[indexDate]]
                                  ?.isEmpty ??
                              true)
                            Text(
                              "Nenhuma atividade cadastrada nessa data. ",
                              style: AppStyleText.bodySm(context).copyWith(
                                color: AppStyleColors.zinc500,
                              ),
                            ),
                          ListView.separated(
                            shrinkWrap: true,
                            physics: const ClampingScrollPhysics(),
                            itemCount: successState
                                    .groupedActivities[dateList[indexDate]]
                                    ?.length ??
                                0,
                            separatorBuilder: (context, index) =>
                                const SizedBox(height: 12),
                            itemBuilder: (_, indexDayActivity) => Dismissible(
                              direction: DismissDirection.startToEnd,
                              background: Container(
                                color: Theme.of(context).colorScheme.error,
                                alignment: Alignment.centerLeft,
                                child: Icon(
                                  Icons.delete_outline,
                                  color: AppStyleColors.white,
                                ),
                              ),
                              key: Key(successState
                                  .groupedActivities[dateList[indexDate]]!
                                  .elementAt(indexDayActivity)
                                  .id
                                  .toString()),
                              onDismissed:
                                  widget.travelInfoCubit.hasPermission()
                                      ? (direction) {
                                          _cubit.deleteActivity(
                                            successState.groupedActivities[
                                                    dateList[indexDate]]!
                                                .elementAt(indexDayActivity)
                                                .id,
                                          );
                                        }
                                      : null,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 8,
                                ),
                                decoration: BoxDecoration(
                                  color: AppStyleColors.zinc900,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(
                                          activityHasAlreadyPassed(
                                            successState.groupedActivities[
                                                    dateList[indexDate]]!
                                                .elementAt(indexDayActivity)
                                                .date,
                                          )
                                              ? Icons.check_circle_outline
                                              : Icons.radio_button_unchecked,
                                          color: activityHasAlreadyPassed(
                                            successState.groupedActivities[
                                                    dateList[indexDate]]!
                                                .elementAt(indexDayActivity)
                                                .date,
                                          )
                                              ? AppStyleColors.zinc200
                                              : AppStyleColors.lime300,
                                        ),
                                        const SizedBox(width: 16),
                                        Text(
                                          successState.groupedActivities[
                                                  dateList[indexDate]]!
                                              .elementAt(indexDayActivity)
                                              .name,
                                          style: AppStyleText.bodyMd(context)
                                              .copyWith(
                                            color: activityHasAlreadyPassed(
                                              successState.groupedActivities[
                                                      dateList[indexDate]]!
                                                  .elementAt(indexDayActivity)
                                                  .date,
                                            )
                                                ? AppStyleColors.zinc400
                                                : AppStyleColors.zinc100,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      "${successState.groupedActivities[dateList[indexDate]]!.elementAt(indexDayActivity).date.split(' ')[1]}h",
                                      style:
                                          AppStyleText.bodyMd(context).copyWith(
                                        color: activityHasAlreadyPassed(
                                          successState.groupedActivities[
                                                  dateList[indexDate]]!
                                              .elementAt(indexDayActivity)
                                              .date,
                                        )
                                            ? AppStyleColors.zinc400
                                            : AppStyleColors.zinc100,
                                      ),
                                    ),
                                  ],
                                ),
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
          _ => Container(),
        };
      },
    );
  }
}
