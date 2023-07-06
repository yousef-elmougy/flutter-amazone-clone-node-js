class User {
  final String id;
  final String name;
  final String email;
  final String password;
  final String address;
  final String token;
  final String type;

  const User({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.address,
    required this.token,
    required this.type,
  });

  User copyWith({
    final String? id,
    final String? name,
    final String? email,
    final String? password,
    final String? address,
    final String? token,
    final String? type,
  }) =>
      User(
        id: id ?? this.id,
        name: name ?? this.name,
        email: email ?? this.email,
        password: password ?? this.password,
        address: address ?? this.address,
        token: token ?? this.token,
        type: type ?? this.type,
      );

  factory User.fromJson(Map<String, dynamic> map) => User(
        id: map['_id'] ?? '',
        name: map['name'] ?? '',
        email: map['email'] ?? '',
        password: map['password'] ?? '',
        address: map['address'] ?? '',
        token: map['token'] ?? '',
        type: map['type'] ?? '',
             );



  @override
  String toString() =>
      'User(id: $id, name: $name, email: $email, password: $password, address: $address, token: $token, type: $type)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is User &&
        other.id == id &&
        other.name == name &&
        other.email == email &&
        other.password == password &&
        other.address == address &&
        other.token == token &&
        other.type == type;
  }

  @override
  int get hashCode =>
      id.hashCode ^
      name.hashCode ^
      email.hashCode ^
      password.hashCode ^
      address.hashCode ^
      token.hashCode ^
      type.hashCode;
}
