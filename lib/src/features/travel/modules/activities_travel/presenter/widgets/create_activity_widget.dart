import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:travelplannerapp/core/components/c_button.dart';
import 'package:travelplannerapp/core/components/c_textformfield.dart';
import 'package:travelplannerapp/src/features/travel/modules/activities_travel/presenter/blocs/activity_travel_cubit.dart';
import '../../../../../../../core/style/app_style_colors.dart';
import '../../../../../../../core/style/app_style_text.dart';
import '../states/activity_travel_state.dart';

class CreateActivityWidget extends StatefulWidget {
  const CreateActivityWidget({
    super.key,
    required this.travelId,
    required this.startDateTravel,
    required this.endDateTravel,
  });
  final int travelId;
  final String startDateTravel;
  final String endDateTravel;
  @override
  State<CreateActivityWidget> createState() => _CreateActivityWidgetState();
}

class _CreateActivityWidgetState extends State<CreateActivityWidget> {
  final TextEditingController _nameActivityController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _hourController = TextEditingController();
  final _cubit = GetIt.I.get<ActivityTravelCubit>();
  String _convertDateFormat(String date) {
    final parts = date.split('/');
    if (parts.length != 3) {
      throw const FormatException('Invalid date format');
    }
    return '${parts[2]}-${parts[1]}-${parts[0]}';
  }

  bool _isLoading = false;
  bool _formValidated = false;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: _cubit,
      listener: (context, state) {
        if (state is CreatedActivityTravelListener) {
          Navigator.pop(context, true);
        }
      },
      listenWhen: (previous, current) => current is IActivityTravelListener,
      child: Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 16,
          ),
          decoration: BoxDecoration(
            color: AppStyleColors.zinc900,
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(16),
              topLeft: Radius.circular(16),
            ),
          ),
          child: Form(
            key: _formKey,
            onChanged: () {
              if (_nameActivityController.text.isNotEmpty &&
                  _dateController.text.isNotEmpty &&
                  _hourController.text.isNotEmpty) {
                setState(() {
                  _formValidated = true;
                });
              } else {
                setState(() {
                  _formValidated = false;
                });
              }
            },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Cadastrar atividade",
                  style: AppStyleText.headingSm(context)
                      .copyWith(color: AppStyleColors.zinc100),
                ),
                const SizedBox(height: 8),
                Text(
                  "Todos convidados podem visualizar as atividades.",
                  style: AppStyleText.bodySm(context)
                      .copyWith(color: AppStyleColors.zinc400),
                ),
                const SizedBox(height: 8),
                CTextFormField(
                  controller: _nameActivityController,
                  hintText: "Qual a atividade?",
                  prefixIconData: Icons.label_outline,
                  fillColor: AppStyleColors.zinc950,
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Flexible(
                      flex: 2,
                      child: CTextFormField(
                        controller: _dateController,
                        hintText: "Data",
                        prefixIconData: Icons.date_range,
                        fillColor: AppStyleColors.zinc950,
                        readOnly: true,
                        onTap: () async {
                          await showDatePicker(
                            context: context,
                            firstDate: DateTime.parse(
                                _convertDateFormat(widget.startDateTravel)),
                            lastDate: DateTime.parse(
                                _convertDateFormat(widget.endDateTravel)),
                          ).then(
                            (value) {
                              if (value != null) {
                                _dateController.text =
                                    '${value.day}/${value.month}/${value.year}';
                              }
                            },
                          );
                        },
                      ),
                    ),
                    const SizedBox(width: 16),
                    Flexible(
                      child: CTextFormField(
                        controller: _hourController,
                        hintText: "Horário",
                        prefixIconData: Icons.schedule_outlined,
                        fillColor: AppStyleColors.zinc950,
                        readOnly: true,
                        onTap: () async {
                          await showTimePicker(
                            context: context,
                            initialTime: TimeOfDay.now(),
                            builder: (context, child) {
                              return MediaQuery(
                                data: MediaQuery.of(context)
                                    .copyWith(alwaysUse24HourFormat: true),
                                child: child!,
                              );
                            },
                          ).then(
                            (value) {
                              if (value != null) {
                                _hourController.text =
                                    '${value.hour}:${value.minute}';
                              }
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: CButton(
                    text: 'Salvar atividade',
                    stateTypeButton: _formValidated
                        ? (_isLoading
                            ? StateTypeButton.loading
                            : StateTypeButton.idle)
                        : StateTypeButton.unable,
                    onPressed: () async {
                      setState(() {
                        _isLoading = true;
                      });
                      await _cubit.createActivity(
                        _nameActivityController.text,
                        _dateController.text,
                        _hourController.text,
                        widget.travelId,
                      );
                      setState(() {
                        _isLoading = false;
                      });
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
