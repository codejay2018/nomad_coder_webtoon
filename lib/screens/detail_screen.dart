import 'package:flutter/material.dart';
import 'package:webtoon/models/webtoon_model.dart';

class DetailScreen extends StatelessWidget {
  final WebtoonModel toon;
  const DetailScreen({super.key, required this.toon});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.green,
        elevation: 5,
        title: Text(toon.title, style: TextStyle(fontSize: 24)),
      ),
      body: Column(
        children: [
          SizedBox(height: 50),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Hero(
                tag: toon.id,
                child: Container(
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
              ),
            ],
          ),
        ],
      ),
    );
  }
}
