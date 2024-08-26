import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:travelplannerapp/core/components/c_button.dart';
import 'package:travelplannerapp/core/components/c_textformfield.dart';
import 'package:travelplannerapp/core/style/app_style_text.dart';
import 'package:travelplannerapp/src/features/travel/modules/create_travel/presenter/blocs/create_travel_cubit.dart';

import '../../../../../../../core/style/app_style_colors.dart';
import '../widgets/select_guests_widget.dart';

class CreateTravelPage extends StatefulWidget {
  const CreateTravelPage({super.key});

  @override
  State<CreateTravelPage> createState() => _CreateTravelPageState();
}

class _CreateTravelPageState extends State<CreateTravelPage> {
  final TextEditingController _localNameController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _guestsController = TextEditingController();

  final _cubit = GetIt.I.get<CreateTravelCubit>();

  final _btnInitialEnabled = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: _cubit,
      builder: (context, state) {
        return Container(
          decoration: BoxDecoration(
            color: AppStyleColors.zinc900,
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Form(
            onChanged: () {
              if (_localNameController.text.isNotEmpty &&
                  _dateController.text.isNotEmpty) {
                _btnInitialEnabled.value = true;
              } else {
                _btnInitialEnabled.value = false;
              }
            },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CTextFormField(
                  controller: _localNameController,
                  hintText: 'Para onde?',
                  enabled:
                      _cubit.state.createTravelStep == CreateTravelStep.initial,
                  prefixIconData: Icons.location_on_outlined,
                ),
                CTextFormField(
                  controller: _dateController,
                  hintText: 'Quando?',
                  prefixIconData: Icons.date_range_outlined,
                  readOnly: true,
                  enabled:
                      _cubit.state.createTravelStep == CreateTravelStep.initial,
                  onTap: () async {
                    DateTimeRange? dateTimeRange = await showDateRangePicker(
                      context: context,
                      firstDate: DateTime.now(),
                      lastDate: DateTime.now().add(const Duration(days: 365)),
                      initialEntryMode: DatePickerEntryMode.calendar,
                      builder: (context, child) {
                        return Theme(
                          data: Theme.of(context).copyWith(
                            scaffoldBackgroundColor: AppStyleColors.zinc800,
                            colorScheme: ColorScheme.light(
                              primary: AppStyleColors.lime300,
                              secondary:
                                  AppStyleColors.lime300.withOpacity(0.6),
                              tertiary: AppStyleColors.lime300.withOpacity(0.6),
                              onPrimary: AppStyleColors.zinc200,
                              onSurface: AppStyleColors.zinc200,
                            ),
                            datePickerTheme: DatePickerThemeData(
                              backgroundColor: AppStyleColors.zinc800,
                              inputDecorationTheme: InputDecorationTheme(
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.zero,
                                hintStyle: AppStyleText.bodyMd(context)
                                    .copyWith(color: AppStyleColors.lime950),
                                helperStyle: AppStyleText.bodyMd(context)
                                    .copyWith(color: AppStyleColors.lime950),
                              ),
                              yearStyle: AppStyleText.bodyMd(context)
                                  .copyWith(color: AppStyleColors.lime950),
                            ),
                            textTheme: TextTheme(
                              bodyMedium: AppStyleText.bodyMd(context),
                            ),
                            disabledColor: AppStyleColors.zinc400,
                          ),
                          child: child!,
                        );
                      },
                    );
                    if (dateTimeRange != null) {
                      setState(() {
                        _dateController.text =
                            '${dateTimeRange.start.day}/${dateTimeRange.start.month}/${dateTimeRange.start.year} - ${dateTimeRange.end.day}/${dateTimeRange.end.month}/${dateTimeRange.end.year}';
                      });
                    }
                  },
                ),
                Visibility(
                  visible:
                      _cubit.state.createTravelStep == CreateTravelStep.guests,
                  child: SizedBox(
                    width: double.infinity,
                    child: CButton.icon(
                      text: 'Alterar local/data',
                      textColor: AppStyleColors.zinc200,
                      backgroundColor: AppStyleColors.zinc800,
                      icon: Icons.tune,
                      iconColor: AppStyleColors.zinc200,
                      iconAlignment: IconAlignment.end,
                      onPressed: () {
                        _cubit.changeStepToInitial();
                      },
                    ),
                  ),
                ),
                Visibility(
                  visible:
                      _cubit.state.createTravelStep == CreateTravelStep.initial,
                  child: ValueListenableBuilder(
                    valueListenable: _btnInitialEnabled,
                    builder: (context, value, child) {
                      return Column(
                        children: [
                          const SizedBox(height: 16),
                          SizedBox(
                            width: double.infinity,
                            child: CButton(
                              text: 'Continuar',
                              stateTypeButton: _btnInitialEnabled.value
                                  ? StateTypeButton.idle
                                  : StateTypeButton.unable,
                              onPressed: () {
                                _cubit.changeStepToGuests();
                              },
                            ),
                          )
                        ],
                      );
                    },
                  ),
                ),
                Visibility(
                  visible:
                      _cubit.state.createTravelStep == CreateTravelStep.guests,
                  child: Column(
                    children: [
                      Divider(color: AppStyleColors.zinc800),
                      CTextFormField(
                        controller: _guestsController,
                        hintText: 'Quem estará na viagem?',
                        prefixIconData: Icons.person_add_outlined,
                        readOnly: true,
                        onTap: () async {
                          await showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            builder: (context) => SelectGuestsWidget(
                              emailGuests: _cubit.emailGuests,
                            ),
                          ).then(
                            (value) {
                              setState(() {
                                _guestsController.text =
                                    "${_cubit.emailGuests.length} pessoa(s) convidada(s)";
                              });
                            },
                          );
                        },
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        width: double.infinity,
                        child: CButton.icon(
                          text: 'Confirmar viagem',
                          onPressed: () {
                            //
                          },
                          icon: Icons.arrow_right_outlined,
                          iconAlignment: IconAlignment.end,
                        ),
                      )
                    ],
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
