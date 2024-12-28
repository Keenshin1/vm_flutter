import '../../domain/repositories/numbers_repository.dart';
import '../datasources/random_numbers_datasource.dart';

class NumbersRepositoryImpl implements NumbersRepository {
  final RandomNumbersDataSource dataSource;

  NumbersRepositoryImpl(this.dataSource);

  @override
  List<int> getRandomNumbers(int quantity) {
    return dataSource.getRandomNumbers(quantity);
  }

  @override
  bool checkOrder(List<int> numbers) {
    return dataSource.checkOrder(numbers);
  }
}