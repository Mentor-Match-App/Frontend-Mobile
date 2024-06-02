import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mentormatch_apps/style/color_style.dart';
import 'package:mentormatch_apps/style/font_style.dart';
import 'package:url_launcher/url_launcher.dart';

class PaymentErrorScreenMentee extends StatefulWidget {
  final String classname;
  final int price;
  // final String paymentdate;
  final String rejectReason;
  final int uniqueId;
  PaymentErrorScreenMentee(
      {Key? key,
      required this.classname,
      required this.price,
      // required this.paymentdate,
      required this.uniqueId,
      required this.rejectReason})
      : super(key: key);

  @override
  State<PaymentErrorScreenMentee> createState() =>
      _PaymentErrorScreenMenteeState();
}

class _PaymentErrorScreenMenteeState extends State<PaymentErrorScreenMentee> {
  final String phoneNumber =
      "+6281362845327"; // Ganti dengan nomor telepon tujuan

  Future<void> _launchWhatsApp() async {
    final String url = "https://wa.me/$phoneNumber";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  String formatCurrency(int amount) {
    final formatter = NumberFormat.currency(
        locale: 'id_ID', symbol: 'Rp. ', decimalDigits: 0);
    return formatter.format(amount);
  }

  @override
  Widget build(BuildContext context) {
    int totalAmount = widget.price + widget.uniqueId;
    return Scaffold(
      appBar: AppBar(
        title: Text('Pembayaran di tolak',
            style: FontFamily().boldText.copyWith(
                  fontSize: 20,
                  color: ColorStyle().primaryColors,
                )),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Image.asset(
                  "assets/Handoff/ilustrator/payment-gagal.png",
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Text("Nama Kelas"),
                  const Text(" : "),
                  Text(
                    widget.classname,
                    style: FontFamily().boldText.copyWith(
                          fontSize: 12,
                        ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Text("Nominal Pembayaran"),
                  const Text(" : "),
                  Text(
                    // Menggabungkan total pembayaran dan uniqueId serta memformatnya
                    formatCurrency(totalAmount),
                    style: FontFamily().boldText.copyWith(
                          fontSize: 12,
                        ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Maaf, pembayaran anda ditolak karena :',
                      style: FontFamily().regularText,
                      textAlign: TextAlign.center,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        //buat tanda kutip di awal dan akhir kalimat
                        '"${widget.rejectReason}"' ?? 'Alasan tidak diketahui',
                        style: FontFamily()
                            .boldText
                            .copyWith(color: ColorStyle().errorColors),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Text(
                      'Silahkan melakukan hubungi kontak admin dibawah ini untuk informasi lebih lanjut',
                      style: FontFamily().regularText,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              SizedBox(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 48,
                      width: 132,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: ColorStyle().succesColors,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 1,
                            blurRadius: 2,
                            offset: Offset(0, 2), // changes position of shadow
                          ),
                        ],
                      ),
                      child: TextButton.icon(
                        onPressed: _launchWhatsApp,
                        label: Text(
                          'WhatsApp ',
                          style: FontFamily().regularText.copyWith(
                                color: ColorStyle().whiteColors,
                              ),
                        ),
                        icon: Icon(
                          Icons.phone,
                          color: ColorStyle().whiteColors,
                        ),
                        style: ButtonStyle(
                          iconSize: MaterialStateProperty.all(20),
                          padding: MaterialStateProperty.all(
                            EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
