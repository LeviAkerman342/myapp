import 'package:flutter/material.dart';

class TegsEducation extends StatefulWidget {
  final Color textColor;
  final List<String> tags;
  final Function(String) onTagTap;

  const TegsEducation({
    super.key,
    required this.textColor,
    required this.tags,
    required this.onTagTap,
  });

  @override
  _TegsEducationState createState() => _TegsEducationState();
}

class _TegsEducationState extends State<TegsEducation> {
  late List<bool> hoverStates;

  @override
  void initState() {
    super.initState();
    hoverStates = List<bool>.filled(widget.tags.length, false);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Wrap(
        spacing: 8.0,
        runSpacing: 8.0,
        children: List.generate(widget.tags.length, (index) {
          return _buildEducationTag(widget.tags[index], index);
        }),
      ),
    );
  }

  Widget _buildEducationTag(String text, int index) {
    return GestureDetector(
      onTap: () {
        widget.onTagTap(text);
      },
      onTapDown: (_) {
        setState(() {
          hoverStates[index] = true;
        });
      },
      onTapUp: (_) {
        setState(() {
          hoverStates[index] = false;
        });
      },
      onTapCancel: () {
        setState(() {
          hoverStates[index] = false;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          border: Border.all(color: const Color.fromARGB(255, 99, 99, 99), width: 2), // Серая обводка
          borderRadius: BorderRadius.circular(25),
          boxShadow: [
            if (hoverStates[index])
              const BoxShadow(
                color: Colors.black, 
                blurRadius: 20,
                spreadRadius: -5,
              ),
          ],
          color: Colors.white, 
        ),
        child: AnimatedOpacity(
          duration: const Duration(milliseconds: 200),
          opacity: hoverStates[index] ? 0.8 : 1.0,
          child: Text(
            text,
            style: TextStyle(
              fontSize: 14,
              color: widget.textColor,
              fontFamily: 'SFProDisplay-Medium',
              fontWeight: FontWeight.normal,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
  }
}
