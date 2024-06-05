// Library file for all calculations

// class Calculator {
//
//   //Sample Function
//   double calculate(double a, double b, bool isProduct) {
//     if (isProduct) {
//       return a * b;
//     } else {
//       return a + b;
//     }
//   }
// }

class Calculator {
  Map<String, double> calculateENA(double a, double b) {
    double sum = a + b;
    double product = a * b;
    return {'sum': sum, 'product': product};
  }
}