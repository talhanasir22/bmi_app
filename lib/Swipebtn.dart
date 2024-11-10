import 'package:flutter/material.dart';
import 'package:swipeable_button_view/swipeable_button_view.dart';

import 'Result.dart';

class SwipeButton extends StatefulWidget {
  final double height;
  final int weight;
  final String gender;
  final int age;
  const SwipeButton({
    super.key,
    required this.height,
    required this.weight,
    required this.gender,
    required this.age,
  });

  @override
  State<SwipeButton> createState() => _SwipeButtonState();
}

class _SwipeButtonState extends State<SwipeButton> {
  bool _finished = false;

  @override
  Widget build(BuildContext context) {
    return SwipeableButtonView(
      isFinished: _finished,
      onFinish: () async {
        try {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Result(
                height: widget.height,
                weight: widget.weight,
                gender: widget.gender,
                age: widget.age,
              ),
            ),
          );
        } catch (e) {
          print('Navigation to Result page failed: $e');
          // Optionally show an error message to the user
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to navigate to result page.')),
          );
        } finally {
          setState(() {
            _finished = false;
          });
        }
      },
      onWaitingProcess: () async {
        try {
          await Future.delayed(Duration(seconds: 1));
          setState(() {
            _finished = true;
          });
        } catch (e) {
          print('An error occurred during waiting: $e');
          // Optionally show an error message to the user
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('An error occurred while processing.')),
          );
        }
      },
      activeColor: Theme.of(context).colorScheme.primary,
      buttonWidget: const Icon(Icons.arrow_forward_ios, color: Colors.deepPurpleAccent),
      buttonText: 'Check My BMI',buttontextstyle: TextStyle(fontSize: 15,
      fontWeight: FontWeight.bold,
      color: Colors.white,),

    );
  }
}
