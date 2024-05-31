import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myapp/core/data/model/course.dart';
import 'package:myapp/feature/course/screens/course_detail_screen.dart';
import 'package:myapp/feature/course/widgets/custom_chip/custom_chip.dart';

class CustomCard extends StatefulWidget {
  final Course course;
  final Color? backgroundColor;

  const CustomCard({super.key, required this.course, this.backgroundColor});

  @override
  _CustomCardState createState() => _CustomCardState();
}

class _CustomCardState extends State<CustomCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _navigateToCourseDetail,
      child: FadeTransition(
        opacity: _animation,
        child: SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0.0, -0.5),
            end: Offset.zero,
          ).animate(_controller),
          child: Card(
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: Container(
              decoration: BoxDecoration(
                color: widget.backgroundColor ?? Colors.white,
                borderRadius: BorderRadius.circular(15.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildImageSection(),
                  _buildContentSection(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildImageSection() {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Hero(
          tag: widget.course.id,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15.0),
            child: Image.network(
              widget.course.imageUrl,
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  Colors.black.withOpacity(0.7),
                ],
              ),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(15.0),
                bottomRight: Radius.circular(15.0),
              ),
            ),
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Hero(
              tag: '${widget.course.id}_title',
              child: Material(
                color: Colors.transparent,
                child: Text(
                  widget.course.name,
                  style: GoogleFonts.poppins(
                    textStyle: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildContentSection() {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildCourseDescription(),
          const SizedBox(height: 8),
          _buildTagsSection(),
          const SizedBox(height: 8),
          _buildMetricsSection(),
          const SizedBox(height: 8),
          _buildPriceSection(),
        ],
      ),
    );
  }

  Widget _buildCourseDescription() {
    return Text(
      widget.course.description,
      style: GoogleFonts.poppins(
        textStyle: const TextStyle(
          fontSize: 14,
          height: 1.5,
        ),
      ),
      maxLines: 3,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _buildTagsSection() {
    return Wrap(
      spacing: 8.0,
      runSpacing: 8.0,
      children: widget.course.tags.map((tag) {
            return CustomChip(
              label: tag,
              icon: Icons.local_offer,
            );
          }).toList(),
    );
  }

  Widget _buildMetricsSection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomChip(
          label: 'Занятия: ${widget.course.lessons}',
          icon: Icons.timer,
        ),
        CustomChip(
          label: 'Тесты: ${widget.course.tests}',
          icon: Icons.assignment,
        ),
      ],
    );
  }

  Widget _buildPriceSection() {
    return Container(
      decoration: BoxDecoration(
        color: widget.course.isFree
            ? const Color.fromARGB(255, 113, 233, 159)
            : const Color.fromARGB(255, 249, 126, 117),
        borderRadius: BorderRadius.circular(6),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: Text(
        widget.course.isFree ? 'Free' : '\$${widget.course.price}',
        style: GoogleFonts.poppins(
          textStyle: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),
    );
  }

  void _navigateToCourseDetail() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CourseDetailScreen(
            courseId: widget.course.id, course: widget.course),
      ),
    );
  }
}
