import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// import 'multiprovider.dart';

void main() {
  // runApp(const MyMultiProvider());
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
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
              Text('${context.read().empCount}'),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  log('pressed');
                  Provider.of<Company>(context, listen: false)
                      .changeCompany('NVIDIA', 511);
                },
                child: const Text('change company'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class Company with ChangeNotifier {
  String companyName;
  int empCount;

  Company({required this.companyName, required this.empCount});

  void changeCompany(String companyName, int empCount) {
    this.companyName = companyName;
    this.empCount = empCount;
    notifyListeners();
  }
}
