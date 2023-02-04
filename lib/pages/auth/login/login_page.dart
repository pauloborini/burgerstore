import 'package:burgerstore/core/ui/styles/colors_app.dart';
import 'package:burgerstore/pages/auth/login/login_controller.dart';
import 'package:burgerstore/pages/auth/login/login_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:validatorless/validatorless.dart';

import '../../../../generated/assets.dart';
import '../../../core/ui/base_state/base_state.dart';
import '../../../core/ui/styles/text_styles.dart';
import '../../../core/ui/widgets/delivery_button.dart';
import '../register/register_route.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends BaseState<LoginPage, LoginController> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _hidePassword = true;
  Icon visibleOrNot = const Icon(Icons.visibility);

  getIcon() {
    if (_hidePassword == true) {
      visibleOrNot = const Icon(Icons.visibility);
    } else {
      visibleOrNot = const Icon(Icons.visibility_off);
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginController, LoginState>(
      listener: (context, state) {
        state.status.matchAny(
            any: () => hideLoader(),
            login: () => showLoader(),
            loginError: () {
              hideLoader();
              showError('Login ou senha inválidos');
            },
            error: () {
              hideLoader();
              showError('Erro ao efetuar login, tente novamente');
            },
            success: () {
              hideLoader();
              Navigator.of(context).pop(true);
            });
      },
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 32,
          leading: GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: const Icon(Icons.arrow_back_ios_new)),
        ),
        backgroundColor: Colors.white,
        body: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onPanDown: (_) {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            child: Center(
              child: Container(
                constraints: const BoxConstraints(maxWidth: 1440),
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                width: double.infinity,
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height * 0.12,
                        child: Image.asset(Assets.imagesLogo, fit: BoxFit.contain),
                      ),
                      const SizedBox(height: 15),
                      Text('Login', style: TextStyles.instance.textXBold.copyWith(fontSize: 28)),
                      const SizedBox(height: 20),
                      TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          controller: _emailController,
                          validator: Validatorless.multiple([Validatorless.required('Email Obrigatório'), Validatorless.email('Email Inválido')]),
                          decoration: InputDecoration(
                            labelText: 'Email',
                            labelStyle: TextStyles.instance.textRegular,
                          )),
                      const SizedBox(height: 30),
                      TextFormField(
                          obscureText: _hidePassword,
                          keyboardType: TextInputType.number,
                          controller: _passwordController,
                          validator: Validatorless.multiple(
                              [Validatorless.required('Senha Obrigatória'), Validatorless.max(20, 'Senha pode ter no máximo 20 caracteres')]),
                          decoration: InputDecoration(
                            labelText: 'Senha',
                            labelStyle: TextStyles.instance.textRegular,
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  _hidePassword = !_hidePassword;
                                  getIcon();
                                });
                              },
                              icon: visibleOrNot,
                            ),
                          )),
                      const SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            style: ButtonStyle(overlayColor: MaterialStateProperty.all(Colors.transparent)),
                            onPressed: () {},
                            child: Text('Esqueceu a senha?',
                                textAlign: TextAlign.right,
                                style: TextStyles.instance.textMedium.copyWith(
                                  color: context.colors.primary,
                                  fontSize: 16,
                                )),
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),
                      DeliveryButton(
                          height: 50,
                          width: double.maxFinite,
                          label: 'ENTRAR',
                          onPressed: () {
                            var formValid = _formKey.currentState?.validate() ?? false;
                            if (formValid) {
                              controller.login(_emailController.text, _passwordController.text);
                            }
                          }),
                      const SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Não possui conta?',
                            style: TextStyles.instance.textMedium.copyWith(fontSize: 16),
                          ),
                          TextButton(
                              onPressed: () {
                                showBarModalBottomSheet(context: context, builder: (context) => RegisterRoute.page);
                              },
                              child: Text(
                                'Cadastre-se',
                                style: TextStyles.instance.textBold.copyWith(fontSize: 16),
                              ))
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
