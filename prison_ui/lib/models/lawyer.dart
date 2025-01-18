class Lawyer {
  String firstName;
  String lastName;
  String email;
  String firm;
  String phoneNumber;

  Lawyer({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.firm,
    required this.phoneNumber
  });

  // Factory method to create a new instance from a map (useful for serialization)
  factory Lawyer.fromMap(Map<String, dynamic> map) {
    return Lawyer(
      firstName: map['firstName'],
      lastName: map['lastName'],
      email: map['email'],
      firm: map['firm'],
      phoneNumber: map['phoneNumber']
    );
  }

  // Convert instance to a map (useful for saving to a database)
  Map<String, dynamic> toMap() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'firm': firm,
      'phoneNumber': phoneNumber
    };
  }
}
