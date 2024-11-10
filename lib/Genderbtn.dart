import 'package:flutter/material.dart';

class Genderbutton extends StatefulWidget {
  final IconData icon;
  final VoidCallback onPress;
  final String btnname;
  final bool isSelected; // New parameter to determine if the button is selected

  const Genderbutton({
    super.key,
    required this.icon,
    required this.btnname,
    required this.onPress,
    this.isSelected = false, // Default to not selected
  });

  @override
  State<Genderbutton> createState() => _GenderbuttonState();
}

class _GenderbuttonState extends State<Genderbutton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onPress,
      child: Container(
        width: 160,
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(11),
          color: widget.isSelected
              ? Theme.of(context).colorScheme.primary
              : Colors.transparent,
          border: Border.all(
            color: widget.isSelected
                ? Theme.of(context).colorScheme.primary
                : Colors.grey.withOpacity(0.5),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              widget.icon,
              color: widget.isSelected ? Colors.white : Colors.grey,
            ),
            const SizedBox(width: 10),
            Text(
              widget.btnname,
              style: TextStyle(
                color: widget.isSelected ? Colors.white : Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
