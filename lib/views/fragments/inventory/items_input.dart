import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ItemsInput extends StatefulWidget {
  final String num;
  final Function(String num, int qty) onInputChanged;

  ItemsInput({required this.num, required this.onInputChanged});

  @override
  State<ItemsInput> createState() => _ItemsInputState();
}

class _ItemsInputState extends State<ItemsInput> {
  TextEditingController _controller = TextEditingController();
  bool _isValid = true;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextField(
        controller: _controller,
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly // Only allows digits
        ],
        decoration: InputDecoration(
          border: OutlineInputBorder(),
        ),
        onChanged: (value) {
          // Validate input and update the quantity
          final qty = int.tryParse(value);
          if (qty != null && qty >= 0) {
            setState(() {
              _isValid = true;
            });
            widget.onInputChanged(widget.num, qty); // Update the qty for this num
          } else {
            setState(() {
              _isValid = false;
            });
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose(); // Dispose of the controller when the widget is removed
    super.dispose();
  }
}
