// features/auth/data/models/profile_model.dart
class ProfileModel {
  final int? id;
  final String fullName;
  final String email;
  final String mobileNumber;
  final String? whatsappNumber;
  final String address;
  final String emergencyNumber;
  final String country;
  final String? passportNumber;
  final String? passportExpiryDate;
  final String? cnic;
  final bool? cnicVerified;
  final String? profilePictureUrl;
  final String? lastLoginAt;

  ProfileModel({
    this.id,
    required this.fullName,
    required this.email,
    required this.mobileNumber,
    this.whatsappNumber,
    required this.address,
    required this.emergencyNumber,
    required this.country,
    this.passportNumber,
    this.passportExpiryDate,
    this.cnic,
    this.cnicVerified,
    this.profilePictureUrl,
    this.lastLoginAt,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      id: json['id'],
      fullName: json['fullName'] ?? '',
      email: json['email'] ?? '',
      mobileNumber: json['mobileNumber'] ?? '',
      whatsappNumber: json['whatsappNumber'],
      address: json['address'] ?? '',
      emergencyNumber: json['emergencyNumber'] ?? '',
      country: json['country'] ?? '',
      passportNumber: json['passportNumber'],
      passportExpiryDate: json['passportExpiryDate'],
      cnic: json['cnic'],
      cnicVerified: json['cnicVerified'],
      profilePictureUrl: json['profilePictureUrl'],
      lastLoginAt: json['lastLoginAt'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'fullName': fullName,
      'mobileNumber': mobileNumber,
      'whatsappNumber': whatsappNumber,
      'address': address,
      'emergencyNumber': emergencyNumber,
      'country': country,
      'passportNumber': passportNumber,
      'passportExpiryDate': passportExpiryDate,
    };
  }

  ProfileModel copyWith({
    int? id,
    String? fullName,
    String? email,
    String? mobileNumber,
    String? whatsappNumber,
    String? address,
    String? emergencyNumber,
    String? country,
    String? passportNumber,
    String? passportExpiryDate,
    String? cnic,
    bool? cnicVerified,
    String? profilePictureUrl,
    String? lastLoginAt,
  }) {
    return ProfileModel(
      id: id ?? this.id,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      mobileNumber: mobileNumber ?? this.mobileNumber,
      whatsappNumber: whatsappNumber ?? this.whatsappNumber,
      address: address ?? this.address,
      emergencyNumber: emergencyNumber ?? this.emergencyNumber,
      country: country ?? this.country,
      passportNumber: passportNumber ?? this.passportNumber,
      passportExpiryDate: passportExpiryDate ?? this.passportExpiryDate,
      cnic: cnic ?? this.cnic,
      cnicVerified: cnicVerified ?? this.cnicVerified,
      profilePictureUrl: profilePictureUrl ?? this.profilePictureUrl,
      lastLoginAt: lastLoginAt ?? this.lastLoginAt,
    );
  }
}