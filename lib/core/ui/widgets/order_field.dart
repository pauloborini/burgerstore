import 'package:flutter/material.dart';
import '../styles/text_styles.dart';

class OrderField extends StatelessWidget {
  final String title;
  final TextEditingController controller;
  final FormFieldValidator validator;
  final TextInputType keyboardType;
  final String hintText;

  const OrderField({
    super.key,
    required this.title,
    required this.controller,
    required this.validator,
    required this.hintText,
    required this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    const defaultBorder = UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey));
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: context.textStyles.medium),
        TextFormField(
          controller: controller,
          validator: validator,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            hintText: hintText,
            contentPadding: EdgeInsets.zero,
            hintStyle: context.textStyles.regular.copyWith(fontSize: 13),
            border: defaultBorder,
            enabledBorder: defaultBorder,
            focusedBorder: defaultBorder,
          ),
        ),
      ],
    );
  }
}
