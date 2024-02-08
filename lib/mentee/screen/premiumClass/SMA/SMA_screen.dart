import 'package:flutter/material.dart';
import 'package:mentormatch_apps/mentee/screen/premiumClass/SD/all_sd_screen.dart';
import 'package:mentormatch_apps/mentee/screen/premiumClass/SD/math_sd_scree.dart';
import 'package:mentormatch_apps/mentee/screen/premiumClass/SD/tech_sd_screen.dart';
import 'package:mentormatch_apps/mentee/screen/premiumClass/SMA/all_sma_screen.dart';
import 'package:mentormatch_apps/mentee/screen/premiumClass/SMA/bahasa_sma_screen.dart';
import 'package:mentormatch_apps/mentee/screen/premiumClass/SMA/biology_sma_screen.dart';
import 'package:mentormatch_apps/mentee/screen/premiumClass/SMA/ekonomi_sma_screen.dart';
import 'package:mentormatch_apps/mentee/screen/premiumClass/SMA/fisika_sma_screen.dart';
import 'package:mentormatch_apps/mentee/screen/premiumClass/SMA/geografi_sma_screen.dart';
import 'package:mentormatch_apps/mentee/screen/premiumClass/SMA/kimia_sma_screen.dart';
import 'package:mentormatch_apps/mentee/screen/premiumClass/SMA/math_sma_screen.dart';
import 'package:mentormatch_apps/mentee/screen/premiumClass/SMA/tech_sma_screen.dart';
import 'package:mentormatch_apps/style/color_style.dart';
import 'package:mentormatch_apps/style/font_style.dart';
import 'package:mentormatch_apps/widget/category_card.dart';
import 'package:mentormatch_apps/widget/navbar.dart';
import 'package:mentormatch_apps/widget/search_bar.dart';

class SMAScreen extends StatefulWidget {
  SMAScreen({Key? key}) : super(key: key);

  @override
  State<SMAScreen> createState() => _SMAScreenState();
}

class _SMAScreenState extends State<SMAScreen> {
  bool isAllCategoryActive = true;
  bool isBiologyActive = false;
  bool isEkonomiActive = false;
  bool isTechActive = false;
  bool isMathActive = false;
  bool isKimiaActive = false;
  bool isGeografiActive = false;
  bool isFisikaActive = false;
  bool isBahasaActive = false;

  void _handleMenuSelected(String menu) {
    setState(
      () {
        if (menu == 'All') {
          isAllCategoryActive = true;
          isBiologyActive = false;
          isEkonomiActive = false;
          isTechActive = false;
          isMathActive = false;
          isKimiaActive = false;
          isGeografiActive = false;
          isFisikaActive = false;
          isBahasaActive = false;
        } else if (menu == 'Biology') {
          isAllCategoryActive = false;
          isBiologyActive = true;
          isEkonomiActive = false;
          isTechActive = false;
          isMathActive = false;
          isKimiaActive = false;
          isGeografiActive = false;
          isFisikaActive = false;
          isBahasaActive = false;
        } else if (menu == 'Ekonomi') {
          isAllCategoryActive = false;
          isBiologyActive = false;
          isEkonomiActive = true;
          isTechActive = false;
          isMathActive = false;
          isKimiaActive = false;
          isGeografiActive = false;
          isFisikaActive = false;
          isBahasaActive = false;
        } else if (menu == 'Fisika') {
          isAllCategoryActive = false;
          isBiologyActive = false;
          isEkonomiActive = false;
          isTechActive = false;
          isMathActive = false;
          isKimiaActive = false;
          isGeografiActive = false;
          isFisikaActive = true;
          isBahasaActive = false;
        } else if (menu == 'Geografi') {
          isAllCategoryActive = false;
          isBiologyActive = false;
          isEkonomiActive = false;
          isTechActive = false;
          isMathActive = false;
          isKimiaActive = false;
          isGeografiActive = true;
          isFisikaActive = false;
          isBahasaActive = false;
        } else if (menu == 'Kimia') {
          isAllCategoryActive = false;
          isBiologyActive = false;
          isEkonomiActive = false;
          isTechActive = false;
          isMathActive = false;
          isKimiaActive = true;
          isGeografiActive = false;
          isFisikaActive = false;
          isBahasaActive = false;
        } else if (menu == 'Bahasa') {
          isAllCategoryActive = false;
          isBiologyActive = false;
          isEkonomiActive = false;
          isTechActive = false;
          isMathActive = false;
          isKimiaActive = false;
          isGeografiActive = false;
          isFisikaActive = false;
          isBahasaActive = true;
        } else if (menu == 'Matematika') {
          isAllCategoryActive = false;
          isBiologyActive = false;
          isEkonomiActive = false;
          isTechActive = false;
          isMathActive = true;
          isKimiaActive = false;
          isGeografiActive = false;
          isFisikaActive = false;
          isBahasaActive = false;
        } else if (menu == 'Teknologi') {
          isAllCategoryActive = false;
          isBiologyActive = false;
          isEkonomiActive = false;
          isTechActive = true;
          isMathActive = false;
          isKimiaActive = false;
          isGeografiActive = false;
          isFisikaActive = false;
          isBahasaActive = false;
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          AppBarPremiumClass(),
        ],
        title: Text(
          'SMA',
          style: FontFamily().boldText.copyWith(
                color: ColorStyle().primaryColors,
                fontSize: 14.0,
              ),
        ),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SearchBarWidget(
                  title: 'Search by name, role, company',
                  onPressed: () {},
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      CategoriCardWidget(
                        isActive: isAllCategoryActive,
                        onTap: () {
                          _handleMenuSelected('All');
                        },
                        title: "All",
                        img: 'assets/Handoff/icon/categoryIcon/SMA/all.png',
                      ),
                      CategoriCardWidget(
                        isActive: isGeografiActive,
                        onTap: () {
                          _handleMenuSelected('Geografi');
                        },
                        title: "Geografi",
                        img: 'assets/Handoff/icon/categoryIcon/SMA/math.png',
                      ),
                      CategoriCardWidget(
                        isActive: isEkonomiActive,
                        onTap: () {
                          _handleMenuSelected('Ekonomi');
                        },
                        title: "Ekonomi",
                        img:
                            'assets/Handoff/icon/categoryIcon/SMA/economi.png',
                      ),
                      CategoriCardWidget(
                        isActive: isBiologyActive,
                        onTap: () {
                          _handleMenuSelected('Biology');
                        },
                        title: "Biology",
                        img:
                            'assets/Handoff/icon/categoryIcon/SMA/bilogy.png',
                      ),
                      CategoriCardWidget(
                        isActive: isFisikaActive,
                        onTap: () {
                          _handleMenuSelected('Fisika');
                        },
                        title: "Fisika",
                        img: 'assets/Handoff/icon/categoryIcon/SMA/fisika.png',
                      ),
                      CategoriCardWidget(
                        isActive: isBahasaActive,
                        onTap: () {
                          _handleMenuSelected('Bahasa');
                        },
                        title: "Fisika",
                        img: 'assets/Handoff/icon/categoryIcon/SMA/Sastra Bahasa.png',
                      ),
                       CategoriCardWidget(
                        isActive: isKimiaActive,
                        onTap: () {
                          _handleMenuSelected('Kimia');
                        },
                        title: "Kimia",
                        img: 'assets/Handoff/icon/categoryIcon/SMA/Kimia.png',
                      ),
                      CategoriCardWidget(
                        isActive: isTechActive,
                        onTap: () {
                          _handleMenuSelected('Teknologi');
                        },
                        title: "Teknologi",
                        img: 'assets/Handoff/icon/categoryIcon/SMA/tech.png',
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    isAllCategoryActive
                        ? AllSMAScreen()
                        : isBiologyActive
                            ? BiologiSMAScreen()
                            : isEkonomiActive
                                ? EkonomiSMAScreen()
                                : isTechActive
                                    ? TechSMAScreen()
                                    : isMathActive
                                        ? MathSMAScreen()
                                        : isBahasaActive
                                            ? BahasaSMAScreen()
                                            : isKimiaActive
                                                ? KimiaSMAScreen()
                                                : isGeografiActive
                                                    ? GeografiSMAScreen()
                                                    : isFisikaActive
                                                        ? FisikaSMAScreen()
                                                        : AllSDScreen()
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
