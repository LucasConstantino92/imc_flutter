import 'package:flutter/material.dart';

class home_page extends StatefulWidget {
  const home_page({Key? key}) : super(key: key);

  @override
  State<home_page> createState() => _home_pageState();
}

class _home_pageState extends State<home_page> {
  String _info = 'Informe seus dados.';
  String? result;
  String? errorTxtPeso;
  String? errorTxtAltura;

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
          padding: const EdgeInsets.all(16),
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
                decoration: InputDecoration(
                  errorText: errorTxtPeso,
                  labelText: 'Peso (Kg)',
                  labelStyle: const TextStyle(color: Colors.green),
                ),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.green,
                  fontSize: 25,
                ),
              ),
              const SizedBox(height: 32),
              TextField(
                controller: heightController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  errorText: errorTxtAltura,
                  labelText: 'Altura (cm)',
                  labelStyle: const TextStyle(color: Colors.green),
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
                  style: ElevatedButton.styleFrom(
                    primary: Colors.green,
                  ),
                  child: const Text(
                    'Calcular',
                    style: TextStyle(
                      fontSize: 22,
                    ),
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
    errorTxtPeso = null;
    errorTxtAltura = null;

    setState(() {
      _info = 'Informe seus dados';
    });
  }

  void calculate() {
    String txtPeso = weightController.text;
    String txtAltura = heightController.text;

    if (txtPeso.isEmpty) {
      setState(() {
        errorTxtPeso = 'Insira seu peso!';
      });
      return;
    } else {
      setState(() {
        errorTxtPeso = null;
      });
    }

    if (txtAltura.isEmpty) {
      setState(() {
        errorTxtAltura = 'Insira sua altura!';
      });
      return;
    } else {
      setState(() {
        errorTxtAltura = null;
      });
    }

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
      result = 'Obesidade M??rbida';
    }

    setState(() {
      _info = 'IMC: ${imc.round()} - Grau $result';
    });
  }
}
