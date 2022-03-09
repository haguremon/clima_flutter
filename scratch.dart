import 'dart:io';

void main() async {
  task0();
 String? task1Data = await task1();
task2(task1Data);
}

void task0() {
  print('task0 complete');
}

Future<String?> task1() async {

  Duration threeSeconds = Duration(seconds: 3);
  String? result;

  //時間がかかる処理
 await Future.delayed(threeSeconds, () {
    result = 'task1Data';
    print('task1 complete');
  });

  return result;
}

void task2(String? task1Data) {
  print('task2　complete with $task1Data');
}
