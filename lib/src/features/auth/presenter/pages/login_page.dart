import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:travelplannerapp/core/style/app_style_colors.dart';
import 'package:travelplannerapp/core/style/app_style_text.dart';
import 'package:travelplannerapp/src/features/auth/presenter/pages/register_page.dart';
import 'package:travelplannerapp/src/features/auth/presenter/states/login_state.dart';

import '../../../../../core/components/c_button.dart';
import '../../../../../core/components/c_textformfield.dart';
import '../blocs/auth_cubit.dart';
import '../blocs/login_cubit.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final _formValid = ValueNotifier(false);
  final _formKey = GlobalKey<FormState>();

  final _loginCubit = GetIt.I.get<LoginCubit>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BlocConsumer<LoginCubit, ILoginState>(
              bloc: _loginCubit,
              listener: (context, state) {
                if (state is SuccessLoginListener) {
                  var authCubit = GetIt.I.get<AuthCubit>();
                  authCubit.authenticated(state.user);
                } else if (state is FailureLoginListener) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.message),
                    ),
                  );
                }
              },
              listenWhen: (previous, current) => current is ILoginListener,
              buildWhen: (previous, current) => current is! ILoginListener,
              builder: (context, state) {
                return Expanded(
                  child: Form(
                    key: _formKey,
                    onChanged: () {
                      if (_emailController.text.isNotEmpty &&
                          _passwordController.text.isNotEmpty) {
                        _formValid.value = true;
                      } else {
                        _formValid.value = false;
                      }
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                          child: Image.asset('assets/images/planner_logo.png'),
                        ),
                        Text(
                          "Convide seus amigos e planeje sua próxima viagem",
                          style: AppStyleText.bodyLg(context).copyWith(
                            color: AppStyleColors.zinc400,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 24),
                        CTextFormField(
                          controller: _emailController,
                          prefixIconData: Icons.email_outlined,
                          hintText: 'Email',
                          enabled: state is! LoadingLoginState,
                        ),
                        const SizedBox(height: 16),
                        CTextFormField.password(
                          controller: _passwordController,
                          hintText: "Senha",
                          enabled: state is! LoadingLoginState,
                        ),
                        const SizedBox(height: 16),
                        ValueListenableBuilder(
                          valueListenable: _formValid,
                          builder: (context, value, child) {
                            return SizedBox(
                              height: 42,
                              width: double.infinity,
                              child: CButton(
                                onPressed: () {
                                  _loginCubit.login(_emailController.text,
                                      _passwordController.text);
                                },
                                text: "Entrar",
                                stateTypeButton: _formValid.value
                                    ? (state is LoadingLoginState)
                                        ? StateTypeButton.loading
                                        : StateTypeButton.idle
                                    : StateTypeButton.unable,
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 6),
                        GestureDetector(
                          onTap: () {
                            //
                          },
                          child: Text(
                            "Esqueci minha senha",
                            style: AppStyleText.bodyMd(context).copyWith(
                              color: AppStyleColors.zinc500,
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Center(
                          child: SizedBox(
                            child: OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  side: BorderSide(
                                    color: AppStyleColors.lime300,
                                    width: 2.0,
                                  ),
                                ),
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => RegisterPage(),
                                  ),
                                );
                              },
                              child: Text(
                                "Criar Conta",
                                style: AppStyleText.bodyMd(context).copyWith(
                                  color: AppStyleColors.lime300,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            Text(
              "Ao planejar sua viagem pela plann.er você automaticamente concorda com nossos termos de uso e políticas de privacidade.",
              style: AppStyleText.bodySm(context).copyWith(
                color: AppStyleColors.zinc500,
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
