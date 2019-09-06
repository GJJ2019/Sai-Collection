import 'dart:math' show Random;

class GenerateRandom {
  String generateRandomNumber(int count) {
    String randomNumber = '';
    Random random = Random();
    for (var i = 0; i < count; i++) {
      randomNumber = '$randomNumber${random.nextInt(9)}';
    }
    return randomNumber;
  }
}