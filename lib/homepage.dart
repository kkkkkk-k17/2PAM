import "package:flutter/material.dart";
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController dateController = TextEditingController();

  @override
  void initState() {
    super.initState();
    dateController.text = "";
  }

  int age = 0;
  bool enterAge = false;

  int calAge(DateTime birthDate) {
    DateTime currentDate = DateTime.now();
    int age = currentDate.year - birthDate.year;
    int month1 = currentDate.month;
    int month2 = birthDate.month;
    if (month2 > month1) {
      age--;
    } else if (month1 == month2) {
      int day1 = currentDate.day;
      int day2 = birthDate.day;
      if (day2 > day1) {
        age--;
      }
    }
    return age;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:Text(enterAge ? "You are $age year old" : "Enter Date")),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: Center(
          child: TextField(
            controller: dateController,
            decoration: const InputDecoration(
                icon: Icon(Icons.calendar_today), labelText: "Enter Date"),
            readOnly: true,
            onTap: () async {
              DateTime? pickedDate = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(2000),
                lastDate: DateTime(2101),
              );
              if (pickedDate != null) {
                enterAge = true;
                age = calAge(pickedDate);
                String formattedDate =
                    DateFormat("yyyy-MM-dd").format(pickedDate);
                setState(() {
                  dateController.text = formattedDate.toString();
                });
              } else {
                print("Not selected");
              }
            },
          ),
        ),
      ),
    );
  }


}
