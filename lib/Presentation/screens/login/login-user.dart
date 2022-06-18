import 'package:admin_v2/Data/models/user/login/login.model.dart';
import 'package:admin_v2/Data/services/local_storage.service.dart';
import 'package:admin_v2/Presentation/Blocs/auth/auth.bloc.dart';
import 'package:admin_v2/Presentation/Blocs/auth/auth_state.dart';
import 'package:admin_v2/Presentation/screens/index/index.screen.dart';
import 'package:admin_v2/Presentation/screens/login/bloc/login.bloc.dart';
import 'package:admin_v2/Presentation/screens/login/bloc/login.state.dart';
import 'package:admin_v2/Presentation/screens/login/register-user.dart';
import 'package:admin_v2/Presentation/shared/app_colors.dart';
import 'package:admin_v2/Presentation/shared/components/button.dart';
import 'package:admin_v2/Presentation/shared/helpers.dart';
import 'package:admin_v2/Presentation/shared/validators.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginUserPage extends StatefulWidget {
  static const String routeName = "login";
  const LoginUserPage({Key? key}) : super(key: key);

  @override
  State<LoginUserPage> createState() => _LoginUserPageState();
}

class _LoginUserPageState extends State<LoginUserPage> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final phoneNumberController = TextEditingController();
  final passwordController = TextEditingController();

  void goToHome() {
    Navigator.of(context).pushNamed(IndexScreen.routeName);
  }

  @override
  void initState() {
    super.initState();
    passwordController.text = 'admin123';
    phoneNumberController.text = '861405590';
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(listener: (context, state) {
      if (state.status == AuthStatus.authenticated) {
        goToHome();
      }
    }, builder: (context, state) {
      return Container(
        color: kScaffoldBgColor,
        alignment: Alignment.center,
        child: Container(
          width: MediaQuery.of(context).size.width * .35,
          decoration: BoxDecoration(
              boxShadow: [shadow],
              color: kWhite,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: kScaffoldBgColor!, width: 1)),
          child: Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Iceri gir".toUpperCase(),
                    style: Theme.of(context).textTheme.headline4,
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: phoneNumberController,
                    validator: phoneValidator,
                    decoration: InputDecoration(
                      focusedErrorBorder: kErrorInputBorder,
                      errorBorder: kErrorInputBorder,
                      focusedBorder: kFocusedInputBorder,
                      enabledBorder: kEnabledInputBorder,
                      labelText: "Telefon belginiz *",
                    ),
                  ),
                  SizedBox(height: 14),
                  TextFormField(
                    controller: passwordController,
                    validator: emptyField,
                    decoration: InputDecoration(
                      labelText: "Acar sozi *",
                      focusedErrorBorder: kErrorInputBorder,
                      errorBorder: kErrorInputBorder,
                      focusedBorder: kFocusedInputBorder,
                      enabledBorder: kEnabledInputBorder,
                    ),
                  ),
                  SizedBox(height: 14),
                  RichText(
                    text: TextSpan(
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.of(context)
                              .pushNamed(RegisterUserPage.routeName);
                        },
                      text: 'Agza dal?',
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge
                          ?.copyWith(color: kPrimaryColor),
                    ),
                  ),
                  SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      BlocBuilder<LoginBloc, LoginState>(
                          builder: (context, state) {
                        return Button(
                          text: "Login",
                          isLoading: state.status == LoginStatus.loading,
                          onPressed: () async {
                            if (formKey.currentState!.validate()) {
                              LoginDTO data = LoginDTO(
                                password: passwordController.text,
                                phoneNumber: phoneNumberController.text,
                              );
                              await context.read<LoginBloc>().login(data);
                              var disk = (await LocalStorage.instance);
                              var sms = disk?.toGetResMessage;
                              print(sms);
                              if (sms != null && sms.isNotEmpty) {
                                showSnackBar(
                                  context,
                                  SnackBar(
                                    behavior: SnackBarBehavior.floating,
                                    content: Text(sms),
                                  ),
                                );
                              }
                            }
                          },
                        );
                      }),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
