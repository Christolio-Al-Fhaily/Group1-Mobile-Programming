class SignupRequest {
  String firstName;
  String lastName;
  String email;
  String ssn;
  DateTime dateOfBirth;
  String phoneNumber;
  int inmateId;
  String password;

  SignupRequest({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.ssn,
    required this.dateOfBirth,
    required this.phoneNumber,
    required this.inmateId,
    required this.password
  });

  // Factory method to create a new instance from a map (useful for serialization)
  factory SignupRequest.fromMap(Map<String, dynamic> map) {
    return SignupRequest(
      firstName: map['firstName'],
      lastName: map['lastName'],
      email: map['email'],
      ssn: map['ssn'],
      dateOfBirth: DateTime.parse(map['dateOfBirth']), // Convert to DateTime
      phoneNumber: map['phoneNumber'],
      inmateId: map['inmateId'],
      password: map['password']
    );
  }

  // Convert instance to a map (useful for saving to a database)
  Map<String, dynamic> toMap() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'ssn': ssn,
      'dateOfBirth': dateOfBirth.toIso8601String(), // Convert to string
      'phoneNumber': phoneNumber,
      'inmateId': inmateId,
      'password':password
    };
  }
}
