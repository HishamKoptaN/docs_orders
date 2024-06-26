// import 'dart:io';
// import 'package:dough/dough.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:image_picker/image_picker.dart';
// import '../global/util.dart';
// import '../controllers/student_list.dart';
// import '../env/env.dart';
// import '../core/student.dart';
// import '../db/students.dart';
// import 'package:location/location.dart' as loc;

// import '../global/values.dart';

// class AddStudentPage extends StatelessWidget {
//   AddStudentPage({super.key});
//   final TextEditingController _nameController = TextEditingController();
//   final ImagePicker _picker = ImagePicker();
//   final RxString imagePath = "".obs;
//   final RxString course = "".obs;
//   final RxString errorMessage = "".obs;
//   final errorType = 0.obs;
//   final loc.Location location = loc.Location();

//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: () async {
//         // Clear image cache on back
//         _clearImageCache();
//         return true;
//       },
//       child: Scaffold(
//         appBar: AppBar(
//           title: const Text("Add student"),
//         ),
//         body: SingleChildScrollView(
//           child: Center(
//             child: Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 16),
//               child: Column(
//                 children: [
//                   const SizedBox(height: 42),

//                   GestureDetector(
//                     onTap: () async {
//                       // Pick image
//                       final XFile? result = await _picker.pickImage(
//                           source: ImageSource.gallery, imageQuality: 0);
//                       // If result is null, return
//                       if (result == null) return;
//                       // Set image path
//                       imagePath.value = result.path;
//                     },
//                     child: PressableDough(
//                       child: Obx(
//                         () => imagePath.isEmpty
//                             ? Icon(Icons.add_photo_alternate_outlined,
//                                 size: 150,
//                                 color: Theme.of(context).colorScheme.secondary)
//                             : SizedBox(
//                                 width: 150,
//                                 child: AspectRatio(
//                                   aspectRatio: 1,
//                                   child: ClipRRect(
//                                     borderRadius: BorderRadius.circular(12),
//                                     child: Image.file(File(imagePath.value),
//                                         height: 150, fit: BoxFit.cover),
//                                   ),
//                                 ),
//                               ),
//                       ),
//                     ),
//                   ),

//                   const SizedBox(height: 20),
//                   const Text("Note: Insert a photo by tapping the image above"),
//                   const SizedBox(height: 24),

//                   // Student name
//                   PressableDough(
//                     child: Obx(
//                       () => TextField(
//                         autofocus: true,
//                         controller: _nameController,
//                         decoration: InputDecoration(
//                             prefixIcon:
//                                 const Icon(Icons.person_outline_rounded),
//                             filled: Get.theme.brightness == Brightness.dark,
//                             border: Get.theme.brightness == Brightness.dark
//                                 ? null
//                                 : OutlineInputBorder(
//                                     borderRadius: BorderRadius.circular(12),
//                                     borderSide: BorderSide(
//                                         color: Theme.of(context)
//                                             .colorScheme
//                                             .onSurface,
//                                         width: 1),
//                                   ),
//                             errorText: errorType.value == 1
//                                 ? errorMessage.value
//                                 : null,
//                             label: const Text("Student name")),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 28),

//                   // Course
//                   PressableDough(
//                     child: Obx(
//                       () => DropdownButtonFormField(
//                         decoration: InputDecoration(
//                             prefixIcon: const Icon(Icons.school_outlined),
//                             filled: Get.theme.brightness == Brightness.dark,
//                             border: Get.theme.brightness == Brightness.dark
//                                 ? null
//                                 : OutlineInputBorder(
//                                     borderRadius: BorderRadius.circular(12),
//                                     borderSide: BorderSide(
//                                         color: Theme.of(context)
//                                             .colorScheme
//                                             .onSurface,
//                                         width: 1)),
//                             errorText: errorType.value == 2
//                                 ? errorMessage.value
//                                 : null,
//                             label: const Text("Course")),
//                         value: course.value.isEmpty ? null : course.value,
//                         items: courses
//                             .map((e) =>
//                                 DropdownMenuItem(value: e, child: Text(e)))
//                             .toList(),
//                         onChanged: (value) {
//                           errorMessage.value = "";
//                           errorType.value = 0;
//                           course.value = value.toString();
//                         },
//                       ),
//                     ),
//                   ),

//                   const SizedBox(height: 32),

//                   // Actions
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.end,
//                     children: [
//                       PressableDough(
//                         child: FilledButton.tonal(
//                             onPressed: () async {
//                               // Clear image cache
//                               _clearImageCache();
//                               // Go back to home
//                               Get.back();
//                             },
//                             child: const Text("Cancel")),
//                       ),
//                       const SizedBox(width: 8),
//                       PressableDough(
//                         child: FilledButton(
//                           onPressed: () {
//                             // Remove focus
//                             FocusScope.of(context).unfocus();
//                             // Add student
//                             addStudent(_nameController.text, course.value,
//                                 imagePath.value);
//                           },
//                           child: const Row(
//                             children: [
//                               Icon(Icons.add),
//                               SizedBox(width: 8),
//                               Text("Add student")
//                             ],
//                           ),
//                         ),
//                       )
//                     ],
//                   )
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Future<void> addorder(String place, String video, String firstImage,
//       String secondImage, double latitude, double longitude) async {
//     try {
//       place = place.trim();
//       _clearImageCache();
//       Student student = Student(
//         id: 4,
//         place: place,
//         video: video,
//         firstImage: firstImage,
//         secondImage: secondImage,
//         latitude: latitude,
//         longitude: longitude,
//       );
//       student.id = await OrderDatabaseTwo.instance.addOrder(student);
//       Get.find<StudentListControllerTwo>().addStudent(student);
//       Get.back();
//       showSuccess(student.firstImage);
//     } catch (e) {
//       print(e);
//     }
//   }

//   /// Copy the image to the app's directory and return the new image name
//   Future<String?> moveImage(File image) async {
//     // Get the app's directory
//     final Directory? directory = Values.appDirectory;
//     // Get the image's name
//     final String tempImageName = image.path.split("/").last;
//     // Get extension filename
//     final String ext = tempImageName.split(".").last;
//     // Create new image name
//     final String imageName =
//         "video_${DateTime.now().millisecondsSinceEpoch}.$ext";
//     // Final image path
//     final String destination = "${directory!.path}/$imageName";

//     // Compress image and copy the image to the app's directory with image_timestamp.ext
//     await compressImageAndCopy(image, destination);

//     // Remove the image from cache
//     _clearImageCache();
//     // Return the path
//     print(destination);
//     return imageName;
//   }

//   /// Clear image cache
//   void _clearImageCache() {
//     // If image path is empty, just return
//     if (imagePath.isEmpty) return;
//     // Delete the image and its directory
//     File(imagePath.value).parent.delete(recursive: true);
//     // Clear image path
//     imagePath.value = "";
//   }

//   // Clear inputs
//   void _clearInputs() {
//     imagePath.value = "";
//     _nameController.clear();
//     course.value = "";
//   }

//   void showSuccess(String name) {
//     showCustomDialog(
//       "Success",
//       "$name added successfully!",
//       [
//         TextButton(
//           onPressed: () {
//             // Clear inputs
//             _clearInputs();
//             // Close this dialog
//             Get.back();
//           },
//           child: const Text("Close"),
//         ),
//         TextButton(
//             onPressed: () {
//               // Close this dialog
//               Get.back();
//               // Close current page
//               Get.back();
//             },
//             child: const Text("Go to home"))
//       ],
//     );
//   }

//   void showPickImageMessage() {
//     showCustomDialog(
//         "Error",
//         "Please select an image first!",
//         [
//           TextButton(
//               style: TextButton.styleFrom(
//                   foregroundColor: Get.theme.colorScheme.onErrorContainer),
//               onPressed: () {
//                 // Close this dialog
//                 Get.back();
//               },
//               child: const Text("Ok"))
//         ],
//         type: DialogType.error);
//   }

//   void showErrorDirectory() {
//     showCustomDialog(
//         "Error",
//         "Error getting appplication directory.",
//         [
//           TextButton(
//               style: TextButton.styleFrom(
//                   foregroundColor: Get.theme.colorScheme.onErrorContainer),
//               onPressed: () {
//                 // Close this dialog
//                 Get.back();
//               },
//               child: const Text("Ok"))
//         ],
//         type: DialogType.error);
//   }
// }
