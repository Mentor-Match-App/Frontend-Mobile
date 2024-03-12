import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:mentormatch_apps/style/color_style.dart';
import 'package:mentormatch_apps/style/font_style.dart';

class TimePickerWidget extends StatefulWidget {
  final String title;
  final TextEditingController controller;

  TimePickerWidget(
      {Key? key,
      required this.controller,
      required Null Function(dynamic time) onTimeSelected,
      required this.title})
      : super(key: key);

  @override
  _TimePickerWidgetState createState() => _TimePickerWidgetState();
}

class _TimePickerWidgetState extends State<TimePickerWidget> {
  void _pickTime() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      final now = DateTime.now();
      final dt =
          DateTime(now.year, now.month, now.day, picked.hour, picked.minute);
      final formattedTime = DateFormat('HH:mm').format(dt); // Format 24 jam
      widget.controller.text = formattedTime;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: 150,
        child: TextField(
          controller: widget.controller,
          decoration: InputDecoration(
              filled: true,
              fillColor: ColorStyle().tertiaryColors,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide: BorderSide.none,
              ),
              icon: Icon(
                Icons.timer,
                color: ColorStyle().primaryColors,
              ),
              labelText: widget.title,
              labelStyle: FontFamily().regularText),
          readOnly: true,
          onTap: _pickTime,
        ),
      ),
    );
  }
}

class DatePickerWidget extends StatefulWidget {
  final String labelText;
  final Function(DateTime) onDateSelected;
  final TextEditingController controller;

  DatePickerWidget({required this.onDateSelected, required this.controller, this.labelText = "Pilih Tanggal"});

  @override
  _DatePickerWidgetState createState() => _DatePickerWidgetState();
}

class _DatePickerWidgetState extends State<DatePickerWidget> {
  final TextEditingController selecDateController = TextEditingController();
  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
      widget.onDateSelected(selectedDate);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          child: TextField(
            controller: widget.controller,
            decoration: InputDecoration(
                filled: true,
                fillColor: ColorStyle().tertiaryColors,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                  borderSide: BorderSide.none,
                ),
                icon: Icon(
                  Icons.calendar_today,
                  color: ColorStyle().primaryColors,
                ),
                labelText: widget.labelText,
                labelStyle: FontFamily().regularText),
            readOnly: true,
            onTap: () => _selectDate(context),
          ),
        ));
    // ElevatedButton(
    //   onPressed: () => _selectDate(context),
    //   child: Text('Pilih Tanggal'),
    // );
  }
}
