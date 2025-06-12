class EditeProfileModel{
  Map<String, dynamic> user;
  EditeProfileModel({required this.user});
  factory EditeProfileModel.fromjson(Map<String, dynamic> json){
    return EditeProfileModel(user: json);
  }
}