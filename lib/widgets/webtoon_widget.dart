import 'package:flutter/material.dart';
import 'package:webtoon/models/webtoon_model.dart';
import 'package:webtoon/screens/detail_screen.dart';

class Webtoon extends StatelessWidget {
  final WebtoonModel toon;

  const Webtoon({super.key, required this.toon});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailScreen(toon: toon),
            fullscreenDialog: true,
          ),
        );
      },
      child: Column(
        children: [
          Container(
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  blurRadius: 15,
                  offset: Offset(10, 10),
                  color: Colors.black.withAlpha(100),
                ),
              ],
            ),
            width: 250,
            child: Image.network(
              toon.thumb,
              headers: {
                "Referer": "https://comic.naver.com", // 네이버 서버가 요구하는 값
              },
            ),
          ),
          SizedBox(height: 10),
          Text(toon.title, style: TextStyle(fontSize: 22)),
        ],
      ),
    );
  }
}
