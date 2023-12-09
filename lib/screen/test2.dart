import 'package:flutter/material.dart';

class FieldText extends StatefulWidget {
  const FieldText({Key? key}) : super(key: key);

  @override
  State<FieldText> createState() => _FieldTextState();
}

class _FieldTextState extends State<FieldText> {
  final TextEditingController _name = TextEditingController();
  final TextEditingController _phone = TextEditingController();
  final List<Map<String, String>> _inputdata = [];
  final _formKey = GlobalKey<FormState>();

  void _data() {
    final String namaphone = _name.text;
    final String nomerphone = _phone.text;
    setState(() {
      _inputdata.add({'name': namaphone, 'number': nomerphone});
    });
    _name.clear();
    _phone.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: const Text('Contact'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Column(
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    child: TextFormField(
                      controller: _name,
                      decoration: InputDecoration(
                          labelText: 'Name',
                          hintText: 'Insert Your Name',
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          fillColor: Colors.deepPurple[50],
                          filled: true),
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              child: Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.deepPurple),
                      padding: MaterialStateProperty.all(
                          const EdgeInsets.symmetric(
                              horizontal: 30, vertical: 15)),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24)))),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _data();
                    }
                  },
                  child: const Text(
                    'Submit',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: _inputdata.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.all(20),
                  child: Card(
                      // color: Colors.purple[50],
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Text(
                          _inputdata[index]['name']!,
                          style: const TextStyle(fontSize: 20),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            _inputdata.removeAt(index);
                          });
                        },
                        icon: const Icon(Icons.delete),
                      ),
                    ],
                  )),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
