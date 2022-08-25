import 'package:admin_v2/Presentation/screens/example/widgets/auto-suggested-box.dart'
    as c;
import 'package:admin_v2/Presentation/shared/app_colors.dart';
import 'package:fluent_ui/fluent_ui.dart';

class CustomAutoSuggestedBox extends StatefulWidget {
  final String? validateText;
  final GlobalKey<FormState>? formStateForValidate;
  final List<String> items;
  final bool? isTapped;
  final String label;
  final String? hintText;
  final bool isEditMode;
  final EdgeInsets? contentPadding;
  Color? focusedBorderColor;
  Color? borderColor;
  final ValueChanged<String?> onChanged;
  CustomAutoSuggestedBox({
    Key? key,
    this.validateText,
    required this.items,
    required this.onChanged,
    this.contentPadding,
    this.focusedBorderColor,
    this.borderColor,
    this.formStateForValidate,
    this.isTapped,
    required this.label,
    required this.isEditMode,
    this.hintText,
  }) : super(key: key);

  @override
  State<CustomAutoSuggestedBox> createState() => _CustomAutoSuggestedBoxState();
}

class _CustomAutoSuggestedBoxState extends State<CustomAutoSuggestedBox> {
  bool hasNode = false;
  TextEditingController controller = TextEditingController();
  GlobalKey<FormState>? formKey;
  String? value;
  Color? focusedBorderColor;

  Color? borderColor;

  @override
  void initState() {
    if (widget.focusedBorderColor == null) {
      focusedBorderColor = kPrimaryColor;
    } else {
      focusedBorderColor = widget.focusedBorderColor!;
    }
    if (widget.borderColor == null) {
      borderColor = kGrey1Color;
    } else {
      borderColor = widget.borderColor!;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: !widget.isEditMode,
      child: FocusScope(
        onFocusChange: (v) {
          setState(() {
            hasNode = v;
          });
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              widget.label,
              style: FluentTheme.of(context).typography.body?.copyWith(
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                    color: kGrey1Color,
                  ),
            ),
            SizedBox(
              height: 8,
            ),
            c.AutoSuggestBox(
              placeholder: widget.hintText,
              placeholderStyle:
                  FluentTheme.of(context).typography.body?.copyWith(
                        color: kGrey2Color,
                      ),
              controller: controller,
              contentPadding: widget.contentPadding ?? EdgeInsets.all(14),
              foregroundDecoration: BoxDecoration(
                border: Border.all(
                  color: Colors.transparent,
                ),
              ),
              decoration: BoxDecoration(
                border: Border.all(
                  color: hasNode
                      ? kswPrimaryColor
                      : widget.isTapped == true && controller.text.isEmpty
                          ? Colors.red
                          : kGrey2Color,
                ),
              ),
              items: widget.items,
              onChanged: (v, r) {
                setState(() {
                  value = v;
                });
                widget.onChanged.call(v);
              },
            ),
            if (widget.isTapped == true && controller.text.isEmpty) ...[
              SizedBox(
                height: 5,
              ),
              Text(
                widget.validateText ?? 'Bos bolmaly dal',
                style: FluentTheme.of(context).typography.caption?.copyWith(
                      color: Colors.red,
                    ),
              )
            ]
          ],
        ),
      ),
    );
  }
}
