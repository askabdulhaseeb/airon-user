import 'package:flutter/material.dart';

class CustomDropdown extends StatelessWidget {
  const CustomDropdown({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(20),
      ),
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(horizontal: 16),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
        ),
        validator: (String? value) =>
            value == null || value.isEmpty ? 'Select the Collection' : null,
        items: const <DropdownMenuItem<String>>[
          DropdownMenuItem(value: 'value1', child: Text('data')),
          DropdownMenuItem(value: 'value2', child: Text('dat2')),
          DropdownMenuItem(value: 'value3', child: Text('dat3')),
          DropdownMenuItem(value: 'value4', child: Text('dat4')),
          DropdownMenuItem(value: 'value5', child: Text('dat5')),
        ],
        onChanged: (String? value) {},
      ),
    );
  }
}
