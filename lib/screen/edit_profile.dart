import 'package:flutter/material.dart';
import 'package:mentormatch_apps/style/color_style.dart';
import 'package:mentormatch_apps/style/font_style.dart';
import 'package:mentormatch_apps/style/text.dart';
import 'package:mentormatch_apps/widget/button.dart';
import 'package:mentormatch_apps/widget/multicomplete.dart';
import 'package:mentormatch_apps/widget/profile_avatar.dart';
import 'package:mentormatch_apps/widget/textField.dart';

class ChangeProfileScreen extends StatefulWidget {
  const ChangeProfileScreen({Key? key}) : super(key: key);

  @override
  State<ChangeProfileScreen> createState() => _ChangeProfileScreenState();
}

class _ChangeProfileScreenState extends State<ChangeProfileScreen> {
  final TextEditingController _skill = TextEditingController();
  final List<Map<String, String>> _inputdata = [];
  final _formKey = GlobalKey<FormState>();

  void _data() {
    final String skill = _skill.text;
    setState(() {
      _inputdata.add({'skill': skill});
    });
    _skill.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset('assets/Handoff/logo/LogoMobile.png'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    ProfileAvatar(radius: 80),
                    Text(
                      "Charline June",
                      style: FontFamily().titleText.copyWith(fontSize: 14),
                    ),
                  ],
                ),
              ),
              TittleTextField(
                title: "skill",
                color: ColorStyle().secondaryColors,
              ),
              TextFieldWidget(
                controller: _skill,
                keyword: _formKey,
                hintText: "thiyaraal@gmail.com",
              ),
              TittleTextField(
                title: "name",
                color: ColorStyle().secondaryColors,
              ),
              TextFieldWidget(
                hintText: "Thiyara al-mawaddah",
              ),
              TittleTextField(
                title: "job",
                color: ColorStyle().secondaryColors,
              ),
              TextFieldWidget(
                hintText: "Mahasiswa",
              ),
              TittleTextField(
                title: "School/University/Company",
                color: ColorStyle().secondaryColors,
              ),
              TextFieldWidget(
                hintText: "Light University",
              ),
              TittleTextField(
                title: "Skill",
                color: ColorStyle().secondaryColors,
              ),
              TextFieldWidget(
                hintText: " UX Design",
              ),
              TittleTextField(
                title: "Location",
                color: ColorStyle().secondaryColors,
              ),
              TextFieldWidget(
                hintText: "Jakarta, Indonesia",
              ),
              TittleTextField(
                title: " about",
                color: ColorStyle().secondaryColors,
              ),
              TextFieldWidget(
                hintText:
                    "i am a student at light university,now i am in semester 7",
              ),
              SizedBox(
                height: 40,
              ),
              ElevatedButtonWidget(title: "Simpan", onPressed: () {}),
              // Form(
              //   key: _formKey,
              //   child: Column(
              //     children: [
              //       Container(
              //         margin: const EdgeInsets.symmetric(horizontal: 16),
              //         child: TextFormField(
              //           controller: _skill,
              //           decoration: InputDecoration(
              //               labelText: 'skill',
              //               hintText: 'Insert Your skill',
              //               floatingLabelBehavior: FloatingLabelBehavior.always,
              //               fillColor: Colors.deepPurple[50],
              //               filled: true),
              //         ),
              //       ),
              //       const SizedBox(height: 10),
              //     ],
              //   ),
              // ),
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
                            _inputdata[index]['skill']!,
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
      ),
    );
  }
}
