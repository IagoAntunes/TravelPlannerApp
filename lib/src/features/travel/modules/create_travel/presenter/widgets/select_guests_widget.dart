import 'package:flutter/material.dart';
import 'package:travelplannerapp/core/components/c_textformfield.dart';

import '../../../../../../../core/components/c_button.dart';
import '../../../../../../../core/style/app_style_colors.dart';
import '../../../../../../../core/style/app_style_text.dart';

class SelectGuestsWidget extends StatefulWidget {
  const SelectGuestsWidget({
    super.key,
    required this.emailGuests,
  });
  final List<String> emailGuests;
  @override
  State<SelectGuestsWidget> createState() => _SelectGuestsWidgetState();
}

class _SelectGuestsWidgetState extends State<SelectGuestsWidget> {
  final TextEditingController _guestEmailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Padding(
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
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  "Selecionar Convidados",
                  style: AppStyleText.headingMd(context).copyWith(
                    color: AppStyleColors.zinc100,
                  ),
                ),
                const Spacer(),
                const CloseButton(),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              "Os convidados irão receber e-mails para confirmar sua participação na viagem",
              style: AppStyleText.bodyMd(context).copyWith(
                color: AppStyleColors.zinc400,
              ),
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: widget.emailGuests
                  .map(
                    (email) => Chip(
                      backgroundColor: AppStyleColors.zinc800,
                      label: Text(
                        email,
                        style: AppStyleText.bodySm(context).copyWith(
                          color: AppStyleColors.zinc400,
                        ),
                      ),
                      side: BorderSide.none,
                      elevation: 0.0,
                      shadowColor: null,
                      deleteIcon: Icon(
                        Icons.close,
                        size: 18,
                        color: AppStyleColors.zinc400,
                      ),
                      onDeleted: () {
                        setState(() {
                          widget.emailGuests.remove(email);
                        });
                      },
                    ),
                  )
                  .toList(),
            ),
            const SizedBox(height: 24),
            CTextFormField(
              controller: _guestEmailController,
              hintText: 'Digite o e-mail do convidado',
              prefixIconData: Icons.alternate_email,
              fillColor: AppStyleColors.zinc950,
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: CButton.icon(
                text: 'Convidar',
                icon: Icons.add,
                onPressed: () {
                  setState(() {
                    widget.emailGuests.add(_guestEmailController.text);
                  });
                  _guestEmailController.clear();
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
