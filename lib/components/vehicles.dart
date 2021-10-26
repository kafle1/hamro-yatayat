import 'package:flutter/material.dart';
import 'package:yatayat/constants.dart';
import 'package:yatayat/screens/create_booking_screen.dart';

class Vehicles extends StatefulWidget {
  static const String id = 'vehicles';
  @override
  _VehiclesState createState() => _VehiclesState();
}

class _VehiclesState extends State<Vehicles> {
  List<Map> vehicles = [
    {'title': 'Bus', 'icon': 'assets/images/icons/Bus.png'},
    {'title': 'Car', 'icon': 'assets/images/icons/Car.png'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kThemeColor,
        title: Text('Choose your vehicle'),
      ),
      body: ListView.builder(
          itemCount: vehicles.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.symmetric(vertical: 1, horizontal: 4),
              child: Card(
                elevation: 1,
                child: ListTile(
                  onTap: () {
                    print(index);
                    Navigator.popAndPushNamed(context, CreateBookingScreen.id);
                  },
                  title: Text(vehicles[index]['title']),
                  leading: Image(
                    image: AssetImage(vehicles[index]['icon']),
                    height: 40,
                    width: 40,
                  ),
                ),
              ),
            );
          }),
    );
  }
}
