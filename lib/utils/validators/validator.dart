class TValidator{

  static String? ValidateEmptyText(String? fieldName, String? value){
    if(value == null || value.isEmpty){
      return '$fieldName is required.';
    }
    return null;
  }

  static String? validateEmail(String? value){
   if(value == null || value.isEmpty){
    return 'Email is required';
   }
   final emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

   if(!emailRegExp.hasMatch(value)){
    return 'invalid email adress.';
   }
   return null;
  }

  static String? validatePassword(String? value){
    if(value == null || value.isEmpty){
      return 'password is required.';
    }

    // check for inimum password length

    if(value.length< 6){
      return 'password must be at least 6 character long';
    }

    // check for uppercase letters
    if(!value.contains(RegExp(r'[A-Z]'))){
      return 'password must contain at least one uppercase letter';
    }

    //check for numbers
    if(!value.contains(RegExp(r'[0-9]'))){
      return 'password must contain at least one number.';
    }

    //check for special character
    if(!value.contains(RegExp(r'[!@#$%^&*(),.?":|<>]'))){
      return 'password must contain at least one special character';
    }
    return null;

  }

  static String? validatePhoneNumber(String? value){
    if(value == null || value.isEmpty){
      return 'phone numer is required';
    }

    //regular exp for phone number validation assuming 10 didigts
    final phoneRegExp = RegExp(r'^\d{10}$');

    if (!phoneRegExp.hasMatch(value)){
      return ' Invalid phone number format (10 digit required)';
    }
    return null;
  }
}