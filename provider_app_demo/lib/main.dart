import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (context) {
        return Company(companyName: 'Google', empCount: 250);
      },
      child: const MaterialApp(
        home: MyApp(),
      ),
    );
  }
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(Provider.of<Company>(context).companyName),
              const SizedBox(
                height: 20,
              ),
              Text('${Provider.of<Company>(context).empCount}'),
              ElevatedButton(
                onPressed: () {
                  log('pressed');
                  Provider.of<Company>(context, listen: false)
                      .changeCompany('NVIDIA', 511);
                  setState(() {});
                },
                child: const Text('change company'),
              )
            ],
          ),
        ],
      ),
    );
  }
}

class Company {
  String companyName;
  int empCount;

  Company({required this.companyName, required this.empCount});

  void changeCompany(String companyName, int empCount) {
    this.companyName = companyName;
    this.empCount = empCount;
    // notifyListeners();
  }
}
