class ContactUsRequest {
  final int userId;
  final int flatCode;
  final String date;
  final String time;

  ContactUsRequest({
    required this.userId,
    required this.flatCode,
    required this.date,
    required this.time,
  });

  Map<String, dynamic> toJson() {
    return {
      "userId": userId,
      "flatCodeId": flatCode,
      "date": date,
      "time": time,
    };
  }
}