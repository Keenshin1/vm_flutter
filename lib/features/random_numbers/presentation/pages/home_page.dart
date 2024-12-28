import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/numbers_controller.dart';
import 'package:vm_tecnologia/core/constants/app_strings.dart';
import 'package:vm_tecnologia/core/constants/app_constants.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.tituloApp),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => context.read<NumbersController>().reset(),
          ),
        ],
      ),
      body: Consumer<NumbersController>(
        builder: (context, controller, _) {
          final numberList = controller.numberList;
          if (numberList.numbers.isEmpty) {
            return Center(
              child: ElevatedButton(
                onPressed: () => _showQuantityDialog(context),
                child: Text(AppStrings.botaoGerarNumeros),
              ),
            );
          }
          return Column(
            children: [
              Expanded(
                child: ReorderableListView.builder(
                  itemCount: numberList.numbers.length,
                  onReorder: controller.reorderNumbers,
                  itemBuilder: (context, index) {
                    return Card(
                      key: ValueKey(numberList.numbers[index]),
                      child: ListTile(
                        title: Text(
                          numberList.numbers[index].toString(),
                          style: TextStyle(
                            fontSize: AppConstants.tamanhoFonteGrande,
                            color: numberList.isOrdered == true ? Colors.green : null,
                          ),
                        ),
                        trailing: const Icon(
                          Icons.drag_handle,
                          color: Colors.grey,
                        ),
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: AppConstants.paddingPadrao),
                child: Text(
                  AppStrings.dicaReordenar,
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: AppConstants.tamanhoFonteNormal,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(AppConstants.paddingPadrao),
                child: Column(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        final isOrdered = controller.checkOrder();
                        _showOrderCheckResult(context, isOrdered);
                      },
                      child: Text(AppStrings.botaoVerificarOrdem),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  void _showOrderCheckResult(BuildContext context, bool isOrdered) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          icon: Icon(
            isOrdered ? Icons.check_circle : Icons.error_outline,
            size: AppConstants.tamanhoIcone,
            color: isOrdered ? Colors.green : Colors.red,
          ),
          title: Text(
            isOrdered ? AppStrings.numerosOrdenados : AppStrings.numerosDesordenados,
            style: TextStyle(
              color: isOrdered ? Colors.green : Colors.red,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text(
            isOrdered
                ? AppStrings.mensagemSucessoOrdem
                : AppStrings.mensagemErroOrdem,
            style: TextStyle(
              fontSize: AppConstants.tamanhoFonteNormal,
            ),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              style: TextButton.styleFrom(
                foregroundColor: isOrdered ? Colors.green : Colors.red,
              ),
              child: Text(
                AppStrings.botaoOk,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> _showQuantityDialog(BuildContext context) async {
    final numbersController = context.read<NumbersController>();
    final controller = TextEditingController();

    return showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(AppStrings.tituloDialogoQuantidade),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: AppStrings.campoQuantidade,
                helperText: AppStrings.dicaQuantidade,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: Text(AppStrings.botaoCancelar),
          ),
          TextButton(
            onPressed: () {
              final quantity = int.tryParse(controller.text);
              if (quantity != null &&
                  quantity >= AppConstants.quantidadeMinima &&
                  quantity <= AppConstants.quantidadeMaxima) {
                numbersController.generateNumbers(quantity);
                Navigator.pop(dialogContext);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(AppStrings.numeroForaDoIntervalo),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            },
            child: Text(AppStrings.botaoGerar),
          ),
        ],
      ),
    );
  }
}