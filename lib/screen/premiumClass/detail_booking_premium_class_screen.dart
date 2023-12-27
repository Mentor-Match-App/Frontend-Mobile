import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mentormatch_apps/style/color_style.dart';
import 'package:mentormatch_apps/style/font_style.dart';
import 'package:mentormatch_apps/widget/button.dart';

class DetailBookingPremiumClass extends StatefulWidget {
  DetailBookingPremiumClass({Key? key}) : super(key: key);

  @override
  State<DetailBookingPremiumClass> createState() =>
      _DetailBookingPremiumClassState();
}

class _DetailBookingPremiumClassState extends State<DetailBookingPremiumClass> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset('assets/Handoff/logo/LogoMobile.png'),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Container(
              decoration: BoxDecoration(
                color: ColorStyle().tertiaryColors,
              ),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Card(
                        color: ColorStyle().succesColors,
                        child: const Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            'IDR 1.000.000,00',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    Text(
                      "Nama kelas",
                      style: FontFamily().boldText.copyWith(
                          color: ColorStyle().primaryColors, fontSize: 16),
                    ),
                    Text(
                      'UI/UX Research & Design',
                      style: FontFamily().regularText,
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Text(
                      "Nama Mentor",
                      style: FontFamily().boldText.copyWith(
                          color: ColorStyle().primaryColors, fontSize: 16),
                    ),
                    Text(
                      'Steven Jobs',
                      style: FontFamily().regularText,
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Text(
                      "Periode Kelas",
                      style: FontFamily().boldText.copyWith(
                          color: ColorStyle().primaryColors, fontSize: 16),
                    ),
                    Text(
                      '3 Bulan',
                      style: FontFamily().regularText,
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Text(
                      "Metode Pembayaran",
                      style: FontFamily().boldText.copyWith(
                          color: ColorStyle().primaryColors, fontSize: 16),
                    ),
                    Text(
                      'Transfer Bank',
                      style: FontFamily().regularText,
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Text(
                      "Bank Tujuan",
                      style: FontFamily().boldText.copyWith(
                          color: ColorStyle().primaryColors, fontSize: 16),
                    ),
                    Text(
                      'Bank BCA',
                      style: FontFamily().regularText,
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Text(
                      "Nama Pemilik Rekening",
                      style: FontFamily().boldText.copyWith(
                          color: ColorStyle().primaryColors, fontSize: 16),
                    ),
                    Text(
                      'PT TINOJER ACADEMY',
                      style: FontFamily().regularText,
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Text(
                      "Nomor Rekening",
                      style: FontFamily().boldText.copyWith(
                          color: ColorStyle().primaryColors, fontSize: 16),
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
                                duration:const  Duration(seconds: 2),
                                backgroundColor: ColorStyle().tertiaryColors,
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
                    const SizedBox(
                      height: 24,
                    ),
                    ElevatedButtonWidget(title: "Selesai", onPressed: () {}),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
