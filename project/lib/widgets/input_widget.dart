import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:project/enum/inputType_enum.dart';
import 'package:project/utils/theme_utils.dart';

class Input extends StatefulWidget {
  final void Function(String)? onChanged;
  final void Function(String?)? onSaved;
  final TextEditingController? controller;
  final InputTypeEnum? inputFormat;
  final int? maxDigitsLength;
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

  const Input({
    super.key,
    this.onChanged,
    this.onSaved,
    this.value,
    this.label,
    this.hint,
    this.obscureText = false,
    this.controller,
    this.inputFormat = InputTypeEnum.none,
    this.maxDigitsLength,
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
    if (controller.text == txt) return;

    controller.text = txt;
    controller.selection =
        TextSelection.collapsed(offset: controller.text.length);
  }

  List<TextInputFormatter>? _getInputFormatters() {
    switch (widget.inputFormat) {
      case InputTypeEnum.lettersOnly:
        return [
          FilteringTextInputFormatter.allow(RegExp(r'[a-zA-ZÀ-ÿ\s]')),
        ];
      case InputTypeEnum.numbersOnly:
        return [
          FilteringTextInputFormatter.digitsOnly,
        ];
      case InputTypeEnum.none:
      default:
        return null;
    }
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
            style:
                const TextStyle(color: Colors.black), // Cor do texto digitado
            textDirection: TextDirection.ltr,
            onChanged: (value) => widget.onChanged?.call(value),
            onSaved: widget.onSaved,
            inputFormatters: _getInputFormatters(),
            controller: controller,
            focusNode: focusNode,
            readOnly: widget.readonly,
            maxLength: widget.maxDigitsLength,
            maxLines: widget.maxLines,
            textInputAction: widget.action,
            decoration: InputDecoration(
                contentPadding: widget.contentPadding,
                suffixIcon: widget.suffixIcon,
                suffixText: widget.suffixText,
                prefixIcon: widget.preffixIcon,
                fillColor: ThemeUtils.backgroundColor, // cor de dentro
                filled: true,
                hintMaxLines: 1,
                label: widget.label == null
                    ? null
                    : Text(
                        widget.label!,
                        style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold), // Cor do label
                      ),
                labelStyle: const TextStyle(
                  fontWeight: FontWeight.w500,
                ),
                hintText: widget.hint,
                border: widget.haveBorder
                    ? widget.border ??
                        OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(
                              color: Colors.black), // Cor da borda
                        )
                    : null,
                enabledBorder: widget.haveBorder
                    ? widget.enableBorder ??
                        OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(
                              color: Colors
                                  .black), // Cor da borda quando habilitado
                        )
                    : null,
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: Colors.black))),

            obscureText: widget.obscureText,
            textAlign: widget.textAlign ?? TextAlign.start,
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    if (widget.controller == null) controller.dispose();
    if (widget.focusNode == null) focusNode?.dispose();
    super.dispose();
  }
}
