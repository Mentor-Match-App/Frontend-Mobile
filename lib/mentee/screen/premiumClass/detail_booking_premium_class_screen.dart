import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:mentormatch_apps/mentee/screen/home_screen_mentee.dart';
import 'package:mentormatch_apps/mentee/screen/premiumClass/premium_class_screen.dart';
import 'package:mentormatch_apps/style/color_style.dart';
import 'package:mentormatch_apps/style/font_style.dart';
import 'package:mentormatch_apps/widget/button.dart';

class DetailBookingClass extends StatefulWidget {
  final int uniqueCode;
  final int price;
  final String nama_mentor;
  final int durasi;
  final String nama_kelas;

  DetailBookingClass({
    Key? key,
    required this.price,
    required this.nama_mentor,
    required this.durasi,
    required this.nama_kelas,
    required this.uniqueCode
  }) : super(key: key);

  @override
  State<DetailBookingClass> createState() => _DetailBookingClassState();
}

class _DetailBookingClassState extends State<DetailBookingClass> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.bottomLeft,
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 12.0, left: 24.0, right: 8.0, bottom: 24.0),
                  child: Text(
                    "Payment Class",
                    style: FontFamily().boldText.copyWith(fontSize: 24, color: ColorStyle().secondaryColors),
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Total Pembayaran",
                    style: FontFamily()
                        .regularText
                        .copyWith(color: ColorStyle().disableColors),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                   "${NumberFormat.currency(locale: 'id', symbol: 'Rp').format(widget.price + widget.uniqueCode)}",
                      style: FontFamily().boldText.copyWith(
                          color: ColorStyle().primaryColors, fontSize: 24),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 12,
              ),
              Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                  color: ColorStyle().tertiaryColors,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(65),
                    topRight: Radius.circular(65),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 40.0,
                        left: 24,
                        bottom: 12.0,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.only(bottom: 8.0, top: 8.0),
                            child: Text(
                              "Nama Kelas",
                              style: FontFamily().boldText.copyWith(
                                  color: ColorStyle().secondaryColors,
                                  fontSize: 14),
                            ),
                          ),
                          Text(widget.nama_kelas,
                              style: FontFamily().regularText),
                          Padding(
                            padding:
                                const EdgeInsets.only(bottom: 8.0, top: 8.0),
                            child: Text(
                              "Nama Mentor",
                              style: FontFamily().boldText.copyWith(
                                  color: ColorStyle().secondaryColors,
                                  fontSize: 14),
                            ),
                          ),
                          Text(widget.nama_mentor,
                              style: FontFamily().regularText),
                          Padding(
                            padding:
                                const EdgeInsets.only(bottom: 8.0, top: 8.0),
                            child: Text(
                              "Periode Kelas",
                              style: FontFamily().boldText.copyWith(
                                  color: ColorStyle().secondaryColors,
                                  fontSize: 14),
                            ),
                          ),
                          Text(  '${widget.durasi} Hari', style: FontFamily().regularText),
                          SizedBox(
                            height: 8.0,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(bottom: 8.0, top: 8.0),
                            child: Text(
                              "Metode Pembayaran",
                              style: FontFamily().boldText.copyWith(
                                  color: ColorStyle().secondaryColors,
                                  fontSize: 14),
                            ),
                          ),
                          Text(
                            "BANK BCA",
                            style: FontFamily()
                                .boldText
                                .copyWith(color: ColorStyle().secondaryColors),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '1234567890',
                                style: FontFamily().boldText,
                              ),
                              const SizedBox(
                                width: 12,
                              ),
                              IconButton(
                                onPressed: () {
                                  // Menyalin teks ke clipboard
                                  Clipboard.setData(
                                      const ClipboardData(text: '1234567890'));

                                  // Tampilkan snackbar atau pesan bahwa teks telah disalin
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      duration: const Duration(seconds: 2),
                                      backgroundColor:
                                          ColorStyle().tertiaryColors,
                                      behavior: SnackBarBehavior.floating,
                                      content: Text(
                                        'Teks telah disalin',
                                        style: FontFamily().regularText,
                                      ),
                                    ),
                                  );
                                },
                                icon: const Icon(Icons.copy),
                              )
                            ],
                          ),
                          Text(
                            "PT.TINOJER ACADEMY",
                            style: FontFamily().regularText,
                          ),
                          SizedBox(
                            height: 24,
                          ),
                          Text(
                            "*Pembayaran berlaku sampai 24 jam setelah melakukan booking kelas",
                            style: FontFamily()
                                .regularText
                                .copyWith(color: ColorStyle().errorColors),
                          ),
                          const SizedBox(
                            height: 32,
                          ),
                          Padding(
                            padding: const EdgeInsets.only( top: 8.0, right: 16.0),
                            child: ElevatedButtonWidget(
                              title: "Kembali Ke Beranda",
                              onPressed: () {
                                Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => HomeMenteeScreen()),
                                  (Route<dynamic> route) =>
                                      false, // Remove all routes until the new route
                                );
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
