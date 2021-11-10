import 'package:flutter/material.dart';
import 'package:yatayat/components/vehicle_card.dart';
import 'package:yatayat/shared/constants.dart';
import 'package:get/get.dart';

class MyBookingCard extends StatelessWidget {
  final String vehicleType;
  final String date;
  final String icon;
  final String? status;
  final void Function()? onClick;

  MyBookingCard(
      {required this.vehicleType,
      required this.date,
      required this.status,
      required this.icon,
      this.onClick});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: onClick,
              child: Container(
                height: 80,
                decoration: BoxDecoration(
                  boxShadow: [kBoxShadow],
                  color: status == 'Pending' ? kThemeColor : Colors.white,
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
                              'Vehicle Type: '.tr + '$vehicleType',
                              style: kBookingTextStyle.copyWith(
                                  color: status == 'Pending'
                                      ? Colors.white
                                      : Colors.black),
                            ),
                            Text(
                              'Date: '.tr + '$date',
                              style: kBookingTextStyle.copyWith(
                                  color: status == 'Pending'
                                      ? Colors.white
                                      : Colors.black),
                            ),
                            Text(
                              'Status: '.tr + '$status',
                              style: kBookingTextStyle.copyWith(
                                  color: status == 'Pending'
                                      ? Colors.white
                                      : Colors.black),
                            ),
                          ],
                        ),
                      ),
                    ),
                    VehicleCard(
                      iconPath: 'assets/images/icons/$icon.png',
                      lable: '${vehicleType.characters.take(11)}',
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
