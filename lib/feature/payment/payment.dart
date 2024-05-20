import 'package:flutter/material.dart';
import 'package:myapp/feature/course/widgets/course_card/model/course_model.dart';

class PaymentScreen extends StatelessWidget {
  final CourseModel? course;

  const PaymentScreen({super.key, this.course});

  @override
  Widget build(BuildContext context) {
    const TextStyle boldTextStyle = TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.bold,
      color: Colors.black87,
    );
    const TextStyle regularTextStyle = TextStyle(
      fontSize: 18,
      color: Colors.black87,
    );
    const EdgeInsets textFieldPadding =
        EdgeInsets.symmetric(vertical: 16, horizontal: 24);
    final TextEditingController yourWalletController = TextEditingController();
    final TextEditingController amountController = TextEditingController();

    // Sample wallet address, replace it with the actual wallet address
    const String walletAddress =
        'UQBbxh6mzjvmYLNiPJKRKPe8e-d8aj1E-6c4-NYBFjg-3j0V';

    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          'Оплата курса',
          style: boldTextStyle.copyWith(color: Colors.white),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white, // Устанавливаем цвет стрелочки "назад" в белый
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
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
                course!.status1,
                style: boldTextStyle,
              ),
              const SizedBox(height: 16),
              Text(
                course!.status2,
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
                backgroundColor: Colors.green,
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
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: const Text(
            'Оплата выполнена',
            style: TextStyle(
              color: Colors.black,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text(
            'Курс успешно оплачен! Сумма $amount отправлена на  крипто-кошелек: $yourWallet',
            style: const TextStyle(
              color: Colors.black87,
              fontSize: 18,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                'OK',
                style: TextStyle(
                  color: Colors.green,
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
