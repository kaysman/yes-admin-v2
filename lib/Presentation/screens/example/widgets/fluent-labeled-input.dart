import 'package:admin_v2/Presentation/shared/app_colors.dart';
import 'package:fluent_ui/fluent_ui.dart';

class FluentLabeledInput extends StatefulWidget {
  final TextEditingController controller;
  final bool isEditMode;
  final EdgeInsets? contentPadding;
  final bool isTapped;
  final String label;
  final ValueChanged<String?>? onChanged;
  const FluentLabeledInput(
      {Key? key,
      required this.controller,
      required this.isEditMode,
      this.contentPadding,
      required this.isTapped,
      this.onChanged,
      required this.label})
      : super(key: key);

  @override
  State<FluentLabeledInput> createState() => _FluentLabeledInputState();
}

class _FluentLabeledInputState extends State<FluentLabeledInput> {
  FocusNode _focusNode = FocusNode();
  TextEditingController? _controller;
  String? value;

  @override
  void initState() {
    _controller = widget.controller;

    _focusNode.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
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
        TextBox(
          padding: widget.contentPadding ?? EdgeInsets.all(14),
          controller: _controller,
          onChanged: (v) {
            widget.onChanged?.call(v);
          },
          enabled: widget.isEditMode,
          focusNode: _focusNode,
          foregroundDecoration: BoxDecoration(
            border: Border.all(
              color: Colors.transparent,
            ),
          ),
          decoration: BoxDecoration(
            border: Border.all(
              color: _focusNode.hasFocus
                  ? kswPrimaryColor
                  : widget.isTapped == true && _controller?.text == null ||
                          widget.isTapped == true &&
                              _controller?.text.isEmpty == true
                      ? Colors.red
                      : kGrey2Color,
            ),
          ),
        ),
        if (widget.isTapped && _controller?.text.isEmpty == true) ...[
          SizedBox(
            height: 8,
          ),
          Text(
            'Bos bolmaly dal',
            style: FluentTheme.of(context).typography.caption?.copyWith(
                  color: Colors.red,
                ),
          ),
        ]
      ],
    );
  }
}
