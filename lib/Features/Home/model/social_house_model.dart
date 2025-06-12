
class SocialHouse {
  final String title;
  final String description;
  final String address;
  final String category;
  final String terms;
  final List<SocialHouseImage> images;

  SocialHouse({
    required this.title,
    required this.description,
    required this.address,
    required this.category,
    required this.terms,
    required this.images,
  });

  factory SocialHouse.fromJson(Map<String, dynamic> json) {
    var imagesJson = json['socialHouseImages'] as List<dynamic>?;
    List<SocialHouseImage> imagesList = imagesJson != null
        ? imagesJson.map((e) => SocialHouseImage.fromJson(e)).toList()
        : [];
    return SocialHouse(
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      address: json['address'] ?? '',
      category: json['category'] ?? '',
      terms: json['terms'] ?? '',
      images: imagesList,
    );
  }
}

class SocialHouseImage {
  final String imageBase64;

  SocialHouseImage({required this.imageBase64});

  factory SocialHouseImage.fromJson(Map<String, dynamic> json) {
    return SocialHouseImage(
      imageBase64: json['imageBase64'] ?? '',
    );
  }
}
