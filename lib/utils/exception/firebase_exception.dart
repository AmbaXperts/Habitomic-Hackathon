
class TFirebaseException implements Exception {
  final String code;

  TFirebaseException(this.code);

  String get message {
    switch (code) {
      case 'unknown':
        return 'An unknown error occurred. Please try again later.';
      case 'invalid-verification-id':
        return 'Invalid verification ID. Please try again with a valid ID.';
      case 'invalid-verification-code':
        return 'Invalid verification code. Please enter the valid code.';
      case 'keychain-error':
        return 'Keychain error. Please try again later.';
      case 'internal-error':
        return 'Internal error occurred. Please try again later.';
      case 'network-request-failed':
        return 'Network request failed. Please check your internet connection.';
      case 'user-token-expired':
        return 'User token expired. Please sign in again.';
      case 'too-many-requests':
        return 'Too many requests. Please try again later.';
      case 'user-disabled':
        return 'The user account has been disabled. Please contact support for assistance.';
      case 'user-not-found':
        return 'User not found. Please check your input and try again.';
      case 'email-already-in-use':
        return 'The email address is already in use. Please use a different email.';
      case 'requires-recent-login':
        return 'This operation requires a recent login. Please log in again and try again.';
      case 'provider-already-linked':
        return 'The provider is already linked to this user. Please try a different one.';
      case 'credential-already-in-use':
        return 'The credential is already in use. Please try a different one.';
      case 'operation-not-allowed':
        return 'Operation not allowed. Please contact support for assistance.';
         case 'invalid-email':
        return 'The email address provided is invalid. Please enter a valid email.';
      case 'weak-password':
        return 'The password is too weak. Please choose a strong password.';
      case 'user-disabled':
        return 'The user is disabled. Please contact support for assistance.';
      case 'user-not-found':
        return 'Invalid user details. User not found.';
      case 'wrong-password':
        return 'Incorrect password. Please check your password and try again.';
      case 'invalid-verification-code':
        return 'Invalid verification code. Please enter the valid code.';
      case 'invalid-credential':
        return 'Invalid credentials provided. Please check your email and password.';
      case 'operation-not-allowed':
        return 'Operation not allowed. Please contact support for assistance.';
      case 'invalid-action-code':
        return 'Invalid action code. Please check the link and try again.';
      case 'user-mismatch':
        return 'User mismatch. Please try again.';
      case 'credential-already-in-use':
        return 'The credential is already in use. Please try a different one.';
      case 'invalid-recipient-email':
        return 'Invalid recipient email. Please enter a valid email address.';
      case 'expired-action-code':
        return 'The action code has expired. Please request a new one.';
      case 'app-not-authorized':
        return 'The app is not authorized to perform this action.';
      case 'invalid-continue-uri':
        return 'Invalid continue URI. Please check the link and try again.';
      case 'missing-continue-uri':
        return 'Missing continue URI. Please provide a valid URI.';
      case 'user-mismatch':
        return 'User mismatch. Please try again.';
      case 'requires-recent-login':
        return 'This operation requires a recent login. Please log in again and try again.';
      case 'provider-already-linked':
        return 'The provider is already linked to this user. Please try a different one.';
      case 'quota-exceeded':
        return 'The request quota for this operation has been exceeded. Please try again later.';
      case 'invalid-verification-id':
        return 'Invalid verification ID. Please try again with a valid ID.';
      case 'missing-phone-number':
        return 'Missing phone number. Please provide a valid phone number.';
      case 'invalid-verification-code':
        return 'Invalid verification code. Please enter the valid code.';
      case 'session-expired':
        return 'Session expired. Please log in again.';
      case 'too-many-requests':
        return 'Too many requests. Please try again later.';
      default:
        return 'An unknown Firebase error occurred. Please try again later.';
    }
  }
}
