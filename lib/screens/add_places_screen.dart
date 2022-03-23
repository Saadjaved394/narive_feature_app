import 'package:flutter/material.dart';
import 'dart:io';
import 'package:provider/provider.dart';

import '../widgets/image_input.dart';
import '../providers/placeProvider.dart';


class AddPlacesScreen extends StatefulWidget {
  const AddPlacesScreen({Key? key}) : super(key: key);
  static const routeName = '/add_Place_Screen';

  @override
  State<AddPlacesScreen> createState() => _AddPlacesScreenState();
}

class _AddPlacesScreenState extends State<AddPlacesScreen> {
  final _titleController = TextEditingController();
   File? _pickedImage;

   void _selectedImage(File pickedImage){
     _pickedImage = pickedImage;
   }

   void _savedPlace(){
     if(_titleController.text.isEmpty || _pickedImage==null){
       return;
     }
     Provider.of<PlaceProvider>(context,listen: false).addPlace(_titleController.text, _pickedImage!);
     Navigator.of(context).pop();
   }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ADD Place'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(children: [
              TextField(decoration: InputDecoration(labelText: 'title'),
                controller: _titleController,

              ),
              const SizedBox(height: 15,),
              ImageInput(_selectedImage),




            ],),
          )),
          RaisedButton.icon(
            color: Theme.of(context).accentColor,
            onPressed:_savedPlace,
            icon: const Icon(Icons.add,color: Colors.white,),
            label: const Text('Add place',style: TextStyle(color: Colors.white),),
            elevation: 0,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          )
        ],
      ),
    );
  }
}
