import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator Consum Combustibil',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const FuelCalculatorScreen(),
    );
  }
}

class FuelCalculatorScreen extends StatefulWidget {
  const FuelCalculatorScreen({super.key});

  @override
  State<FuelCalculatorScreen> createState() => _FuelCalculatorScreenState();
}

class _FuelCalculatorScreenState extends State<FuelCalculatorScreen> {
  final TextEditingController _distanceController = TextEditingController();
  final TextEditingController _fuelController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  String _result = "Consum mediu: - l/100 km";

  void _calculateConsumption() {
    final double? distance = double.tryParse(_distanceController.text);
    final double? fuel = double.tryParse(_fuelController.text);
    final double? time = double.tryParse(_timeController.text);

    setState(() {
      if (distance != null && fuel != null) {
        if (distance > 0) {
          // Cazul normal: mașina s-a mișcat
          final double consumption = (fuel / distance) * 100;
          _result = "Consum mediu: ${consumption.toStringAsFixed(2)} l/100 km";
        } else if (distance == 0 && fuel > 0) {
          // Cazul special: motor pornit pe loc
          if (time != null && time > 0) {
            final double consumptionPerHour = fuel / time;
            _result = "Consum la oră: ${consumptionPerHour.toStringAsFixed(2)} l/h";
          } else {
            _result = "Introdu timpul (ore) pentru calculul l/h!";
          }
        } else if (distance == 0 && fuel == 0) {
          _result = "Mașina este oprită.";
        }
      } else {
        _result = "Vă rugăm să introduceți date valide!";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculator Consum'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Calculator Consum Combustibil',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),
            TextField(
              controller: _distanceController,
              decoration: const InputDecoration(
                labelText: 'Distanța parcursă (km)',
                border: OutlineInputBorder(),
              ),
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _fuelController,
              decoration: const InputDecoration(
                labelText: 'Combustibil consumat (litri)',
                border: OutlineInputBorder(),
              ),
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _timeController,
              decoration: const InputDecoration(
                labelText: 'Timp petrecut pe loc (ore)',
                border: OutlineInputBorder(),
              ),
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _calculateConsumption,
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(50),
              ),
              child: const Text('Calculează'),
            ),
            const SizedBox(height: 24),
            Text(
              _result,
              style: const TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _distanceController.dispose();
    _fuelController.dispose();
    _timeController.dispose();
    super.dispose();
  }
}
