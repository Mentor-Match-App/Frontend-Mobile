import 'package:flutter/material.dart';
import 'package:mentormatch_apps/mentor/model/profile_model.dart';
import 'package:mentormatch_apps/mentor/screen/daftar_mentor/verification_regist.dart';
import 'package:mentormatch_apps/mentor/service/profile_service.dart';

import 'package:mentormatch_apps/mentor/service/reregistration_mentor_service.dart';
import 'package:mentormatch_apps/style/color_style.dart';
import 'package:mentormatch_apps/style/font_style.dart';
import 'package:mentormatch_apps/style/text.dart';
import 'package:mentormatch_apps/widget/button.dart';
import 'package:mentormatch_apps/widget/flushsBar_widget.dart';
import 'package:mentormatch_apps/widget/textField.dart';

class RegisterUlangMentorScreen extends StatefulWidget {
  RegisterUlangMentorScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<RegisterUlangMentorScreen> createState() =>
      _RegisterUlangMentorScreenState();
}

class _RegisterUlangMentorScreenState extends State<RegisterUlangMentorScreen> {
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
  String _mentorid = "";

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
  // list experience with role and experienceCompany
  List<Map<String, String>> experience = [];

  /// ambil data profile
  final ProfileService mentorService = ProfileService();

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
    _genderController.text = _selectedGender;
  }

  //  //// dispose controller ///
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
    _skillController.dispose();
    _roleController.dispose();
    _experienceCompanyController.dispose();
    _mentorid = "";

    super.dispose();
  }

  void _loadProfileData() async {
    final profileData = await mentorService.getMentorProfile();
    setState(() {
      //id mentor
      _mentorid = profileData.user!.id!;
      //gender
      _selectedGender = profileData.user!.gender ?? '';
      _jobController.text = profileData.user!.experiences
              ?.firstWhere((element) => element.isCurrentJob == true,
                  orElse: () => ExperienceMentor())
              .jobTitle ??
          '';
      _companyController.text = profileData.user!.experiences
              ?.firstWhere((element) => element.isCurrentJob == true,
                  orElse: () => ExperienceMentor())
              .company ??
          '';
      _locationController.text = profileData.user?.location ?? '';
      _linkedinController.text = profileData.user?.linkedin ?? '';
      _aboutController.text = profileData.user?.about ?? '';
      _portofolioController.text = profileData.user?.portofolio ?? '';
      _accountNumberController.text = profileData.user?.accountNumber ?? '';
      _accountNameController.text = profileData.user?.accountName ?? '';
      _skills.addAll(
          profileData.user?.skills?.map((skill) => {'skill': skill}) ?? []);
      experience.addAll(profileData.user?.experiences?.map((exp) => {
                'role': exp.jobTitle ?? '',
                'experienceCompany': exp.company ?? ''
              }) ??
          []);
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

  void _addExperience() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        experience.add({
          'role': _roleController.text,
          'experienceCompany': _experienceCompanyController.text
        });
        _roleController.clear();
        _experienceCompanyController.clear();
      });
    }
  }

  void _updateMentor() async {
    if (_formKey.currentState!.validate()) {
      final profileData = await mentorService.getMentorProfile();
      try {
        await MentorUpdateService().updateMentor(
          accountNumber: profileData.user?.accountName ?? '',
          accountName: profileData.user?.accountNumber ?? '',
          gender: profileData.user?.gender ?? '',
          mentorId: profileData.user?.id ?? '',
          portfolio: profileData.user?.portofolio ?? '',
          job: profileData.user?.experiences
                  ?.firstWhere((element) => element.isCurrentJob == true,
                      orElse: () => ExperienceMentor())
                  .jobTitle ??
              '',
          company: profileData.user?.experiences
                  ?.firstWhere((element) => element.isCurrentJob == true,
                      orElse: () => ExperienceMentor())
                  .company ??
              '',
          location: profileData.user?.location ?? '',
          skills: profileData.user?.skills ?? [],
          about: profileData.user?.about ?? '',
          linkedin: profileData.user?.linkedin ?? '',
          experiences: profileData.user?.experiences
                  ?.map((exp) => {
                        'role': exp.jobTitle ?? '',
                        'experienceCompany': exp.company ?? ''
                      })
                  .toList() ??
              [],
        );

        // Tampilkan SnackBar jika pembaruan berhasil
        if (mounted) {
          showTopSnackBar(context, 'Profile updated successfully',
        
        leftBarIndicatorColor: ColorStyle().succesColors);
        }

        // Navigasi ke halaman verifikasi
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => VerificationFormRegistScreen(),
          ),
          (route) => false,
        );
      } catch (error) {
        // Menampilkan pesan kesalahan jika terjadi kesalahan saat pembaruan profil mentor
        print('Error updating mentor profile: $error');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Failed to update mentor profile. Please try again later.',
            ),
            backgroundColor: Colors.red, // Warna merah untuk pesan kesalahan
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset('assets/Handoff/logo/LogoMobile.png'),
      ),
      body: Form(
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
    );
  }

  Widget _formFields() {
    return Column(
      children: [
        _genderDropdownField(), // Replace the gender text field with this

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
        children: experience.map((exp) => _buildExperienceChip(exp)).toList(),
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
          setState(() => experience.remove(exp));
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
        onPressed: () {
          _updateMentor();
        },
        title: "Apply",
      ),
    );
  }
}
