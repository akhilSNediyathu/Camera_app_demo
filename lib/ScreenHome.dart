import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';


class ScreenHome extends StatefulWidget {
  const ScreenHome({super.key});

  @override
  State<ScreenHome> createState() => _ScreenHomeState();
}

class _ScreenHomeState extends State<ScreenHome> {
  File? image;

  
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Camera App'),
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
                Colors.deepPurple,Colors.red
              ],begin: Alignment.bottomRight,
              end: Alignment.topLeft
              )
            ),
          ),
          
        ),
        body:
        
        Column(
          children: [
            SizedBox(
              height: 200,
              child: CircleAvatar(
                backgroundColor: const Color.fromARGB(255, 223, 220, 228),
                maxRadius: 70,
                child: GestureDetector(
              onTap: () => pickimage(),
              child: Icon(Icons.camera_alt_outlined,size: 100,color: Colors.black,),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                height: 300,
                width: MediaQuery.of(context).size.width*0.9,

                child: image!=null?Image.file(image!,width:80,height:80,fit:BoxFit.cover ,):Image.asset('assets/cam2.jpg',fit: BoxFit.cover,),
                )

              ),
            
          ],
        ),
         backgroundColor: Color.fromARGB(255, 163, 157, 157),
      ),
    );
  }

    
  Future pickimage()async{
  try {
  final image =  await ImagePicker().pickImage(source: ImageSource.camera);
  if(image==null)return;
  final imageTemporary =File(image.path);
  setState(() {
      this.image = imageTemporary;
  });

} on PlatformException catch (e) {
  print('Failed to pick image');
}
}

}