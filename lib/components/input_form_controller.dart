import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class ReusableInputFormField extends StatelessWidget {
  final String id;
  final String label;
  final String placeholder;
  final TextEditingController? controller; // Add controller parameter
  final String? Function(String?)? validator;

  const ReusableInputFormField({
    Key? key,
    required this.id,
    required this.label,
    required this.placeholder,
    this.controller, // Initialize the controller
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ShadInputFormField(
      id: id,
      label: Text(label, style: TextStyle(
        fontSize: 17,
        fontWeight: FontWeight.w600
      ),),
      placeholder: Text(placeholder),
      controller: controller, // Pass the controller to the ShadInputFormField
      validator: validator,
      decoration: ShadDecoration(  
        labelPadding: const EdgeInsets.only(bottom: 2),
      ),
    );
  }
}
