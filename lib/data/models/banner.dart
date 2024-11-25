class Banner {
  final String id;
  final String imageUrl;
  final int width;
  final int height;
  final String author;

  Banner({
    required this.id,
    required this.imageUrl,
    required this.width,
    required this.height,
    required this.author,
  });

  factory Banner.fromJson(Map<String, dynamic> json) {
    return Banner(
      id: json['id'] ?? "",
      imageUrl: json['download_url'] ?? "",
      width: json['width'] ?? 0,
      height: json['height'] ?? 0,
      author: json['author'] ?? "",
    );
  }
}

// {
// "id": "",
// "author": "",
// "width": 0,
// "height": 0,
// "url": "",
// "download_url": ""
// }
