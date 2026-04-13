// lib/screens/prayer_setting_model.dart
enum CalculationMethod {
  karachi,
  islamicSocietyNorthAmerica,
  muslimWorldLeague,
  egyptian,
  makkah;
  
  int getApiMethodCode() {
    switch (this) {
      case CalculationMethod.karachi:
        return 1; // Karachi
      case CalculationMethod.islamicSocietyNorthAmerica:
        return 2; // ISNA
      case CalculationMethod.muslimWorldLeague:
        return 3; // Muslim World League
      case CalculationMethod.egyptian:
        return 5; // Egyptian
      case CalculationMethod.makkah:
        return 4; // Umm Al-Qura
    }
  }
  
  String getDisplayName() {
    switch (this) {
      case CalculationMethod.karachi:
        return 'University of Islamic Sciences, Karachi';
      case CalculationMethod.islamicSocietyNorthAmerica:
        return 'Islamic Society of North America (ISNA)';
      case CalculationMethod.muslimWorldLeague:
        return 'Muslim World League';
      case CalculationMethod.egyptian:
        return 'Egyptian General Authority';
      case CalculationMethod.makkah:
        return 'Umm Al-Qura University, Makkah';
    }
  }
}

enum Madhab {
  hanafi,
  shafi;
  
  int getApiMadhabCode() {
    switch (this) {
      case Madhab.hanafi:
        return 1; // Hanafi
      case Madhab.shafi:
        return 0; // Shafi/Standard
    }
  }
  
  String getDisplayName() {
    switch (this) {
      case Madhab.hanafi:
        return 'Hanafi';
      case Madhab.shafi:
        return 'Shafi';
    }
  }
}

class PrayerSettings {
  CalculationMethod calculationMethod;
  Madhab madhab;
  bool useManualLocation;
  double? manualLatitude;
  double? manualLongitude;
  
  PrayerSettings({
    this.calculationMethod = CalculationMethod.karachi,
    this.madhab = Madhab.hanafi,
    this.useManualLocation = false,
    this.manualLatitude,
    this.manualLongitude,
  });
  
  int getApiMethodCode() => calculationMethod.getApiMethodCode();
  int getApiMadhabCode() => madhab.getApiMadhabCode();
}