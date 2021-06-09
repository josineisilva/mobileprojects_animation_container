import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Home extends StatefulWidget {

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _duration = 1;
  bool _big = false;
  List<String> _curveList = [
    'linear',
    'easeInOutBack',
    'slowMiddle',
    'bounceIn'
  ];
  String _curveName = "linear";

  @override
  Widget build(BuildContext context) {
    Curve _curve = Curves.linear;
    if(_curveName == 'easeInOutBack')
      _curve = Curves.easeInOutBack;
    if(_curveName == 'slowMiddle')
      _curve = Curves.slowMiddle;
    if(_curveName == 'bounceIn')
      _curve = Curves.bounceIn;
    return Scaffold(
      appBar: AppBar(title: Text("AnimatedContainer"),),
      body: Column(
        children: <Widget>[
          TextField(
            controller: TextEditingController(text: "${_duration}"),
            decoration: InputDecoration(labelText: "Duration"),
            keyboardType: TextInputType.number,
            inputFormatters:
              [WhitelistingTextInputFormatter.digitsOnly],
            onSubmitted: (String value) => _duration = int.parse(value),
          ),
          Row(
            children: <Widget>[
              Text("Curve:  "),
              DropdownButton<String>(
                value: _curveName,
                icon: Icon(Icons.arrow_downward),
                iconSize: 24,
                elevation: 16,
                underline: Container(
                  height: 2,
                ),
                onChanged: (String value) {
                  setState(() =>_curveName = value);
                },
                items: _curveList.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ],
          ),
          Expanded(
            child: Center(
              child: AnimatedContainer(
                decoration: BoxDecoration(
                  gradient: RadialGradient(
                    colors: [Colors.lightGreenAccent[400], Colors.transparent],
                    stops: [ !_big ? 0.0 : 0.7, 1.0]
                  )
                ),
                width: _big ? 500 : 100,
                child: Image.asset('assets/images/star.png'),
                duration: Duration(seconds: _duration),
                curve: _curve,
              ),
            ),
          ),
          RaisedButton(
            onPressed: () => setState(() {
              _big = !_big;
            }),
            child: Icon(Icons.star),
          ),
        ],
      ),
    );
  }
}
