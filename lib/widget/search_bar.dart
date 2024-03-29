import 'package:flutter/material.dart';

class SearchBarWidget extends StatefulWidget {
  final String title;
  final VoidCallback? onPressed;
  final TextEditingController? controller;

  SearchBarWidget({Key? key, required this.title,
  this.controller,
   this.onPressed})
      : super(key: key);

  @override
  State<SearchBarWidget> createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
      child: Container(
        // height: 352.0,
        // width: 200.0, // Ubah nilai lebar sesuai kebutuhan
        padding: const EdgeInsets.symmetric(horizontal: 6.0),
        child: TextField(
          controller: widget.controller,
          decoration: InputDecoration(
            hintText: 'Search by name,company, role ',
            prefixIcon: IconButton(
              icon: Icon(Icons.search),
              onPressed: widget.onPressed,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            contentPadding:
                EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
            hintStyle: TextStyle(fontSize: 16.0),
          ),
        ),
      ),
    );
  }
}
