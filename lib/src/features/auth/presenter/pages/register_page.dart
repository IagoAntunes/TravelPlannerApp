import 'package:flutter/material.dart';
import 'package:travelplannerapp/core/components/c_button.dart';
import 'package:travelplannerapp/core/components/c_textformfield.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({super.key});

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _paswordController = TextEditingController();

  final _formValid = ValueNotifier(false);
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Form(
          key: _formKey,
          onChanged: () {
            if (_nameController.text.isNotEmpty &&
                _emailController.text.isNotEmpty &&
                _paswordController.text.isNotEmpty) {
              _formValid.value = true;
            } else {
              _formValid.value = false;
            }
          },
          child: Column(
            children: [
              CTextFormField(
                controller: _nameController,
                prefixIconData: Icons.person_outline,
                hintText: 'Name',
              ),
              const SizedBox(height: 16),
              CTextFormField(
                controller: _emailController,
                prefixIconData: Icons.email_outlined,
                hintText: 'Email',
              ),
              const SizedBox(height: 16),
              CTextFormField.password(
                controller: _paswordController,
                hintText: 'Senha',
              ),
              const SizedBox(height: 32),
              ValueListenableBuilder(
                valueListenable: _formValid,
                builder: (context, value, child) {
                  return SizedBox(
                    height: 42,
                    width: double.infinity,
                    child: CButton(
                      onPressed: () {
                        //
                      },
                      text: 'Registrar',
                      stateTypeButton:
                          value ? StateTypeButton.idle : StateTypeButton.unable,
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
