import 'package:flutter/material.dart';
import 'package:yatayat/components/appbar.dart';
import 'package:yatayat/shared/constants.dart';

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
                'Select your vehicle : ',
                style: kComponentTitleStyle,
              ),
            ),
            SizedBox(
              height: 15,
            ),
            VehicleTile(
              vehicle: 'Bus',
              seats: '30-45',
              price: '💲💲💲💲💲',
            ),
            VehicleTile(
              vehicle: 'Car',
              seats: '4',
              price: '💲💲💲',
            ),
            VehicleTile(
              vehicle: 'Taxi',
              seats: '4',
              price: '💲💲',
            ),
            VehicleTile(
              vehicle: 'Other',
              seats: '2',
              price: '💲💲💲💲💲',
            ),
          ],
        ),
      ),
    );
  }
}

class VehicleTile extends StatelessWidget {
  final String? vehicle;
  final String? seats;
  final String? price;

  VehicleTile({this.vehicle, this.seats, this.price});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
          boxShadow: [kBoxShadow],
          color: Colors.white,
          borderRadius: BorderRadius.circular(5)),
      child: ListTile(
        leading: Image(
          image: AssetImage('assets/images/icons/$vehicle.png'),
          height: 35,
          width: 35,
        ),
        subtitle: Text('$seats 💺'),
        title: Text(
          '$vehicle',
        ),
        trailing: Text('$price'),
        onTap: () {
          Navigator.pop(context, vehicle);
        },
      ),
    );
  }
}
