import 'package:ar_food_recipe/shared/theme.dart';
import 'package:flutter/material.dart';

class DescriptionWidget extends StatefulWidget {
  final String description;
  final int maxWordsToShow; // Jumlah kata maksimum untuk tampilan singkat

  const DescriptionWidget({
    Key? key,
    required this.description,
    this.maxWordsToShow = 20, // Default maksimum 20 kata
  }) : super(key: key);

  @override
  _DescriptionWidgetState createState() => _DescriptionWidgetState();
}

class _DescriptionWidgetState extends State<DescriptionWidget> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AnimatedCrossFade(
          firstChild: buildShortDescription(),
          secondChild: buildFullDescription(),
          crossFadeState:
              isExpanded ? CrossFadeState.showSecond : CrossFadeState.showFirst,
          duration: Duration(milliseconds: 300),
        ),
        if (shouldShowMoreButton())
          TextButton(
            onPressed: () {
              setState(() {
                isExpanded = !isExpanded;
              });
            },
            child: Text(
              isExpanded ? 'Lebih sedikit' : 'Selengkapnya',
              style: TextStyle(color: greenColor),
            ),
          ),
      ],
    );
  }

  Widget buildShortDescription() {
    List<String> words = widget.description.split(' ');
    List<String> shortWords = words.take(widget.maxWordsToShow).toList();
    String shortDescription = shortWords.join(' ');

    return Text(
      shortDescription,
      style: TextStyle(fontSize: 12),
      maxLines: 2, // Maksimum 2 baris
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget buildFullDescription() {
    return Text(
      widget.description,
      style: TextStyle(fontSize: 12),
    );
  }

  bool shouldShowMoreButton() {
    // Split deskripsi menjadi kata-kata
    List<String> words = widget.description.split(' ');
    return words.length > widget.maxWordsToShow;
  }
}
