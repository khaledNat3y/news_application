import 'package:flutter/material.dart';

class ErrorView extends StatelessWidget {
  final String error;

  const ErrorView({super.key, required this.error,});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(error),
        ElevatedButton(
            onPressed: (){},
            child: Text("Refresh")),
      ],
    );
  }
}