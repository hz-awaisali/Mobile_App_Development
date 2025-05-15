class Student {
  final int id;
  final String studentId;
  final String studentName;
  final String programName;

  Student({
    required this.id,
    required this.studentId,
    required this.studentName,
    required this.programName,
  });

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      id: json['id'],
      studentId: json['student_id'],
      studentName: json['student_name'],
      programName: json['program_name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'student_id': studentId,
      'student_name': studentName,
      'program_name': programName,
    };
  }
}