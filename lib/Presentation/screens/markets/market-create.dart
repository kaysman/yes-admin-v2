import 'package:admin_v2/Data/models/market/create-market.model.dart';
import 'package:admin_v2/Presentation/screens/markets/bloc/market.bloc.dart';
import 'package:admin_v2/Presentation/screens/markets/bloc/market.state.dart';
import 'package:admin_v2/Presentation/shared/app_colors.dart';
import 'package:admin_v2/Presentation/shared/components/button.dart' as f;
import 'package:admin_v2/Presentation/shared/helpers.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../example/widgets/fluent-labeled-input.dart';

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
          showSnackbar(
            context,
            Snackbar(
              content: Text('Created successfully'),
            ),
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
                    style:
                        FluentTheme.of(context).typography.bodyLarge?.copyWith(
                              fontWeight: FontWeight.w500,
                            ),
                  ),
                  SizedBox(height: 20),
                  FluentLabeledInput(
                    controller: titleController,
                    isTapped: false,
                    label: "Markediň ady *",
                    isEditMode: true,
                  ),
                  SizedBox(height: 14),
                  FluentLabeledInput(
                    isTapped: false,
                    label: "Barada",
                    isEditMode: true,
                    controller: descriptionController,
                  ),
                  SizedBox(height: 14),
                  FluentLabeledInput(
                    isTapped: false,
                    label: "Salgysy",
                    isEditMode: true,
                    controller: addressController,
                  ),
                  SizedBox(height: 14),
                  FluentLabeledInput(
                    isTapped: false,
                    label: "Telefon *",
                    isEditMode: true,
                    controller: phoneNumberController,
                  ),
                  SizedBox(height: 14),
                  FluentLabeledInput(
                    isTapped: false,
                    label: "Eýesiniň ady",
                    isEditMode: true,
                    controller: ownerNameController,
                  ),
                  SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      f.Button(
                        text: 'Cancel',
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      SizedBox(width: 16),
                      f.Button(
                        text: "Save",
                        isLoading:
                            state.createStatus == MarketCreateStatus.loading,
                        primary: kswPrimaryColor,
                        textColor: kWhite,
                        onPressed: () async {
                          if (true) {
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
