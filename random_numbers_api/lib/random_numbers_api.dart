library;

import 'dart:math';

abstract class RandomNumbersApi {
  List<int> getRandomNumbers(int quantity);

  bool checkOrder(List<int> numbers);
}

class RandomNumbersApiImpl implements RandomNumbersApi {
  @override
  List<int> getRandomNumbers(int quantity) {
    if (quantity <= 0 || quantity > 1000) {
      throw ArgumentError('Quantidade deve estar entre 1 e 1000');
    }

    final random = Random();
    final Set<int> uniqueNumbers = {};

    while (uniqueNumbers.length < quantity) {
      uniqueNumbers.add(random.nextInt(1000));
    }

    return uniqueNumbers.toList();
  }

  @override
  bool checkOrder(List<int> numbers) {
    if (numbers.isEmpty) {
      throw ArgumentError('Lista não pode estar vazia');
    }

    for (int i = 0; i < numbers.length - 1; i++) {
      if (numbers[i] > numbers[i + 1]) {
        return false;
      }
    }
    return true;
  }
}
