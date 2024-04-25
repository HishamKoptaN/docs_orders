import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:get/get.dart';
import 'temporary/student_app/app/controllers/student_list.dart';
import 'temporary/student_app/app/db/students.dart';
import 'temporary/student_app/app/global/values.dart';
import 'temporary/student_app/app/theme/theme.dart';
import 'temporary/student_app/app/views/home.dart';

late bool isDarkMode;
List<CameraDescription> cameras = [];

Future<void> main() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();
    cameras = await availableCameras();
  } on CameraException catch (e) {
    _logError(e.code, e.description);
  }
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();
  // Get dark mode setting
  isDarkMode = await StudentDatabase.instance.getDarkMode();
  // Set app directory
  Values.appDirectory = (await getExternalStorageDirectory());
  runApp(const MyApp());
}

void _logError(String code, String? message) {
  // ignore: avoid_print
  print('Error: $code${message == null ? '' : '\nError Message: $message'}');
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(StudentListController());

    return GetMaterialApp(
      title: 'Student app',
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
      home: HomePage(),
    );
  }
}
