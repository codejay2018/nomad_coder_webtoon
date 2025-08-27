class WebtoonEpisodeModel {
  final String thumb, id, title, rating, date;

  WebtoonEpisodeModel(Map<String, dynamic> json)
    : thumb = json['thumb'],
      id = json['id'],
      title = json['title'],
      rating = json['rating'],
      date = json['date'];
}
