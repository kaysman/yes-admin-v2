import 'package:admin_v2/Data/models/market/create-market.model.dart';
import 'package:admin_v2/Presentation/screens/markets/bloc/market.bloc.dart';
import 'package:admin_v2/Presentation/screens/markets/bloc/market.state.dart';
import 'package:admin_v2/Presentation/shared/app_colors.dart';
import 'package:admin_v2/Presentation/shared/components/button.dart';
import 'package:admin_v2/Presentation/shared/components/input_fields.dart';
import 'package:admin_v2/Presentation/shared/helpers.dart';
import 'package:admin_v2/Presentation/shared/validators.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateMarketPage extends StatefulWidget {
  const CreateMarketPage({Key? key}) : super(key: key);

  @override
  State<CreateMarketPage> createState() => _CreateMarketPageState();
}

class _CreateMarketPageState extends State<CreateMarketPage> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late MarketBloc marketBloc;

  final titleController = TextEditingController();
  final addressController = TextEditingController();
  final descriptionController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final ownerNameController = TextEditingController();
  @override
  void initState() {
    marketBloc = BlocProvider.of<MarketBloc>(context);

    titleController.text = "MB Shoes";
    addressController.text = "Berkarar";
    descriptionController.text = "Ayakgaplar";
    phoneNumberController.text = "123123";
    ownerNameController.text = "MB";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MarketBloc, MarketState>(
      listenWhen: (s1, s2) => s1.createStatus != s2.createStatus,
      listener: (context, state) {
        if (state.createStatus == MarketCreateStatus.success) {
          showSnackBar(
            context,
            Text('Created successfully'),
            type: SnackbarType.success,
          );
          Navigator.of(context).pop();
        }
      },
      builder: (context, state) {
        return Container(
          width: MediaQuery.of(context).size.width * 0.45,
          child: Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Market döret".toUpperCase(),
                    style: Theme.of(context).textTheme.headline4,
                  ),
                  SizedBox(height: 20),
                  LabeledInput(
                    controller: titleController,
                    validator: emptyField,
                    editMode: true,
                    hintText: "Markediň ady *",
                  ),
                  SizedBox(height: 14),
                  LabeledInput(
                    controller: descriptionController,
                    editMode: true,
                    hintText: "Barada",
                  ),
                  SizedBox(height: 14),
                  LabeledInput(
                    controller: addressController,
                    editMode: true,
                    hintText: "Salgysy",
                  ),
                  SizedBox(height: 14),
                  LabeledInput(
                    controller: phoneNumberController,
                    validator: emptyField,
                    editMode: true,
                    hintText: "Telefon *",
                  ),
                  SizedBox(height: 14),
                  LabeledInput(
                    controller: ownerNameController,
                    hintText: "Eýesiniň ady",
                    editMode: true,
                  ),
                  SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Button(
                        text: 'Cancel',
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      SizedBox(width: 16),
                      Button(
                        text: "Save",
                        primary: kswPrimaryColor,
                        textColor: kWhite,
                        isLoading:
                            state.createStatus == MarketCreateStatus.loading,
                        onPressed: () async {
                          if (formKey.currentState!.validate()) {
                            CreateMarketDTO data = CreateMarketDTO(
                              title: titleController.text,
                              address: addressController.text,
                              description: descriptionController.text,
                              phoneNumber: phoneNumberController.text,
                              ownerName: ownerNameController.text,
                            );
                            await marketBloc.createMarket(data, context);
                          }
                        },
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
