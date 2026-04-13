// lib/models/dua_model.dart
class DuaModel {
  final String id;
  final String title;
  final String titleArabic;
  final String titleUrdu;
  final String arabicText;
  final String translation;
  final String transliteration;
  final String urduTranslation;
  final String audioUrl;
  final String category;
  final bool isOffline;
  final int times;
  final String reference;
  final bool isCustom;

  DuaModel({
    required this.id,
    required this.title,
    required this.titleArabic,
    required this.titleUrdu,
    required this.arabicText,
    required this.translation,
    required this.transliteration,
    required this.urduTranslation,
    required this.audioUrl,
    required this.category,
    this.isCustom = false,
    required this.isOffline,
    required this.times,
    required this.reference,
  });

  factory DuaModel.fromJson(Map<String, dynamic> json) {
    return DuaModel(
      id: json['id'],
      title: json['title'],
      titleArabic: json['titleArabic'],
      titleUrdu: json['titleUrdu'],
      arabicText: json['arabicText'],
      translation: json['translation'],
      transliteration: json['transliteration'],
      urduTranslation: json['urduTranslation'],
      audioUrl: json['audioUrl'],
      category: json['category'],
      isOffline: json['isOffline'] ?? false,
      times: json['times'] ?? 1,
      reference: json['reference'],
      isCustom: json['isCustom'] ?? false,
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'titleArabic': titleArabic,
      'titleUrdu': titleUrdu,
      'arabicText': arabicText,
      'translation': translation,
      'transliteration': transliteration,
      'urduTranslation': urduTranslation,
      'audioUrl': audioUrl,
      'category': category,
      'isOffline': isOffline,
      'times': times,
      'reference': reference,
      'isCustom': isCustom,
    };
  }
}
