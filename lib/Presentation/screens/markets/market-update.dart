import 'package:admin_v2/Data/models/market/market.model.dart';
import 'package:admin_v2/Presentation/screens/example/widgets/fluent-labeled-input.dart';
import 'package:admin_v2/Presentation/screens/markets/bloc/market.bloc.dart';
import 'package:admin_v2/Presentation/shared/app_colors.dart';
import 'package:admin_v2/Presentation/shared/components/button.dart' as f;
import 'package:admin_v2/Presentation/shared/helpers.dart';
import 'package:fluent_ui/fluent_ui.dart';
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
                style: FluentTheme.of(context).typography.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
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
              FluentLabeledInput(
                controller: titleController,
                isTapped: false,
                label: "Markediň ady *",
                isEditMode: editMode,
              ),
              SizedBox(height: 14),
              FluentLabeledInput(
                isTapped: false,
                label: "Barada",
                isEditMode: editMode,
                controller: descriptionController,
              ),
              SizedBox(height: 14),
              FluentLabeledInput(
                isTapped: false,
                label: "Salgysy",
                isEditMode: editMode,
                controller: addressController,
              ),
              SizedBox(height: 14),
              FluentLabeledInput(
                isTapped: false,
                label: "Telefon *",
                isEditMode: editMode,
                controller: phoneNumberController,
              ),
              SizedBox(height: 14),
              FluentLabeledInput(
                isTapped: false,
                label: "Eýesiniň ady",
                isEditMode: editMode,
                controller: ownerNameController,
              ),
              SizedBox(height: 24),
              f.Button(
                text: "Upadete",
                textColor: kWhite,
                primary: kswPrimaryColor,
                onPressed: () async {
                  if (true) {
                    MarketEntity data = MarketEntity(
                      id: widget.market.id,
                      title: checkIfChangedAndReturn(
                          getOldTitle, titleController.text),
                      address: checkIfChangedAndReturn(
                          getOldAdress, addressController.text),
                      description: checkIfChangedAndReturn(
                          getOldDescription, descriptionController.text),
                      phoneNumber: checkIfChangedAndReturn(
                          getOldPhoneNumber, phoneNumberController.text),
                      ownerName: checkIfChangedAndReturn(
                          getOldOwnerName, ownerNameController.text),
                      products: [],
                    );
                    Navigator.of(context).pop(data);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
