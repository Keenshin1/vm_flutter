import 'package:test/test.dart';
import 'package:random_numbers_api/random_numbers_api.dart';

void main() {
  late ExamApi api;

  setUp(() {
    api = ExamApiImpl();
  });

  group('ExamApi Tests', () {
    test('getRandomNumbers deve retornar a quantidade correta', () {
      final result = api.getRandomNumbers(5);
      expect(result.length, 5);
    });

    test('getRandomNumbers não deve repetir números', () {
      final result = api.getRandomNumbers(10);
      expect(result.length, result.toSet().length,
          reason: 'Deve ter todos os números únicos');
    });

    test('getRandomNumbers deve lançar erro para quantidade <= 0', () {
      expect(
            () => api.getRandomNumbers(0),
        throwsA(isA<ArgumentError>().having(
                (error) => error.message,
            'message',
            'Quantidade deve estar entre 1 e 1000'
        )),
      );

      expect(
            () => api.getRandomNumbers(-5),
        throwsA(isA<ArgumentError>()),
      );
    });

    test('getRandomNumbers deve lançar erro para quantidade > 1000', () {
      expect(
            () => api.getRandomNumbers(1001),
        throwsA(isA<ArgumentError>().having(
                (error) => error.message,
            'message',
            'Quantidade deve estar entre 1 e 1000'
        )),
      );
    });

    test('checkOrder deve retornar true para lista ordenada', () {
      final sortedList = [1, 2, 3, 4, 5];
      expect(api.checkOrder(sortedList), isTrue);
    });

    test('checkOrder deve retornar false para lista não ordenada', () {
      final unsortedList = [2, 1, 4, 3];
      expect(api.checkOrder(unsortedList), isFalse);
    });

    test('checkOrder deve lançar erro para lista vazia', () {
      expect(
            () => api.checkOrder([]),
        throwsA(isA<ArgumentError>().having(
                (error) => error.message,
            'message',
            'Lista não pode estar vazia'
        )),
      );
    });

    test('getRandomNumbers não deve gerar números maiores que 999', () {
      final result = api.getRandomNumbers(100);
      expect(result.every((number) => number < 1000), isTrue);
    });

    test('getRandomNumbers deve gerar números diferentes em chamadas diferentes', () {
      final result1 = api.getRandomNumbers(5);
      final result2 = api.getRandomNumbers(5);
      expect(result1, isNot(equals(result2)));
    });
  });
}