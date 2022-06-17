import 'package:admin_v2/Data/models/user/login/login.model.dart';
import 'package:admin_v2/Presentation/shared/app_colors.dart';
import 'package:admin_v2/Presentation/shared/components/button.dart';
import 'package:admin_v2/Presentation/shared/helpers.dart';
import 'package:admin_v2/Presentation/shared/validators.dart';
import 'package:flutter/material.dart';

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

  @override
  Widget build(BuildContext context) {
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
                SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    OutlinedButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: Text(
                        "Cancel",
                        style: Theme.of(context).textTheme.bodyText2!.copyWith(
                              color: Theme.of(context).primaryColor,
                            ),
                      ),
                    ),
                    SizedBox(width: 16),
                    Button(
                      text: "Save",
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          LoginDTO data = LoginDTO(
                            password: passwordController.text,
                            phoneNumber: phoneNumberController.text,
                          );
                        }
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
