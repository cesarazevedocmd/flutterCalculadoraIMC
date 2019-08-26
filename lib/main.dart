import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(home: Home()));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController _weightController = TextEditingController();
  TextEditingController _heightController = TextEditingController();
  TextEditingController _resultController = TextEditingController();
  String _result = "Informe seus dados";

  void _resetFields() {
    _weightController.text = "";
    _heightController.text = "";
    setState(() {
      _result = "Informe seus dados";
    });
  }

  void _calcularIMC() {
    try {
      double weight = double.parse(_weightController.text);
      double height = double.parse(_heightController.text) / 100.0;
      double resultIMC = (weight / (height * height));
      String resultIMCPrecision = resultIMC.toStringAsPrecision(4);

      setState(() {
        if (resultIMC < 18.5)
          _result = "Abaixo do peso (${resultIMCPrecision})";
        else if (resultIMC < 25.0)
          _result = "Normal (${resultIMCPrecision})";
        else if (resultIMC < 30.0)
          _result = "Sobrepeso I (${resultIMCPrecision})";
        else if (resultIMC < 40.0)
          _result = "Obesidade II (${resultIMCPrecision})";
        else
          _result = "Obesidade Grave III (${resultIMCPrecision})";
      });
    } catch (ex) {
      setState(() {
        _result = "Preencha corretamente os campos";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Minha Calculadora IMC"),
        centerTitle: true,
        backgroundColor: Colors.lightGreen,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _resetFields,
          )
        ],
      ),
      backgroundColor: Colors.white,
      body: _getColunaDeFormulario(),
    );
  }

  SingleChildScrollView _getColunaDeFormulario() {
    return SingleChildScrollView(
      padding: EdgeInsets.fromLTRB(5.0, 2.0, 5.0, 0.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Icon(Icons.person_outline, color: Colors.lightGreen, size: 120.0),
          TextField(
            controller: _weightController,
            keyboardType: TextInputType.numberWithOptions(decimal: true),
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20.0, color: Colors.lightGreen),
            decoration: InputDecoration(
              labelText: "Peso (Kg)",
              alignLabelWithHint: true,
              labelStyle: TextStyle(color: Colors.lightGreen),
            ),
          ),
          TextField(
            controller: _heightController,
            keyboardType: TextInputType.numberWithOptions(decimal: true),
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20.0, color: Colors.lightGreen),
            decoration: InputDecoration(
              labelText: "Altura",
              alignLabelWithHint: true,
              labelStyle: TextStyle(color: Colors.lightGreen),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10.0),
            child: Container(
              height: 50.0,
              child: RaisedButton(
                padding: EdgeInsets.all(2.0),
                child: Text(
                  "Calcular",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                  ),
                ),
                color: Colors.green,
                onPressed: _calcularIMC,
              ),
            ),
          ),
          Text(
            _result,
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.green, fontSize: 15.0),
          ),
        ],
      ),
    );
  }
}
