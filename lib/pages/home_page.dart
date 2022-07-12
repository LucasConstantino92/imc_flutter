import 'package:flutter/material.dart';

class home_page extends StatefulWidget {
  const home_page({Key? key}) : super(key: key);

  @override
  State<home_page> createState() => _home_pageState();
}

class _home_pageState extends State<home_page> {
  String _info = 'Informe seus dados.';
  String? result;

  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text('Calculadora de IMC'),
          centerTitle: true,
          backgroundColor: Colors.green,
          actions: [
            IconButton(
              onPressed: _resetField,
              icon: const Icon(Icons.refresh),
            )
          ],
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Icon(
                Icons.person_outline,
                size: 120,
                color: Colors.green,
              ),
              TextField(
                controller: weightController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Peso (Kg)',
                  labelStyle: TextStyle(color: Colors.green),
                ),
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 25,
                ),
              ),
              const SizedBox(height: 32),
              TextField(
                controller: heightController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Altura (cm)',
                  labelStyle: TextStyle(color: Colors.green),
                ),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.green,
                  fontSize: 25,
                ),
              ),
              const SizedBox(height: 32),
              Container(
                height: 50,
                child: ElevatedButton(
                  onPressed: calculate,
                  child: Text(
                    'Calcular',
                    style: TextStyle(
                      fontSize: 22,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.green,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                '$_info',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 20,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _resetField() {
    heightController.text = "";
    weightController.text = "";
    setState(() {
      _info = 'Informe seus dados';
    });
  }

  void calculate() {
    double weight = double.parse(weightController.text);
    double height = double.parse(heightController.text) / 100;

    double imc = weight / (height * height);

    if(imc < 18.5) {
      result = 'Abaixo do peso';
    } else if (imc >= 18.5 && imc <= 24.9) {
      result = 'Peso Normal';
    } else if (imc >= 25 && imc <= 29.9) {
      result = 'Sobrepeso';
    } else if (imc >= 30 && imc <= 34.9) {
      result = 'Obesidade Grau I';
    } else if (imc >= 35 && imc <= 39.9) {
      result = 'Obesidade Grau II';
    } else {
      result = 'Obesidade Mórbida';
    }

    setState(() {
      _info = 'IMC: ${imc.round()} - Grau $result';
    });
  }
}
