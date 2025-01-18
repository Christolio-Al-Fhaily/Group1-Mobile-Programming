class User {
  int id;
  String firstName;
  String lastName;
  String email;
  String ssn;
  DateTime dateOfBirth;
  String phoneNumber;
  int inmateId;

  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.ssn,
    required this.dateOfBirth,
    required this.phoneNumber,
    required this.inmateId,
  });

  // Factory method to create a new instance from a map (useful for serialization)
  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      firstName: map['firstName'],
      lastName: map['lastName'],
      email: map['email'],
      ssn: map['ssn'],
      dateOfBirth: DateTime.parse(map['dateOfBirth']), // Convert to DateTime
      phoneNumber: map['phoneNumber'],
      inmateId: map['inmateId'],
    );
  }

  // Convert instance to a map (useful for saving to a database)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'ssn': ssn,
      'dateOfBirth': dateOfBirth.toIso8601String(), // Convert to string
      'phoneNumber': phoneNumber,
      'inmateId': inmateId,
    };
  }
}
