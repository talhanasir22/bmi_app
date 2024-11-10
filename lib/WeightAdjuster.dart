import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'Secondbtn.dart';

class WeightAdjuster extends StatefulWidget {
  final Function(int) onWeightChanged;

  const WeightAdjuster({super.key, required this.onWeightChanged});

  @override
  State<WeightAdjuster> createState() => _WeightAdjusterState();
}

class _WeightAdjusterState extends State<WeightAdjuster> {
  int weight = 0;
  late TextEditingController weightController;

  @override
  void initState() {
    super.initState();
    weightController = TextEditingController(text: weight.toString());
  }

  @override
  void dispose() {
    weightController.dispose();
    super.dispose();
  }

  void updateWeight(int newWeight) {
    setState(() {
      weight = newWeight.clamp(0, 999); // Ensure weight stays within the 0-999 range
      weightController.text = weight.toString();
    });
    widget.onWeightChanged(weight);
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
            'Weight (Kg)',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          const SizedBox(height: 40,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SecondButton(
                onpress: () {
                  setState(() {
                    if (weight > 0) {
                      weight--;
                      weightController.text = weight.toString();
                      widget.onWeightChanged(weight);
                    }
                  });
                },
                icon: Icons.remove,
              ),

              SizedBox(
                width: 55,
                child: TextField(
                  controller: weightController,
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
                  onChanged: (value) {
                    // Remove leading zeros if there are more than one digit
                    if (value.startsWith('0') && value.length > 1) {
                      value = value.replaceFirst(RegExp(r'^0+'), '');
                      weightController.text = value;
                      weightController.selection = TextSelection.fromPosition(
                        TextPosition(offset: weightController.text.length),
                      );
                      return; // Exit to avoid further processing
                    }

                    // Prevent updating the field if the content is '0' and '0' is pressed again
                    if (value.isEmpty || (value == '0' && weightController.text == '0')) {
                      return;
                    }

                    // If input length exceeds 3 digits, keep the content unchanged
                    if (value.length > 3) {
                      weightController.text = weight.toString();
                      weightController.selection = TextSelection.fromPosition(
                        TextPosition(offset: weightController.text.length),
                      );
                      return;
                    }

                    // Try to parse the input value
                    final parsedValue = int.tryParse(value);
                    if (parsedValue == null || parsedValue < 0 || parsedValue > 999) {
                      // If parsing fails or the value is out of range, revert to the last valid weight
                      weightController.text = weight.toString();
                      weightController.selection = TextSelection.fromPosition(
                        TextPosition(offset: weightController.text.length),
                      );
                    } else {
                      // Update the weight if valid
                      setState(() {
                        weight = parsedValue;
                        widget.onWeightChanged(weight);
                      });
                    }
                  },
                  onSubmitted: (value) {
                    final sanitizedValue = int.tryParse(value) ?? 0;
                    final clampedValue = sanitizedValue.clamp(0, 999);
                    updateWeight(clampedValue);
                  },
                ),
              ),
              SecondButton(
                onpress: () {
                  setState(() {
                    if (weight < 999) {
                      weight++;
                      weightController.text = weight.toString();
                      widget.onWeightChanged(weight);
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