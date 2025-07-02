import 'package:flutter/material.dart';
import 'package:rafek_mumen/utils/theme/app_colors.dart';
import 'package:rafek_mumen/utils/theme/sizes.dart';

class MyTextField extends StatefulWidget {
  final TextEditingController controller;
  final Widget? suffixIcon;
  final IconData? prefixIcon;
  final void Function()? onPressedSuffixIcon;
  final bool isOnPressedSuffixIconClearText;
  final String? hintText;
  final void Function(String)? onChanged;
  final Color fillColor;
  final void Function()? onTap;
  final bool readOnly;
  final bool autofocus;

  const MyTextField({
    super.key,
    required this.controller,
    this.suffixIcon,
    this.prefixIcon,
    this.onPressedSuffixIcon,
    this.isOnPressedSuffixIconClearText = true,
    this.hintText = "label",
    this.onChanged,
    this.fillColor = Colors.white,
    this.onTap,
    this.readOnly = false,
    this.autofocus = false,
  });

  @override
  State<MyTextField> createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  final FocusNode _focusNode = FocusNode();
  @override
  void initState() {
    super.initState();
    if (!widget.readOnly) {
      _focusNode.addListener(_handleFocusChange);
    }
  }

  void _handleFocusChange() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(kWidgetPadding),
      child: Focus(
        focusNode: widget.readOnly ? null : _focusNode,
        child: TextFormField(
          autofocus: widget.autofocus,
          readOnly: widget.readOnly,
          onTap: widget.onTap,
          controller: widget.controller,
          decoration: InputDecoration(
            fillColor: widget.fillColor,
            filled: true,
            hintText: widget.hintText,
            suffixIcon: widget.controller.text.isEmpty
                ? const SizedBox()
                : IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () {
                      if (widget.isOnPressedSuffixIconClearText) {
                        setState(() {
                          widget.controller.clear();
                        });
                      }
                      if (widget.onPressedSuffixIcon != null) {
                        widget.onPressedSuffixIcon!();
                      }
                    },
                  ),
            prefixIcon: Icon(
              widget.prefixIcon,
              color: _focusNode.hasFocus ? kPrimaryColor : Colors.grey,
            ),
          ),
          onChanged: widget.onChanged,
        ),
      ),
    );
  }

  @override
  void dispose() {
    if (!widget.readOnly) {
      _focusNode.dispose();
      widget.controller.dispose();
    }
    super.dispose();
  }
}
