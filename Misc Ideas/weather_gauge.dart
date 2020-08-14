import 'package:flutter/material.dart';

class WeatherGauge extends StatefulWidget {
  @override
  _WeatherGaugeState createState() => _WeatherGaugeState();
}

class _WeatherGaugeState extends State<WeatherGauge> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Image.asset('assets/rain.jpg'),
        ),
        Expanded(
          child: Image.asset('assets/cloud.jpg'),
        ),
        Expanded(
          child: Image.asset('assets/sun.jpg'),
        ),
      ],
    );
  }
}
