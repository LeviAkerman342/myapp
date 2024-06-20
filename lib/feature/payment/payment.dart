import 'package:flutter/material.dart';
import 'package:myapp/core/data/model/course/course.dart';
import 'package:myapp/feature/course/widgets/documentation/pages/course_page.dart';
import 'package:myapp/theme/color.dart';

class PaymentScreen extends StatelessWidget {
  final Course? course;

  const PaymentScreen({super.key, this.course});

  @override
  Widget build(BuildContext context) {
    const TextStyle boldTextStyle = TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.bold,
      color: AppLightColors.button,
    );
    const TextStyle regularTextStyle = TextStyle(
      fontSize: 18,
      color: AppLightColors.button,
    );
    const EdgeInsets textFieldPadding =
        EdgeInsets.symmetric(vertical: 16, horizontal: 24);
    final TextEditingController yourWalletController = TextEditingController();
    final TextEditingController amountController = TextEditingController();

    const String walletAddress =
        'UQBbxh6mzjvmYLNiPJKRKPe8e-d8aj1E-6c4-NYBFjg-3j0V';

    return Scaffold(
      backgroundColor: AppLightColors.background,
      appBar: AppBar(
        backgroundColor: AppLightColors.button,
        title: Text(
          'Оплата курса',
          style: boldTextStyle.copyWith(color: Colors.white),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const ListTile(
              title: Text(
                'Крипто-кошелек для оплаты:',
                style: boldTextStyle,
              ),
              subtitle: Text(
                walletAddress,
                style: regularTextStyle,
              ),
            ),
            const SizedBox(height: 16),
            if (course != null) ...[
              Text(
                course!.name,
                style: boldTextStyle,
              ),
              const SizedBox(height: 16),
              Text(
                course!.description,
                style: regularTextStyle,
              ),
              const SizedBox(height: 32),
            ],
            Padding(
              padding: textFieldPadding,
              child: TextField(
                controller: yourWalletController,
                style: regularTextStyle,
                decoration: InputDecoration(
                  labelText: 'Ваш крипто-кошелек',
                  labelStyle: regularTextStyle,
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                  errorText: yourWalletController.text.isEmpty
                      ? 'Пожалуйста, введите криптокошелек'
                      : null,
                ),
              ),
            ),
            Padding(
              padding: textFieldPadding,
              child: TextField(
                controller: amountController,
                style: regularTextStyle,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Сумма для отправки',
                  labelStyle: regularTextStyle,
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                  errorText: amountController.text.isEmpty
                      ? 'Пожалуйста, введите сумму'
                      : null,
                ),
              ),
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                if (yourWalletController.text.isNotEmpty &&
                    amountController.text.isNotEmpty) {
                  final yourWallet = yourWalletController.text;
                  final amount = amountController.text;
                  _handleCryptoPayment(yourWallet, amount, context);
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppLightColors.tagText,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.all(16),
              ),
              child: const Text(
                'Оплата',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _handleCryptoPayment(
      String yourWallet, String amount, BuildContext context) {
    if (course != null) {
      course!.isPaid = true;
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: const Text(
            'Оплата выполнена',
            style: TextStyle(
              color: AppLightColors.button,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text(
            'Курс успешно оплачен! Сумма $amount отправлена на крипто-кошелек: $yourWallet',
            style: const TextStyle(
              color: AppLightColors.button,
              fontSize: 18,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CoursePage(courseId: course?.id ?? 0),
                  ),
                );
              },
              child: const Text(
                'OK',
                style: TextStyle(
                  color: AppLightColors.tagText,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
