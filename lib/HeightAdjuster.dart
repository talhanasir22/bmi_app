import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class HeightAdjuster extends StatefulWidget {
  final Function(double) onHeightChanged;

  const HeightAdjuster({super.key, required this.onHeightChanged,});

  @override
  State<HeightAdjuster> createState() => _HeightAdjusterState();
}

class _HeightAdjusterState extends State<HeightAdjuster> {
  var _height = 200.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100, // Adjust height to accommodate a larger slider
      width: 400,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Theme.of(context).colorScheme.primaryContainer,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            const Text(
              'Height (cm)',
              style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),
            ),
            const SizedBox(width: 20), // Adds space between text and slider
            Expanded(
              child: RepaintBoundary( // Helps to optimize repaint performance
                child: SfSlider(
                  min: 100,
                  max: 300.0,
                  interval: 50,
                  value: _height,
                  showTicks: true,
                  showLabels: true,
                  enableTooltip: true,
                  minorTicksPerInterval: 1,
                  onChanged: (dynamic value) {
                    try {
                      if (value != _height) { // Avoid unnecessary state updates
                        setState(() {
                          _height = value;
                        });
                        widget.onHeightChanged(_height);
                      }
                    } catch (e) {
                      print("Error adjusting height: $e");
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
