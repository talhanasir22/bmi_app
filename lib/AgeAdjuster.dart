import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'Secondbtn.dart';

class AgeAdjuster extends StatefulWidget {
  final Function(int) onAgeChanged;

  const AgeAdjuster({super.key, required this.onAgeChanged});

  @override
  State<AgeAdjuster> createState() => _AgeAdjusterState();
}

class _AgeAdjusterState extends State<AgeAdjuster> {
  int Age = 0;
  late TextEditingController AgeController;

  @override
  void initState() {
    super.initState();
    AgeController = TextEditingController(text: Age.toString());
  }

  @override
  void dispose() {
    AgeController.dispose();
    super.dispose();
  }

  void updateAge(int newAge) {
    setState(() {
      Age = newAge.clamp(0, 199); // Ensure Age stays within the 0-199 range
      AgeController.text = Age.toString();
    });
    widget.onAgeChanged(Age);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: 170,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Theme.of(context).colorScheme.primaryContainer,
      ),
      child: Column(
        children: [
          const Text(
            'Age (years)',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),

          const SizedBox(height: 40,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SecondButton(
                onpress: () {
                  setState(() {
                    if (Age > 0) {
                      Age--;
                      AgeController.text = Age.toString();
                      widget.onAgeChanged(Age);
                    }
                  });
                },
                icon: Icons.remove,
              ),
              SizedBox(
                width: 55,
                child: TextField(
                  controller: AgeController,
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onSurface,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                  ),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(
                      RegExp(r'^[0-9]*$'), // Allow any numeric input
                    ),
                  ],
                  onChanged: (value) {
                    // Remove leading zeros
                    if (value.startsWith('0') && value.length > 1) {
                      value = value.replaceFirst(RegExp(r'^0+'), '');
                      AgeController.text = value;
                      AgeController.selection = TextSelection.fromPosition(
                        TextPosition(offset: AgeController.text.length),
                      );
                    }

                    // Prevent updating the field if the content is '0' and '0' is pressed again
                    if (value.isEmpty || (value == '0' && AgeController.text == '0')) {
                      return;
                    }

                    // If input length exceeds 3 digits, keep the content unchanged
                    if (value.length > 3) {
                      AgeController.text = Age.toString();
                      AgeController.selection = TextSelection.fromPosition(
                        TextPosition(offset: AgeController.text.length),
                      );
                      return;
                    }

                    // Try to parse the input value
                    final parsedValue = int.tryParse(value);
                    if (parsedValue == null || parsedValue < 0 || parsedValue > 199) {
                      // If parsing fails or the value is out of range, revert to the last valid Age
                      AgeController.text = Age.toString();
                      AgeController.selection = TextSelection.fromPosition(
                        TextPosition(offset: AgeController.text.length),
                      );
                    } else {
                      // Update the Age if valid
                      setState(() {
                        Age = parsedValue;
                        widget.onAgeChanged(Age);
                      });
                    }
                  },
                  onSubmitted: (value) {
                    final sanitizedValue = int.tryParse(value) ?? 0;
                    final clampedValue = sanitizedValue.clamp(0, 199);
                    updateAge(clampedValue);
                  },
                ),
              ),
              SecondButton(
                onpress: () {
                  setState(() {
                    if (Age < 199) {
                      Age++;
                      AgeController.text = Age.toString();
                      widget.onAgeChanged(Age);
                    }
                  });
                },
                icon: Icons.add,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
