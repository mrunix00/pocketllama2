import 'package:flutter/material.dart';

class ColumnContainer extends StatelessWidget {
  const ColumnContainer({
    super.key,
    required this.children,
  });

  final List<Widget> children;

  @override
  Widget build(BuildContext context) => Container(
        margin: const EdgeInsets.all(10),
        child: Column(children: children),
      );
}
