import 'package:flutter/material.dart';

import '../style/app_style_colors.dart';
import '../style/app_style_text.dart';

enum TypeButton {
  text,
  icon,
}

enum StateTypeButton {
  idle,
  loading,
  unable,
}

class CButton extends StatelessWidget {
  const CButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.type = TypeButton.text,
    this.stateTypeButton = StateTypeButton.idle,
  });
  final TypeButton type;
  final String text;
  final StateTypeButton stateTypeButton;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return switch (type) {
      TypeButton.text => ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppStyleColors.lime300,
            disabledBackgroundColor: AppStyleColors.zinc200,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          onPressed: (stateTypeButton != StateTypeButton.unable &&
                  stateTypeButton != StateTypeButton.loading)
              ? onPressed
              : null,
          child: (stateTypeButton == StateTypeButton.loading)
              ? CircularProgressIndicator(
                  color: AppStyleColors.lime950,
                )
              : Text(
                  text,
                  style: AppStyleText.button(context).copyWith(
                    color: AppStyleColors.lime950,
                  ),
                ),
        ),
      _ => Container(),
    };
  }
}
