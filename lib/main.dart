import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: PayCalculator(),
    );
  }
}

class PayCalculator extends StatefulWidget {
  const PayCalculator({super.key});

  @override
  _PayCalculatorState createState() => _PayCalculatorState();
}

class _PayCalculatorState extends State<PayCalculator> {
  TextEditingController hoursController = TextEditingController();
  TextEditingController rateController = TextEditingController();

  double regularPay = 0.0;
  double overtimePay = 0.0;
  double totalPay = 0.0;
  double tax = 0.0;

  double minimumHourlyRate = 16.5;

  void calculatePay() {
    double hours = double.tryParse(hoursController.text) ?? 0.0;
    double rate = double.tryParse(rateController.text) ?? 0.0;

    if (rate < minimumHourlyRate) {
      // Show an error message or take appropriate action
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Invalid Hourly Rate'),
          content: Text('The minimum hourly rate is $minimumHourlyRate.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('OK'),
            ),
          ],
        ),
      );
      return;
    }

    if (hours <= 40) {
      regularPay = hours * rate;
      overtimePay = 0.0;
    } else {
      regularPay = 40 * rate;
      overtimePay = (hours - 40) * rate * 1.5;
    }

    totalPay = regularPay + overtimePay;
    tax = totalPay * 0.18;

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1E2C34),
      appBar: AppBar(
        title: const Text(
          'My Pay Calculator',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: const Color(0xFF0D151A),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextFormField(
              controller: hoursController,
              keyboardType: TextInputType.number,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: 'Enter Number of Hours',
                labelStyle: TextStyle(color: Colors.white),
                filled: true,
                fillColor: const Color(0xFF243846),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.green),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                border: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.grey),
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
            const SizedBox(height: 20.0),
            TextField(
              controller: rateController,
              keyboardType: TextInputType.number,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: 'Enter Hourly Rate',
                labelStyle: TextStyle(color: Colors.white),
                filled: true,
                fillColor: const Color(0xFF243846),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.green),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                border: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.grey),
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: const Color(0xFF2ECC71),
                padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              onPressed: calculatePay,
              child: const Text(
                'Calculate',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 50.0),
            Container(
              padding: const EdgeInsets.all(20),
              width: 300,
              height: 150,
              decoration: BoxDecoration(
                color: const Color(0xFF243846),
                borderRadius: BorderRadius.circular(15.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Report',
                    style: TextStyle(
                      color: Colors.white,
                      decoration: TextDecoration.underline,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text('Regular Pay: $regularPay',
                      style: TextStyle(color: Colors.white)),
                  Text('Overtime Pay: $overtimePay',
                      style: TextStyle(color: Colors.white)),
                  Text('Total Pay (before tax): $totalPay',
                      style: TextStyle(color: Colors.white)),
                  Text('Tax: $tax', style: TextStyle(color: Colors.white)),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: const Color(0xFF0D151A),
        elevation: 0,
        child: Column(
          children: [
            Text(
              'Name: Promish Khaniya',
              style: TextStyle(color: Colors.white, fontSize: 15),
            ),
            Text(
              'College ID: 301369717',
              style: TextStyle(color: Colors.white, fontSize: 15),
            ),
          ],
        ),
      ),
    );
  }
}
