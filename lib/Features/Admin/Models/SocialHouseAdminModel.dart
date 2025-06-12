class SocialHouseAdminModel {
  final String title;
  final String description;
  final String address;
  final String category;
  final String terms;
  final int socialHouseId;
  final List<SocialHouseImage> socialHouseImages;
  final List<SocialHouseDocument> socialHouseDocuments;

  SocialHouseAdminModel({
    required this.socialHouseId,
    required this.title,
    required this.description,
    required this.address,
    required this.category,
    required this.terms,
    required this.socialHouseImages,
    required this.socialHouseDocuments,
  });

  factory SocialHouseAdminModel.fromJson(Map<String, dynamic> json) {
    // Parse images
    var imagesJson = json['socialHouseImages'] as List;
    List<SocialHouseImage> imagesList = imagesJson
        .map((i) => SocialHouseImage.fromJson(i))
        .toList();

    // Parse documents
    var documentsJson = json['socialHouseDocuments'] as List;
    List<SocialHouseDocument> documentsList = documentsJson
        .map((d) => SocialHouseDocument.fromJson(d))
        .toList();

    return SocialHouseAdminModel(
      socialHouseId: json['socialHouseId'],
      title: json['title'],
      description: json['description'],
      address: json['address'],
      category: json['category'],
      terms: json['terms'],
      socialHouseImages: imagesList,
      socialHouseDocuments: documentsList,
    );
  }

  // Convert the model to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'socialHouseId': socialHouseId,
      'title': title,
      'description': description,
      'address': address,
      'category': category,
      'terms': terms,
      'socialHouseImages': socialHouseImages.map((image) => image.toJson()).toList(),
      'socialHouseDocuments': socialHouseDocuments.map((doc) => doc.toJson()).toList(),
    };
  }
}

class SocialHouseImage {
  final String imageBase64;

  SocialHouseImage({required this.imageBase64});

  factory SocialHouseImage.fromJson(Map<String, dynamic> json) {
    return SocialHouseImage(imageBase64: json['imageBase64']);
  }

  // Convert the image to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'imageBase64': imageBase64,
    };
  }
}

class SocialHouseDocument {
  final String documentBase64;

  SocialHouseDocument({required this.documentBase64});

  factory SocialHouseDocument.fromJson(Map<String, dynamic> json) {
    return SocialHouseDocument(documentBase64: json['documentBase64']);
  }

  // Convert the document to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'documentBase64': documentBase64,
    };
  }
}