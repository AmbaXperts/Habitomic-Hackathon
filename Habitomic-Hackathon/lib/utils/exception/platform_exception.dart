class TPlatformException implements Exception {
  final String code;

  TPlatformException(this.code);

  String get message {
    switch (code) {
      case 'invalid-login-credentials':
        return 'Invalid login credentials. Please check your username and password.';
      case 'too-many-requests':
        return 'Too many requests. Please try again later.';
      case 'invalid-argument':
        return 'Invalid argument provided.';
      case 'invalid-password':
        return 'Invalid password format. Please choose a stronger password.';
      case 'invalid-phone-number':
        return 'Invalid phone number format. Please enter a valid phone number.';
      case 'operation-not-allowed':
        return 'Operation not allowed. Please contact support for assistance.';
      case 'session-cookie-expired':
        return 'Session cookie expired. Please sign in again.';
      case 'uid-already-exists':
        return 'UID already exists. Please use a different one.';
      case 'signin-failed':
        return 'Sign-in failed. Please try again.';
      case 'network-request-failed':
        return 'Network request failed. Please check your internet connection.';
      case 'internal-error':
        return 'Internal error occurred. Please try again later.';
      case 'verification-failed':
        return 'Verification failed. Please try again.';
      case 'invalid-verification-code':
        return 'Invalid verification code. Please enter a valid code.';
      case 'user-token-expired':
        return 'User token expired. Please sign in again.';
      case 'user-disabled':
        return 'The user account has been disabled. Please contact support for assistance.';
      case 'user-not-found':
        return 'User not found. Please check your input and try again.';
      case 'email-already-in-use':
        return 'The email address is already in use. Please use a different email.';
      case 'provider-already-linked':
        return 'The provider is already linked to this user. Please try a different one.';
      case 'credential-already-in-use':
        return 'The credential is already in use. Please try a different one.';
      case 'operation-not-supported':
        return 'Operation not supported. Please contact support for assistance.';
      // Add more cases as needed
      default:
        return 'An unknown platform error occurred. Please try again later.';
    }
  }
}
