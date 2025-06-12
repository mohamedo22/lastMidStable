class FlatAdminModel {
  final int flatCode;
  final double flatPrice;
  final int flatBathrooms;
  final int flatBedrooms;
  final int floorNumber;
  final String flatGovernorate;
  final String flatCity;
  final String flatDetails;
  final String flatAddress;
  final String flatStatus;
  final List<String> flatImages;
  final List<String> documents;
  final bool isAdmin;

  FlatAdminModel({
    required this.flatCode,
    required this.flatPrice,
    required this.flatBathrooms,
    required this.flatBedrooms,
    required this.floorNumber,
    required this.flatGovernorate,
    required this.flatCity,
    required this.flatDetails,
    required this.flatAddress,
    required this.flatStatus,
    required this.flatImages,
    required this.documents,
    required this.isAdmin,
  });

  factory FlatAdminModel.fromJson(Map<String, dynamic> json) {
    return FlatAdminModel(
      flatCode: json['flatCode'] as int? ?? 0,
      flatPrice: (json['flatPrice'] as num?)?.toDouble() ?? 0.0,
      flatBathrooms: json['flatBathrooms'] as int? ?? 0,
      flatBedrooms: json['flatBedrooms'] as int? ?? 0,
      floorNumber: json['floorNumber'] as int? ?? 0,
      flatGovernorate: json['flatGovernorate'] as String? ?? '',
      flatCity: json['flatCity'] as String? ?? '',
      flatDetails: json['flatDetails'] as String? ?? '',
      flatAddress: json['flatAddress'] as String? ?? '',
      flatStatus: json['flatStatus'] as String? ?? '',
      flatImages: (json['flatImages'] as List<dynamic>?)
          ?.map((img) => img['imageBase64'].toString())
          .toList() ??
          [],
      documents: (json['documents'] as List<dynamic>?)
          ?.map((doc) => doc.toString())
          .toList() ??
          [],
      isAdmin: json['isAdmin'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'flatCode': flatCode,
      'flatPrice': flatPrice,
      'flatBathrooms': flatBathrooms,
      'flatBedrooms': flatBedrooms,
      'floorNumber': floorNumber,
      'flatGovernorate': flatGovernorate,
      'flatCity': flatCity,
      'flatDetails': flatDetails,
      'flatAddress': flatAddress,
      'flatStatus': flatStatus,
      'flatImages': flatImages.map((img) => {'imageBase64': img}).toList(),
      'documents': documents,
      'isAdmin': isAdmin,
    };
  }
}