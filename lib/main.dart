import 'package:flutter/material.dart';
import 'package:classhero2/screens/filter_students_screen.dart'; // Atualize com o nome do seu projeto

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Filtro de Alunos',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const FilterStudentsScreen(),
    );
  }
}