import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Student {
  final String name;
  final double grade;

  Student({required this.name, required this.grade});
}

class FilterStudentsScreen extends StatefulWidget {
  const FilterStudentsScreen({super.key});

  @override
  State<FilterStudentsScreen> createState() => _FilterStudentsScreenState();
}

class _FilterStudentsScreenState extends State<FilterStudentsScreen> {
  final TextEditingController _filterController = TextEditingController();

  final List<Student> _allStudents = [
    Student(name: 'Ana Silva', grade: 9.5),
    Student(name: 'Bruno Costa', grade: 6.8),
    Student(name: 'Carla Dias', grade: 7.2),
    Student(name: 'Daniel Martins', grade: 5.5),
    Student(name: 'Eduarda Rocha', grade: 8.9),
    Student(name: 'Fábio Souza', grade: 10.0),
    Student(name: 'Gabriela Lima', grade: 4.8),
    Student(name: 'Heitor Alves', grade: 7.0),
    Student(name: 'Isabela Pereira', grade: 9.1),
    Student(name: 'João Santos', grade: 6.0),
  ];

  List<Student> _filteredStudents = [];

  @override
  void initState() {
    super.initState();
    _filteredStudents = _allStudents;
    _filterController.addListener(_filterList);
  }

  @override
  void dispose() {
    _filterController.removeListener(_filterList);
    _filterController.dispose();
    super.dispose();
  }

  void _filterList() {
    String query = _filterController.text;
    if (query.isEmpty) {
      setState(() {
        _filteredStudents = _allStudents;
      });
      return;
    }

    double? minGrade = double.tryParse(query.replaceAll(',', '.'));
    if (minGrade == null) {
      setState(() {
         _filteredStudents = [];
      });
      return;
    }

    setState(() {
      _filteredStudents = _allStudents.where((student) {
        return student.grade >= minGrade;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Filtrar Alunos por Nota'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _filterController,
              decoration: const InputDecoration(
                labelText: 'Nota mínima',
                hintText: 'Ex: 7.5',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.filter_list),
              ),
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: _filteredStudents.length,
                itemBuilder: (context, index) {
                  final student = _filteredStudents[index];
                  return Card(
                    elevation: 2,
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.blueAccent,
                        child: Text(
                          student.grade.toString(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      title: Text(student.name),
                      subtitle: Text('Nota: ${student.grade}'),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}