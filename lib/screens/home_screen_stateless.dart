import 'package:flutter/material.dart';
import 'package:webtoon/models/webtoon_model.dart';
import 'package:webtoon/services/api_service.dart';

class HomeScreenStateless extends StatelessWidget {
  final Future<List<WebtoonModel>> webtoons = ApiService.getTodaysToons();

  HomeScreenStateless({super.key});

  @override
  Widget build(BuildContext context) {
    print(webtoons);
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
            return ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                print(index);
                var title = snapshot.data![index].title;
                return Text(' $index. $title');
              },
              separatorBuilder: (context, index) => SizedBox(width: 20),
            );
          }

          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
