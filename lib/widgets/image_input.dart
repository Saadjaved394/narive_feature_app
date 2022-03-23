import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart'as path;
import 'package:path_provider/path_provider.dart' as syspaths;

class ImageInput extends StatefulWidget {
  const ImageInput(this.selectedImage,{Key? key, }) : super(key: key);
  final Function selectedImage;

  @override
  State<ImageInput> createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File? _storedImage;
  final picker = ImagePicker();
  Future<void> _takeImage()async{
    final imageFile = await picker.pickImage(source: ImageSource.camera,maxWidth: 600,);
    if(imageFile==null){
      return;
    }
    setState(() {
      _storedImage = File(imageFile.path);
    });
    final appDir = await syspaths.getApplicationDocumentsDirectory();
    final filename = path.basename(imageFile.path);
   final savedImage = await File(imageFile.path).copy('${appDir.path}/$filename');
   widget.selectedImage(savedImage);

  }
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 110,
          width: 130,
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: Colors.grey,
            ),
          ),
          child: _storedImage != null
              ? Image.file(
                  _storedImage!,
                  fit: BoxFit.cover,
                  width: double.infinity,
                )
              : const Text('NO image Found',textAlign: TextAlign.center,),
          alignment: Alignment.center,
        ),
        const SizedBox(
          width: 10,
        ),
        Expanded(
            child: FlatButton.icon(
          onPressed: _takeImage,
          label: const Text('Take photo'),
          icon:  Icon(Icons.camera,color: Theme.of(context).primaryColor,),
        ))
      ],
    );
  }
}
