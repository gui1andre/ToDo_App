import 'package:flutter/material.dart';

class ChipCategoria extends StatelessWidget {
  const ChipCategoria({super.key, required this.titulo});
  final String titulo;

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Container(
      decoration: BoxDecoration(
          color: Colors.grey, borderRadius: BorderRadius.circular(16)),
      padding: const EdgeInsets.all(8),
      alignment: Alignment.center,
      child: Text(
        titulo,
        style: textTheme.bodySmall,
      ),
    );
  }
}
