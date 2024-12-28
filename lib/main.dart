import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:random_numbers_api/random_numbers_api.dart';

import 'features/random_numbers/data/datasources/random_numbers_datasource.dart';
import 'features/random_numbers/data/repositories/numbers_repository_impl.dart';
import 'features/random_numbers/presentation/controllers/numbers_controller.dart';
import 'features/random_numbers/presentation/pages/home_page.dart';
import 'package:vm_tecnologia/core/constants/app_strings.dart';

void main() {
  final api = ExamApiImpl();
  final dataSource = RandomNumbersDataSource(api);
  final repository = NumbersRepositoryImpl(dataSource);

  runApp(
    MaterialApp(
      title: AppStrings.tituloApp,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ChangeNotifierProvider(
        create: (_) => NumbersController(repository),
        child: const HomePage(),
      ),
    ),
  );
}