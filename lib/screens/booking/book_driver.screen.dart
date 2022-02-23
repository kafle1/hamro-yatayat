import 'package:flutter/material.dart';
import 'package:yatayat/components/appbar.dart';
import 'package:get/get.dart';
import 'package:yatayat/components/snackbar.dart';
import 'package:yatayat/services/database.dart';
import 'package:yatayat/shared/constants.dart';

class BookDriver extends StatefulWidget {
  const BookDriver({Key? key}) : super(key: key);

  static const id = 'bookDriver';

  @override
  _BookDriverState createState() => _BookDriverState();
}

class _BookDriverState extends State<BookDriver> {
  final TextEditingController _companyNameCtrl = TextEditingController();
  final TextEditingController _companyAddressCtrl = TextEditingController();
  final TextEditingController _companyNumberCtrl = TextEditingController();
  final TextEditingController _bookingDaysCtrl = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final _formKey2 = GlobalKey<FormState>();
  final _formKey3 = GlobalKey<FormState>();
  final _formKey4 = GlobalKey<FormState>();

  String? _numberError;
  String? _bookingDaysError;

  bool showSpinner = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: YatayatAppbar(
        height: 60,
        title: Text('Book Driver'.tr),
      ),
      body: showSpinner
          ? Center(
              child: CircularProgressIndicator(
                color: kThemeColor,
                backgroundColor: Colors.white,
              ),
            )
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    Text(
                      'Enter required details to book a driver.'.tr,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Form(
                      key: _formKey,
                      child: TextField(
                        controller: _companyNameCtrl,
                        decoration: InputDecoration(
                          hintText: 'Enter Company Name'.tr,
                          labelText: 'Company Name'.tr,
                          errorMaxLines: 3,
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.business),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Form(
                      key: _formKey2,
                      child: TextField(
                        controller: _companyNumberCtrl,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: 'Enter Your Phone Number'.tr,
                          labelText: 'Phone Number'.tr,
                          errorText: _numberError,
                          errorMaxLines: 3,
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.phone),
                        ),
                        maxLength: 10,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Form(
                      key: _formKey3,
                      child: TextField(
                        controller: _companyAddressCtrl,
                        decoration: InputDecoration(
                          hintText: 'Enter Company\'s Address'.tr,
                          labelText: 'Address'.tr,
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.place),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Form(
                      key: _formKey4,
                      child: TextField(
                        keyboardType: TextInputType.number,
                        controller: _bookingDaysCtrl,
                        decoration: InputDecoration(
                          hintText: 'Enter Number of Booking Days'.tr,
                          labelText: 'Booking Days'.tr,
                          errorMaxLines: 3,
                          errorText: _bookingDaysError,
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.calendar_today),
                        ),
                        maxLength: 2,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      width: double.infinity,
                      height: 55,
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                            primary: Colors.green[900]),
                        onPressed: () {
                          if (_companyNumberCtrl.text.isEmpty) {
                            setState(() {
                              _numberError = 'Enter Valid Phone Number'.tr;
                            });
                          } else {
                            setState(() {
                              _numberError = null;
                            });
                          }
                          if (_bookingDaysCtrl.text.isEmpty) {
                            setState(() {
                              _bookingDaysError =
                                  'Booking Days Cannot be Empty'.tr;
                            });
                          } else {
                            _bookingDaysError = null;
                          }
                          if (_numberError == null &&
                              _bookingDaysError == null) {
                            //Save it to db
                            setState(() {
                              showSpinner = true;
                            });
                            Database.createDriverBooking(
                                    name: _companyNameCtrl.text,
                                    number: _companyNumberCtrl.text,
                                    address: _companyAddressCtrl.text,
                                    bookingDays: _bookingDaysCtrl.text)
                                .then((value) {
                              setState(() {
                                showSpinner = false;
                              });
                              Navigator.pop(context);
                              ShowSnackBar().success(
                                  'Driver Booked Successfully. You will get a detailed call about this booking from Yatayat. Thank you for booking !!'
                                      .tr,
                                  context);
                            });
                          }
                        },
                        icon: Icon(Icons.check),
                        label: Text(
                          'Book Driver'.tr,
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
