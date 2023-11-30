import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gah_mobile_10550/edit_profile_screen.dart';
import 'package:gah_mobile_10550/login_screen.dart';
import 'package:gah_mobile_10550/theme/color.dart';
import 'package:gah_mobile_10550/utils/data.dart';
import 'package:gah_mobile_10550/widgets/custom_image.dart';
import 'package:gah_mobile_10550/widgets/icon_box.dart';
import 'package:gah_mobile_10550/widgets/setting_item.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:gah_mobile_10550/model/customer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:gah_mobile_10550/riwayat_reservasi.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String nama = '';
  String email = '';
  String nomorTelepon = '';

  Future<int> fetchLoggedInCustomerId() async {
    final prefs = await SharedPreferences.getInstance();
    final _token = prefs.getString('token');

    var response = await http.get(
      Uri.parse('https://kejowijaya.com/backend/public/api/user'),
      headers: {
        'Authorization': 'Bearer $_token',
      },
    );

    if (response.statusCode == 200) {
      var userData = json.decode(response.body);
      var customerId = userData['id_customer'];

      return customerId;
    } else {
      print('Gagal mendapatkan data. Status code: ${response.statusCode}');
      return -1;
    }
  }

  Future<void> fetchCustomer() async {
    final prefs = await SharedPreferences.getInstance();
    final _id = prefs.getInt('id');

    var url = Uri.parse('https://kejowijaya.com/backend/public/api/customer/$_id');
    var response = await http.get(url);

    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      var item = jsonResponse['data'];
      var customer = Customer.fromJson(item);

      setState(() {
        nama = customer.nama;
        email = customer.email;
        nomorTelepon = customer.nomorTelepon;
      });
    } else {
      print('Gagal mendapatkan data. Status code: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.appBgColor,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: AppColor.appBgColor,
            elevation: 0,
            pinned: true,
            expandedHeight: 100,
            flexibleSpace: FlexibleSpaceBar(
              background: Padding(
                padding: EdgeInsets.only(right: 20, left: 20, top: 25),
                child: _buildAppBar(),
              )
            ),
          ),
          SliverToBoxAdapter(
            child: _buildBody(),
          ),
        ],
      ),
    );
  }

  Widget _buildAppBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Setting",
          style: TextStyle(
            color: AppColor.textColor,
            fontSize: 24,
            fontWeight: FontWeight.w600,
          ),
        ),
        IconBox(
          child: SvgPicture.asset(
            "images/pencil.svg",
            width: 24,
            height: 24,
          ),
          bgColor: AppColor.appBgColor,
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return EditProfileScreen();
            }));
          }
        ),
      ],
    );
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      padding: EdgeInsets.only(right: 20, left:20),
      child: Column(
        children: [
          _buildProfile(),
          const SizedBox(height: 40),
          SettingItem(
            title: "General Setting",
            leadingIcon: Icons.settings,
            leadingIconColor: AppColor.orange,
          ),
          const SizedBox(height: 10),
          SettingItem(
            title: "Bookings",
            leadingIcon: Icons.bookmark_border,
            leadingIconColor: AppColor.blue,
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return RiwayatReservasi();
              }));
            },
          ),
          const SizedBox(height: 10),
          SettingItem(
            title: "Log Out",
            leadingIcon: Icons.logout_outlined,
            leadingIconColor: Colors.grey.shade400,
            onTap: () {
              _showConfirmLogout();
            },
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }

  Widget _buildProfile() {
    fetchCustomer();
    return Padding(
      padding: EdgeInsets.only(left: 20),
      child: Column(
        children: <Widget>[
          CustomImage(
            profile["image"]!,
            width: 150,
            height: 150,
            radius: 100,
          ),
          const SizedBox(
            height: 12,
          ),
          Text(
            '$nama',
            style: TextStyle(
              color: AppColor.textColor,
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            '$email',
            style: TextStyle(
              color: AppColor.labelColor,
              fontSize: 15,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            '$nomorTelepon',
            style: TextStyle(
              color: AppColor.labelColor,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  _showConfirmLogout() {
    showCupertinoModalPopup(
      context: context,
      builder: (context) => CupertinoActionSheet(
        message: Text("Would you like to log out?"),
        actions: [
          CupertinoActionSheetAction(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return (LoginPage());
              }));
            },
            child: Text(
              "Log Out",
              style: TextStyle(color: AppColor.actionColor),
            ),
          )
        ],
        cancelButton: CupertinoActionSheetAction(
          child: Text("Cancel"),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
    );
  }
}