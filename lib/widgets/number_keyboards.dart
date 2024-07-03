import 'package:flutter/material.dart';

class NumberKeyboards extends StatelessWidget {
  const NumberKeyboards({super.key, required this.onKeyPressed, required this.onClose});

  final Function(String) onKeyPressed;
  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: 330,
      width: 200,
      child: Column(
        children: [
          Expanded(
            child: GridView.builder(
              itemCount: 12,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
              ),
              itemBuilder: (context, index) {
                String keyLabel;
                if (index < 9) {
                  keyLabel = '${index + 1}';
                } else if (index == 9) {
                  keyLabel = 'C';
                } else if (index == 10) {
                  keyLabel = '0';
                } else {
                  keyLabel = '←';
                }
                return GestureDetector(
                  onTap: () => onKeyPressed(keyLabel),
                  child: Container(
                    margin: EdgeInsets.all(5.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8.0),
                      color: Colors.blueAccent,
                    ),
                    child: Center(
                      child: Text(
                        keyLabel,
                        style: TextStyle(fontSize: 24, color: Colors.white),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          ElevatedButton(
            onPressed: onClose,
            child: Text('Close'),
          ),
        ],
      ),
    );
  }
}