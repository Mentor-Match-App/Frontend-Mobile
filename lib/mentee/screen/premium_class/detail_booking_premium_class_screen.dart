import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:mentormatch_apps/mentee/screen/bottom_mentee_screen.dart';
import 'package:mentormatch_apps/style/color_style.dart';
import 'package:mentormatch_apps/style/font_style.dart';
import 'package:mentormatch_apps/widget/button.dart';
import 'package:mentormatch_apps/widget/flushs_bar_widget.dart';

class DetailBookingClass extends StatefulWidget {
  final int uniqueCode;
  final int price;
  final String nama_mentor;
  final int durasi;
  final String nama_kelas;

  DetailBookingClass(
      {Key? key,
      required this.price,
      required this.nama_mentor,
      required this.durasi,
      required this.nama_kelas,
      required this.uniqueCode})
      : super(key: key);

  @override
  State<DetailBookingClass> createState() => _DetailBookingClassState();
}

class _DetailBookingClassState extends State<DetailBookingClass> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorStyle().whiteColors,
      body: ListView(
        children: [
          SizedBox(
            height: 36,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.bottomLeft,
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 12.0,
                    left: 24.0,
                    right: 8.0,
                  ),
                  child: Text(
                    "Payment Class",
                    style: FontFamily().boldText.copyWith(
                        fontSize: 24, color: ColorStyle().secondaryColors),
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(left: 24.0, top: 8.0, bottom: 8.0),
                child: Text(
                  "Terima kasih telah melakukan booking kelas dengan kami. Pesanan Anda telah diterima dengan baik. Namun, untuk mengonfirmasi keikutsertaan Anda, pembayaran harus dilakukan.",
                  style: FontFamily().regularText.copyWith(fontSize: 12),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: 8.0, left: 12.0, right: 12.0, bottom: 8.0),
                child: Container(
                  width: double.infinity,
                  height: 400,
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: ColorStyle().tertiaryColors,
                          blurRadius: 4,
                          spreadRadius: 4,
                          offset: Offset(0, 4), // Shadow position
                        ),
                      ],
                      color: Colors.white,

                      // border radius
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 20.0,
                          left: 12,
                          bottom: 12.0,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              children: [
                                Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    "Total Pembayaran",
                                    style: FontFamily()
                                        .regularText
                                        .copyWith(fontSize: 14),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.center,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      "${NumberFormat.currency(locale: 'id', symbol: 'Rp').format(widget.price + widget.uniqueCode)}",
                                      style: FontFamily().boldText.copyWith(
                                          color: ColorStyle().secondaryColors,
                                          fontSize: 24),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(bottom: 8.0, top: 8.0),
                              child: Text(
                                "Nama Kelas",
                                style: FontFamily().boldText.copyWith(
                                    color: ColorStyle().primaryColors,
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
                                    color: ColorStyle().primaryColors,
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
                                    color: ColorStyle().primaryColors,
                                    fontSize: 14),
                              ),
                            ),
                            Text('${widget.durasi} Hari',
                                style: FontFamily().regularText),
                            SizedBox(
                              height: 8.0,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(bottom: 8.0, top: 8.0),
                              child: Text(
                                "Metode Pembayaran",
                                style: FontFamily().boldText.copyWith(
                                    color: ColorStyle().primaryColors,
                                    fontSize: 14),
                              ),
                            ),
                            Text(
                              "BANK BCA",
                              style: FontFamily()
                                  .boldText
                                  .copyWith(color: ColorStyle().primaryColors),
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
                                    Clipboard.setData(const ClipboardData(
                                        text: '1234567890'));

                                    // Tampilkan snackbar atau pesan bahwa teks telah disalin
                                    showTopSnackBar(
                                        context, 'Teks telah disalin');
                                  },
                                  icon: const Icon(Icons.copy),
                                )
                              ],
                            ),
                            Text(
                              "PT.TINOJER ACADEMY",
                              style: FontFamily().regularText,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  "*Pembayaran berlaku sampai 24 jam setelah melakukan booking kelas",
                  style: FontFamily()
                      .regularText
                      .copyWith(color: ColorStyle().errorColors),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: ElevatedButtonWidget(
                  title: "Kembali Ke Beranda",
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const BottomNavbarMenteeScreen(
                                activeScreen: 0,
                              )),
                      (Route<dynamic> route) =>
                          false, // Remove all routes until the new route
                    );
                  },
                ),
              ),
              const SizedBox(
                height: 24,
              ),
            ],
          )
        ],
      ),
    );
  }
}
