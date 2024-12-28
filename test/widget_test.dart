import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:vm_tecnologia/features/random_numbers/presentation/pages/home_page.dart';
import 'package:vm_tecnologia/features/random_numbers/presentation/controllers/numbers_controller.dart';
import 'package:mockito/mockito.dart';
import './mocks/mock_repository.mocks.dart';
import 'package:vm_tecnologia/core/constants/app_strings.dart';
import 'package:vm_tecnologia/core/constants/app_constants.dart';

void main() {
  late MockNumbersRepository repository;

  setUp(() {
    repository = MockNumbersRepository();
    when(repository.getRandomNumbers(any)).thenReturn([1, 2, 3]);

    when(repository.checkOrder([2, 1, 3])).thenReturn(false);
    when(repository.checkOrder([1, 2, 3])).thenReturn(true);

    when(repository.getRandomNumbers(1001)).thenThrow(
        ArgumentError('Quantidade deve estar entre 1 e 1000')
    );
    when(repository.checkOrder([])).thenThrow(
        ArgumentError('Lista não pode estar vazia')
    );
  });

  Widget createHomeScreen() {
    return MaterialApp(
      home: ChangeNotifierProvider(
        create: (_) => NumbersController(repository),
        child: const HomePage(),
      ),
    );
  }

  testWidgets('Deve mostrar botão de gerar números inicialmente',
          (WidgetTester tester) async {
        await tester.pumpWidget(createHomeScreen());

        expect(find.text(AppStrings.botaoGerarNumeros), findsOneWidget);
        expect(find.byType(ReorderableListView), findsNothing);
      });

  testWidgets('Deve mostrar diálogo ao clicar em gerar números',
          (WidgetTester tester) async {
        await tester.pumpWidget(createHomeScreen());

        await tester.tap(find.text(AppStrings.botaoGerarNumeros));
        await tester.pumpAndSettle();

        expect(find.text(AppStrings.tituloDialogoQuantidade), findsOneWidget);
        expect(find.byType(TextField), findsOneWidget);
      });

  testWidgets('Deve validar entrada de quantidade inválida',
          (WidgetTester tester) async {
        await tester.pumpWidget(createHomeScreen());

        await tester.tap(find.text(AppStrings.botaoGerarNumeros));
        await tester.pumpAndSettle();

        await tester.enterText(find.byType(TextField), '1001');
        await tester.tap(find.text(AppStrings.botaoGerar));
        await tester.pumpAndSettle();

        expect(
          find.text(AppStrings.numeroForaDoIntervalo),
          findsOneWidget,
        );
      });

  testWidgets('Deve mostrar lista após gerar números',
          (WidgetTester tester) async {
        await tester.pumpWidget(createHomeScreen());

        await tester.tap(find.text(AppStrings.botaoGerarNumeros));
        await tester.pumpAndSettle();

        await tester.enterText(find.byType(TextField), '3');
        await tester.tap(find.text(AppStrings.botaoGerar));
        await tester.pumpAndSettle();

        expect(find.byType(ReorderableListView), findsOneWidget);
        expect(find.text('1'), findsOneWidget);
        expect(find.text('2'), findsOneWidget);
        expect(find.text('3'), findsOneWidget);
      });

  testWidgets('Deve mostrar feedback ao verificar ordem',
          (WidgetTester tester) async {
        await tester.pumpWidget(createHomeScreen());

        final context = tester.element(find.byType(HomePage));
        context.read<NumbersController>().generateNumbers(3);
        await tester.pumpAndSettle();

        await tester.tap(find.text(AppStrings.botaoVerificarOrdem));
        await tester.pumpAndSettle();

        expect(find.byType(AlertDialog), findsOneWidget);
        expect(find.text(AppStrings.numerosOrdenados), findsOneWidget);
      });

  testWidgets('Deve atualizar status de ordenação ao reordenar',
          (WidgetTester tester) async {
        await tester.pumpWidget(createHomeScreen());

        final context = tester.element(find.byType(HomePage));
        final controller = context.read<NumbersController>();

        controller.generateNumbers(3);
        await tester.pumpAndSettle();

        controller.reorderNumbers(0, 2);
        await tester.pumpAndSettle();

        expect(controller.numberList.isOrdered, isFalse);
      });

  testWidgets('Deve mostrar mensagem de erro ao gerar com quantidade inválida',
          (WidgetTester tester) async {
        await tester.pumpWidget(createHomeScreen());

        final controller = tester.element(find.byType(HomePage))
            .read<NumbersController>();

        controller.generateNumbers(1001);
        await tester.pumpAndSettle();

        expect(controller.errorMessage, isNotNull);
        expect(controller.numberList.numbers, isEmpty);
      });

  testWidgets('Deve limpar lista ao resetar',
          (WidgetTester tester) async {
        await tester.pumpWidget(createHomeScreen());

        final context = tester.element(find.byType(HomePage));
        final controller = context.read<NumbersController>();

        controller.generateNumbers(3);
        await tester.pumpAndSettle();

        controller.reset();
        await tester.pumpAndSettle();

        expect(controller.numberList.numbers, isEmpty);
        expect(find.text(AppStrings.botaoGerarNumeros), findsOneWidget);
      });
}