import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_app_demo/mytheme.dart';

class MyMultiProvider extends StatelessWidget {
  const MyMultiProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // Provider(create: (context) {
        //   return const Employee(
        //     empName: "Vishal",
        //     empId: 30,
        //     // same: "Same Emlployee",
        //   );
        // }),
        ChangeNotifierProvider(create: (context) {
          return Project(
            projectName: "EdTech",
            devType: "Backend Dev",
            same: "Same Project",
          );
        }),
      ],
      child: MaterialApp(
        theme: mytheme,
        home: const Screen(),
      ),
    );
  }
}

class Screen extends StatefulWidget {
  const Screen({super.key});

  @override
  State<Screen> createState() => _ScreenState();
}

class _ScreenState extends State<Screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Text(Provider.of<Employee>(context).empName),
              // const SizedBox(
              //   height: 30,
              // ),
              // Text("${Provider.of<Employee>(context).empId}"),
              // const SizedBox(
              //   height: 30,
              // ),
              Text(Provider.of<Project>(context).projectName),
              const SizedBox(
                height: 30,
              ),
              Text(Provider.of<Project>(context).devType),
              const SizedBox(
                height: 30,
              ),
              Text(Provider.of<Project>(context).projectName),
              const SizedBox(
                height: 30,
              ),
              TextButton(
                onPressed: () {
                  Provider.of<Project>(context, listen: false)
                      .changeCompany('GameDev', 'Bench');
                },
                style: TextButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                ),
                child: const Text('Change Button'),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class Employee {
  final String empName;
  final int empId;
  // final String same;

  const Employee({
    required this.empId,
    required this.empName,
    // required this.same,
  });
}

class Project extends ChangeNotifier {
  String projectName;
  String devType;
  String same;

  Project({
    required this.projectName,
    required this.devType,
    required this.same,
  });

  void changeCompany(String projectName, String devType) {
    this.projectName = projectName;
    this.devType = devType;
    notifyListeners();
  }
}
