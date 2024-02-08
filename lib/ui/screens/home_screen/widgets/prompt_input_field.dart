import 'package:flutter/material.dart';

class PromptInputField extends StatelessWidget {
  const PromptInputField({super.key});

  @override
  Widget build(BuildContext context) {
    return const TextField(
      decoration: InputDecoration(
        hintText: 'Prompt',
        filled: true,
        border: UnderlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(30)),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
