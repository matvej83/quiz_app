import 'package:flutter/material.dart';

class PronounceButton extends StatelessWidget {
  const PronounceButton({super.key, required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return IconButton(onPressed: onTap, icon: const Icon(Icons.mic));
  }
}
