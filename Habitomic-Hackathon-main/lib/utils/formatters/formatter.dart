import 'package:intl/intl.dart';

class TFormatter{

  static String formatDate(DateTime? date){

    date??= DateTime.now();
    return DateFormat('dd-MMM-YYYY').format(date);
  }

  static String formatCurrency(double amount){
    return NumberFormat.currency(locale: 'en_US', symbol: '\$').format(amount);// to customize the currency
  }

  static String formatPhoneNumber(String phoneNumber){
    // for 10 digits

    if(phoneNumber.length ==10){
      return '(${phoneNumber.substring(0,2)}) ${phoneNumber.substring(2,6)} ${phoneNumber.substring(6)}';

    }else if(phoneNumber.length ==11){
       return '(${phoneNumber.substring(0,3)}) ${phoneNumber.substring(3,8)} ${phoneNumber.substring(8)}';
    }
    return phoneNumber;
  }

  static String internationalFormatPhoneNumber(String phoneNumber){

    // to remove non digit character
    var digitsOnly =phoneNumber.replaceAll(RegExp(r'\D'), '');

    //   to extract the country code
    String countryCode = '+${digitsOnly.substring(0,2)}';
    digitsOnly = digitsOnly.substring(0,2);

    //to add remaning digit to format
    final formatedNumber = StringBuffer();
    formatedNumber.write('($countryCode)');

    int i=0;
    while (i < digitsOnly.length){
      int groupLength =2;

      if(i ==0 && countryCode == '+1'){
        groupLength =3;
      }

      int end = i+ groupLength;
      formatedNumber.write(digitsOnly.substring(i,end));

      if(end < digitsOnly.length){
        formatedNumber.write('');


      }
      i=end;
    }
    return formatedNumber.toString();
  }
}