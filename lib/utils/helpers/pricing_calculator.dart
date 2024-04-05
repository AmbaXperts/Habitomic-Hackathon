
class TpricingCalculator{

  // calculate price based on price and shipping and delivery fee

  static double calculateTotalPrice(double productionPrice, String location){
    double taxRate = getTaxRateForLocation(location);
    double taxAmount = productionPrice * taxRate;

    double shippingCost= getShippingCost(location);

    double totalPrice = productionPrice + taxAmount + shippingCost;
    return totalPrice;
  }
  static String calculateShippingCost(double productionPrice, String location){
    double shippingCost= getShippingCost(location);
    return shippingCost.toStringAsFixed(2);
  }

  static String calculateTax(double productionPrice, String location){

    double taxRate = getTaxRateForLocation(location);
    double taxAmount = productionPrice * taxRate;
    return taxAmount.toStringAsFixed(2);
  }
   static double getTaxRateForLocation(String location){

    //  we can do the following if we have enought time left


// lookip the Tax rate for the given location using a shipping rate API
// calculate the tax rate based on various factors like distance, weight, etc
    return 0.10;
   }

    

    //  we can do the following if we have enought time left

 static double getShippingCost(String location){

    //  we can do the following if we have enought time left


// lookip the Tax rate for the given location using a shipping rate API
// calculate the tax rate based on various factors like distance, weight, etc
   return 5.00;
   }

   // sum all cart values and return total amount

   /*  static double calculateCartTotal(CartModl cart){
   return cart.item.map((e) => e,price).fold(0,(previosPrice, currentprice) => previousPrice + (currentprice ?? 0));
   }*/
   
   }


