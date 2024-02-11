import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ProfileAvatar extends StatefulWidget {
  final String? imageUrl;
  double? radius;
  ProfileAvatar({Key? key, this.imageUrl, this.radius}) : super(key: key);

  @override
  State<ProfileAvatar> createState() => _ProfileAvatarState();
}

class _ProfileAvatarState extends State<ProfileAvatar> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(80)),
        child:Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              CircleAvatar(
                backgroundColor: Colors.white,
                radius: widget.radius ?? 50,
                backgroundImage: NetworkImage(
                  widget.imageUrl.toString(),
                   ),
              ),
            ]),
      ),
    );
  }
}
