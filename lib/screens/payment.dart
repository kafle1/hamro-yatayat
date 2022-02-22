import 'package:flutter/material.dart';
import 'package:yatayat/shared/constants.dart';

class PaymentMethod extends StatefulWidget {
  const PaymentMethod({Key? key}) : super(key: key);
  static const id = 'paymentMethod';

  @override
  _PaymentMethodState createState() => _PaymentMethodState();
}

class _PaymentMethodState extends State<PaymentMethod> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment Method (भुक्तानी विधि)'),
        backgroundColor: kThemeColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '१. तलको Qr Code स्क्यान (Scan) गर्नुहोस र तपाइलाई सजिलो लाग्ने डिजिटल भुक्तानी मध्यम जस्तै Esewa, Khalti, Phone Pay, Ime Pay आदि बाट बाँकी रहेको रकम तिर्नुहोस ।',
              style: TextStyle(color: kThemeColor, fontSize: 15),
            ),
            Align(
              alignment: Alignment.center,
              child: Image(
                image: AssetImage('./assets/images/qrCode.jpg'),
                height: 200,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              '२. तलको बैंक खातामा बाँकी रकम तिर्नुहोस ।',
              style: TextStyle(color: kThemeColor, fontSize: 15),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'A/C Holder Name: Nischal Kafle \nAccount Number: 08501606630690000001 \nBank Name: Nepal Bank Limited',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              '3. तलको Esewa ID मा राकम तिर्नुहोस ।',
              style: TextStyle(color: kThemeColor, fontSize: 15),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Name: Nischal Kafle \nEsewa ID: 9860461944',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
          ],
        ),
      ),
    );
  }
}
