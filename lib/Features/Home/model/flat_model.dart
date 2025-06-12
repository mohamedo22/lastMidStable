class Flatt {
  final double price;
  final int bathrooms;
  final int bedrooms;
  final int floorNumber;
  final String governorate;
  final String city;
  final String details;
  final String address;
  final List<String> images;
  final int flatCode;
  final String flatStatus;
  final int id;

  Flatt({
    required this.flatStatus,
    required this.flatCode,
    required this.price,
    required this.bathrooms,
    required this.bedrooms,
    required this.floorNumber,
    required this.governorate,
    required this.city,
    required this.details,
    required this.address,
    required this.images,
    required this.id,
  });

  factory Flatt.fromJson(Map<String, dynamic> json) {
    return Flatt(
      flatStatus: json['status'] is String
          ? json['status']
          : json['status'].toString(),
      price: json['flatPrice'].toDouble(),
      bathrooms: json['flatBathrooms'] ?? 0,
      bedrooms: json['flatBedrooms'] ?? 0,
      floorNumber: json['floorNumber']?? 0,
      governorate: json['flatGovernorate'],
      city: json['flatCity'],
      details: json['flatDetails'],
      address: json['flatAddress'],
      flatCode: json['flatId'] ?? 0,
      id: json['flatId'] ?? 0,
      images: (json['flatImages'] as List)
          .map((img) => "data:image/png;base64,${img['imageBase64']}")
          .toList(),
    );
  }
}
