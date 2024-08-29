import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:travelplannerapp/src/features/travel/modules/links_travel/presenter/links_travel_cubit.dart';

import '../../../../../../../core/components/c_button.dart';
import '../../../../../../../core/components/c_textformfield.dart';
import '../../../../../../../core/style/app_style_colors.dart';
import '../../../../../../../core/style/app_style_text.dart';
import '../states/links_travel_state.dart';

class CreateLinkModalBottomSheet extends StatefulWidget {
  const CreateLinkModalBottomSheet({
    super.key,
    required this.travelId,
  });

  final int travelId;

  @override
  State<CreateLinkModalBottomSheet> createState() =>
      _CreateLinkModalBottomSheetState();
}

class _CreateLinkModalBottomSheetState
    extends State<CreateLinkModalBottomSheet> {
  final TextEditingController _titleLinkController = TextEditingController();

  final TextEditingController _urlController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  bool _btnSaveLinkEnabled = false;

  final _cubit = GetIt.I.get<LinksTravelCubit>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LinksTravelCubit, ILinksTravelState>(
      bloc: _cubit,
      listener: (context, state) {
        if (state is SuccessCreateLinkTravelListener) {
          var createdLink = state.link;
          Navigator.pop(context, createdLink);
        }
      },
      listenWhen: (previous, current) => current is ILinksTravelListener,
      buildWhen: (previous, current) => current is! ILinksTravelListener,
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
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
                if (_titleLinkController.text.isNotEmpty &&
                    _urlController.text.isNotEmpty) {
                  setState(() {
                    _btnSaveLinkEnabled = true;
                  });
                } else {
                  setState(() {
                    _btnSaveLinkEnabled = false;
                  });
                }
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Cadastrar Link",
                        style: AppStyleText.headingSm(context)
                            .copyWith(color: AppStyleColors.zinc50),
                      ),
                      CloseButton(
                        color: AppStyleColors.zinc400,
                      ),
                    ],
                  ),
                  Text(
                    "Todos convidados podem visualizar os links importantes.",
                    style: AppStyleText.bodySm(context)
                        .copyWith(color: AppStyleColors.zinc400),
                  ),
                  const SizedBox(height: 16),
                  CTextFormField(
                    controller: _titleLinkController,
                    fillColor: AppStyleColors.zinc950,
                    prefixIconData: Icons.label_outline,
                    hintText: 'Titulo do link',
                  ),
                  const SizedBox(height: 8),
                  CTextFormField(
                    controller: _urlController,
                    fillColor: AppStyleColors.zinc950,
                    prefixIconData: Icons.link_outlined,
                    hintText: 'Link',
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    width: double.infinity,
                    child: CButton(
                      text: 'Salvar link',
                      stateTypeButton: _btnSaveLinkEnabled
                          ? (state is LoadingCreateLinkTravelState
                              ? StateTypeButton.loading
                              : StateTypeButton.idle)
                          : StateTypeButton.unable,
                      onPressed: () {
                        _cubit.addLinkToTravel(
                          _titleLinkController.text,
                          _urlController.text,
                          widget.travelId,
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
