import 'package:flutter/material.dart';

class SecondButton extends StatefulWidget{
  final VoidCallback onpress;
  final IconData icon;
  const SecondButton({super.key, required this.onpress, required this.icon});

  @override
  State<SecondButton> createState() => _SecondButtonState();
}

class _SecondButtonState extends State<SecondButton> {
  @override
  Widget build(BuildContext context) {

    return InkWell(
      onTap: widget.onpress,
      child: Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(
          child: Icon(widget.icon,
          color: Colors.white,),

        ),
      ),
    );
  }
}