import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart' show rootBundle;

import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:yatayat/models/mobile.dart';

Future<void> createPdf(Map data) async {
  PdfDocument document = PdfDocument();
  final page = document.pages.add();

//Heading
  page.graphics.drawString('Yatayat Booking Details',
      PdfStandardFont(PdfFontFamily.helvetica, 20, style: PdfFontStyle.bold));
  page.graphics.drawString(
    'Pending',
    PdfStandardFont(PdfFontFamily.helvetica, 15, style: PdfFontStyle.bold),
    bounds: Rect.fromLTWH(0, 30, 0, 0),
  );

  //Left Details
  page.graphics.drawString(
    'Name: ${data['name']}',
    PdfStandardFont(
      PdfFontFamily.helvetica,
      13,
    ),
    bounds: Rect.fromLTWH(0, 80, 0, 0),
  );
  page.graphics.drawString(
    data['email'] != null ? 'Email: ${data['email']}' : 'Email: ---',
    PdfStandardFont(
      PdfFontFamily.helvetica,
      13,
    ),
    bounds: Rect.fromLTWH(0, 100, 0, 0),
  );
  page.graphics.drawString(
    'Phone Number: ${data['phoneNumber']}',
    PdfStandardFont(
      PdfFontFamily.helvetica,
      13,
    ),
    bounds: Rect.fromLTWH(0, 120, 0, 0),
  );
  page.graphics.drawString(
    'Vehicle Type: ${data['vehicleType']}',
    PdfStandardFont(
      PdfFontFamily.helvetica,
      13,
    ),
    bounds: Rect.fromLTWH(0, 140, 0, 0),
  );

//Yatayat Logo
  page.graphics.drawImage(PdfBitmap(await _readImageData('logo.png')),
      Rect.fromLTWH(440, 0, 65, 65));

//Right Details
  page.graphics.drawString(
    'Booking ID: ${data['bookingId']}',
    PdfStandardFont(
      PdfFontFamily.helvetica,
      13,
    ),
    bounds: Rect.fromLTWH(320, 80, 0, 0),
  );
  page.graphics.drawString(
    'Booking Date: ${data['bookingDate']}',
    PdfStandardFont(
      PdfFontFamily.helvetica,
      13,
    ),
    bounds: Rect.fromLTWH(320, 100, 0, 0),
  );
  page.graphics.drawString(
    'Status: ${data['status']}',
    PdfStandardFont(
      PdfFontFamily.helvetica,
      13,
    ),
    bounds: Rect.fromLTWH(320, 120, 0, 0),
  );
  page.graphics.drawString(
    'Payment Status: ${data['paymentStatus']}',
    PdfStandardFont(
      PdfFontFamily.helvetica,
      13,
    ),
    bounds: Rect.fromLTWH(320, 140, 0, 0),
  );

  //Other details
  page.graphics.drawString(
    'Other Details :',
    PdfStandardFont(PdfFontFamily.helvetica, 15, style: PdfFontStyle.bold),
    bounds: Rect.fromLTWH(0, 170, 0, 0),
  );

  page.graphics.drawString(
    'Pickup Location: ${data['pickupLocation']}',
    PdfStandardFont(
      PdfFontFamily.helvetica,
      13,
    ),
    bounds: Rect.fromLTWH(0, 200, 0, 0),
  );
  page.graphics.drawString(
    'Pickup Date: ${data['pickupDate']}',
    PdfStandardFont(
      PdfFontFamily.helvetica,
      13,
    ),
    bounds: Rect.fromLTWH(0, 220, 0, 0),
  );
  page.graphics.drawString(
    'No of trips: ${data['noOfTrips']}',
    PdfStandardFont(
      PdfFontFamily.helvetica,
      13,
    ),
    bounds: Rect.fromLTWH(0, 240, 0, 0),
  );
  page.graphics.drawString(
    'Destination: ${data['destinationLocation']}',
    PdfStandardFont(
      PdfFontFamily.helvetica,
      13,
    ),
    bounds: Rect.fromLTWH(0, 260, 0, 0),
  );
  page.graphics.drawString(
    'Days of Booking: ${data['noOfDays']}',
    PdfStandardFont(
      PdfFontFamily.helvetica,
      13,
    ),
    bounds: Rect.fromLTWH(0, 280, 0, 0),
  );
  page.graphics.drawString(
    data['isEmergency'] ? 'Booking Type: Emergency' : 'Booking Type: Normal',
    PdfStandardFont(PdfFontFamily.helvetica, 13, style: PdfFontStyle.bold),
    bounds: Rect.fromLTWH(0, 300, 0, 0),
  );

  //Vehicle Details
  page.graphics.drawString(
    'Driver and Vehicle Details :',
    PdfStandardFont(PdfFontFamily.helvetica, 15, style: PdfFontStyle.bold),
    bounds: Rect.fromLTWH(0, 340, 0, 0),
  );

  page.graphics.drawString(
    data['driverName'] != null
        ? 'Driver\'s Name: ${data['diverName']}'
        : 'Driver\'s Name: ---',
    PdfStandardFont(
      PdfFontFamily.helvetica,
      13,
    ),
    bounds: Rect.fromLTWH(0, 370, 0, 0),
  );
  page.graphics.drawString(
    data['driverNumber'] != null
        ? 'Driver\'s Phone Number: ${data['driverNumber']}'
        : 'Driver\'s Phone Number: ---',
    PdfStandardFont(
      PdfFontFamily.helvetica,
      13,
    ),
    bounds: Rect.fromLTWH(0, 390, 0, 0),
  );
  page.graphics.drawString(
    data['vehicleId'] != null
        ? 'Vehicle ID: ${data['vehicleId']}'
        : 'Vehicle ID: ---',
    PdfStandardFont(
      PdfFontFamily.helvetica,
      13,
    ),
    bounds: Rect.fromLTWH(0, 410, 0, 0),
  );

  page.graphics.drawString(
    data['vehicleNumber'] != null
        ? 'Vehicle Number: ${data['vehicleNumber']}'
        : 'Vehicle Number: ---',
    PdfStandardFont(
      PdfFontFamily.helvetica,
      13,
    ),
    bounds: Rect.fromLTWH(0, 430, 0, 0),
  );
  page.graphics.drawString(
    data['paymentStatus'] != null
        ? 'Payment Status: ${data['paymentStatus']}'
        : 'Payment Status: ---',
    PdfStandardFont(PdfFontFamily.helvetica, 13, style: PdfFontStyle.bold),
    bounds: Rect.fromLTWH(0, 450, 0, 0),
  );

  page.graphics.drawString(
    data['amount'] != null
        ? 'Total Amount: ${data['amount']}'
        : 'Total Amount: ---',
    PdfStandardFont(PdfFontFamily.helvetica, 13, style: PdfFontStyle.bold),
    bounds: Rect.fromLTWH(0, 470, 0, 0),
  );

  //Make Payment
  page.graphics.drawString(
    'Make Payment :',
    PdfStandardFont(PdfFontFamily.helvetica, 15, style: PdfFontStyle.bold),
    bounds: Rect.fromLTWH(0, 510, 0, 0),
  );
  page.graphics.drawImage(PdfBitmap(await _readImageData('qrCode.png')),
      Rect.fromLTWH(0, 530, 150, 150));

  //Footer
  page.graphics.drawString(
    'Yatayat | Kathmandu, Nepal  | 9861595869, 9860461944 | yatayatnep@gmail.com',
    PdfStandardFont(
      PdfFontFamily.helvetica,
      12,
    ),
    bounds: Rect.fromLTWH(45, 730, 0, 0),
  );

  List<int> bytes = document.save();
  document.dispose();

  saveAndLaunchFile(bytes, 'yatayatBookingDetails.pdf');
}

Future<Uint8List> _readImageData(String name) async {
  final data = await rootBundle.load('assets/images/$name');
  return data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
}
