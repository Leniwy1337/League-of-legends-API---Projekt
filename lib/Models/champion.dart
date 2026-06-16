class Champion {
  final String id;
  final String name;
  final String title;
  final String blurb;
  final String imageUrl;

  Champion({
    required this.id,
    required this.name,
    required this.title,
    required this.blurb,
    required this.imageUrl,
  });

  factory Champion.fromJson(Map<String, dynamic> json, String version) {
    final imageId = json['image']['full'];
    return Champion(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      title: json['title'] ?? '',
      blurb: json['blurb'] ?? '',
      imageUrl:
          'https://ddragon.leagueoflegends.com/cdn/$version/img/champion/$imageId',
    );
  }

  factory Champion.fromMap(Map<dynamic, dynamic> map) {
    return Champion(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      title: map['title'] ?? '',
      blurb: map['blurb'] ?? '',
      imageUrl: map['imageUrl'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'title': title,
      'blurb': blurb,
      'imageUrl': imageUrl,
    };
  }
}
