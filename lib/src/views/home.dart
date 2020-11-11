import 'package:flutter/material.dart';
import 'dart:math';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _infoText = "Informe seus dados";

  void _resetField() {
    setState(() {
      weightController.text = "";
      heightController.text = "";
      _infoText = "Informe seus dados";
    });
  }

  void _calculate() {
    print('aqui');
    double weight = double.parse(weightController.text);
    double height = double.parse(heightController.text) / 100;

    double imc = weight / pow(height, 2);
    setState(() {
      if (imc < 18.6) {
        _infoText = "Abaixo do peso: IMC (${imc.toStringAsPrecision(4)})";
      } else if (imc >= 18.6 && imc <= 24.9) {
        _infoText = "Peso ideal: IMC (${imc.toStringAsPrecision(4)})";
      } else if (imc >= 24.9 && imc < 29.9) {
        _infoText =
            "Levemente acima do peso: IMC (${imc.toStringAsPrecision(4)})";
      } else if (imc >= 29.9 && imc < 34.9) {
        _infoText = "Obesidade Grau I: IMC (${imc.toStringAsPrecision(4)})";
      } else if (imc >= 34.9 && imc < 39.9) {
        _infoText = "Obesidade Grau II: IMC (${imc.toStringAsPrecision(4)})";
      } else if (imc >= 40) {
        _infoText = "Obesidade Grau III: IMC (${imc.toStringAsPrecision(4)})";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Calculadora de IMC',
          style: TextStyle(color: Colors.redAccent),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.refresh,
              color: Colors.redAccent,
            ),
            onPressed: _resetField,
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(16.0, 0, 16.0, 0),
        child: ConstrainedBox(
          constraints: BoxConstraints.tightFor(
            height: screenSize.height - 80,
          ),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Image(
                      image: AssetImage('images/apple.png'),
                      height: 64.0,
                    ),
                    Image(
                      image: AssetImage('images/banana.png'),
                      height: 64.0,
                    ),
                    Image(
                      image: AssetImage('images/grapes.png'),
                      height: 64.0,
                    )
                  ],
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Peso em Kg',
                    labelStyle: TextStyle(
                      color: Colors.redAccent,
                    ),
                  ),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18.0,
                  ),
                  controller: weightController,
                  validator: (value) {
                    if (value.isEmpty) {
                      return;
                    }

                    return null;
                  },
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Altura em cm',
                    labelStyle: TextStyle(
                      color: Colors.redAccent,
                    ),
                  ),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18.0,
                  ),
                  controller: heightController,
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Insira sua altura.";
                    }

                    return null;
                  },
                ),
                Container(
                  height: 50.0,
                  child: RaisedButton(
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        _calculate();
                      }
                    },
                    child: Text(
                      'Calcular',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                      ),
                    ),
                    color: Colors.redAccent,
                  ),
                ),
                Text(
                  _infoText,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.redAccent, fontSize: 18.0),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Image(
                      image: AssetImage('images/lemon.png'),
                      height: 64.0,
                    ),
                    Image(
                      image: AssetImage('images/pineapple.png'),
                      height: 64.0,
                    ),
                    Image(
                      image: AssetImage('images/strawberry.png'),
                      height: 64.0,
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
