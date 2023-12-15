import 'package:flutter/material.dart';
import 'package:gah_mobile_10550/kamar_tersedia.dart';
import 'package:gah_mobile_10550/profile_screen.dart';
import 'package:gah_mobile_10550/riwayat_reservasi.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:gah_mobile_10550/theme/color.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 5, bottom: 10),
        child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 50, 15, 10),
              child: Text(
                "Welcome to Grand Atma Hotel",
                style: TextStyle(
                color: AppColor.textColor,
                fontWeight: FontWeight.w600,
                fontSize: 24,
              ),
            ),
          ),
        const SizedBox(
        height: 10,
        ),
        Container(
          width: 347,
          height: 52,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(width: 1, color: Color(0xFFD6D6D6)),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.search,
                    color: Color(0xFF878787),
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Search',
                    style: TextStyle(
                      color: Color(0xFF878787),
                      fontSize: 14,
                      fontFamily: 'Plus Jakarta Sans',
                      fontWeight: FontWeight.w500,
                      height: 1.0,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 25, 15, 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Featured",
                  style: TextStyle(
                    color: AppColor.textColor,
                    fontWeight: FontWeight.w500,
                    fontSize: 22,
                  ),
                ),
              ],
            ),
          ),


        const SizedBox(
        height: 15,
        ),
        Padding(
        padding: EdgeInsets.fromLTRB(15, 0, 15, 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
              "Facilities",
              style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
        ],
        ),
    ),
      bottomNavigationBar: BottomNavigationBar(
      currentIndex: _currentIndex,
      backgroundColor: Colors.white,
      selectedItemColor: Colors.black,
      unselectedItemColor: Colors.blue,
      onTap: (int index) {
        if (index == 0) {
          Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
        } else if (index == 1) {
          Navigator.push(context, MaterialPageRoute(builder: (context) => RiwayatReservasi()));
        } else if (index == 2) {
          Navigator.push(context, MaterialPageRoute(builder: (context) => AvailableRoomsScreen()));
        } else if (index == 3) {
        Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileScreen()));
        }
      },
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.bookmark),
          label: 'Reservation',
        ),

        BottomNavigationBarItem(
          icon: Icon(Icons.bed),
          label: 'Kamar',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profile',
        ),
      ],
    ),
    );
  }



}