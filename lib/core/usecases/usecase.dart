abstract class UseCase<Type, Params> {
  Future<Type> call(Params params);
}

class NumberParams {
  final int quantity;

  const NumberParams(this.quantity);
}

class OrderCheckParams {
  final List<int> numbers;

  const OrderCheckParams(this.numbers);
}