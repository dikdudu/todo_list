import 'package:flutter/material.dart';

class TimeComponent extends StatefulWidget {
  @override
  _TimeComponentState createState() => _TimeComponentState();
}

class _TimeComponentState extends State<TimeComponent> {
  final List<String> _hours = List.generate(25, (index) => index++)
      .map((h) => '${h.toString().padLeft(2, '0')}')
      .toList();
  final List<String> _min = List.generate(61, (index) => index++)
      .map((m) => '${m.toString().padLeft(2, '0')}')
      .toList();

  final List<String> _sec = List.generate(61, (index) => index++)
      .map((s) => '${s.toString().padLeft(2, '0')}')
      .toList();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _buildBox(_hours),
        _buildBox(_min),
        _buildBox(_sec),
      ],
    );
  }

  _buildBox(List<String> options) {
    return Container(
      height: 100,
      width: 100,
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
        boxShadow: [
          BoxShadow(
            spreadRadius: 0,
            blurRadius: 10,
            color: Theme.of(context).primaryColor,
            offset: Offset(2, 5),
          ),
        ],
      ),
      child: ListWheelScrollView(
        physics: FixedExtentScrollPhysics(),
        perspective: 0.0099,
        itemExtent: 60,
        children: options
            .map<Text>(
              (e) => Text(
                e,
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
