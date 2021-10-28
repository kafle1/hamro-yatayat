import 'package:flutter/material.dart';
import 'package:yatayat/components/appbar.dart';
import 'package:yatayat/components/button.dart';
import 'package:yatayat/components/input_field.dart';
import 'package:yatayat/components/vehicles.dart';
import 'package:yatayat/constants.dart';

class CreateBookingScreen extends StatefulWidget {
  static const String id = 'createBooking';

  @override
  State<CreateBookingScreen> createState() => _CreateBookingScreenState();
}

class _CreateBookingScreenState extends State<CreateBookingScreen> {
  bool? isEmergencyBooking = false;
  bool? is1Trip = false;
  bool? is2Trip = false;
  String tripSelected = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: YatayatAppbar(
        height: 65,
        title: Text(
          'Create Booking',
          style: kAppbarTitleStyle,
        ),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InputField(
                    label: 'Name',
                    placeholder: 'Enter Full Name',
                    onChange: (value) {}),
                Text(
                  'Vehicle Type:',
                  style: kFormLabelStyle,
                ),
                MaterialButton(
                  minWidth: double.infinity,
                  height: 45,
                  onPressed: () {
                    Navigator.pushNamed(context, Vehicles.id);
                  },
                  color: kThemeColor,
                  child: Text(
                    'Enter Vehicle Type',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                InputField(
                    label: 'Pickup Location',
                    placeholder: 'Enter your pickup location',
                    onChange: (value) {}),
                InputField(
                    label: 'Destination',
                    placeholder: 'Enter your destination location',
                    onChange: (value) {}),
                InputField(
                    label: 'Number of Days / Hours ',
                    placeholder: 'Enter duration (Eg: 4 days, 2 Hours)',
                    onChange: (value) {}),
                InputField(
                    label: 'Number of Trips',
                    placeholder: 'Enter numbers of trips (Eg: 1 , 2)',
                    onChange: (value) {}),
                Text(
                  'Number of Trips',
                  style: kFormLabelStyle,
                ),
                Row(
                  children: [
                    Checkbox(
                      value: is1Trip,
                      onChanged: (newValue) {
                        setState(() {
                          is1Trip = newValue;
                          if (newValue!) {
                            tripSelected = '1';
                            is2Trip = false;
                          } else {
                            tripSelected = '';
                          }
                        });
                      },
                      activeColor: kThemeColor,
                    ),
                    Tooltip(
                      message:
                          '1 Trip includes: Pickup Location to Destination',
                      child: Text(
                        '1 Trip',
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                    Checkbox(
                      value: is2Trip,
                      onChanged: (newValue) {
                        setState(() {
                          is2Trip = newValue;
                          if (newValue!) {
                            tripSelected = '2';
                            is1Trip = false;
                          } else {
                            tripSelected = '';
                          }
                        });
                      },
                      activeColor: kThemeColor,
                    ),
                    Tooltip(
                      message:
                          '2 Trip includes: Pickup Location to Destination and again to Pickup Location',
                      child: Text(
                        '2 Trip',
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                  ],
                ),
                InputField(
                    label: 'Phone',
                    placeholder: 'Enter your destination location',
                    onChange: (value) {}),
                InputField(
                    label: 'Email',
                    otherDetails: '(Optional)',
                    placeholder: 'Enter your Email',
                    onChange: (value) {}),
                Row(
                  children: [
                    Checkbox(
                      value: isEmergencyBooking,
                      onChanged: (newValue) {
                        setState(() {
                          isEmergencyBooking = newValue;
                        });
                      },
                      activeColor: kThemeColor,
                    ),
                    Tooltip(
                        message:
                            'Check this if you want to make an emergency booking!',
                        child: Text(
                          'Emergency Booking',
                          style: TextStyle(fontSize: 15),
                        )),
                  ],
                ),
                YatayatButton(label: 'Confirm Booking', onClick: () {})
              ],
            ),
          ),
        ),
      ),
    );
  }
}
