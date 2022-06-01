import 'package:equatable/equatable.dart';

class UserProfile extends Equatable {
  final String firstname;
  final String lastname;
  final String fullname;

  const UserProfile({
    required this.firstname,
    required this.lastname,
    required this.fullname,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    String firstname = json['firstname'] ?? '';
    String lastname = json['lastname'] ?? '';
    String fullname = json['fullname'] ?? '';

    return UserProfile(
      firstname: firstname,
      lastname: lastname,
      fullname: fullname,
    );
  }

  Map<String, dynamic> toJson() => {
        'firstname': firstname,
        'lastname': lastname,
        'fullname': fullname,
      };

  @override
  List<Object?> get props => [firstname, lastname, fullname];
}
