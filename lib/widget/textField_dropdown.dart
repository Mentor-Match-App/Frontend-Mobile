// import 'package:flutter/material.dart';
// import 'package:mentormatch_apps/style/font_style.dart';

// class MyDropdownWidget extends StatefulWidget {
//   final List<String> items;

//   const MyDropdownWidget({Key? key, required this.items}) : super(key: key);

//   @override
//   _MyDropdownWidgetState createState() => _MyDropdownWidgetState();
// }

// class _MyDropdownWidgetState extends State<MyDropdownWidget> {
//   String? selectedValue; // Default selected value set to null

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: 56,
//       child: DropdownButtonFormField<String>(
//         value: selectedValue,
//         decoration: InputDecoration(
//           filled: true,
//           fillColor: Colors.grey[200],
//           border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(4),
//             borderSide: BorderSide.none,
//           ),
//           hintText: selectedValue ?? 'Select an item', // Updated hint text
//           hintStyle: FontFamily().regularText.copyWith(
//                 color: Colors.grey[500],
//           ),
//         ),
//         onChanged: (String? newValue) {
//           setState(() {
//             selectedValue = newValue;
//           });
//         },
//         items: ['Select an item', ...widget.items]
//             .map<DropdownMenuItem<String>>((String value) {
//           return DropdownMenuItem<String>(
//             value: value,
//             child: Text(value, style: FontFamily().regularText,),
//           );
//         }).toList(),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:mentormatch_apps/style/font_style.dart';

class MyDropdownWidget extends StatefulWidget {
  final List<String> items;
  final Color? textColor;
  final ValueChanged<String>? onChanged;

  const MyDropdownWidget({
    Key? key,
    required this.items,
    this.textColor,
    this.onChanged,
  }) : super(key: key);

  @override
  _MyDropdownWidgetState createState() => _MyDropdownWidgetState();
}

class _MyDropdownWidgetState extends State<MyDropdownWidget> {
  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 56,
      child: DropdownButtonFormField<String>(
        value: selectedValue,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.grey[200],
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4),
            borderSide: BorderSide.none,
          ),
          hintText: selectedValue ?? 'Select an item',
          hintStyle: FontFamily().regularText.copyWith(
            color: Colors.grey[500],
          ),
        ),
        onChanged: (String? newValue) {
          setState(() {
            selectedValue = newValue;
          });

          if (widget.onChanged != null) {
            widget.onChanged!(newValue ?? "");
          }
        },
        items: ['Select an item', ...widget.items]
            .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(
              value,
              style: FontFamily().regularText.copyWith(
                color: widget.textColor ?? Colors.black,
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
