import 'package:flutter/material.dart';
import 'package:myapp/feature/course/widgets/course_card/model/course_model.dart';
import 'package:myapp/feature/payment/payment.dart';

class CourseCard extends StatelessWidget {
  final CourseModel data;
  final Color textColor;
  final Color backgroundColor;
  final Color chipColor;
  final Color color1;
  final Color color;
  final VoidCallback onPressed;
  final BuildContext context; // Добавлено поле context

  const CourseCard({
    super.key,
    required this.context, // Добавлено в конструктор
    required this.data,
    required this.textColor,
    required this.backgroundColor,
    required this.chipColor,
    required this.color1,
    required this.color,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(16.0),
          border: Border.all(color: Colors.grey),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildInfoSection(),
            const SizedBox(height: 16.0),
            _buildContentSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoSection() {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 8.0,
        horizontal: 16.0,
      ),
      decoration: BoxDecoration(
        color: chipColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(16.0),
          topRight: Radius.circular(16.0),
        ),
      ),
      child: Text(
        '${data.info}',
        style: TextStyle(
          color: textColor,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildContentSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            data.status1,
            style: TextStyle(
              color: textColor,
              fontWeight: FontWeight.bold,
              fontSize: 18.0,
            ),
          ),
          const SizedBox(height: 8.0),
          Text(
            data.status2,
            style: TextStyle(color: textColor),
          ),
          const SizedBox(height: 8.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${data.days} дней',
                style: TextStyle(color: textColor),
              ),
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const PaymentScreen()),
                  );
                },
                icon: Icon(
                  Icons.shopping_cart,
                  color: color1,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
