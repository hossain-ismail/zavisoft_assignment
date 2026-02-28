class User {
  final int id;
  final String email;
  final String username;
  final Name name;
  final String phone;

  User({
    required this.id,
    required this.email,
    required this.username,
    required this.name,
    required this.phone,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      email: json['email'],
      username: json['username'],
      name: Name.fromJson(json['name']),
      phone: json['phone'],
    );
  }
}

class Name {
  final String firstname;
  final String lastname;

  Name({required this.firstname, required this.lastname});

  factory Name.fromJson(Map<String, dynamic> json) {
    return Name(
      firstname: json['firstname'],
      lastname: json['lastname'],
    );
  }

  String get fullname => '$firstname $lastname';
}
