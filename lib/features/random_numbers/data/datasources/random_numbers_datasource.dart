import 'package:random_numbers_api/random_numbers_api.dart';

class RandomNumbersDataSource {
  final ExamApi api;

  RandomNumbersDataSource(this.api);

  List<int> getRandomNumbers(int quantity) {
    return api.getRandomNumbers(quantity);
  }

  bool checkOrder(List<int> numbers) {
    return api.checkOrder(numbers);
  }
}