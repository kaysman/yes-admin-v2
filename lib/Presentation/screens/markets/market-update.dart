import 'package:admin_v2/Data/models/market/market.model.dart';
import 'package:admin_v2/Presentation/screens/markets/bloc/market.bloc.dart';
import 'package:admin_v2/Presentation/screens/markets/bloc/market.state.dart';
import 'package:admin_v2/Presentation/shared/app_colors.dart';
import 'package:admin_v2/Presentation/shared/components/button.dart';
import 'package:admin_v2/Presentation/shared/components/input_fields.dart';
import 'package:admin_v2/Presentation/shared/helpers.dart';
import 'package:admin_v2/Presentation/shared/validators.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UpdateMarketPage extends StatefulWidget {
  const UpdateMarketPage({
    Key? key,
    required this.market,
  }) : super(key: key);

  final MarketEntity market;

  @override
  State<UpdateMarketPage> createState() => UpdateMarketPageState();
}

class UpdateMarketPageState extends State<UpdateMarketPage> {
  late MarketBloc marketBloc;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final addressController = TextEditingController();
  final descriptionController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final ownerNameController = TextEditingController();
  bool editMode = false;

  @override
  void initState() {
    marketBloc = BlocProvider.of<MarketBloc>(context);

    titleController.text = widget.market.title ?? '';
    addressController.text = widget.market.address ?? '';
    descriptionController.text = widget.market.description ?? '';
    phoneNumberController.text = widget.market.phoneNumber ?? '';
    ownerNameController.text = widget.market.ownerName ?? '';
    super.initState();
  }

  String? get getOldTitle => widget.market.title;
  String? get getOldAdress => widget.market.address;
  String? get getOldDescription => widget.market.description;
  String? get getOldPhoneNumber => widget.market.phoneNumber;
  String? get getOldOwnerName => widget.market.ownerName;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MarketBloc, MarketState>(
      listenWhen: (state1, state2) {
        return state1.marketDeleteStatus != state2.marketDeleteStatus ||
            state1.marketUpadteStatus != state2.marketUpadteStatus;
      },
      listener: (context, state) {
        if (state.marketDeleteStatus == MarketDeleteStatus.success) {
          print(state.marketDeleteStatus);
          showSnackBar(
            context,
            Text('Deleted successfully'),
            type: SnackbarType.success,
          );
          Navigator.of(context).pop();
        } else if (state.marketUpadteStatus == MarketUpadteStatus.success) {
          print(state.marketUpadteStatus);
          showSnackBar(
            context,
            Text('Updated successfully'),
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
                  SizedBox(height: 12),
                  OutlinedButton(
                    onPressed: () => setState(() => editMode = !editMode),
                    child: Text(
                      editMode ? "Ignore" : "Üýtget",
                      // style: Theme.of(context).textTheme.caption,
                    ),
                  ),
                  SizedBox(height: 20),
                  LabeledInput(
                    controller: titleController,
                    hintText: "Markediň ady *",
                    validator: emptyField,
                    editMode: editMode,
                  ),
                  SizedBox(height: 14),
                  LabeledInput(
                    controller: descriptionController,
                    hintText: "Barada",
                    editMode: editMode,
                  ),
                  SizedBox(height: 14),
                  LabeledInput(
                    controller: addressController,
                    hintText: "Salgysy",
                    editMode: editMode,
                  ),
                  SizedBox(height: 14),
                  LabeledInput(
                    controller: phoneNumberController,
                    validator: emptyField,
                    hintText: "Telefon *",
                    editMode: editMode,
                  ),
                  SizedBox(height: 14),
                  LabeledInput(
                    controller: ownerNameController,
                    hintText: "Eýesiniň ady",
                    editMode: editMode,
                  ),
                  SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Button(
                        text: 'Delete',
                        textColor: Colors.redAccent,
                        borderColor: Colors.redAccent,
                        isLoading: state.marketDeleteStatus ==
                            MarketDeleteStatus.loading,
                        onPressed: () async {
                          if (widget.market.id != null) {
                            await marketBloc.deleteMarket(widget.market.id!);
                          }
                        },
                      ),
                      SizedBox(width: 16),
                      Button(
                        text: "Upadete",
                        textColor: kWhite,
                        isLoading: state.marketUpadteStatus ==
                            MarketUpadteStatus.loading,
                        primary: kswPrimaryColor,
                        onPressed: () async {
                          if (formKey.currentState!.validate()) {
                            MarketEntity data = MarketEntity(
                              id: widget.market.id,
                              title: checkIfChangedAndReturn(
                                  getOldTitle, titleController.text),
                              address: checkIfChangedAndReturn(
                                  getOldAdress, addressController.text),
                              description: checkIfChangedAndReturn(
                                  getOldDescription,
                                  descriptionController.text),
                              phoneNumber: checkIfChangedAndReturn(
                                  getOldPhoneNumber,
                                  phoneNumberController.text),
                              ownerName: checkIfChangedAndReturn(
                                  getOldOwnerName, ownerNameController.text),
                              products: [],
                            );
                            await marketBloc.updateMarket(data);
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
