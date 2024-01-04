class User {
  int? id;
  final String fullname;
  final String email;
  final String password;

  User({
    this.id,
    required this.fullname,
    required this.email,
    required this.password,
  });

  // Factory method to convert a map to a User object
  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      fullname: map['fullname'],
      email: map['email'],
      password: map['password'],
    );
  }

  // Convert the User object to a map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'fullname': fullname,
      'email': email,
      'password': password,
    };
  }
}
