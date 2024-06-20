import 'package:flutter/material.dart';

class TegsEducation extends StatefulWidget {
  final Color textColor;
  final List<String> tags;
  final Function(String) onTagTap;

  const TegsEducation({
    Key? key,
    required this.textColor,
    required this.tags,
    required this.onTagTap,
  }) : super(key: key);

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
        _updateHoverState(index, true);
      },
      onTapUp: (_) {
        _updateHoverState(index, false);
      },
      onTapCancel: () {
        _updateHoverState(index, false);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          border: Border.all(color: const Color.fromARGB(255, 99, 99, 99), width: 2), // Gray border
          borderRadius: BorderRadius.circular(25),
          boxShadow: [
            if (hoverStates[index])
              const BoxShadow(
                color: Colors.black,
                blurRadius: 20,
                spreadRadius: -5,
              ),
          ],
          color: Colors.white, // Background color
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

  void _updateHoverState(int index, bool isHovered) {
    setState(() {
      hoverStates[index] = isHovered;
    });
  }
}
