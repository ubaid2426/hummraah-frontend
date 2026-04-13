// lib/utils/validators.dart
class Validators {
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value)) {
      return 'Please enter a valid email';
    }
    
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    
    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    
    return null;
  }

  static String? validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Phone number is required';
    }
    
    final phoneRegex = RegExp(r'^\+?[\d\s-]{10,}$');
    if (!phoneRegex.hasMatch(value)) {
      return 'Please enter a valid phone number';
    }
    
    return null;
  }

  static String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Name is required';
    }
    
    if (value.length < 2) {
      return 'Name must be at least 2 characters';
    }
    
    return null;
  }

  static String? validatePassport(String? value) {
    if (value == null || value.isEmpty) {
      return 'Passport number is required';
    }
    
    if (value.length < 6) {
      return 'Passport number must be at least 6 characters';
    }
    
    return null;
  }

  static String? validateAmount(String? value) {
    if (value == null || value.isEmpty) {
      return 'Amount is required';
    }
    
    final amount = double.tryParse(value);
    if (amount == null || amount <= 0) {
      return 'Please enter a valid amount';
    }
    
    return null;
  }

  static String? validateCardNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Card number is required';
    }
    
    final cleaned = value.replaceAll(RegExp(r'\s+'), '');
    if (cleaned.length != 16) {
      return 'Card number must be 16 digits';
    }
    
    return null;
  }

  static String? validateCVV(String? value) {
    if (value == null || value.isEmpty) {
      return 'CVV is required';
    }
    
    if (value.length != 3) {
      return 'CVV must be 3 digits';
    }
    
    return null;
  }

  static String? validateExpiryDate(String? value) {
    if (value == null || value.isEmpty) {
      return 'Expiry date is required';
    }
    
    final parts = value.split('/');
    if (parts.length != 2) {
      return 'Invalid format (MM/YY)';
    }
    
    final month = int.tryParse(parts[0]);
    final year = int.tryParse('20${parts[1]}');
    
    if (month == null || year == null || month < 1 || month > 12) {
      return 'Invalid date';
    }
    
    final now = DateTime.now();
    if (year < now.year || (year == now.year && month < now.month)) {
      return 'Card has expired';
    }
    
    return null;
  }
}