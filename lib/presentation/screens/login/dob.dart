import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:vibehunt/presentation/widgets/textfield.dart';

class MyDOBField extends StatefulWidget {
  final TextEditingController controller;

  const MyDOBField({Key? key, required this.controller}) : super(key: key);

  @override
  _MyDOBFieldState createState() => _MyDOBFieldState();
}

class _MyDOBFieldState extends State<MyDOBField> {
  void _selectDate(BuildContext context) async {
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (selectedDate != null) {
      setState(() {
        widget.controller.text = DateFormat('dd-MM-yyyy').format(selectedDate);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _selectDate(context),
      child: AbsorbPointer(
        child: MyTextfield(
          controller: widget.controller,
          hintText: 'DD-MM-YYYY',
          prefixIcon: const Icon(Icons.calendar_today),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Date of birth is required';
            }
            return null;
          },
          maxline: 1,
        ),
      ),
    );
  }
}
