import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:travelplannerapp/core/components/c_button.dart';
import 'package:travelplannerapp/core/components/c_textformfield.dart';
import 'package:travelplannerapp/src/features/auth/presenter/blocs/register_cubit.dart';

import '../states/register_state.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({super.key});

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _paswordController = TextEditingController();

  final _formValid = ValueNotifier(false);
  final _formKey = GlobalKey<FormState>();

  final _cubit = GetIt.I.get<RegisterCubit>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
      ),
      body: BlocConsumer<RegisterCubit, IRegisterState>(
        bloc: _cubit,
        listener: (context, state) {
          if (state is SuccessRegisterListener) {
            Navigator.of(context).pop();
          } else if (state is FailureRegisterListener) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(state.message),
            ));
          }
        },
        listenWhen: (previous, current) => current is IRegisterListener,
        buildWhen: (previous, current) => current is! IRegisterListener,
        builder: (context, state) {
          return Padding(
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
                    enabled: state is! LoadingRegisterState,
                  ),
                  const SizedBox(height: 16),
                  CTextFormField(
                    controller: _emailController,
                    prefixIconData: Icons.email_outlined,
                    hintText: 'Email',
                    enabled: state is! LoadingRegisterState,
                  ),
                  const SizedBox(height: 16),
                  CTextFormField.password(
                    controller: _paswordController,
                    hintText: 'Senha',
                    enabled: state is! LoadingRegisterState,
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
                            _cubit.register(_nameController.text,
                                _emailController.text, _paswordController.text);
                          },
                          text: 'Registrar',
                          stateTypeButton: value
                              ? (state is! LoadingRegisterState)
                                  ? StateTypeButton.idle
                                  : StateTypeButton.loading
                              : StateTypeButton.unable,
                        ),
                      );
                    },
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
