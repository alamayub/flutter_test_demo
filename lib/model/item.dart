class Item {
  final String type;
  final int id;
  final String name;
  final String url;
  final String imageUrl;

  Item({
    required this.type,
    required this.id,
    required this.name,
    required this.url,
    required this.imageUrl
  });

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      type: json['type'],
      id: json['id'],
      name: json['name'],
      url: json['url'],
      imageUrl: json['imageUrl']
    );
  }
}