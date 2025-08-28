import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webtoon/models/webtoon_detail_model.dart';
import 'package:webtoon/models/webtoon_episode_model.dart';
import 'package:webtoon/models/webtoon_model.dart';
import 'package:webtoon/services/api_service.dart';
import 'package:webtoon/widgets/episode_widget.dart';

class DetailScreen extends StatefulWidget {
  final WebtoonModel toon;
  const DetailScreen({super.key, required this.toon});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late Future<WebtoonDetailModel> webtoon;
  late Future<List<WebtoonEpisodeModel>> epicodes;
  late SharedPreferences pref;
  bool isLiked = false;

  static String LIKED_TOONS = 'likedToons';

  Future initPrefs() async {
    pref = await SharedPreferences.getInstance();
    final likedToons = pref.getStringList(LIKED_TOONS);
    if (likedToons == null) {
      await pref.setStringList(LIKED_TOONS, []);
    } else {
      if (likedToons.contains(widget.toon.id)) {
        setState(() {
          isLiked = true;
        });
      }
    }
  }

  @override
  void initState() {
    webtoon = ApiService.getToonById(widget.toon.id);
    epicodes = ApiService.getLatestEpicodesById(widget.toon.id);
    initPrefs();

    super.initState();
  }

  onHeartTap() async {
    final linkedToons = pref.getStringList(LIKED_TOONS);

    if (linkedToons != null) {
      if (isLiked) {
        linkedToons.remove(widget.toon.id);
      } else {
        linkedToons.add(widget.toon.id);
      }

      await pref.setStringList(LIKED_TOONS, linkedToons);

      setState(() {
        isLiked = !isLiked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.green,
        elevation: 5,
        title: Text(widget.toon.title, style: TextStyle(fontSize: 24)),
        actions: [
          IconButton(
            onPressed: onHeartTap,
            icon: Icon(isLiked ? Icons.favorite : Icons.favorite_outline),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(50),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Hero(
                    tag: widget.toon.id,
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
                        widget.toon.thumb,
                        headers: {
                          "Referer":
                              "https://comic.naver.com", // 네이버 서버가 요구하는 값
                        },
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 25),
              FutureBuilder(
                future: webtoon,
                builder: (context, snapsht) {
                  if (snapsht.hasData) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          snapsht.data!.about,
                          style: TextStyle(fontSize: 16),
                        ),
                        SizedBox(height: 15),
                        Text(
                          '${snapsht.data!.genre} / ${snapsht.data!.age}',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    );
                  }
                  return Text('...');
                },
              ),
              SizedBox(height: 50),
              FutureBuilder(
                future: epicodes,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Column(
                      children: [
                        for (var episode in snapshot.data!)
                          Episode(episode: episode, webtoonId: widget.toon.id),
                      ],
                    );
                  }
                  return Container();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
