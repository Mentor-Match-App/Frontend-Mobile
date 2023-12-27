import 'package:flutter/material.dart';
import 'package:mentormatch_apps/style/color_style.dart';
import 'package:mentormatch_apps/style/font_style.dart';
import 'package:mentormatch_apps/style/text.dart';
import 'package:mentormatch_apps/widget/button.dart';
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
                title: "name",
                color: ColorStyle().secondaryColors,
              ),
              const TextFieldWidget(
                hintText: "Thiyara al-mawaddah",
              ),
              TittleTextField(
                title: "job",
                color: ColorStyle().secondaryColors,
              ),
              const TextFieldWidget(
                hintText: "Mahasiswa",
              ),
              TittleTextField(
                title: "School/University/Company",
                color: ColorStyle().secondaryColors,
              ),
              const TextFieldWidget(
                hintText: "Light University",
              ),
              const SizedBox(
                height: 12,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TittleTextField(
                    title: "Skill",
                    color: ColorStyle().secondaryColors,
                  ),
                  TextButton.icon(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _data();
                        }
                      },
                      icon: const Icon(Icons.add, size: 16),
                      label: Text(
                        "Add Skill",
                        style: FontFamily().regularText,
                      )),
                ],
              ),
              TextFieldWidget(
                controller: _skill,
                hintText: "skill",
                formKey: _formKey,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: _inputdata.map((data) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 12),
                      child: Padding(
                        padding: const EdgeInsets.only(top : 8.0),
                        child: Container(
                          constraints: const BoxConstraints(maxWidth: 123),
                          decoration: BoxDecoration(
                            color: ColorStyle().primaryColors,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  data['skill']!,
                                  style: FontFamily()
                                      .regularText
                                      .copyWith(color: ColorStyle().whiteColors),
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    _inputdata.remove(data);
                                  });
                                },
                                icon: Icon(
                                  Icons.close,
                                  size: 12,
                                  color: ColorStyle().whiteColors,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              TittleTextField(
                title: "Location",
                color: ColorStyle().secondaryColors,
              ),
              const TextFieldWidget(
                hintText: "Jakarta, Indonesia",
              ),
              TittleTextField(
                title: " about",
                color: ColorStyle().secondaryColors,
              ),
              const TextFieldWidget(
                hintText:
                    "i am a student at light university,now i am in semester 7",
              ),
              const SizedBox(
                height: 40,
              ),
              ElevatedButtonWidget(title: "Simpan", onPressed: () {}),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
