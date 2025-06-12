class RequestModel {
  final int requestId;
  final int userId;
  final String userEmail;
  final String userPhone;
  final int flatCodeId;
  final String date;
  final String time;

  RequestModel({
    required this.requestId,
    required this.userId,
    required this.userEmail,
    required this.userPhone,
    required this.flatCodeId,
    required this.date,
    required this.time,
  });

  factory RequestModel.fromJson(Map<String, dynamic> json) {
    return RequestModel(
      requestId: json['requestId'],
      userId: json['userId'],
      userEmail: json['userEmail'],
      userPhone: json['userPhone'],
      flatCodeId: json['flatCodeId'],
      date: json['date'],
      time: json['time'],
    );
  }
}

class RequestResponse {
  final List<RequestModel> requests;
  final String message;

  RequestResponse({
    required this.requests,
    required this.message,
  });

  factory RequestResponse.fromJson(Map<String, dynamic> json) {
    var requestsList = json['requests'] as List;
    List<RequestModel> requests = requestsList
        .map((request) => RequestModel.fromJson(request))
        .toList();

    return RequestResponse(
      requests: requests,
      message: json['message'],
    );
  }
}