import 'dart:ui' as ui;
import 'package:flutter/material.dart';

enum TextChangedReason {
  userInput,
  suggestionChosen,
}

/// A Material-style AutoSuggestBox that provides a list of suggestions as the user types.
class AutoSuggestBox extends StatefulWidget {
  const AutoSuggestBox({
    Key? key,
    required this.items,
    this.controller,
    this.onChanged,
    this.onSelected,
    this.leadingIcon,
    this.trailingIcon,
    this.clearButtonEnabled = true,
    this.placeholder,
    this.placeholderStyle,
    this.style,
    this.decoration,
    this.foregroundDecoration,
    this.highlightColor,
    this.cursorColor,
    this.cursorHeight,
    this.cursorRadius,
    this.cursorWidth = 1.5,
    this.showCursor,
    this.keyboardAppearance,
    this.scrollPadding = const EdgeInsets.all(20.0),
    this.selectionHeightStyle = ui.BoxHeightStyle.tight,
    this.selectionWidthStyle = ui.BoxWidthStyle.tight,
    this.contentPadding = const EdgeInsets.all(14),
  }) : super(key: key);

  final List<String> items;
  final TextEditingController? controller;
  final void Function(String text, TextChangedReason reason)? onChanged;
  final ValueChanged<String>? onSelected;
  final Widget? leadingIcon;
  final Widget? trailingIcon;
  final bool clearButtonEnabled;
  final String? placeholder;
  final TextStyle? placeholderStyle;
  final TextStyle? style;
  final BoxDecoration? decoration;
  final BoxDecoration? foregroundDecoration;
  final Color? highlightColor;
  final double cursorWidth;
  final double? cursorHeight;
  final Radius? cursorRadius;
  final Color? cursorColor;
  final bool? showCursor;
  final ui.BoxHeightStyle selectionHeightStyle;
  final ui.BoxWidthStyle selectionWidthStyle;
  final Brightness? keyboardAppearance;
  final EdgeInsets scrollPadding;
  final EdgeInsets contentPadding;

  @override
  State<AutoSuggestBox> createState() => _AutoSuggestBoxState();

  static List<T> defaultItemSorter<T>(String text, List<T> items) {
    return items
        .where((element) =>
            element.toString().toLowerCase().contains(text.toLowerCase()))
        .toList();
  }
}

class _AutoSuggestBoxState extends State<AutoSuggestBox> {
  final FocusNode focusNode = FocusNode();
  OverlayEntry? _entry;
  final LayerLink _layerLink = LayerLink();
  final GlobalKey _textBoxKey = GlobalKey();

  late TextEditingController controller;
  final FocusScopeNode overlayNode = FocusScopeNode();

  @override
  void initState() {
    super.initState();
    controller = widget.controller ?? TextEditingController();
    focusNode.addListener(_handleFocusChanged);
  }

  @override
  void dispose() {
    focusNode.removeListener(_handleFocusChanged);
    if (widget.controller == null) {
      controller.dispose();
    }
    overlayNode.dispose();
    _dismissOverlay();
    super.dispose();
  }

  void _handleFocusChanged() {
    if (!focusNode.hasFocus) {
      _dismissOverlay();
    } else {
      _showOverlay();
    }
    setState(() {});
  }

  void _insertOverlay() {
    _entry = OverlayEntry(builder: (context) {
      final box = _textBoxKey.currentContext?.findRenderObject() as RenderBox?;
      if (box == null) return const SizedBox.shrink();
      return Positioned(
        width: box.size.width,
        child: CompositedTransformFollower(
          link: _layerLink,
          showWhenUnlinked: false,
          offset: Offset(0, box.size.height + 4),
          child: _AutoSuggestBoxOverlay(
            node: overlayNode,
            controller: controller,
            items: widget.items,
            onSelected: (String item) {
              widget.onSelected?.call(item);
              controller.text = item;
              controller.selection = TextSelection.collapsed(offset: item.length);
              widget.onChanged?.call(item, TextChangedReason.suggestionChosen);
              _dismissOverlay();
              focusNode.unfocus();
            },
          ),
        ),
      );
    });

    if (_textBoxKey.currentContext != null) {
      Overlay.of(context)?.insert(_entry!);
    }
  }

  void _dismissOverlay() {
    _entry?.remove();
    _entry = null;
  }

  void _showOverlay() {
    if (_entry == null) {
      _insertOverlay();
    }
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: TextField(
        key: _textBoxKey,
        controller: controller,
        focusNode: focusNode,
        decoration: InputDecoration(
          prefixIcon: widget.leadingIcon,
          suffixIcon: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (widget.trailingIcon != null) widget.trailingIcon!,
              if (widget.clearButtonEnabled && controller.text.isNotEmpty)
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () {
                    controller.clear();
                    focusNode.unfocus();
                  },
                ),
            ],
          ),
          hintText: widget.placeholder,
          hintStyle: widget.placeholderStyle,
          contentPadding: widget.contentPadding,
          border: const OutlineInputBorder(),
        ),
        style: widget.style,
        cursorColor: widget.cursorColor,
        cursorHeight: widget.cursorHeight,
        cursorRadius: widget.cursorRadius,
        cursorWidth: widget.cursorWidth,
        showCursor: widget.showCursor,
        scrollPadding: widget.scrollPadding,
        onChanged: (text) {
          widget.onChanged?.call(text, TextChangedReason.userInput);
          _showOverlay();
        },
      ),
    );
  }
}

class _AutoSuggestBoxOverlay extends StatelessWidget {
  const _AutoSuggestBoxOverlay({
    Key? key,
    required this.items,
    required this.controller,
    required this.onSelected,
    required this.node,
  }) : super(key: key);

  final List items;
  final TextEditingController controller;
  final ValueChanged<String> onSelected;
  final FocusScopeNode node;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return FocusScope(
      node: node,
      child: Container(
        constraints: const BoxConstraints(maxHeight: 380),
        decoration: BoxDecoration(
          color: theme.cardColor,
          borderRadius: const BorderRadius.vertical(bottom: Radius.circular(4.0)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              offset: const Offset(-1, 1),
              blurRadius: 2.0,
              spreadRadius: 3.0,
            ),
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              offset: const Offset(1, 1),
              blurRadius: 2.0,
              spreadRadius: 3.0,
            ),
          ],
        ),
        child: ValueListenableBuilder<TextEditingValue>(
          valueListenable: controller,
          builder: (context, value, _) {
            final items = AutoSuggestBox.defaultItemSorter(
              value.text,
              this.items,
            );
            if (items.isEmpty) {
              return const Padding(
                padding: EdgeInsets.only(bottom: 4.0),
                child: ListTile(
                  title: Text('No results found'),
                ),
              );
            }
            return ListView.builder(
              shrinkWrap: true,
              padding: const EdgeInsets.only(bottom: 4.0),
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index];
                return ListTile(
                  title: Text('$item'),
                  onTap: () => onSelected(item),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
