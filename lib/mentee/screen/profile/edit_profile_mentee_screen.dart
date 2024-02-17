import 'package:flutter/material.dart';
import 'package:mentormatch_apps/mentee/screen/home_mentee_screen.dart';
import 'package:mentormatch_apps/mentee/screen/profile/service.dart';
import 'package:mentormatch_apps/style/color_style.dart';
import 'package:mentormatch_apps/style/font_style.dart';
import 'package:mentormatch_apps/widget/button.dart';
import 'package:mentormatch_apps/widget/profile_avatar.dart';
import 'package:mentormatch_apps/widget/textField.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../style/text.dart';

class EditProfileMenteeScreen extends StatefulWidget {
  const EditProfileMenteeScreen({Key? key}) : super(key: key);

  @override
  _EditProfileMenteeScreenState createState() =>
      _EditProfileMenteeScreenState();
}

class _EditProfileMenteeScreenState extends State<EditProfileMenteeScreen> {
  final TextEditingController _skillController = TextEditingController();
  final List<Map<String, String>> _skills = [];
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _jobController = TextEditingController();
  final TextEditingController _schoolController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _aboutController = TextEditingController();
  final TextEditingController _linkedinController = TextEditingController();

  String _email = "";
  String _name = "";
  String _photoUrl = "";
  String job = '';
  String school = '';
  List<String> skills = []; // Consider how you'll collect and manage list input
  String location = '';
  String about = '';
  String linkedin = '';

  @override
  void initState() {
    super.initState();
    _loadProfileData();
    _emailController.text = _email;
    _nameController.text = _name;
    _jobController.text = job;
    _schoolController.text = school;
    _locationController.text = location;
    _aboutController.text = about;
    _linkedinController.text = linkedin;
  }

  Future<void> _loadProfileData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _email = prefs.getString('email') ?? "";
      _name = prefs.getString('name') ?? "";
      _photoUrl = prefs.getString('photoUrl') ?? "";

      // Update the controllers with the fetched values
      _emailController.text = _email;
      _nameController.text = _name;
    });
  }

  void _addSkill() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _skills.add({'skill': _skillController.text});
        _skillController.clear();
      });
    }
  }

  void _updateUserProfile() async {
    skills = _skills.map((skill) => skill['skill']!).toList();
    // Instance of ProfileService
    ProfileService profileService = ProfileService();
    await profileService.updateProfile(
      job: _jobController.text,
      school: _schoolController.text,
      skills: skills,
      location: _locationController.text,
      about: _aboutController.text,
      linkedin: _linkedinController.text,
    );
    // Handle post-update actions, like showing a confirmation dialog
  }

  @override
  void dispose() {
    _skillController.dispose();
    _emailController.dispose();
    _nameController.dispose();
    _jobController.dispose();
    _schoolController.dispose();
    _locationController.dispose();
    _aboutController.dispose();
    _linkedinController.dispose();
    super.dispose();
  }

  Widget _skillChips() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: _skills.map((skill) => _buildSkillChip(skill)).toList(),
      ),
    );
  }

  Widget _buildSkillChip(Map<String, String> skill) {
    return Padding(
      padding: const EdgeInsets.only(right: 12, top: 8),
      child: Chip(
        label: Text(
          skill['skill']!,
          style: FontFamily().regularText.copyWith(color: Colors.white),
        ),
        backgroundColor: ColorStyle().primaryColors,
        deleteIcon: const Icon(Icons.close, size: 12),
        onDeleted: () {
          setState(() => _skills.remove(skill));
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset('assets/Handoff/logo/LogoMobile.png'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Column(
          children: [
            _profileSection(),
            _formFields(),
            const SizedBox(height: 40),
            _saveButton(context),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  Widget _profileSection() {
    return Center(
      child: Column(
        children: [
          ProfileAvatar(imageUrl: _photoUrl, radius: 80),
          Text(_name, style: FontFamily().titleText.copyWith(fontSize: 14)),
        ],
      ),
    );
  }

  Widget _formFields() {
    return Column(
      children: [
        _textFieldWithTitle("Email", _emailController, "Your email",
            enabled: false), // Assuming you have an email controller
        _textFieldWithTitle("Name", _nameController, "Your name",
            enabled: false), // Assuming you have a name controller
        _textFieldWithTitle(
          "Job",
          _jobController,
          "Enter Your Job/Position",
          onChanged: (value) {
            setState(() {
              job = value;
            });
          },
        ),
        _textFieldWithTitle(
          "School/University/Company",
          _schoolController,
          "Enter Your School/University/Company",
          onChanged: (value) {
            setState(() {
              school = value;
            });
          },
        ),
        const SizedBox(height: 12),
        _skillField(),
        _skillChips(),
        const SizedBox(height: 12),
        _textFieldWithTitle(
            "Location", _locationController, "Enter Your Location",
            onChanged: (value) {
          setState(() {
            location = value;
          });
        }),
        _textFieldWithTitle("About", _aboutController, "Enter Your About",
            onChanged: (value) {
          setState(() {
            about = value;
          });
        }),
        _textFieldWithTitle(
            "LinkedIn", _linkedinController, "Enter Your LinkedIn URL",
            onChanged: (value) {
          setState(() {
            linkedin = value;
          });
        }),
      ],
    );
  }

  Widget _textFieldWithTitle(
      String title, TextEditingController controller, String hintText,
      {bool enabled = true, Function(String)? onChanged}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TittleTextField(title: title, color: ColorStyle().secondaryColors),
        TextFieldWidget(
          hintText: hintText,
          controller: controller,
          enabled: enabled,
          onChanged: onChanged, // Add this line
        ),
      ],
    );
  }

  Widget _skillField() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TittleTextField(
                title: "Skill", color: ColorStyle().secondaryColors),
            TextButton.icon(
              onPressed: _addSkill,
              icon: const Icon(Icons.add, size: 16),
              label: Text("Add Skill", style: FontFamily().regularText),
            ),
          ],
        ),
        TextFieldWidget(
          controller: _skillController,
          hintText: "Skill",
          formKey: _formKey,
        ),
      ],
    );
  }

  Widget _saveButton(BuildContext context) {
    return ElevatedButtonWidget(
        title: "Save",
        onPressed: () {
          // Validate if any skills have been added to the chips (i.e., the _skills list is not empty)
          if (_skills.isEmpty) {
            // If no skills have been added to chips, show a SnackBar prompting the user to add at least one skill
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                    "Please add at least one skill using the 'Add Skill' button."),
                backgroundColor: Colors.red,
              ),
            );
          } else if (_formKey.currentState!.validate()) {
            // If there are one or more skills added and the form is valid, proceed to update the profile
            _formKey.currentState!.save();
            _updateUserProfile();
            // navigate to HomeMenteeScreen after updating the profile
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => HomeMenteeScreen()),
                (route) => false);
          }
        });
  }
}
