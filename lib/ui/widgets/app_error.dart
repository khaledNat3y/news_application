import 'package:flutter/material.dart';

class ErrorView extends StatelessWidget {
  final String error;
  final Function? onRefreshClick;
  const ErrorView({super.key, required this.error, this.onRefreshClick});
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(error),
        ElevatedButton(
            onPressed: (){
              onRefreshClick?.call();
            },
            child: Text("Refresh")),
      ],
    );
  }
}