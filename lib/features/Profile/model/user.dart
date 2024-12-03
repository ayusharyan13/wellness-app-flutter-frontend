class User {
  final int id;
  final String name;
  final String email;
  final String username;
  final List<String> roles;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.username,
    required this.roles,
  });

  // Convert a User into a Map.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'username': username,
      'roles': roles.join(','), // Store roles as comma-separated string
    };
  }

  // Create a User from a Map.
  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      name: map['name'],
      email: map['email'],
      username: map['username'],
      roles: List<String>.from(map['roles'].split(',')),
    );
  }
}
