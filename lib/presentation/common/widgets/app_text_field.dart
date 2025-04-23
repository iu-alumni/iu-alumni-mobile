import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import '../constants/app_text_styles.dart';

class AppTextField extends StatefulWidget {
  const AppTextField({
    required this.onChange,
    required this.initialText,
    this.hintText = '',
    this.inputType,
    this.obscureText = false,
    this.maxLines,
    this.validate,
    super.key,
  });

  final String? initialText;
  final String hintText;
  final void Function(String) onChange;
  final TextInputType? inputType;
  final bool obscureText;
  final int? maxLines;
  final String? Function(String)? validate;

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  late final TextEditingController _controller;
  late final _focusNode = FocusNode();

  late var _textObscured = widget.obscureText;
  String? _errorText;

  @override
  void initState() {
    _controller = TextEditingController(text: widget.initialText);
    _controller.addListener(_onChange);
    super.initState();
  }

  @override
  void dispose() {
    _controller.removeListener(_onChange);
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _onChange() {
    final text = _controller.text;
    widget.onChange(text);
    final newError = widget.validate?.call(text);
    if (newError != _errorText) {
      setState(() => _errorText = newError);
    }
  }

  @override
  Widget build(BuildContext context) => TextField(
        controller: _controller,
        focusNode: _focusNode,
        maxLines: widget.maxLines,
        onTapUpOutside: (e) => _focusNode.unfocus(),
        obscureText: _textObscured,
        style: AppTextStyles.body,
        keyboardType: widget.inputType,
        decoration: InputDecoration(
          hintText: widget.hintText,
          hintStyle: AppTextStyles.body.copyWith(color: AppColors.blueGray),
          fillColor: AppColors.lightGray,
          filled: true,
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(4),
          ),
          errorText: _errorText,
          suffixIcon: widget.obscureText
              ? IconButton(
                  onPressed: () => setState(
                    () => _textObscured = !_textObscured,
                  ),
                  icon: Icon(
                    _textObscured ? Icons.visibility : Icons.visibility_off,
                    color: AppColors.blueGray,
                  ),
                )
              : null,
        ),
      );
}
