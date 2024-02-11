import 'package:flutter/material.dart';
import 'package:mentormatch_apps/mentee/screen/Session/all_session_screen.dart';
import 'package:mentormatch_apps/mentee/screen/Session/back_end_session_screen.dart';
import 'package:mentormatch_apps/mentee/screen/Session/data_analys_session_screen.dart';
import 'package:mentormatch_apps/mentee/screen/Session/design_session_screen.dart';
import 'package:mentormatch_apps/mentee/screen/Session/finance_session_screen.dart';
import 'package:mentormatch_apps/mentee/screen/Session/front_end_session_screen.dart';
import 'package:mentormatch_apps/mentee/screen/Session/marketing_session_screen.dart';
import 'package:mentormatch_apps/mentee/screen/Session/quality_ansurance_session_screen.dart';
import 'package:mentormatch_apps/mentee/screen/Session/security_engineer_session_screen.dart';
import 'package:mentormatch_apps/style/color_style.dart';
import 'package:mentormatch_apps/style/font_style.dart';
import 'package:mentormatch_apps/widget/category_card.dart';
import 'package:mentormatch_apps/widget/navbar.dart';
import 'package:mentormatch_apps/widget/search_bar.dart';

class SessionScreen extends StatefulWidget {
  SessionScreen({Key? key}) : super(key: key);

  @override
  State<SessionScreen> createState() => _SessionScreenState();
}

class _SessionScreenState extends State<SessionScreen> {
  bool isAllCategoryActive = true;
  bool isBackEndActive = false;
  bool isFrontEndActive = false;
  bool isDataAnalystActive = false;
  bool isFinanceActive = false;
  bool isDesignActive = false;
  bool isMarketingActive = false;
  bool isQualityActive = false;
  bool isSecurityActive = false;

  void _handleMenuSelected(String menu) {
    setState(
      () {
        if (menu == 'All') {
          isAllCategoryActive = true;
          isBackEndActive = false;
          isFrontEndActive = false;
          isDataAnalystActive = false;
          isFinanceActive = false;
          isDesignActive = false;
          isMarketingActive = false;
          isQualityActive = false;
          isSecurityActive = false;
        } else if (menu == 'Back End') {
          isAllCategoryActive = false;
          isBackEndActive = true;
          isFrontEndActive = false;
          isDataAnalystActive = false;
          isFinanceActive = false;
          isDesignActive = false;
          isMarketingActive = false;
          isQualityActive = false;
          isSecurityActive = false;
        } else if (menu == 'Front End') {
          isAllCategoryActive = false;
          isBackEndActive = false;
          isFrontEndActive = true;
          isDataAnalystActive = false;
          isFinanceActive = false;
          isDesignActive = false;
          isMarketingActive = false;
          isQualityActive = false;
          isSecurityActive = false;
        } else if (menu == 'Data Analyst') {
          isAllCategoryActive = false;
          isBackEndActive = false;
          isFrontEndActive = false;
          isDataAnalystActive = true;
          isFinanceActive = false;
          isDesignActive = false;
          isMarketingActive = false;
          isQualityActive = false;
          isSecurityActive = false;
        } else if (menu == 'Finance') {
          isAllCategoryActive = false;
          isBackEndActive = false;
          isFrontEndActive = false;
          isDataAnalystActive = false;
          isFinanceActive = true;
          isDesignActive = false;
          isMarketingActive = false;
          isQualityActive = false;
          isSecurityActive = false;
        } else if (menu == 'Design') {
          isAllCategoryActive = false;
          isBackEndActive = false;
          isFrontEndActive = false;
          isDataAnalystActive = false;
          isFinanceActive = false;
          isDesignActive = true;
          isMarketingActive = false;
          isQualityActive = false;
          isSecurityActive = false;
        } else if (menu == 'Marketing') {
          isAllCategoryActive = false;
          isBackEndActive = false;
          isFrontEndActive = false;
          isDataAnalystActive = false;
          isFinanceActive = false;
          isDesignActive = false;
          isMarketingActive = true;
          isQualityActive = false;
          isSecurityActive = false;
          isDesignActive = false;
        } else if (menu == 'Quality Assurance') {
          isAllCategoryActive = false;
          isBackEndActive = false;
          isFrontEndActive = false;
          isDataAnalystActive = false;
          isFinanceActive = false;
          isDesignActive = false;
          isMarketingActive = false;
          isQualityActive = true;
          isSecurityActive = false;
        } else if (menu == 'Security Engineer') {
          isAllCategoryActive = false;
          isBackEndActive = false;
          isFrontEndActive = false;
          isDataAnalystActive = false;
          isFinanceActive = false;
          isDesignActive = false;
          isMarketingActive = false;
          isQualityActive = false;
          isSecurityActive = true;
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
          'Session',
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
                        img: 'assets/Handoff/icon/categoryIcon/Karier/all.png',
                      ),
                      CategoriCardWidget(
                        isActive: isBackEndActive,
                        onTap: () {
                          _handleMenuSelected('Back End');
                        },
                        title: "Back End ",
                        img:
                            'assets/Handoff/icon/categoryIcon/Karier/Back End.png',
                      ),
                      CategoriCardWidget(
                        isActive: isFrontEndActive,
                        onTap: () {
                          _handleMenuSelected('Front End');
                        },
                        title: "Front End",
                        img:
                            'assets/Handoff/icon/categoryIcon/Karier/Front End .png',
                      ),
                      CategoriCardWidget(
                        isActive: isDataAnalystActive,
                        onTap: () {
                          _handleMenuSelected('Data Analyst');
                        },
                        title: "Data Analyst",
                        img:
                            'assets/Handoff/icon/categoryIcon/Karier/data analys.png',
                      ),
                      CategoriCardWidget(
                        isActive: isFinanceActive,
                        onTap: () {
                          _handleMenuSelected('Finance');
                        },
                        title: "Finance",
                        img:
                            'assets/Handoff/icon/categoryIcon/Karier/finance.png',
                      ),
                      CategoriCardWidget(
                        isActive: isDesignActive,
                        onTap: () {
                          _handleMenuSelected('Design');
                        },
                        title: "Design",
                        img:
                            'assets/Handoff/icon/categoryIcon/Karier/design.png',
                      ),
                      CategoriCardWidget(
                        isActive: isMarketingActive,
                        onTap: () {
                          _handleMenuSelected('Marketing');
                        },
                        title: "Marketing",
                        img:
                            'assets/Handoff/icon/categoryIcon/Karier/marketing.png',
                      ),
                      CategoriCardWidget(
                        isActive: isQualityActive,
                        onTap: () {
                          _handleMenuSelected('Quality Assurance');
                        },
                        title: "Quality\nAssurance",
                        img:
                            'assets/Handoff/icon/categoryIcon/Karier/Qualiti Assurance.png',
                      ),
                      CategoriCardWidget(
                        isActive: isSecurityActive,
                        onTap: () {
                          _handleMenuSelected('Security Engineer');
                        },
                        title: "Security\nEngineer",
                        img:
                            'assets/Handoff/icon/categoryIcon/Karier/security engineer.png',
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    isAllCategoryActive
                        ? AllSessionScreen()
                        : isBackEndActive
                            ? BackEndSessionScreen() 
                            : isFrontEndActive
                                ? FrontEndSessionScreen()
                                : isDataAnalystActive
                                    ? DataAnalysSessionScreen()
                                    : isFinanceActive
                                        ? FinanceSessionScreen()
                                        : isDesignActive
                                            ? DesignSessionScreen()
                                            : isMarketingActive
                                                ? MarketingSessionScreen()
                                                : isQualityActive
                                                    ? QualityAnsuranceSessionScreen()
                                                    : isSecurityActive
                                                        ? SecurityEngineerSessionScreen()
                                                        : AllSessionScreen(),
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
