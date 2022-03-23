
import 'dart:io';


class PlaceLocation{
  final double longitude;
  final double latitude;
  final String address;
  PlaceLocation(this.address, {required this.longitude,required this.latitude});
}

class Places{
  final String id;
  final String title;
  final PlaceLocation? location;
  final File image;

  Places({required this.id,required this.title,required this.image,required this.location});

}