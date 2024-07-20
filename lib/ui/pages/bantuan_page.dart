import 'package:ar_food_recipe/shared/theme.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class BantuanPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Image.asset(
              "assets/gif/whatsapp.gif",
              width: 125,
              height: 125,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            'Anda mengalami kendala dan\nbutuh bantuan?',
            textAlign: TextAlign.center,
            style: greyTextStyle.copyWith(fontSize: 14, fontWeight: bold),
          ),
          SizedBox(height: 8),
          GestureDetector(
            onTap: () {
              launchUrlString(
                  'https://api.whatsapp.com/send?phone=6287840199095');
            },
            child: Container(
              width: 200,
              height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(30),
                ),
                color: greenColor,
              ),
              child: Center(
                child: Text(
                  'Hubungi Kami',
                  style:
                      whiteTextStyle.copyWith(fontSize: 14, fontWeight: bold),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
