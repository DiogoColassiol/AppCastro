import 'package:flutter/material.dart';

class Input extends StatefulWidget {
  final void Function(String)? onChanged;
  final void Function(String?)? onSaved;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final String? label;
  final String? hint;
  final String? value;
  final bool obscureText;
  final Widget? suffixIcon;
  final bool readonly;
  final int? maxLines;
  final int? minLines;
  final InputBorder? border;
  final InputBorder? enableBorder;
  final TextInputAction? action;
  final EdgeInsetsGeometry? contentPadding;
  final String? tooltip;
  final String? suffixText;
  final TextAlign? textAlign;
  final Widget? preffixIcon;
  final bool haveBorder;
  final Color? labelTextColor;

  const Input({
    super.key,
    this.onChanged,
    this.onSaved,
    this.value,
    this.label,
    this.hint,
    this.obscureText = false,
    this.controller,
    this.focusNode,
    this.suffixIcon,
    this.readonly = false,
    this.maxLines,
    this.minLines,
    this.border,
    this.action,
    this.contentPadding,
    this.enableBorder,
    this.tooltip,
    this.suffixText,
    this.textAlign,
    this.preffixIcon,
    this.haveBorder = true,
    this.labelTextColor,
  });

  @override
  State<Input> createState() => _InputState();
}

class _InputState extends State<Input> {
  TextEditingController controller = TextEditingController();
  FocusNode? focusNode;
  ThemeData? tema;

  @override
  void initState() {
    super.initState();
    focusNode = widget.focusNode;
    if (widget.controller != null) {
      controller = widget.controller!;
    }
    if (widget.value != null) {
      controller = TextEditingController(text: widget.value);
    }
  }

  @override
  void didChangeDependencies() {
    tema = Theme.of(context);
    super.didChangeDependencies();
  }

  void onFocus() {
    if (focusNode != null && focusNode!.hasFocus) {
      controller.selection =
          TextSelection(baseOffset: 0, extentOffset: controller.text.length);
    }
  }

  void verifyValueChanges() {
    String? txt = widget.value ?? controller.text;
    if (controller.text == txt) {
      return;
    }
    controller.text = txt;
    controller.selection = TextSelection(
        baseOffset: controller.text.length,
        extentOffset: controller.text.length);
  }

  @override
  Widget build(BuildContext context) {
    verifyValueChanges();
    return Visibility(
      child: Padding(
        padding: const EdgeInsets.only(top: 5.0),
        child: Tooltip(
          message: widget.tooltip ?? '',
          child: TextFormField(
            style: TextStyle(
                color: widget.readonly
                    ? tema!.brightness == Brightness.dark
                        ? Colors.grey[700]
                        : Colors.grey[800]
                    : tema!.brightness == Brightness.dark
                        ? Colors.white
                        : Colors.black),
            textDirection: TextDirection.ltr,
            onChanged: (value) {
              if (widget.onChanged != null) {
                widget.onChanged!(value);
              }
            },
            onSaved: widget.onSaved,
            controller: controller,
            focusNode: focusNode,
            readOnly: widget.readonly,
            maxLines: widget.maxLines ?? 1,
            textInputAction: widget.action,
            decoration: InputDecoration(
              contentPadding: widget.contentPadding,
              suffixIcon: widget.suffixIcon,
              suffixText: widget.suffixText,
              prefixIcon: widget.preffixIcon,
              fillColor: tema?.brightness == Brightness.dark
                  ? Colors.black12
                  : Colors.grey[100],
              filled: widget.readonly,
              hintMaxLines: 1,
              label: widget.label == null
                  ? null
                  : Text(
                      widget.label!,
                      style: TextStyle(color: widget.labelTextColor),
                    ),
              labelStyle: const TextStyle(
                fontWeight: FontWeight.w500,
              ),
              hintText: widget.hint,
              border: widget.haveBorder
                  ? widget.border ??
                      OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      )
                  : null,
              enabledBorder: widget.haveBorder
                  ? widget.border ??
                      OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(
                              color: tema?.brightness == Brightness.dark
                                  ? Colors.grey
                                  : Colors.black))
                  : null,
            ),
            obscureText: widget.obscureText,
            textAlign: widget.textAlign ?? TextAlign.start,
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      controller.dispose();
    }
    if (widget.focusNode == null) {
      focusNode?.dispose();
    }
    super.dispose();
  }
}
