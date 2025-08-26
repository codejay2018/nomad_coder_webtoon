import 'package:flutter/material.dart';
import 'package:webtoon/models/webtoon_model.dart';
import 'package:webtoon/services/api_service.dart';
import 'package:webtoon/widgets/webtoon_widget.dart';

class HomeScreenStateless extends StatelessWidget {
  final Future<List<WebtoonModel>> webtoons = ApiService.getTodaysToons();

  HomeScreenStateless({super.key});

  @override
  Widget build(BuildContext context) {
    // print(webtoons);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.green,
        elevation: 5,
        title: Text('Today`s Toons', style: TextStyle(fontSize: 24)),
      ),
      body: FutureBuilder(
        future: webtoons,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Column(
              children: [
                SizedBox(height: 100),
                Expanded(child: makeList(snapshot)),
              ],
            );
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  ListView makeList(AsyncSnapshot<List<WebtoonModel>> snapshot) {
    return ListView.separated(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      scrollDirection: Axis.horizontal,
      itemCount: snapshot.data!.length,
      itemBuilder: (context, index) {
        var toon = snapshot.data![index];
        return Webtoon(toon: toon);
      },
      separatorBuilder: (context, index) => SizedBox(width: 20),
    );
  }
}
