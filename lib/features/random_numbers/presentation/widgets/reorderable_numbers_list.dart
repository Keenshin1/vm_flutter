import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ReorderableNumbersList extends StatelessWidget {
  final List<int> numbers;
  final Function(int, int) onReorder;

  const ReorderableNumbersList({
    Key? key,
    required this.numbers,
    required this.onReorder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ReorderableListView.builder(
      itemCount: numbers.length,
      onReorder: onReorder,
      itemBuilder: (context, index) {
        return Card(
          key: ValueKey(numbers[index]),
          child: ListTile(
            title: Text(numbers[index].toString()),
          ),
        );
      },
    );
  }
}