import 'package:flutter/material.dart';

//form elemanları için verileri alıyoruz ve verilen veriye göre içeriği değiştiriyoruz
class FormItems extends StatelessWidget {
  const FormItems({
    super.key,
    required TextEditingController titlecontroller,
    required this.text,
    required this.type,
    this.simge,
  }) : _titlecontroller = titlecontroller;

  final TextEditingController _titlecontroller;
  final String text;
  final dynamic type;
  final Icon? simge;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 20,
        top: 20,
      ),
      child: TextField(
          controller: _titlecontroller,
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            focusColor: Colors.white,
            prefixIcon: simge,
            labelText: text,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
          textInputAction: TextInputAction.done),
    );
  }
}
