import 'package:flutter/material.dart';

import '../../../../../../../core/components/c_button.dart';
import '../../../../../../../core/components/c_textformfield.dart';
import '../../../../../../../core/style/app_style_colors.dart';
import '../../../../../../../core/style/app_style_text.dart';

class CreateLinkModalBottomSheet extends StatefulWidget {
  const CreateLinkModalBottomSheet({
    super.key,
  });

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

  @override
  Widget build(BuildContext context) {
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
                      ? StateTypeButton.idle
                      : StateTypeButton.unable,
                  onPressed: () {
                    //
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
