class LogInResponse {
  int id;
  String firstName;
  String lastName;
  String email;
  int inmateId;

  LogInResponse({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.inmateId,
  });

  // Factory method to create a new instance from a map (useful for deserialization)
  factory LogInResponse.fromMap(Map<String, dynamic> map) {
    return LogInResponse(
      id: map['id'],
      firstName: map['firstName'],
      lastName: map['lastName'],
      email: map['email'],
      inmateId: map['inmateId'],
    );
  }

  // Convert instance to a map (useful for saving to a database or serialization)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'inmateId': inmateId,
    };
  }
}
