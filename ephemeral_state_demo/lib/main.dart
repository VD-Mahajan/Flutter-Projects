import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyApp(),
    );
  }
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override
  State createState() => _MyAppState();
}

class _MyAppState extends State {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ephemeral State Demo'),
        centerTitle: true,
      ),
      body: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Course(courseName: 'Java'),
          SizedBox(
            height: 30,
          ),
          Course(courseName: 'Flutter'),
        ],
      ),
    );
  }
}

class Course extends StatefulWidget {
  final String courseName;
  const Course({super.key, required this.courseName});

  @override
  State<Course> createState() => _CourseState();
}

class _CourseState extends State<Course> {
  int courseCounter = 0;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              courseCounter++;
            });
          },
          child: Container(
            height: 60,
            width: 100,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.amber,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(widget.courseName),
          ),
        ),
        const SizedBox(
          width: 20,
        ),
        Container(
          height: 60,
          width: 100,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.pink,
          ),
          child: Text('$courseCounter'),
        ),
      ],
    );
  }
}
