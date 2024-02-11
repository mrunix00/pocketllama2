import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../bloc/text_generation/text_generation_bloc.dart';

class GenerateButton extends StatelessWidget {
  const GenerateButton({
    super.key,
    required this.controller,
  });

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return IconButton.filled(
      iconSize: 20,
      onPressed: () {
        BlocProvider.of<TextGenerationBloc>(context).add(
          GenerateText(controller.text.trim()),
        );
      },
      icon: const Icon(Icons.edit),
    );
  }
}
