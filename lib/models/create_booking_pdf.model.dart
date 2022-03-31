import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart' show rootBundle;

import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:yatayat/models/mobile.model.dart';

Future<void> createPdf(Map data) async {
  PdfDocument document = PdfDocument();
  final page = document.pages.add();

//Heading
  page.graphics.drawString('Hamro Yatayat Booking Details',
      PdfStandardFont(PdfFontFamily.helvetica, 20, style: PdfFontStyle.bold));
  page.graphics.drawString(
    '${data['status']}',
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

  //Vehicle Details
  page.graphics.drawString(
    'Driver and Vehicle Details :',
    PdfStandardFont(PdfFontFamily.helvetica, 15, style: PdfFontStyle.bold),
    bounds: Rect.fromLTWH(0, 310, 0, 0),
  );

  page.graphics.drawString(
    data['driverName'] != null
        ? 'Driver\'s Name: ${data['driverName']}'
        : 'Driver\'s Name: ---',
    PdfStandardFont(
      PdfFontFamily.helvetica,
      13,
    ),
    bounds: Rect.fromLTWH(0, 340, 0, 0),
  );
  page.graphics.drawString(
    data['driverNumber'] != null
        ? 'Driver\'s Phone Number: ${data['driverNumber']}'
        : 'Driver\'s Phone Number: ---',
    PdfStandardFont(
      PdfFontFamily.helvetica,
      13,
    ),
    bounds: Rect.fromLTWH(0, 360, 0, 0),
  );
  page.graphics.drawString(
    data['vehicleId'] != null
        ? 'Vehicle ID: ${data['vehicleId']}'
        : 'Vehicle ID: ---',
    PdfStandardFont(
      PdfFontFamily.helvetica,
      13,
    ),
    bounds: Rect.fromLTWH(0, 380, 0, 0),
  );

  page.graphics.drawString(
    data['vehicleNumber'] != null
        ? 'Vehicle Number: ${data['vehicleNumber']}'
        : 'Vehicle Number: ---',
    PdfStandardFont(
      PdfFontFamily.helvetica,
      13,
    ),
    bounds: Rect.fromLTWH(0, 400, 0, 0),
  );
  page.graphics.drawString(
    data['paymentStatus'] != null
        ? 'Payment Status: ${data['paymentStatus']}'
        : 'Payment Status: ---',
    PdfStandardFont(PdfFontFamily.helvetica, 13, style: PdfFontStyle.bold),
    bounds: Rect.fromLTWH(0, 420, 0, 0),
  );

  page.graphics.drawString(
    'Pricing: ',
    PdfStandardFont(PdfFontFamily.helvetica, 13, style: PdfFontStyle.bold),
    bounds: Rect.fromLTWH(0, 440, 0, 0),
  );

  page.graphics.drawString(
    data['amount'] != null
        ? 'Fare: Rs. ${double.parse(data['amount']) * 100 / 102.5}'
        : '---',
    PdfStandardFont(
      PdfFontFamily.helvetica,
      13,
    ),
    bounds: Rect.fromLTWH(0, 460, 0, 0),
  );
  page.graphics.drawString(
    data['amount'] != null
        ? 'Hamro Yatayat Charge (2.5%): Rs. ${2.5 / 100 * (double.parse(data['amount']) * 100 / 102.5)}'
        : '---',
    PdfStandardFont(
      PdfFontFamily.helvetica,
      13,
    ),
    bounds: Rect.fromLTWH(0, 480, 0, 0),
  );
  page.graphics.drawString(
    data['amount'] != null ? 'Total Amount: Rs. ${data['amount']}' : '---',
    PdfStandardFont(
      PdfFontFamily.helvetica,
      13,
    ),
    bounds: Rect.fromLTWH(0, 500, 0, 0),
  );

  //Make Payment
  page.graphics.drawString(
    'Payment Options:',
    PdfStandardFont(PdfFontFamily.helvetica, 15, style: PdfFontStyle.bold),
    bounds: Rect.fromLTWH(0, 530, 0, 0),
  );
  page.graphics.drawString(
    '1. Scan the Qr Code below and pay the amount from digital payment medium like \nEsewa (Esewa Id: 9845807600), Khalti, Phone Pay, Ime Pay etc.',
    PdfStandardFont(
      PdfFontFamily.helvetica,
      13,
    ),
    bounds: Rect.fromLTWH(0, 555, 0, 0),
  );
  page.graphics.drawString(
    '2. Pay the amount in the bank account below: \nA/C Holder Name: Nischal Kafle \nAccount Number: 08501606630690000001 \nBank Name: Nepal Bank Limited',
    PdfStandardFont(
      PdfFontFamily.helvetica,
      13,
    ),
    bounds: Rect.fromLTWH(0, 595, 0, 0),
  );
  page.graphics.drawString(
    '3. Pay the amount to the driver.',
    PdfStandardFont(
      PdfFontFamily.helvetica,
      13,
    ),
    bounds: Rect.fromLTWH(0, 670, 0, 0),
  );
  page.graphics.drawImage(PdfBitmap(await _readImageData('qrCode.jpg')),
      Rect.fromLTWH(370, 590, 120, 120));

  //Footer
  page.graphics.drawString(
    'Hamro Yatayat | Nawalpur, Chitwan  | 9829490671',
    PdfStandardFont(
      PdfFontFamily.helvetica,
      12,
    ),
    bounds: Rect.fromLTWH(110, 740, 0, 0),
  );

  List<int> bytes = document.save();
  document.dispose();

  saveAndLaunchFile(bytes, 'hamro-yatayat-booking-${data['bookingId']}.pdf');
}

Future<Uint8List> _readImageData(String name) async {
  final data = await rootBundle.load('assets/images/$name');
  return data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
}
