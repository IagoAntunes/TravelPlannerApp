import 'package:flutter/material.dart';

import '../style/app_style_colors.dart';
import '../style/app_style_text.dart';

enum TypeTextFormField {
  idle,
  password,
}

class CTextFormField extends StatefulWidget {
  const CTextFormField({
    super.key,
    this.controller,
    this.hintText,
    this.prefixIconData,
    this.suffixIconData,
    this.typeTextFormField = TypeTextFormField.idle,
    this.enabled = true,
    this.readOnly,
    this.onTap,
    this.fillColor,
  });

  const CTextFormField.password({
    super.key,
    this.controller,
    this.hintText,
    this.prefixIconData = Icons.password,
    this.suffixIconData,
    this.typeTextFormField = TypeTextFormField.password,
    this.enabled = true,
    this.readOnly = false,
    this.onTap,
    this.fillColor,
  });

  final TextEditingController? controller;
  final IconData? prefixIconData;
  final IconData? suffixIconData;
  final Color? fillColor;
  final String? hintText;
  final bool enabled;
  final bool? readOnly;
  final TypeTextFormField? typeTextFormField;
  final void Function()? onTap;
  @override
  State<CTextFormField> createState() => _CTextFormFieldState();
}

class _CTextFormFieldState extends State<CTextFormField> {
  Color _prefixIconDataColor = AppStyleColors.zinc400;
  bool _valueObscureText = true;
  late TextEditingController controller;
  @override
  void initState() {
    super.initState();
    if (widget.controller == null) {
      controller = TextEditingController();
    } else {
      controller = widget.controller!;
    }
    if (widget.typeTextFormField == TypeTextFormField.password) {
      _prefixIconDataColor = AppStyleColors.lime300;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FocusScope(
      onFocusChange: (value) {
        if (value) {
          setState(() {
            _prefixIconDataColor = AppStyleColors.lime300;
          });
        } else {
          setState(() {
            _prefixIconDataColor = AppStyleColors.zinc400;
          });
        }
      },
      child: TextFormField(
        onTap: widget.onTap,
        controller: controller,
        style: AppStyleText.bodyMd(context).copyWith(
          color: AppStyleColors.zinc300,
        ),
        readOnly: widget.readOnly ?? false,
        obscureText: widget.typeTextFormField == TypeTextFormField.password
            ? _valueObscureText
            : false,
        enabled: widget.enabled,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(vertical: 16.0),
          prefixIcon: widget.prefixIconData != null
              ? Icon(
                  widget.prefixIconData,
                  color: _prefixIconDataColor,
                )
              : null,
          suffixIcon: widget.typeTextFormField == TypeTextFormField.password
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      _valueObscureText = !_valueObscureText;
                    });
                  },
                  icon: Icon(
                    _valueObscureText
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                  ),
                )
              : null,
          fillColor: widget.fillColor ?? AppStyleColors.zinc900,
          filled: true,
          hintText: widget.hintText,
          hintStyle: AppStyleText.bodyMd(context).copyWith(
            color: AppStyleColors.zinc400,
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
