class MemeModel {
  final String name;
  final String author;
  final String url;
  final String id;

  MemeModel({
    required this.name,
    required this.author,
    required this.url,
    required this.id,
  });

  factory MemeModel.fromJson(Map<String, dynamic> json) {
    return MemeModel(
      name: json['name'],
      author: json['author'],
      url: json['imgUrl'],
      id: json['id'],
    );
  }
}
