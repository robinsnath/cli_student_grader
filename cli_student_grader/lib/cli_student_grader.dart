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
      case '1':
        print("Enter student name:");
        var name = stdin.readLineSync() ?? "Unknown";

        Map<String, dynamic> newStudent = {
          "name": name,
          "scores": <int>[],
          "subjects": {...availableSubjects},
          "bonus": null,
          "comment": null,
        };
        students.add(newStudent);
        print("Student '$name' added successfully!");
        break;

      case '2':
        if (students.isEmpty) {
          print("No students found.");
          break;
        }

        for (int i = 0; i < students.length; i++) {
          print("$i. ${students[i]["name"]}");
        }

        print("Select student index:");
        int idx = int.parse(stdin.readLineSync() ?? "0");

        print("Enter score (0-100):");
        int score = int.parse(stdin.readLineSync() ?? "0");

        while (score < 0 || score > 100) {
          print("Invalid! Enter score between 0-100:");
          score = int.parse(stdin.readLineSync() ?? "0");
        }

        students[idx]["scores"].add(score);
        print("Score recorded.");
        break;

      case '3':
        if (students.isEmpty) break;
        for (int i = 0; i < students.length; i++) {
          print("$i. ${students[i]["name"]}");
        }
        int bIdx = int.parse(stdin.readLineSync() ?? "0");

        print("Enter bonus (1-10):");
        int bonusVal = int.parse(stdin.readLineSync() ?? "0");

        if (students[bIdx]["bonus"] == null) {
          students[bIdx]["bonus"] ??= bonusVal;
          print("Bonus points added!");
        } else {
          print("Bonus already exists: ${students[bIdx]["bonus"]}");
        }
        break;

      case '4':
        if (students.isEmpty) break;
        for (int i = 0; i < students.length; i++) {
          print("$i. ${students[i]["name"]}");
        }
        int cIdx = int.parse(stdin.readLineSync() ?? "0");

        print("Enter comment:");
        students[cIdx]["comment"] = stdin.readLineSync();

        String display = students[cIdx]["comment"]?.toUpperCase() ?? "No comment provided";
        print("Comment saved as: $display");
        break;

      case '5':
        if (students.isEmpty) break;
        for (var s in students) {
          var tags = [
            s["name"],
            "${s["scores"].length} scores recorded",
            if (s["bonus"] != null) "Has Bonus",
          ];
          print(tags.join(" | "));
        }
        break;

      case '6':
        if (students.isEmpty) break;
        for (int i = 0; i < students.length; i++) {
          print("$i. ${students[i]["name"]}");
        }
        int rIdx = int.parse(stdin.readLineSync() ?? "0");
        var st = students[rIdx];

        double sum = 0;
        for (int s in st["scores"]) {
          sum = sum + s;
        }

        double rawAvg = st["scores"].isEmpty ? 0 : sum / st["scores"].length;
        double finalAvg = rawAvg + (st["bonus"] ?? 0);
        if (finalAvg > 100) finalAvg = 100;

        String grade = "";
        if (finalAvg >= 90) grade = "A";
        else if (finalAvg >= 80) grade = "B";
        else if (finalAvg >= 70) grade = "C";
        else if (finalAvg >= 60) grade = "D";
        else if (finalAvg < 60) grade = "F";

        // 14. Switch expression with pattern matching
        String feedback = switch (grade) {
          "A" => "Outstanding performance!",
          "B" => "Good work, keep it up!",
          "C" => "Satisfactory. Room to improve.",
          "D" => "Needs improvement.",
          "F"  => "Failing. Please seek help.",
          _  => "Unknown grade.",
        };

        print("""
╔════════════════════════════════════════════════╗
║        REPORT CARD                             ║
╠════════════════════════════════════════════════╝
║ Name:    ${st["name"]}                         ║
║ Scores:  ${st["scores"]}                       ║
║ Bonus:   +${st["bonus"] ?? 0}                  ║
║ Average: ${finalAvg.toStringAsFixed(1)}        ║
║ Grade:   $grade                                ║
║ Comment: ${st["comment"] ?? "N/A"}             ║
║ Feedback: $feedback                            ║
╚════════════════════════════════════════════════╝""");
        break;
    }
  } while (isRunning);

}