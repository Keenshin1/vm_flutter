import 'package:flutter/material.dart';

import '../../domain/entities/number_list_entity.dart';
import '../../domain/repositories/numbers_repository.dart';

class NumbersController extends ChangeNotifier {
  final NumbersRepository repository;
  NumberListEntity _numberList;
  String? _errorMessage;

  NumberListEntity get numberList => _numberList;
  String? get errorMessage => _errorMessage;

  NumbersController(this.repository) : _numberList = NumberListEntity(numbers: []);

  void reorderNumbers(int oldIndex, int newIndex) {
    final numbers = List<int>.from(_numberList.numbers);

    if (oldIndex < newIndex) {
      newIndex -= 1;
    }

    final item = numbers.removeAt(oldIndex);
    numbers.insert(newIndex, item);

    final isOrdered = repository.checkOrder(numbers);
    _numberList = NumberListEntity(
      numbers: numbers,
      isOrdered: isOrdered,
    );
    notifyListeners();
  }

  void generateNumbers(int quantity) {
    try {
      final numbers = repository.getRandomNumbers(quantity);
      _errorMessage = null;
      _numberList = NumberListEntity(numbers: numbers, isOrdered: null);
    } catch (e) {
      _errorMessage = e is ArgumentError ? e.message : 'Erro ao gerar números';
      _numberList = NumberListEntity(numbers: [], isOrdered: null);
    }
    notifyListeners();
  }

  bool checkOrder() {
    final isOrdered = repository.checkOrder(_numberList.numbers);
    _numberList = NumberListEntity(
      numbers: _numberList.numbers,
      isOrdered: isOrdered,
    );
    notifyListeners();
    return isOrdered;
  }

  void reset() {
    _numberList = NumberListEntity(numbers: []);
    notifyListeners();
  }
}