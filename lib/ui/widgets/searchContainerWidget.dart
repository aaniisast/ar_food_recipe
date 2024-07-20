import 'package:ar_food_recipe/shared/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchContainer extends StatefulWidget {
  final String hintText;
  const SearchContainer({Key? key, required this.hintText}) : super(key: key);

  @override
  State<SearchContainer> createState() => _SearchContainerState();
}

class _SearchContainerState extends State<SearchContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(9),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(33),
        color: greyLightColor,
      ),
      child: Center(
        child: Column(
          children: [
            buildSearchAndFilter(),
          ],
        ),
      ),
    );
  }

  Widget buildSearchAndFilter() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              flex: 4,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  color: whiteColor,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.search,
                      color: blackColor,
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: widget.hintText,
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              flex: 1,
              child: Container(
                decoration: BoxDecoration(
                  color: orangeColor,
                  borderRadius: BorderRadius.circular(13),
                ),
                child: IconButton(
                  icon: Icon(Icons.filter_alt, color: whiteColor),
                  onPressed: () {
                    // Tambahkan aksi ketika tombol filter ditekan
                  },
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  
}
