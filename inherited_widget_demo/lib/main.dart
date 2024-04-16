import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const SharedData(
      data: 50,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: MainApp(),
      ),
    );
  }
}

class SharedData extends InheritedWidget {
  final int data;
  const SharedData({
    super.key,
    required this.data,
    required super.child,
  });

  static SharedData of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<SharedData>()!;
  }

  @override
  bool updateShouldNotify(SharedData oldWidget) {
    return data != oldWidget.data;
  }
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  Widget build(BuildContext context) {
    SharedData sharedData = SharedData.of(context);
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        title: const Text('InheritedWidget demo'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Text(sharedData.data.toString()),
          Text(
            sharedData.hashCode.toString(),
            style: const TextStyle(color: Colors.red),
          ),
          const AccessData(),
        ],
      ),
    );
  }
}

class AccessData extends StatelessWidget {
  const AccessData({super.key});

  @override
  Widget build(BuildContext context) {
    SharedData sharedData = SharedData.of(context);
    return Row(
      children: [
        Text(sharedData.data.toString()),
        const SizedBox(
          width: 20,
        ),
        Text(
          sharedData.hashCode.toString(),
          style: const TextStyle(color: Colors.red),
        ),
        const SizedBox(
          width: 40,
        ),
        const AccessDataChild(),
      ],
    );
  }
}

class AccessDataChild extends StatelessWidget {
  const AccessDataChild({super.key});

  @override
  Widget build(BuildContext context) {
    SharedData sharedData = SharedData.of(context);
    return Text(sharedData.data.toString());
  }
}
