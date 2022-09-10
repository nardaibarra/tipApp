import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int? currentRadio;
  bool rounded = false;
  double tax = 0.0;
  var _txtTotal = TextEditingController();
  var radioGroup = {
    0: {'tag': 'Amazing 20%', 'value': 20},
    1: {'tag': 'Good 15%', 'value': 15},
    2: {'tag': 'Ok 10%', 'value': 10}
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tip time'),
      ),
      body: ListView(
        children: [
          SizedBox(height: 14),
          ListTile(
            leading: Icon(Icons.room_service),
            title: Padding(
              padding: EdgeInsets.only(right: 24),
              child: TextField(
                controller: _txtTotal,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    labelText: "Cost of service:",
                    border: OutlineInputBorder()),
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.dinner_dining),
            title: Text("How was the service?"),
          ),
          Container(
            padding: EdgeInsets.only(left: 20),
            margin: EdgeInsets.all(2),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: radioGroupGenerator(),
            ),
          ),
          ListTile(
            leading: Icon(Icons.credit_card),
            title: Text("Round up tip"),
            trailing: Switch(
                value: rounded,
                onChanged: (value) {
                  setState(() {
                    rounded = value;
                  });
                }),
          ),
          Container(
            margin: EdgeInsets.only(right: 20, left: 20),
            child: MaterialButton(
              child: Text("CALCULATE"),
              color: Colors.green,
              onPressed: _tipCalculation,
            ),
          ),
          Container(
              alignment: Alignment.centerRight,
              padding: EdgeInsets.all(20), //You can use EdgeInsets like above
              margin: EdgeInsets.all(5),
              child: Text("Tip amount: \$ ${tax.toStringAsFixed(2)}")),
        ],
      ),
    );
  }

  _tipCalculation() {
    double percentage = 0.0;
    if (_txtTotal.text.isNotEmpty) {
      percentage = double.parse(_txtTotal.text);
    } else {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(const SnackBar(
          content: Text("Plase enter the total amount"),
          backgroundColor: Colors.redAccent,
        ));
    }

    tax = (currentRadio ?? 0) * (percentage / 100);
    if (rounded) {
      tax = tax.ceilToDouble();
    }
    setState(() {});
  }

  radioGroupGenerator() {
    return radioGroup.entries
        .map(
          (radioElement) => ListTile(
            leading: Radio(
              value: int.parse("${radioElement.value['value']}"),
              groupValue: currentRadio,
              onChanged: (int? selected) {
                currentRadio = selected;
                setState(() {});
              },
            ),
            title: Text("${radioElement.value['tag']}"),
          ),
        )
        .toList();
  }

  roundTip() {}
}
