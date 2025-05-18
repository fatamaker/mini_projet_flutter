import 'package:flutter/material.dart';

class InputSearch extends StatelessWidget {
  final ValueChanged<String> onChanged;

  const InputSearch({super.key, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: 'Search...',
        fillColor: Colors.white,
        filled: true,
        prefixIcon: const Icon(Icons.search),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(
                width: 2, color: Color.fromARGB(255, 223, 174, 12))),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(width: 2, color: Colors.black)),
      ),
    );
  }
}
