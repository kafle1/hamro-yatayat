import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:nepali_date_picker/nepali_date_picker.dart';
import 'package:yatayat/components/appbar.dart';
import 'package:yatayat/components/button.dart';
import 'package:yatayat/components/input_field.dart';
import 'package:yatayat/components/snackbar.dart';
import 'package:yatayat/components/vehicles.dart';
import 'package:yatayat/screens/booking/booking_success_screen.dart';
import 'package:yatayat/services/database.dart';
import 'package:yatayat/shared/constants.dart';
import 'package:nepali_date_picker/nepali_date_picker.dart' as picker;

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

  //Display vehicles list when enter vehicle type is clicked
  bool showVehicles = false;

  final _formKey = GlobalKey<FormState>();

  //Input values
  String? name;
  String? pickupLocation;
  String? destination;
  dynamic vehicleType;
  String? phoneNumber = '';
  String? days;
  String? email;
  DateTime? _date;
  String? icon;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _auth = FirebaseAuth.instance;
    //Initialize firebase auth

    //Get details of current user
    final currentUser = _auth.currentUser;

    //Set values of predefined values
    if (currentUser != null) {
      if (name == null) {
        setState(() {
          name = currentUser.displayName ?? '';
        });
      }
      if (phoneNumber == '' && currentUser.phoneNumber != null) {
        setState(() {
          phoneNumber = currentUser.phoneNumber!.replaceAll('+977', '');
        });
      }

      if (email == null) {
        setState(() {
          email = currentUser.email;
        });
      }
    }

    //Get value from home screen  and set vehicle type and icons accordingly
    if (vehicleType == null) {
      final data = ModalRoute.of(context)!.settings.arguments as Map;

      vehicleType = data['vehicle'];
      icon = data['icon'];
    }

    return showVehicles
        ? Vehicles()
        : Scaffold(
            appBar: YatayatAppbar(
              height: 65,
              title: Text(
                'Create Booking'.tr,
                style: kAppbarTitleStyle,
              ),
            ),
            body: SingleChildScrollView(
              child: SafeArea(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InputField(
                          label: 'Name'.tr,
                          placeholder: 'Enter your full name'.tr,
                          validation: (val) =>
                              val!.isEmpty ? 'Enter your full name'.tr : null,
                          value: name,
                          onChange: (value) {
                            setState(() {
                              name = value;
                            });
                          },
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Vehicle Type :'.tr,
                              style: kFormLabelStyle,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            MaterialButton(
                              onPressed: () async {
                                dynamic newValue = await Navigator.pushNamed(
                                    context, Vehicles.id);

                                if (newValue != null) {
                                  setState(() {
                                    vehicleType = newValue['vehicle'];
                                    icon = newValue['icon'];
                                  });
                                }
                              },
                              height: 50,
                              child: Text(vehicleType == ''
                                  ? 'Enter your vehicle type'.tr
                                  : '$vehicleType'),
                              color: kThemeColor,
                              textColor: Colors.white,
                              minWidth: double.infinity,
                            ),
                          ],
                        ),
                        InputField(
                            label: 'Pickup Location'.tr,
                            placeholder: 'Enter your pickup location'.tr,
                            validation: (val) => val!.isEmpty
                                ? 'Enter your pickup location'.tr
                                : null,
                            onChange: (value) {
                              setState(() {
                                pickupLocation = value;
                              });
                            }),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Pickup Date :'.tr,
                              style: kFormLabelStyle,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            MaterialButton(
                              onPressed: () async {
                                picker.NepaliDateTime? newDate =
                                    await picker.showMaterialDatePicker(
                                  context: context,
                                  initialDate: NepaliDateTime.now(),
                                  firstDate: NepaliDateTime.now(),
                                  lastDate: NepaliDateTime(2090),
                                  initialDatePickerMode: DatePickerMode.day,
                                );

                                if (newDate != null) {
                                  setState(() {
                                    _date = newDate;
                                  });
                                }
                              },
                              height: 50,
                              child: Text(_date != null
                                  ? _date
                                      .toString()
                                      .replaceAll('00:00:00.000', '')
                                  : 'Enter your pickup date'.tr),
                              color: kThemeColor,
                              textColor: Colors.white,
                              minWidth: double.infinity,
                            ),
                          ],
                        ),
                        InputField(
                            label: 'Destination Location'.tr,
                            validation: (val) => val!.isEmpty
                                ? 'Enter your destination location'.tr
                                : null,
                            placeholder: 'Enter your destination location'.tr,
                            onChange: (value) {
                              setState(() {
                                destination = value;
                              });
                            }),
                        InputField(
                            label: 'Booking Days'.tr,
                            otherDetails: '(Minimum booking is of 1 day)'.tr,
                            keyboard: TextInputType.number,
                            maxLength: 2,
                            validation: (val) => val!.isEmpty
                                ? 'Enter no. of days you want to book the vehicle for'
                                    .tr
                                : null,
                            placeholder:
                                'Enter no. of days you want to book the vehicle for'
                                    .tr,
                            onChange: (value) {
                              setState(() {
                                days = value;
                              });
                            }),
                        Text(
                          'Number of Trips :'.tr,
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
                                  '1 Trip includes: Pickup Location to Destination'
                                      .tr,
                              child: Text(
                                '1 Trip'.tr,
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
                                  '2 Trip includes: Pickup Location to Destination and again to Pickup Location'
                                      .tr,
                              child: Text(
                                '2 Trip'.tr,
                                style: TextStyle(fontSize: 15),
                              ),
                            ),
                          ],
                        ),
                        InputField(
                            label: 'Phone Number'.tr,
                            placeholder: 'Enter your phone number'.tr,
                            keyboard: TextInputType.phone,
                            maxLength: 10,
                            validation: (val) => val!.isEmpty
                                ? 'Enter your phone number'.tr
                                : null,
                            value: phoneNumber!.replaceAll('+977', ''),
                            onChange: (value) {
                              setState(() {
                                phoneNumber = value;
                              });
                            }),
                        InputField(
                            label: 'Email'.tr,
                            keyboard: TextInputType.emailAddress,
                            otherDetails: '(Optional)'.tr,
                            value: email,
                            placeholder: 'Enter your email'.tr,
                            onChange: (value) {
                              setState(() {
                                email = value;
                              });
                            }),
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
                                    'Check this if you want to make an emergency booking!'
                                        .tr,
                                child: Text(
                                  'Emergency Booking'.tr,
                                  style: TextStyle(fontSize: 15),
                                )),
                          ],
                        ),
                        YatayatButton(
                            label: 'Confirm Booking'.tr,
                            onClick: () async {
                              print(phoneNumber);
                              if (_formKey.currentState!.validate()) {
                                if (tripSelected == '') {
                                  ShowSnackBar().error(
                                      'Select number of trips'.tr, context);
                                } else if (_date == null) {
                                  ShowSnackBar().error(
                                      'Choose a pickup date'.tr, context);
                                } else if (phoneNumber!.length < 10) {
                                  ShowSnackBar().error(
                                      'Phone number must be of 10 digits'.tr,
                                      context);
                                } else if (vehicleType.toString() == '') {
                                  ShowSnackBar().error(
                                      'Select a vehicle you want to book'.tr,
                                      context);
                                } else {
                                  try {
                                    //Save in the db
                                    await Database(uid: currentUser!.uid)
                                        .createNewBooking(
                                            name: name,
                                            vehicleType: vehicleType.toString(),
                                            pickupLocation: pickupLocation,
                                            pickupDate: _date
                                                .toString()
                                                .replaceAll('00:00:00.000', ''),
                                            destinationLocation: destination,
                                            noOfDays: days,
                                            noOfTrips: tripSelected,
                                            phoneNumber: phoneNumber,
                                            email: email,
                                            icon: icon,
                                            emergencyBooking:
                                                isEmergencyBooking);

//Create notification of booking
                                    await Database(uid: currentUser.uid)
                                        .createNotification(
                                            title:
                                                'New Booking created successfully!'
                                                    .tr,
                                            body:
                                                'Your booking has been created successfully. To check the full details of your booking go to \'My Bookings\' screen. Soon, you will get a call from Yatayat regarding further details of your booking. Thanks for using Yatayat.'
                                                    .tr);

                                    Navigator.popAndPushNamed(
                                        context, BookingSuccess.id);
                                  } on FirebaseException catch (e) {
                                    ShowSnackBar()
                                        .error('${e.message}', context);
                                  }
                                }
                              }
                            })
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
  }
}
