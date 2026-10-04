import 'package:flutter/material.dart';

class AdminMainScreen extends StatelessWidget {
  final Widget child;
  const AdminMainScreen({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: child);
  }
}

