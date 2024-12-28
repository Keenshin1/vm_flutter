import 'package:flutter/material.dart';
import 'package:vm_tecnologia/core/constants/app_constants.dart';

class ReorderableNumbersList extends StatefulWidget {
  final List<int> numbers;
  final Function(int, int) onReorder;
  final bool? isOrdered;

  const ReorderableNumbersList({
    Key? key,
    required this.numbers,
    required this.onReorder,
    this.isOrdered,
  }) : super(key: key);

  @override
  State<ReorderableNumbersList> createState() => _ReorderableNumbersListState();
}

class _ReorderableNumbersListState extends State<ReorderableNumbersList> {
  int? draggedIndex;
  double dragOffset = 0;

  @override
  Widget build(BuildContext context) {
    return ReorderableListView.builder(
      itemCount: widget.numbers.length,
      onReorderStart: (index) {
        setState(() {
          draggedIndex = index;
        });
      },
      onReorderEnd: (index) {
        setState(() {
          draggedIndex = null;
          dragOffset = 0;
        });
      },
      onReorder: widget.onReorder,
      itemBuilder: (context, index) {
        final number = widget.numbers[index];
        final isDragged = draggedIndex == index;

        return TweenAnimationBuilder<double>(
          key: ValueKey(number),
          duration: Duration(milliseconds: AppConstants.duracaoAnimacaoMs),
          tween: Tween<double>(
            begin: 0,
            end: isDragged ? dragOffset : 0,
          ),
          builder: (context, value, child) {
            return Transform.translate(
              offset: Offset(0, value),
              child: child,
            );
          },
          child: GestureDetector(
            onHorizontalDragUpdate: (details) {
              if (isDragged) {
                setState(() {
                  dragOffset += details.delta.dy;
                });
              }
            },
            child: AnimatedContainer(
              duration: Duration(milliseconds: AppConstants.duracaoAnimacaoMs),
              margin: EdgeInsets.symmetric(
                horizontal: AppConstants.paddingPadrao,
                vertical: AppConstants.paddingPadrao / 2,
              ),
              decoration: BoxDecoration(
                color: isDragged
                    ? Theme.of(context).primaryColor.withOpacity(0.1)
                    : Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(isDragged ? 0.15 : 0.1),
                    blurRadius: isDragged ? 8 : 4,
                    offset: Offset(0, isDragged ? 4 : 2),
                  ),
                ],
              ),
              child: ListTile(
                contentPadding: EdgeInsets.symmetric(
                  horizontal: AppConstants.paddingPadrao,
                  vertical: AppConstants.paddingPadrao / 2,
                ),
                title: Text(
                  number.toString(),
                  style: TextStyle(
                    fontSize: AppConstants.tamanhoFonteGrande,
                    color: widget.isOrdered == true
                        ? Colors.green
                        : Theme.of(context).textTheme.bodyLarge?.color,
                    fontWeight: isDragged ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.drag_indicator,
                      color: isDragged
                          ? Theme.of(context).primaryColor
                          : Colors.grey,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}