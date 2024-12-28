class NumberListEntity {
  final List<int> numbers;
  final bool? isOrdered;

  NumberListEntity({
    required this.numbers,
    this.isOrdered,
  });

  NumberListEntity copyWith({
    List<int>? numbers,
    bool? isOrdered,
  }) {
    return NumberListEntity(
      numbers: numbers ?? this.numbers,
      isOrdered: isOrdered ?? this.isOrdered,
    );
  }
}