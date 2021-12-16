import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class FormError extends StatelessWidget {
  final List<String> errors;

  const FormError(this.errors, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
          errors.length, (index) => formErrorText(error: errors[index])),
    );
  }

  Row formErrorText({String? error}) {
    return Row(
      children: [
        const FaIcon(
          FontAwesomeIcons.exclamationTriangle,
          size: 14,
          color: Colors.red,
        ),
        const SizedBox(
          width: 10,
        ),
        Text(
          error!,
          style: const TextStyle(color: Colors.red),
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
