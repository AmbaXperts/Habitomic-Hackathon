class TFormatException implements Exception {
  final String message;

  const TFormatException([this.message = 'An unexpected format error occurred. Please check input.']);

  // Create a FormatException from a specific error message

  factory TFormatException.fromMessage(String message) {
    return TFormatException(message);
  }

  String get formattedMessage => message;

  // Create FormatException from specific error code
  factory TFormatException.fromCode(String code) {
    switch (code) {
      case 'invalid-email-format':
        return const TFormatException('The email address format is invalid. Please enter a valid email.');
      case 'invalid-phone-number-format':
        return const TFormatException('The date format is invalid. Please enter a valid date.');
      case 'invalid-url-format':
        return const TFormatException('The URL format is invalid. Please enter a valid URL.');
      case 'invalid-credit-card-format':
        return const TFormatException('The credit card format is invalid. Please enter a valid credit card number.');
      case 'invalid-numeric-format':
        return const TFormatException('The numeric format is invalid. Please enter a valid numeric value.');
      case 'invalid-password-format':
        return const TFormatException('The password format is invalid. Please choose a stronger password.');
      case 'invalid-username-format':
        return const TFormatException('The username format is invalid. Please enter a valid username.');
      case 'invalid-country-code-format':
        return const TFormatException('The country code format is invalid. Please enter a valid country code.');
      case 'invalid-social-security-number-format':
        return const TFormatException('The social security number format is invalid. Please enter a valid SSN.');
      case 'invalid-zip-code-format':
        return const TFormatException('The ZIP code format is invalid. Please enter a valid ZIP code.');
      case 'invalid-ipv4-format':
        return const TFormatException('The IPv4 address format is invalid. Please enter a valid IPv4 address.');
      case 'invalid-ipv6-format':
        return const TFormatException('The IPv6 address format is invalid. Please enter a valid IPv6 address.');
      case 'invalid-mac-address-format':
        return const TFormatException('The MAC address format is invalid. Please enter a valid MAC address.');
      case 'invalid-iban-format':
        return const TFormatException('The IBAN format is invalid. Please enter a valid IBAN.');
      case 'invalid-ssn-format':
        return const TFormatException('The SSN format is invalid. Please enter a valid SSN.');
      case 'invalid-passport-number-format':
        return const TFormatException('The passport number format is invalid. Please enter a valid passport number.');
      case 'invalid-driving-license-format':
        return const TFormatException('The driving license format is invalid. Please enter a valid driving license.');
      case 'invalid-vat-number-format':
        return const TFormatException('The VAT number format is invalid. Please enter a valid VAT number.');
      case 'invalid-employee-id-format':
        return const TFormatException('The employee ID format is invalid. Please enter a valid employee ID.');
      // Add more cases as needed
      default:
        return const TFormatException();
    }
  }
}
