class User {
  final String username;
  final String age;
  final String country;
  final String phone;
  final String email;
  final String gender;

  User({
    required this.username,
    required this.age,
    required this.country,
    required this.phone,
    required this.email,
    required this.gender,
  });

  
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      username: json['username'],
      age: json['age'],
      country: json['country'],
      phone: json['phone'],
      email: json['email'],
      gender: json['gender'],
    );
  }

  
  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'age': age,
      'country': country,
      'phone': phone,
      'email': email,
      'gender': gender,
    };
  }
}
