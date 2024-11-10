import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pretty_gauge/pretty_gauge.dart';
import 'Suggestion.dart';

class Result extends StatefulWidget {
  final double height;
  final int weight;
  final String gender;
  final int? age;
  Result({
    super.key,
    required this.height,
    required this.weight,
    required this.gender,
    this.age, // Initialize age
  });

  @override
  State<Result> createState() => _ResultState();
}

class _ResultState extends State<Result> {
 // Add age as an optional parameter
  bool issuggestionvisible = true;

  double calculateBmi() {
    if (widget.weight <= 0) {
      return 0.0;
    } else {
      double heightInMeters = widget.height / 100; // Convert cm to meters
      return widget.weight / (heightInMeters * heightInMeters);
    }
  }

  Widget BmiInterpretation(BuildContext context) {
    double bmi = calculateBmi();
    String interpretation;

    if (bmi <= 0) {
      return const SizedBox.shrink(); // Return an empty widget if BMI is <= 0
    } else if (bmi < 18.5) {
      interpretation = 'This indicates that you are underweight. '
          'It could be due to various factors such as insufficient nutrition, high metabolism, or underlying health conditions. '
          'Gaining weight through a balanced diet and proper medical consultation might be necessary.';
    } else if (bmi >= 18.5 && bmi < 24.9) {
      interpretation = 'This indicates that you are a normal weight. '
          'Maintaining a balanced diet and regular physical activity is essential to keep the body in this healthy range.';
    } else if (bmi >= 25 && bmi < 29.9) {
      interpretation = 'This indicates that you are overweight. '
          'It might be beneficial to adopt a healthier diet and increase physical activity to manage weight more effectively.';
    } else {
      interpretation = 'This indicates that you are obese. '
          'It is advisable to seek guidance from a healthcare professional for weight management and to address potential health risks.';
    }

    return SizedBox(
      width: 250,
      child: Card(
        elevation: 12,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            interpretation,
            style: TextStyle(fontSize: 18, color: Theme.of(context).colorScheme.primary),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double bmiScore = calculateBmi();
    bool isBmiPositive = bmiScore > 0;

    return Scaffold(
      appBar: AppBar(
        title: const Text("BMI Score", style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.primary,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Card(
              elevation: 10,
              child: Center(
                child: PrettyGauge(
                  gaugeSize: 300,
                  minValue: 0,
                  maxValue: 40,
                  endMarkerStyle: const TextStyle(color: Colors.blueAccent),
                  startMarkerStyle: const TextStyle(color: Colors.blueAccent),
                  segments: [
                    GaugeSegment("Underweight", 18.5, Colors.red),
                    GaugeSegment("Normal", 6.4, Colors.green),
                    GaugeSegment("OverWeight", 5, Colors.orange),
                    GaugeSegment("Obese", 10.1, Colors.pink),
                  ],
                  valueWidget: Text(
                    isBmiPositive ? bmiScore.toStringAsFixed(1) : 'N/A', // Display 'N/A' if weight is 0
                    style: const TextStyle(fontSize: 40),
                  ),
                  currentValue: isBmiPositive ? bmiScore.toDouble() : 0.0,
                  needleColor: Colors.blue,
                ),
              ),
            ),

            if (isBmiPositive) ...[ // Conditionally display BMI interpretation
              Container(
                padding: const EdgeInsets.all(16.0),
                child: BmiInterpretation(context),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    PageTransition(child: SuggestionScreen(
                      gender: widget.gender,
                      bmi: bmiScore,
                      age: widget.age ?? 0, // Pass -1 if age is null to handle in SuggestionScreen
                    ), type: PageTransitionType.rightToLeft)

                  );
                },
                style: ElevatedButton.styleFrom(backgroundColor: Theme.of(context).colorScheme.primary),
                child: const Text('Get Diet & Exercise Suggestions', style: TextStyle(color: Colors.white)),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
