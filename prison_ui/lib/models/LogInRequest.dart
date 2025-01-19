class LogInRequest {
  String email;
  String password;

  LogInRequest({
    required this.email,
    required this.password,
  });

  // Factory method to create a new instance from a map (useful for serialization)
  factory LogInRequest.fromMap(Map<String, dynamic> map) {
    return LogInRequest(
      email: map['email'],
      password: map['password'],
    );
  }

  // Convert instance to a map (useful for saving to a database)
  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'password': password,
    };
  }
}
