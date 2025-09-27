class UserModel{
  final String id;
  final String email;
  final String firstname;
  final String lastname;
  final String mobile;

  String get fullName => '$firstname $lastname';

  UserModel({
    required this.id,
    required this.email,
    required this.firstname,
    required this.lastname,
    required this.mobile
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['_id'],
      email: json['email'],
      firstname: json['firstName'],
      lastname: json['lastName'],
      mobile: json['mobile'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'email': email,
      'firstName': firstname,
      'lastName': lastname,
      'mobile': mobile,
    };
  }

}