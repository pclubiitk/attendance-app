// Import the test package and Counter class
import 'package:attendance_app/src/shared/data.dart';
import 'package:attendance_app/src/shared/utils.dart';
import 'package:test/test.dart';

void main() {
  final agent = AttendanceManager();
  group('Get attendance, Check Absent, Change', () {
    test('I wish to take off today', () {
      agent.setAttendance(DateTime.now(), false);
      expect(agent.getAttendance(DateTime.now()), false);
    });

    test('Am I marked Absent', () {
      final Map<DateTime, bool> map1 = agent.getAllAttendance();
      expect(map1[normalizeDate(DateTime.now())], false);
    });

    test('Let\'s go to work !', () {
      agent.setAttendance(DateTime.now(), true);
      expect(agent.getAttendance(DateTime.now()), true);
    });

    test('I must be Present', () {
      expect(agent.isAbsent(DateTime.now()) , false);
    });
  });
}