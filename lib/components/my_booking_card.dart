import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:yatayat/components/vehicle_card.dart';
import 'package:yatayat/shared/constants.dart';
import 'package:get/get.dart';

class MyBookingCard extends StatefulWidget {
  final String vehicleType;
  final String date;
  final String icon;
  final String? status;
  final void Function()? onClick;
  final String bookingId;

  MyBookingCard(
      {required this.vehicleType,
      required this.date,
      required this.status,
      required this.icon,
      required this.bookingId,
      this.onClick});

  @override
  State<MyBookingCard> createState() => _MyBookingCardState();
}

class _MyBookingCardState extends State<MyBookingCard> {
  bool vehicleAvailable = false;

  @override
  Widget build(BuildContext context) {
    FirebaseFirestore.instance
        .collection('biddings')
        .where('bookingId', isEqualTo: widget.bookingId)
        .get()
        .then((QuerySnapshot querySnapshot) {
      if (querySnapshot.docs.length > 0 && widget.status == 'Pending') {
        setState(() {
          vehicleAvailable = true;
        });
      } else {
        setState(() {
          vehicleAvailable = false;
        });
      }
    });

    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: widget.onClick,
              child: Container(
                height: 80,
                decoration: BoxDecoration(
                  boxShadow: [kBoxShadow],
                  color: widget.status == 'Pending'
                      ? kThemeColor
                      : widget.status == 'Cancelled'
                          ? Colors.red[900]
                          : widget.status == 'Processed'
                              ? Colors.black
                              : widget.status == 'Confirmed'
                                  ? Colors.green[900]
                                  : Colors.white,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.70,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Vehicle Type: '.tr + '${widget.vehicleType}',
                              style: kBookingTextStyle.copyWith(
                                  color: widget.status != 'Completed'
                                      ? Colors.white
                                      : Colors.black),
                            ),
                            Text(
                              'Date: '.tr + '${widget.date}',
                              style: kBookingTextStyle.copyWith(
                                  color: widget.status != 'Completed'
                                      ? Colors.white
                                      : Colors.black),
                            ),
                            Text(
                              'Status: '.tr +
                                  '${widget.status}' +
                                  '${vehicleAvailable ? ' ( VEHICLES AVAILABLE ! )' : ' '} ',
                              style: kBookingTextStyle.copyWith(
                                  color: widget.status != 'Completed'
                                      ? Colors.white
                                      : Colors.black),
                            ),
                          ],
                        ),
                      ),
                    ),
                    VehicleCard(
                      iconPath: 'assets/images/icons/${widget.icon}.png',
                      lable: '${widget.vehicleType.characters.take(11)}',
                      booking: true,
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
