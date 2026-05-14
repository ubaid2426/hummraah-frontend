// lib/models/user_data.dart
class UserData {
  final String id;
  final String name;
  final String email;
  final String phone;
  final String nationality;
  final String passportNumber;
  final String profileImage;
  final String cnic;

  UserData({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.nationality,
    required this.passportNumber,
    required this.profileImage,
    required this.cnic,
  });

  // Factory constructor for creating a UserData from JSON
  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String,
      nationality: json['nationality'] as String,
      passportNumber: json['passportNumber'] as String,
      profileImage: json['profileImage'] as String,
      cnic:json['cnic'] as String,
    );
  }

  // Method to convert UserData to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'nationality': nationality,
      'passportNumber': passportNumber,
      'profileImage': profileImage,
      'cnic' : cnic,
    };
  }

  // Method to get greeting based on time of day
  String get greeting {
    final hour = DateTime.now().hour;
    if (hour < 12) return 'Good Morning';
    if (hour < 17) return 'Good Afternoon';
    if (hour < 20) return 'Good Evening';
    return 'Good Night';
  }

  // Method to get user's full name with title
  String get fullName {
    return name;
  }

  // Method to get masked passport number
  String get maskedPassport {
    if (passportNumber.length <= 4) return passportNumber;
    return 'XXXX${passportNumber.substring(passportNumber.length - 4)}';
  }
}
