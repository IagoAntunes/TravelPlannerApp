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
    this.icon,
    this.iconAlignment,
    this.backgroundColor,
    this.textColor,
    this.iconColor,
  });
  const CButton.icon({
    super.key,
    required this.text,
    required this.onPressed,
    required this.icon,
    this.type = TypeButton.icon,
    this.stateTypeButton = StateTypeButton.idle,
    this.iconAlignment = IconAlignment.start,
    this.backgroundColor,
    this.textColor,
    this.iconColor,
  });
  final TypeButton type;
  final Color? backgroundColor;
  final String text;
  final Color? textColor;
  final StateTypeButton stateTypeButton;
  final Function()? onPressed;
  final IconData? icon;
  final Color? iconColor;
  final IconAlignment? iconAlignment;
  @override
  Widget build(BuildContext context) {
    return switch (type) {
      TypeButton.text => ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: backgroundColor ?? AppStyleColors.lime300,
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
                    color: textColor ?? AppStyleColors.lime950,
                  ),
                ),
        ),
      TypeButton.icon => ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            backgroundColor: backgroundColor ?? AppStyleColors.lime300,
            disabledBackgroundColor: AppStyleColors.zinc200,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          onPressed: (stateTypeButton != StateTypeButton.unable &&
                  stateTypeButton != StateTypeButton.loading)
              ? onPressed
              : null,
          iconAlignment: iconAlignment ?? IconAlignment.start,
          icon: (stateTypeButton == StateTypeButton.loading)
              ? null
              : Icon(
                  icon,
                  color: iconColor ?? AppStyleColors.lime950,
                ),
          label: (stateTypeButton == StateTypeButton.loading)
              ? CircularProgressIndicator(
                  color: AppStyleColors.lime950,
                )
              : Text(
                  text,
                  style: AppStyleText.button(context).copyWith(
                    color: textColor ?? AppStyleColors.lime950,
                  ),
                ),
        ),
    };
  }
}
