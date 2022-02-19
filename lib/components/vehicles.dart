import 'package:flutter/material.dart';
import 'package:yatayat/shared/constants.dart';
import 'package:get/get.dart';

class Vehicles extends StatefulWidget {
  static const String id = 'vehicles';
  @override
  _VehiclesState createState() => _VehiclesState();
}

class _VehiclesState extends State<Vehicles> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView(
          children: [
            Center(
              child: Text(
                'Select your vehicle : '.tr,
                style: kComponentTitleStyle,
              ),
            ),
            SizedBox(
              height: 15,
            ),
            VehicleTile(
              vehicle: 'Bus (Normal)',
              icon: 'Bus',
              seats: '30-40',
            ),
            VehicleTile(
              vehicle: 'Bus (Tourist)',
              icon: 'Bus',
              seats: '35-45',
            ),
            VehicleTile(
              vehicle: 'Taxi',
              icon: 'Taxi',
              seats: '4',
            ),
            VehicleTile(
              vehicle: 'Scorpio',
              icon: 'Suv',
              seats: '7',
            ),
            VehicleTile(
              vehicle: 'Landcruiser',
              icon: 'Cruiser',
              seats: '7-8',
            ),
            VehicleTile(
              vehicle: 'Toyota Hiace',
              icon: 'Micro',
              seats: '13-14',
            ),
            VehicleTile(
              vehicle: 'Car (Sedan)',
              icon: 'Car',
              seats: '4',
            ),
            VehicleTile(
              vehicle: 'Car (SUV)',
              icon: 'Suv',
              seats: '4',
            ),
            VehicleTile(
              vehicle: 'TATA Winger',
              icon: 'Van',
              seats: '13',
            ),
            VehicleTile(
              vehicle: 'TATA Sumo (A/c)',
              icon: 'Jeep',
              seats: '7',
            ),
            VehicleTile(
              vehicle: 'TATA Sumo - Non (A/c)',
              icon: 'Jeep',
              seats: '7',
            ),
            VehicleTile(
              vehicle: 'Magic Van',
              icon: 'Van',
              seats: '9-10',
            ),
            VehicleTile(
              vehicle: 'Delivery Van (Bolero)',
              icon: 'Other',
              seats: '2',
            ),
            VehicleTile(
              vehicle: 'TATA Ace (Cargo / Carrier Van )',
              icon: 'Carrier',
              seats: '2',
            ),
          ],
        ),
      ),
    );
  }
}

class VehicleTile extends StatelessWidget {
  final String? vehicle;
  final String? icon;

  final String? seats;

  VehicleTile({this.vehicle, this.seats, this.icon});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Material(
        elevation: 1,
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(5),
        child: ListTile(
          leading: Image(
            image: AssetImage('assets/images/icons/$icon.png'),
            height: 35,
            width: 35,
          ),
          trailing: Text('$seats 💺'),
          title: Text(
            '$vehicle',
          ),
          onTap: () {
            Navigator.pop(context, {'vehicle': vehicle, 'icon': icon});
          },
        ),
      ),
    );
  }
}
