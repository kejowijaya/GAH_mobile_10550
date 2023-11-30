import 'package:flutter/material.dart';
import 'package:gah_mobile_10550/login_screen.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:gah_mobile_10550/model/customer.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfileScreen> {
  String nama = '';
  String email = '';
  String password = '';
  String nomorTelepon = '';
  String alamat = '';
  String noIdentitas = '';
  TextEditingController emailC = TextEditingController();
  TextEditingController passwordC = TextEditingController();
  TextEditingController namaC = TextEditingController();
  TextEditingController nomorTeleponC = TextEditingController();
  TextEditingController alamatC = TextEditingController();
  TextEditingController noIdentitasC = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchCustomer();
  }

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
    int id = await fetchLoggedInCustomerId();

    var url = Uri.parse('https://kejowijaya.com/backend/public/api/customer/$id');
    var response = await http.get(url);

    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      var item = jsonResponse['data'];
      var customer = Customer.fromJson(item);

      setState(() {
        emailC.text = customer.email;
        passwordC.text = customer.password;
        namaC.text = customer.nama;
        nomorTeleponC.text = customer.nomorTelepon;
        alamatC.text = customer.alamat;
        noIdentitasC.text = customer.noIdentitas;
      });
    } else {
      print('Gagal mendapatkan data. Status code: ${response.statusCode}');
    }
  }

  Future<void> update(String email, String password, String nama, String nomorTelepon, String alamat, String noIdentitas) async {
    final prefs = await SharedPreferences.getInstance();
    final id = prefs.getInt('id');
    print(id);

    final response = await http.put(
      Uri.parse('https://kejowijaya.com/backend/public/api/customer/$id'),
      body: {
        'email': email,
        'password': password,
        'nama': nama,
        'nomor_telepon': nomorTelepon,
        'alamat': alamat,
        'jenis_tamu': 'personal',
        'no_identitas': noIdentitas,
      },
    );
    if (response.statusCode == 200) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
      Fluttertoast.showToast(
          msg: "Edit Profile Berhasil",
          toastLength: Toast.LENGTH_SHORT,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.greenAccent,
          textColor: Colors.black,
          fontSize: 16.0
      );
    } else {
      Fluttertoast.showToast(
          msg: "Edit Profile Gagal",
          toastLength: Toast.LENGTH_SHORT,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.redAccent,
          textColor: Colors.black,
          fontSize: 16.0
      );
      print('Gagal dengan kode status: ${response.statusCode}');
      print('Pesan kesalahan: ${response.body}');
    }
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  width: 331,
                  child: Text(
                    'Edit Profile',
                    style: TextStyle(
                      color: Color(0xFF1E232C),
                      fontSize: 30,
                      fontWeight: FontWeight.w700,
                      letterSpacing: -0.20,
                    ),
                  ),
                ),
                SizedBox(height: 30),
                Container(
                  width: 351,
                  height: 56,
                  child: TextFormField(
                    controller: namaC,
                    decoration: InputDecoration(
                      hintText: 'Nama',
                      focusColor: Color(0xFFF7F8F9),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(width: 1, color: Color(0xFFE8ECF4)),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  width: 351,
                  height: 56,
                  child: TextFormField(
                    controller: nomorTeleponC,
                    decoration: InputDecoration(
                      hintText: 'Nomor Telepon',
                      focusColor: Color(0xFFF7F8F9),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(width: 1, color: Color(0xFFE8ECF4)),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  width: 351,
                  height: 56,
                  child: TextFormField(
                    controller: alamatC,
                    decoration: InputDecoration(
                      hintText: 'Alamat',
                      focusColor: Color(0xFFF7F8F9),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(width: 1, color: Color(0xFFE8ECF4)),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  width: 351,
                  height: 56,
                  child: TextFormField(
                    controller: emailC,
                    decoration: InputDecoration(
                      hintText: 'Email',
                      focusColor: Color(0xFFF7F8F9),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(width: 1, color: Color(0xFFE8ECF4)),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  width: 351,
                  height: 56,
                  child: TextFormField(
                    obscureText: true,
                    controller: passwordC,
                    decoration: InputDecoration(
                      hintText: 'Password',
                      focusColor: Color(0xFFF7F8F9),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(width: 1, color: Color(0xFFE8ECF4)),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  width: 351,
                  height: 56,
                  child: TextFormField(
                    controller: noIdentitasC,
                    decoration: InputDecoration(
                      hintText: 'Nomor Identitas',
                      focusColor: Color(0xFFF7F8F9),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(width: 1, color: Color(0xFFE8ECF4)),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                    ),
                  ),
                ),
                SizedBox(height: 50),
                Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(331, 56),
                      backgroundColor: Color(0xFF1E232C),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    onPressed: () {
                      update(emailC.text, passwordC.text, namaC.text, nomorTeleponC.text, alamatC.text, noIdentitasC.text);
                    },
                    child: Text('Update'),
                  ),
                ),
              ],
            ),
          ),
        )
    );
  }
}