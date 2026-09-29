import 'package:flutter/material.dart';

void main() {
  runApp(const CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  const CalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator de Reducere',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const DiscountCalculatorPage(),
    );
  }
}

class DiscountCalculatorPage extends StatefulWidget {
  const DiscountCalculatorPage({super.key});

  @override
  State<DiscountCalculatorPage> createState() => _DiscountCalculatorPageState();
}

class _DiscountCalculatorPageState extends State<DiscountCalculatorPage> {
final TextEditingController _priceController = TextEditingController();
final TextEditingController _discountController = TextEditingController();

double _discountValue = 0.0;
double _finalPrice = 0.0;

String _selectedFixedDiscount = '10%';

void _calculate() {
double price = double.tryParse(_priceController.text) ?? 0.0;
double discountPercent = double.tryParse(_discountController.text) ?? 0.0;

setState(() {
_discountValue = (price * discountPercent) / 100;
_finalPrice = price - _discountValue;
});
}

@override
Widget build(BuildContext context) {
return Scaffold(
appBar: AppBar(
title: const Text('Calculator Reducere'),
backgroundColor: Theme.of(context).colorScheme.inversePrimary,
),
body: SingleChildScrollView(
padding: const EdgeInsets.all(16.0),
child: Column(
crossAxisAlignment: CrossAxisAlignment.stretch,
children: [
TextField(
controller: _priceController,
keyboardType: TextInputType.number,
decoration: const InputDecoration(
labelText: 'Preț inițial',
border: OutlineInputBorder(),
prefixIcon: Icon(Icons.attach_money),
),
),
const SizedBox(height: 16),
TextField(
controller: _discountController,
keyboardType: TextInputType.number,
decoration: const InputDecoration(
labelText: 'Procent reducere (%)',
border: OutlineInputBorder(),
prefixIcon: Icon(Icons.percent),
),
),
const SizedBox(height: 20),
const Text('Selecție rapidă:',
style: TextStyle(fontWeight: FontWeight.bold)),

// DropdownButton
Row(
children: [
const Text('Alege din listă: '),
DropdownButton<String>(
value: _selectedFixedDiscount,
items: <String>['5%', '10%', '20%', '50%'].map((String value) {
return DropdownMenuItem<String>(
value: value,
child: Text(value),
);
}).toList(),
onChanged: (newValue) {
setState(() {
_selectedFixedDiscount = newValue!;
_discountController.text = newValue.replaceAll('%', '');
});
},
),
],
),
  // RadioButtons
  Row(
    children: [
      const Text('Opțiuni radio: '),
      Expanded(
        child: RadioListTile<String>(
          title: const Text('10%'),
          value: '10',
          groupValue: _discountController.text,
          onChanged: (value) {
            setState(() {
              _discountController.text = value!;
            });
          },
        ),
      ),
      Expanded(
        child: RadioListTile<String>(
          title: const Text('20%'),
          value: '20',
          groupValue: _discountController.text,
          onChanged: (value) {
            setState(() {
              _discountController.text = value!;
            });
          },
        ),
      ),
    ],
  ),

  const SizedBox(height: 20),
  ElevatedButton(
    onPressed: _calculate,
    style: ElevatedButton.styleFrom(
      padding: const EdgeInsets.symmetric(vertical: 15),
    ),
    child: const Text('CALCULEAZĂ', style: TextStyle(fontSize: 18)),
  ),
  const SizedBox(height: 30),
  Card(
    color: Colors.blue.shade50,
    elevation: 4,
    child: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          Text(
            'Valoare reducere: ${_discountValue.toStringAsFixed(2)}',
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
          ),
          const Divider(height: 30),
          Text(
            'Preț final: ${_finalPrice.toStringAsFixed(2)}',
            style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.blue),
          ),
        ],
      ),
    ),
  ),
],
),
),
);
}
}