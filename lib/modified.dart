import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class ScreenHome2 extends StatefulWidget {
  const ScreenHome2({Key? key}) : super(key: key);

  @override
  State<ScreenHome2> createState() => _ScreenHomeState();
}

class _ScreenHomeState extends State<ScreenHome2> {
  File? image;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Camera App'),
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.deepPurple, Colors.red],
                begin: Alignment.bottomRight,
                end: Alignment.topLeft,
              ),
            ),
          ),
        ),
        body: Column(
          children: [
            SizedBox(
              height: 200,
              child: CircleAvatar(
                backgroundColor: const Color.fromARGB(255, 223, 220, 228),
                maxRadius: 70,
                child: GestureDetector(
                  onTap: () => pickImage(),
                  child: const Icon(
                    Icons.camera_alt_outlined,
                    size: 100,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                height: 300,
                width: MediaQuery.of(context).size.width * 0.9,
                child: image != null
                    ? Image.file(
                        image!,
                        width: 80,
                        height: 80,
                        fit: BoxFit.cover,
                      )
                    : Image.asset('assets/cam2.jpg', fit: BoxFit.cover),
              ),
            ),
          ],
        ),
        backgroundColor: const Color.fromARGB(255, 163, 157, 157),
      ),
    );
  }

  Future pickImage() async {
    try {
      final pickedImage =
          await ImagePicker().pickImage(source: ImageSource.camera);
      if (pickedImage == null) return;

      final imageFile = File(pickedImage.path);
      saveImage(imageFile); // Save the image to the desired folder

      setState(() {
        image = imageFile;
      });
    } on PlatformException catch (e) {
      print('Failed to pick image');
    }
  }

  Future<void> saveImage(File imageFile) async {
    // Define your desired folder path
    final desiredFolderPath = 'E:/flutter images';

    // Ensure that the desired folder exists
    final desiredFolder = Directory(desiredFolderPath);
    if (!desiredFolder.existsSync()) {
      desiredFolder.createSync(recursive: true);
    }

    // Define the file path within the desired folder
    final fileName = 'picked_image_${DateTime.now().millisecondsSinceEpoch}.jpg';
    final filePath = '$desiredFolderPath/$fileName';

    // Copy the picked image to the desired folder
    imageFile.copySync(filePath);

    // Optionally, you can display a message to indicate that the image is saved
    // ScaffoldMessenger.of(context).showSnackBar(
    //   SnackBar(
    //     content: Text('Image saved to $desiredFolderPath'),
    //   ),
    // );
  }
}
