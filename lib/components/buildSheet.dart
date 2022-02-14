import 'package:flutter/material.dart';
import 'package:yatayat/components/button.dart';
import 'package:yatayat/screens/booking/bookingDetails/booking_details_screen.dart';
import 'package:yatayat/screens/booking/booking_price_check.dart';
import 'package:yatayat/shared/constants.dart';

class BuildSheet extends StatefulWidget {
  final String docId;
  final Map data;
  const BuildSheet({Key? key, required this.docId, required this.data})
      : super(key: key);

  @override
  _BuildSheetState createState() => _BuildSheetState();
}

class _BuildSheetState extends State<BuildSheet> {
  @override
  Widget build(BuildContext context) {
    return makeDismissible(
      child: DraggableScrollableSheet(
        initialChildSize: 0.7,
        minChildSize: 0.3,
        builder: (_, controller) => Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(5))),
          padding: EdgeInsets.all(10),
          child: ListView(
            controller: controller,
            children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: 140),
                height: 7,
                decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(50)),
              ),
              SizedBox(
                height: 15,
              ),
              BookingPrice(
                docId: widget.docId,
                userData: widget.data,
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton.icon(
                    style:
                        TextButton.styleFrom(backgroundColor: Colors.red[900]),
                    onPressed: () {},
                    icon: Icon(
                      Icons.delete,
                      color: Colors.white,
                    ),
                    label: Text(
                      'Delete Booking',
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  TextButton.icon(
                    style: TextButton.styleFrom(
                      backgroundColor: kThemeColor,
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, BookingDetailsScreen.id,
                          arguments: widget.docId);
                    },
                    icon: Icon(
                      Icons.text_snippet,
                      color: Colors.white,
                    ),
                    label: Text(
                      'Booking Details',
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget makeDismissible({required Widget child}) => GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => Navigator.pop(context),
        child: GestureDetector(
          onTap: () {},
          child: child,
        ),
      );
}
