import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mentormatch_apps/mentee/screen/premiumClass/SMA/detail_class_mentor_SMA.dart';
import 'package:mentormatch_apps/mentor/model/category_SMA_model.dart';
import 'package:mentormatch_apps/style/color_style.dart';
import 'package:mentormatch_apps/style/font_style.dart';
import 'package:mentormatch_apps/style/text.dart';
import 'package:mentormatch_apps/widget/button.dart';
import 'package:mentormatch_apps/widget/category_card.dart';
import 'package:mentormatch_apps/widget/experience_widget.dart';
import 'package:mentormatch_apps/widget/navbar.dart';
import 'package:mentormatch_apps/widget/profile_avatar.dart';
import 'package:mentormatch_apps/widget/review_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailMentorSMAScreen extends StatefulWidget {
  //  final List<Experience> description;
  final List<ExperienceSMA> experiences;
  final String classid;
  // final int periode;
  final List<MentorReviewSMA>? reviews;
  // final int price;
  final List<ClassMentorSMA>? classes;
  final String about;
  final String photoUrl;
  final String name;
  final String company;
  final String job;
  final String email;
  final String linkedin;
  final List<String> skills;
  final String location;

  // final List<String> terms;
  final MentorSMA mentor;
  DetailMentorSMAScreen(
      {Key? key,
      required this.experiences,
      required this.classid,
      // required this.periode,
      this.reviews,
      // required this.price,
      required this.classes,
      required this.about,
      required this.photoUrl,
      required this.name,
      required this.company,
      required this.job,
      required this.email,
      required this.linkedin,
      required this.skills,
      required this.location,
      // required this.description,
      // required this.terms,
      required this.mentor})
      : super(key: key);

  @override
  State<DetailMentorSMAScreen> createState() => _DetailMentorSMAScreenState();
}

class _DetailMentorSMAScreenState extends State<DetailMentorSMAScreen> {
  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Tidak dapat membuka $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: ColorStyle().tertiaryColors,
          title: AppBarLogoNotif()),
      body: ListView(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.20,
                decoration: BoxDecoration(
                    color: ColorStyle()
                        .tertiaryColors // Warna latar belakang yang diinginkan
                    ),
              ),
              Transform.translate(
                offset: Offset(0.0, -120 / 2.0),
                child: Center(
                  child: Column(
                    children: [
                      ProfileAvatar(
                        imageUrl: widget.photoUrl,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        widget.name,
                        style: FontFamily().boldText.copyWith(
                              fontSize: 16,
                            ),
                      ),
                      TextButton.icon(
                        onPressed: () {},
                        icon: Icon(
                          Icons.location_on,
                          color: ColorStyle().primaryColors,
                        ),
                        label: Text(
                          widget.location,
                          style: FontFamily().regularText,
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TitleProfile(
                            title: 'About',
                            color: ColorStyle().primaryColors,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 12.0),
                            child: Text(
                              widget.about,
                              style: FontFamily().regularText,
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(right: 12.0, top: 8.0),
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Container(
                                width: 120,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: ColorStyle().primaryColors,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: TextButton.icon(
                                  style: TextButton.styleFrom(
                                    primary: ColorStyle().whiteColors,
                                  ),
                                  onPressed: () {
                                    final linkedlnlink = widget.linkedin ?? '';
                                    _launchURL(linkedlnlink);
                                  },
                                  icon: Icon(Icons.link),
                                  label: Text('Linkedln',
                                      style: FontFamily().regularText.copyWith(
                                            color: ColorStyle().whiteColors,
                                          )),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TitleProfile(
                            title: 'Experience',
                            color: ColorStyle().primaryColors,
                          ),
                          Column(
                            children: widget.mentor.experiences
                                    ?.map((experience) {
                                  return ExperienceWidget(
                                    role: experience.jobTitle ?? 'No Job Title',
                                    company: experience.company ?? 'No Company',
                                  );
                                }).toList() ??
                                [Text('No experiences')],
                          )
                        ],
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: TitleProfile(
                          title: 'Skills',
                          color: ColorStyle().primaryColors,
                        ),
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: widget.skills
                              .map((skill) => SkillCard(skill: skill))
                              .toList(),
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: TitleProfile(
                          title: 'Program yang di tawarkan',
                          color: ColorStyle().primaryColors,
                        ),
                      ),
                      Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: widget.classes?.map((kelas) {
                                  int getApprovedTransactionCount(
                                      ClassMentorSMA kelas) {
                                    int count = kelas.transactions
                                            ?.where((t) =>
                                                t.paymentStatus == "Approved")
                                            .length ??
                                        0;
                                    print(
                                        "Kelas: ${kelas.name}, Transaksi Approved: $count");
                                    return count;
                                  }

                                  int approvedTransactions =
                                      getApprovedTransactionCount(kelas);
                                  int availableSlots = kelas.maxParticipants! -
                                      approvedTransactions;

                                  // Mengubah logika warna berdasarkan availableSlots
                                  Color buttonColor = availableSlots > 0
                                      ? ColorStyle()
                                          .primaryColors // Jika masih ada slot, gunakan warna primer
                                      : ColorStyle()
                                          .disableColors; // Jika slot penuh, gunakan warna disable

                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: ElevetadButtonWithIcon(
                                      // Asumsi typo telah diperbaiki
                                      color:
                                          buttonColor, // Terapkan warna tombol
                                      onPressed: availableSlots > 0
                                          ? () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      DetailClassMentorSMA(
                                                   addressMentoring:
                                                      kelas.address ?? "",
                                                  locationMentoring:
                                                      kelas.location ?? "",
                                                  mentorName: widget.name,
                                                  transaction:
                                                      kelas.transactions ?? [],
                                                  mentorData: widget.mentor,
                                                  classId: kelas.id,
                                                  classname: kelas.name ??
                                                      'No Class Name',
                                                  classprice: kelas.price ?? 0,
                                                  classduration:
                                                      kelas.durationInDays ?? 0,
                                                  maxParticipants:
                                                      kelas.maxParticipants ??
                                                          0,
                                                  endDate: DateTime.parse(
                                                      kelas.endDate ?? ''),
                                                  startDate: DateTime.parse(
                                                      kelas.startDate ?? ''),
                                                  schedule: kelas.schedule ??
                                                      'No Schedule',
                                                  classDescription:
                                                      kelas.description ??
                                                          'No Description',
                                                  targetLearning:
                                                      kelas.targetLearning,
                                                  terms: kelas.terms,
                                                  durationInDays:
                                                      kelas.durationInDays,
                                                  price: kelas.price ?? 0,
                                                  location: kelas.location,
                                                  address: kelas.address,
                                                    // Lanjutkan dengan parameter lainnya...
                                                  ),
                                                ),
                                              );
                                            }
                                          : null, // Menonaktifkan tombol jika slot penuh

                                      title: kelas.name ?? 'No Class Name',
                                    ),
                                  );
                                }).toList() ??
                                [Center(child: Text('No classes available'))],
                          )),
                      const SizedBox(
                        height: 12,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: TitleProfile(
                          title: 'Review',
                          color: ColorStyle().primaryColors,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: buildReviewWidgets(),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  //////review mentor///////
  Widget buildReviewWidgets() {
    // Periksa apakah reviews ada dan tidak kosong
    if (widget.reviews != null && widget.reviews!.isNotEmpty) {
      return Column(
        children: widget.reviews!.map((review) {
          return ReviewWidget(
            name: review.reviewer ?? "No Name",
            review: review.content ?? "No Review",
          );
        }).toList(),
      );
    } else {
      // Jika tidak ada review, tampilkan pesan
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text("Belum ada review",
              style: TextStyle(fontWeight: FontWeight.bold)),
        ),
      );
    }
  }
}
