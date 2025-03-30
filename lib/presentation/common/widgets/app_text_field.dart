import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import '../constants/app_text_styles.dart';

class AppTextField extends StatefulWidget {
  const AppTextField({
    required this.initialText,
    required this.onChange,
    required this.hintText,
    this.inputType,
    this.obscureText = false,
    this.maxLines,
    super.key,
  });

  final String? initialText;
  final String hintText;
  final void Function(String) onChange;
  final TextInputType? inputType;
  final bool obscureText;
  final int? maxLines;

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  late final TextEditingController _controller;
  late final _focusNode = FocusNode();

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
  }

  @override
  Widget build(BuildContext context) => TextField(
        controller: _controller,
        focusNode: _focusNode,
        maxLines: widget.maxLines,
        onTapUpOutside: (e) {
          print(e.kind);
          _focusNode.unfocus();
        },
        obscureText: widget.obscureText,
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
        ),
      );
}
