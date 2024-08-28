import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:travelplannerapp/core/components/c_button.dart';
import 'package:travelplannerapp/core/style/app_style_colors.dart';
import 'package:travelplannerapp/src/features/travel/domain/model/travel_model.dart';
import 'package:travelplannerapp/src/features/travel/modules/activities_travel/presenter/widgets/create_activity_widget.dart';

import '../../../../../../../core/style/app_style_text.dart';
import '../blocs/activity_travel_cubit.dart';
import '../states/activity_travel_state.dart';

class ActivityTravelPage extends StatefulWidget {
  const ActivityTravelPage({
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
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
                            backgroundColor:
                                WidgetStatePropertyAll(AppStyleColors.zinc800),
                            shape: WidgetStatePropertyAll(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            iconColor:
                                WidgetStatePropertyAll(AppStyleColors.zinc100),
                          ),
                          itemBuilder: (context) => [
                            PopupMenuItem(
                              onTap: () async {
                                showDialog(
                                  context: context,
                                  barrierDismissible: false,
                                  builder: (context) => const Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                );
                                var deleted =
                                    await _cubit.deleteTravel(widget.travel.id);
                                Navigator.pop(context);
                                Navigator.pop(context, deleted);
                              },
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.delete_outline,
                                    color: Theme.of(context).colorScheme.error,
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
                child: BlocBuilder<ActivityTravelCubit, IActivityTravelState>(
                  bloc: _cubit,
                  builder: (context, state) {
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
                                        showModalBottomSheet(
                                          context: context,
                                          isScrollControlled: true,
                                          builder: (context) =>
                                              CreateActivityWidget(
                                            travelId: widget.travel.id,
                                            startDateTravel:
                                                widget.travel.startDate,
                                            endDateTravel:
                                                widget.travel.endDate,
                                          ),
                                        ).then(
                                          (value) {
                                            if (value != null &&
                                                value == true) {
                                              _cubit.fetchActivities(
                                                widget.travel.id,
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                "Dia ${dateList[indexDate].split('/')[0]}",
                                                style: AppStyleText.headingMd(
                                                        context)
                                                    .copyWith(
                                                  color:
                                                      activityHasAlreadyPassed(
                                                    dateList[indexDate],
                                                  )
                                                          ? AppStyleColors
                                                              .zinc400
                                                          : AppStyleColors
                                                              .zinc100,
                                                ),
                                              ),
                                              const SizedBox(width: 8),
                                              Text(
                                                _getWeekdayName(DateFormat(
                                                        "dd/MM/yyyy")
                                                    .parse(
                                                        dateList[indexDate])),
                                                style:
                                                    AppStyleText.bodySm(context)
                                                        .copyWith(
                                                  color: AppStyleColors.zinc500,
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 8),
                                          if (successState
                                                  .groupedActivities[
                                                      dateList[indexDate]]
                                                  ?.isEmpty ??
                                              true)
                                            Text(
                                              "Nenhuma atividade cadastrada nessa data. ",
                                              style:
                                                  AppStyleText.bodySm(context)
                                                      .copyWith(
                                                color: AppStyleColors.zinc500,
                                              ),
                                            ),
                                          ListView.separated(
                                            shrinkWrap: true,
                                            physics:
                                                const ClampingScrollPhysics(),
                                            itemCount: successState
                                                    .groupedActivities[
                                                        dateList[indexDate]]
                                                    ?.length ??
                                                0,
                                            separatorBuilder:
                                                (context, index) =>
                                                    const SizedBox(height: 12),
                                            itemBuilder:
                                                (_, indexDayActivity) =>
                                                    Dismissible(
                                              direction:
                                                  DismissDirection.startToEnd,
                                              background: Container(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .error,
                                                alignment: Alignment.centerLeft,
                                                child: Icon(
                                                  Icons.delete_outline,
                                                  color: AppStyleColors.white,
                                                ),
                                              ),
                                              key: Key(successState
                                                  .groupedActivities[
                                                      dateList[indexDate]]!
                                                  .elementAt(indexDayActivity)
                                                  .id
                                                  .toString()),
                                              onDismissed: (direction) {
                                                _cubit.deleteActivity(
                                                  successState
                                                      .groupedActivities[
                                                          dateList[indexDate]]!
                                                      .elementAt(
                                                          indexDayActivity)
                                                      .id,
                                                );
                                              },
                                              child: Container(
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
                                                          activityHasAlreadyPassed(
                                                            successState
                                                                .groupedActivities[
                                                                    dateList[
                                                                        indexDate]]!
                                                                .elementAt(
                                                                    indexDayActivity)
                                                                .date,
                                                          )
                                                              ? Icons
                                                                  .check_circle_outline
                                                              : Icons
                                                                  .radio_button_unchecked,
                                                          color:
                                                              activityHasAlreadyPassed(
                                                            successState
                                                                .groupedActivities[
                                                                    dateList[
                                                                        indexDate]]!
                                                                .elementAt(
                                                                    indexDayActivity)
                                                                .date,
                                                          )
                                                                  ? AppStyleColors
                                                                      .zinc200
                                                                  : AppStyleColors
                                                                      .lime300,
                                                        ),
                                                        const SizedBox(
                                                            width: 16),
                                                        Text(
                                                          successState
                                                              .groupedActivities[
                                                                  dateList[
                                                                      indexDate]]!
                                                              .elementAt(
                                                                  indexDayActivity)
                                                              .name,
                                                          style: AppStyleText
                                                                  .bodyMd(
                                                                      context)
                                                              .copyWith(
                                                            color:
                                                                activityHasAlreadyPassed(
                                                              successState
                                                                  .groupedActivities[
                                                                      dateList[
                                                                          indexDate]]!
                                                                  .elementAt(
                                                                      indexDayActivity)
                                                                  .date,
                                                            )
                                                                    ? AppStyleColors
                                                                        .zinc400
                                                                    : AppStyleColors
                                                                        .zinc100,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Text(
                                                      "${successState.groupedActivities[dateList[indexDate]]!.elementAt(indexDayActivity).date.split(' ')[1]}h",
                                                      style:
                                                          AppStyleText.bodyMd(
                                                                  context)
                                                              .copyWith(
                                                        color:
                                                            activityHasAlreadyPassed(
                                                          successState
                                                              .groupedActivities[
                                                                  dateList[
                                                                      indexDate]]!
                                                              .elementAt(
                                                                  indexDayActivity)
                                                              .date,
                                                        )
                                                                ? AppStyleColors
                                                                    .zinc400
                                                                : AppStyleColors
                                                                    .zinc100,
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
                          EnumActivityTravelType.details => Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Divider(
                                  color: AppStyleColors.zinc800,
                                ),
                                Text(
                                  "Convidados",
                                  style: AppStyleText.headingLg(context)
                                      .copyWith(color: AppStyleColors.zinc50),
                                ),
                                Expanded(
                                    child: ListView.builder(
                                  itemCount: widget.travel.guests?.length ?? 0,
                                  itemBuilder: (context, index) => Container(
                                    child: ListTile(
                                      contentPadding: EdgeInsets.zero,
                                      title: Text(
                                        widget.travel.guests![index].name,
                                        style: AppStyleText.headingXs(context)
                                            .copyWith(
                                                color: AppStyleColors.zinc100),
                                      ),
                                      subtitle: Text(
                                        widget.travel.guests![index].email,
                                        style: AppStyleText.bodyMd(context)
                                            .copyWith(
                                                color: AppStyleColors.zinc400),
                                      ),
                                      trailing: Icon(
                                        _statusIconGuest(
                                          widget.travel.guests![index].status,
                                        ),
                                        color: _statusColorGuest(
                                          widget.travel.guests![index].status,
                                        ),
                                      ),
                                    ),
                                  ),
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
