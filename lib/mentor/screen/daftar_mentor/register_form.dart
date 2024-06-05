import 'package:flutter/material.dart';
import 'package:mentormatch_apps/mentor/screen/daftar_mentor/verification_regist.dart';
import 'package:mentormatch_apps/mentor/service/register_mentor_service.dart';
import 'package:mentormatch_apps/preferences/%20preferences_helper.dart';
import 'package:mentormatch_apps/style/font_style.dart';
import 'package:mentormatch_apps/style/text.dart';
import 'package:mentormatch_apps/widget/button.dart';
import 'package:mentormatch_apps/widget/textField.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../style/color_style.dart';

class RegisterMentorScreen extends StatefulWidget {
  const RegisterMentorScreen({Key? key}) : super(key: key);

  @override
  State<RegisterMentorScreen> createState() => _RegisterMentorScreenState();
}

class _RegisterMentorScreenState extends State<RegisterMentorScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _jobController = TextEditingController();
  final TextEditingController _companyController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _linkedinController = TextEditingController();
  final TextEditingController _aboutController = TextEditingController();
  final TextEditingController _portofolioController = TextEditingController();
  final TextEditingController _skillController = TextEditingController();
  final List<Map<String, String>> _skills = [];
  // experience with role and experienceCompany
  final TextEditingController _roleController = TextEditingController();
  final TextEditingController _experienceCompanyController =
      TextEditingController();
  final TextEditingController _accountNumberController =
      TextEditingController();
  final TextEditingController _accountNameController = TextEditingController();

  String _name = "";
  String _selectedGender = '';
  String job = "";
  String company = "";
  String location = "";
  String linkedin = "";
  String about = "";
  String portofolio = "";
  String accountNumber = "";
  String accountName = "";
  List<String> skills = [];
  List<Map<String, String>> experiences = [];
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    _loadProfileData();
    _jobController.text = job;
    _companyController.text = company;
    _locationController.text = location;
    _linkedinController.text = linkedin;
    _aboutController.text = about;
    _portofolioController.text = portofolio;
    _accountNumberController.text = accountNumber;
    _accountNameController.text = accountName;
  }

  Future<void> _loadProfileData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _name = prefs.getString('name') ?? "";
    });
  }

  @override
  void dispose() {
    _genderController.dispose();
    _jobController.dispose();
    _companyController.dispose();
    _locationController.dispose();
    _linkedinController.dispose();
    _aboutController.dispose();
    _portofolioController.dispose();
    _accountNameController.dispose();
    _accountNumberController.dispose();
    super.dispose();
  }

  void _addSkill() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _skills.add({'skill': _skillController.text});
        _skillController.clear();
      });
    }
  }

  void _addExperience() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        experiences.add({
          'role': _roleController.text,
          'experienceCompany': _experienceCompanyController.text
        });
        _roleController.clear();
        _experienceCompanyController.clear();
      });
    }
  }

  Future<void> _registerMentor() async {
    skills = _skills.map((skill) => skill['skill']!).toList();
    setState(() {
      _isSaving = true;
    });
    // Instance of ProfileService
    RegisterMentorService registerMentorService = RegisterMentorService();
    await registerMentorService.registerMentor(
      gender: _genderController.text,
      job: _jobController.text,
      company: _companyController.text,
      skills: skills,
      location: _locationController.text,
      about: _aboutController.text,
      linkedin: _linkedinController.text,
      portofolio: _portofolioController.text,
      experiences: experiences,
      accountName: _accountNameController.text,
      accountNumber: _accountNumberController.text,
    );
    setState(() {
      _isSaving = false;
    });

    await UserPreferences.setUserType("PendingMentor");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset('assets/Handoff/logo/LogoMobile.png'),
      ),
      body: Stack(
        children: [
          Form(
            key: _formKey,
            child: ListView(
              padding: const EdgeInsets.all(20),
              children: [
                Image.asset('assets/Handoff/ilustrator/mentor in zoom.png'),
                const SizedBox(height: 24),
                Text(
                  'Hello $_name, \nComplete the form to become a mentor',
                  style: FontFamily().titleText.copyWith(fontSize: 16),
                  textAlign: TextAlign.start,
                ),
                const SizedBox(height: 24),
                _formFields(),
                const SizedBox(height: 24),
              ],
            ),
          ),
          if (_isSaving)
            Center(
              child: CircularProgressIndicator(),
            ),
        ],
      ),
    );
  }

  Widget _formFields() {
    return Column(
      children: [
        _genderDropdownField(), 
        _textFieldWithTitle(
          "Job/Title",
          _jobController,
          "Enter Your Job/Position",
          onChanged: (value) {
            setState(() {
              job = value;
            });
          },
        ),
        _textFieldWithTitle(
          "Company",
          _companyController,
          "Enter Your Company",
          onChanged: (value) {
            setState(() {
              company = value;
            });
          },
        ),
        _textFieldWithTitle(
          "Location",
          _locationController,
          "Enter Your Location",
          onChanged: (value) {
            setState(() {
              company = value;
            });
          },
        ),
        const SizedBox(height: 12),

        Align(
          alignment: Alignment.centerLeft,
          child: TittleTextField(
            title: "Rekening Bank",
            color: ColorStyle().secondaryColors,
          ),
        ),

        Padding(
          // Add padding left to the column
          padding: const EdgeInsets.only(left: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TittleTextField(
                title: "Bank",
                color: ColorStyle().secondaryColors,
              ),
              TextFieldWidget(
                enabled: false,
                hintText: "BCA",
              ),
              _textFieldWithTitle(
                "Account Name",
                _accountNameController,
                "Enter Your Account Name",
                onChanged: (value) {
                  setState(() {
                    accountName = value;
                  });
                },
              ),
              _textFieldWithTitle(
                "Account Number",
                _accountNumberController,
                "Enter Your Account Number",
                onChanged: (value) {
                  setState(() {
                    accountNumber = value;
                  });
                },
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        _skillField(),
        _skillChips(),
        const SizedBox(height: 12),
        _textFieldWithTitle(
            "LinkedIn", _linkedinController, "Enter Your LinkedIn URL",
            onChanged: (value) {
          setState(() {
            linkedin = value;
          });
        }),

        _textFieldWithTitle("About", _aboutController, "Enter Your About",
            onChanged: (value) {
          setState(() {
            about = value;
          });
        }),
        _textFieldWithTitle(
            "portofolio", _portofolioController, "Enter Your portofolio",
            onChanged: (value) {
          setState(() {
            portofolio = value;
          });
        }),

        _experienceField(),

        _experienceChips(),
        const SizedBox(height: 12),
        _applyButton(),
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
        ),
      ],
    );
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

  Widget _experienceField() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TittleTextField(
                title: "Experience", color: ColorStyle().secondaryColors),
            TextButton.icon(
              onPressed: _addExperience,
              icon: const Icon(Icons.add, size: 16),
              label: Text("Add Experience", style: FontFamily().regularText),
            ),
          ],
        ),
        TextFieldWidget(
          controller: _roleController,
          hintText: "Role",
        ),
        const SizedBox(height: 12),
        TextFieldWidget(
          controller: _experienceCompanyController,
          hintText: "Company",
        ),
      ],
    );
  }

  Widget _experienceChips() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: experiences.map((exp) => _buildExperienceChip(exp)).toList(),
      ),
    );
  }

  Widget _buildExperienceChip(Map<String, String> exp) {
    return Padding(
      padding: const EdgeInsets.only(right: 12, top: 8),
      child: Chip(
        label: Text(
          exp['role']! + " at " + exp['experienceCompany']!,
          style: FontFamily().regularText.copyWith(color: Colors.white),
        ),
        backgroundColor: ColorStyle().primaryColors,
        deleteIcon: const Icon(Icons.close, size: 12),
        onDeleted: () {
          setState(() => experiences.remove(exp));
        },
      ),
    );
  }

  Widget _genderDropdownField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TittleTextField(
            title: "What your gender", color: ColorStyle().secondaryColors),
        DropdownButtonFormField<String>(
          value: _selectedGender.isEmpty ? null : _selectedGender,
          decoration: InputDecoration(
            filled: true,
            fillColor: ColorStyle().tertiaryColors,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
              borderSide: BorderSide.none,
            ),
          ),
          hint: Text("Select Your Gender"),
          style: FontFamily().regularText.copyWith(
                color: ColorStyle().disableColors,
              ),
          //  buat waktu dropdown di klik stylenya sama dengan textfield
          onChanged: (String? newValue) {
            setState(() {
              _selectedGender = newValue!;
              _genderController.text =
                  newValue; // Update the controller if needed
            });
          },
          items: <String>['Pria', 'Wanita']
              .map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
      ],
    );
  }

  // apply button and navigate to next page
  Widget _applyButton() {
    return Center(
      child: ElevatedButtonWidget(
        onPressed: () async {
          if (_formKey.currentState!.validate()) {
            await _registerMentor();
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                    builder: (context) => VerificationFormRegistScreen()),
                (route) => false);
          }
        },
        title: "Apply",
      ),
    );
  }
}
