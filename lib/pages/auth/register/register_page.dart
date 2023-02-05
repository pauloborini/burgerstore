import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:validatorless/validatorless.dart';

import '../../../core/ui/base_state/base_state.dart';
import '../../../core/ui/styles/text_styles.dart';
import '../../../core/ui/widgets/delivery_button.dart';
import 'register_controller.dart';
import 'register_state.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends BaseState<RegisterPage, RegisterController> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _password2Controller = TextEditingController();
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
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _password2Controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterController, RegisterState>(
      listener: (context, state) {
        state.status.matchAny(
          any: () => hideLoader(),
          register: () => showLoader(),
          error: () {
            hideLoader();
            showError('Erro ao registrar usuário');
          },
          success: () {
            hideLoader();
            showSuccess('Cadastro realizado com sucesso');
            Navigator.pop(context);
          },
        );
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onPanDown: (_) {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            scrollDirection: Axis.vertical,
            child: Container(
              padding: const EdgeInsets.fromLTRB(16, 20, 16, 0),
              width: double.infinity,
              color: Colors.white,
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Cadastro',
                        style: context.textStyles.bold.copyWith(fontSize: 28)),
                    const SizedBox(height: 20),
                    TextFormField(
                        validator: Validatorless.required('Nome Obrigatório'),
                        keyboardType: TextInputType.text,
                        controller: _nameController,
                        decoration: InputDecoration(
                          labelText: 'Nome Completo*',
                          labelStyle: context.textStyles.regular,
                        )),
                    const SizedBox(height: 20),
                    TextFormField(
                        validator: Validatorless.multiple([
                          Validatorless.required('Email Obrigatório'),
                          Validatorless.email('Email Inválido')
                        ]),
                        keyboardType: TextInputType.emailAddress,
                        controller: _emailController,
                        decoration: InputDecoration(
                          labelText: 'Email*',
                          labelStyle: context.textStyles.regular,
                        )),
                    const SizedBox(height: 20),
                    TextFormField(
                        validator: Validatorless.multiple([
                          Validatorless.required('Senha Obrigatória'),
                          Validatorless.min(
                              4, 'Senha deve ter no mínimo 4 caracteres'),
                          Validatorless.max(
                              20, 'Senha pode ter no máximo 20 caracteres')
                        ]),
                        obscureText: _hidePassword,
                        keyboardType: TextInputType.text,
                        controller: _passwordController,
                        decoration: InputDecoration(
                          labelText: 'Senha*',
                          labelStyle: context.textStyles.regular,
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
                    const SizedBox(height: 20),
                    TextFormField(
                        validator: Validatorless.multiple([
                          Validatorless.required('Senha Obrigatória'),
                          Validatorless.compare(
                              _passwordController, 'Senhas devem ser idênticas')
                        ]),
                        obscureText: _hidePassword,
                        keyboardType: TextInputType.text,
                        controller: _password2Controller,
                        decoration: InputDecoration(
                          labelText: 'Confirme a Senha*',
                          labelStyle: context.textStyles.regular,
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
                    const SizedBox(height: 30),
                    DeliveryButton(
                        width: double.maxFinite,
                        height: 50,
                        label: 'CADASTRAR',
                        onPressed: () {
                          var formValid =
                              _formKey.currentState?.validate() ?? false;
                          if (formValid) {
                            controller.register(
                                _nameController.text,
                                _emailController.text,
                                _passwordController.text);
                            // Navigator.pushReplacementNamed(context, '/login');
                          }
                        })
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
