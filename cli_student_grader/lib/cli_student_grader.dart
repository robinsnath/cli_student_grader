import 'dart:io';

void main() {
  const String appTitle = "Student Grader v1.0";

  final Set<String> availableSubjects = {
    "Physics",
    "Chemistry",
    "Math",
    "Biology"
  };

  var students = <Map<String, dynamic>>[];
  var isRunning = true;

  do {
    print("""
\n===== $appTitle =====
1. Add Student
2. Record Score
3. Add Bonus Points
4. Add Comment
5. View All Students
6. View Report Card
7. Class Summary
8. Exit

Choose an option:""");

    var choice = stdin.readLineSync();

    switch (choice) {
    }
  } while (isRunning);

}