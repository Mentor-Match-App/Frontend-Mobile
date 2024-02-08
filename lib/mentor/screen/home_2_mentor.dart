// import 'dart:developer';

// import 'package:flutter/material.dart';
// import 'package:mentormatch_apps/mentee/service/user_mentee_service.dart';
// import 'package:mentormatch_apps/mentor/model/mentor_model.dart';
// import 'package:mentormatch_apps/mentor/screen/createClass_Session/form_create_class.dart';
// import 'package:mentormatch_apps/mentor/service/mentor_service.dart';
// import 'package:mentormatch_apps/style/color_style.dart';
// import 'package:mentormatch_apps/style/font_style.dart';
// import 'package:mentormatch_apps/widget/button.dart'; // Asumsi menggunakan ini

// class Home_2 extends StatefulWidget {
//   @override
//   _Home_2State createState() => _Home_2State();
// }

// class _Home_2State extends State<Home_2> {
//   final MentorService _userService = MentorService();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('User List'),
//       ),
//       body: FutureBuilder<List<MentorModel>>(
//         future: _userService.getUsers(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             return Center(child: Text('Error: ${snapshot.error}'));
//           } else {
//             return ListView.builder(
//               itemCount: snapshot.data?.length ?? 0,
//               itemBuilder: (context, index) {
//                 MentorModel mentor = snapshot.data![index];
//                 return Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Container(
//                       padding: const EdgeInsets.all(20),
//                       decoration: BoxDecoration(
//                           color: ColorStyle()
//                               .tertiaryColors // Set your desired background color
//                           ),
//                       child: Row(
//                         children: [
//                           Expanded(
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Row(
//                                   children: [
//                                     Text(
//                                       "Hai,",
//                                       style: FontFamily().regularText,
//                                     ),
//                                     const SizedBox(width: 4),
//                                     Text( mentor.name.toString(),
//                                         style: FontFamily().boldText.copyWith(
//                                             color:
//                                                 ColorStyle().secondaryColors)),
//                                   ],
//                                 ),
//                                 const SizedBox(height: 12),
//                                 Text(
//                                     "Jelajahi Dunia Mentoring yang Menginspirasi",
//                                     style: FontFamily().titleText.copyWith(
//                                         color: ColorStyle().primaryColors)),
//                                 const SizedBox(height: 2),
//                                 Text(
//                                   "Bagikan kisah sukses dan tantangan pribadi Anda. Ini membuat Anda lebih mudah dicapai dan memberikan inspirasi nyata. Dorong peserta untuk berpikir kritis dengan mengajukan pertanyaan terbuka. Ini membuka pintu untuk diskusi yang mendalam.",
//                                   style: FontFamily().regularText,
//                                 ),
//                                 const SizedBox(
//                                   height: 12,
//                                 ),
//                                 SmallElevatedButton(
//                                   height: 36,
//                                   width: 140,
//                                   title: "Buat Kelas",
//                                   style: FontFamily().buttonText.copyWith(
//                                         fontSize: 12,
//                                         color: ColorStyle().whiteColors,
//                                       ),
//                                   onPressed: () {
//                                     Navigator.push(
//                                       context,
//                                       MaterialPageRoute(
//                                         builder: (context) =>
//                                             FormCreatePremiumClassScreen(),
//                                       ),
//                                     );
//                                   },
//                                 ),
//                               ],
//                             ),
//                           ),
//                           Container(
//                             height: 100,
//                             width: 100,
//                             decoration: const BoxDecoration(
//                               image: DecorationImage(
//                                 image: AssetImage(
//                                     'assets/Handoff/ilustrator/mentor in zoom.png'),
//                                 fit: BoxFit.cover,
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     SizedBox(
//                       height: 20,
//                     ),
//                     Container(
//                       padding: const EdgeInsets.all(20),
//                       decoration: BoxDecoration(
//                           color: ColorStyle()
//                               .tertiaryColors // Set your desired background color
//                           ),
//                       child: Row(
//                         children: [
//                           Container(
//                             height: 100,
//                             width: 100,
//                             decoration: const BoxDecoration(
//                               image: DecorationImage(
//                                 image: AssetImage(
//                                     'assets/Handoff/ilustrator/learn by online.png'),
//                                 fit: BoxFit.cover,
//                               ),
//                             ),
//                           ),
//                           Expanded(
//                             child: Column(
//                               children: [
//                                 Text(
//                                     textAlign: TextAlign.right,
//                                     "Pimpin Perubahan, Jadi Mentor dalam Sesi Inovatif dan Pendidikan",
//                                     style: FontFamily().titleText.copyWith(
//                                         color: ColorStyle().primaryColors)),
//                                 const SizedBox(height: 2),
//                                 Text(
//                                   textAlign: TextAlign.right,
//                                   "Bagikan kisah sukses dan tantangan pribadi Anda. Ini membuat Anda lebih mudah dicapai dan memberikan inspirasi nyata. Dorong peserta untuk berpikir kritis dengan mengajukan pertanyaan terbuka. Ini membuka pintu untuk diskusi yang mendalam.",
//                                   style: FontFamily().regularText,
//                                 ),
//                                 const SizedBox(height: 12),
//                                 Align(
//                                   alignment: Alignment.centerRight,
//                                   child: SmallElevatedButton(
//                                     height: 36,
//                                     width: 140,
//                                     title: "Buat Session",
//                                     style: FontFamily().buttonText.copyWith(
//                                           fontSize: 12,
//                                           color: ColorStyle().whiteColors,
//                                         ),
//                                     onPressed: () {
//                                       Navigator.push(
//                                         context,
//                                         MaterialPageRoute(
//                                           builder: (context) =>
//                                               FormCreatePremiumClassScreen(),
//                                         ),
//                                       );
//                                     },
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 );
//               },
//             );
//           }
//         },
//       ),
//     );
//   }
// }
