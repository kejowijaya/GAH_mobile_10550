import 'package:flutter/material.dart';
import 'package:gah_mobile_10550/login_screen.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<RegisterScreen> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController nama = TextEditingController();
  TextEditingController nomorTelepon = TextEditingController();
  TextEditingController alamat = TextEditingController();
  TextEditingController noIdentitas = TextEditingController();

  Future<void> register(String email, String password, String nama, String nomorTelepon, String alamat, String noIdentitas) async {
    final response = await http.post(
      Uri.parse('https://kejowijaya.com/backend/public/api/register'),
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
          msg: "Register Berhasil",
          toastLength: Toast.LENGTH_SHORT,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.greenAccent,
          textColor: Colors.black,
          fontSize: 16.0
      );
    } else {
      Fluttertoast.showToast(
          msg: "Register Gagal",
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
                  'Hello! Register to get started',
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
                  controller: nama,
                  decoration: InputDecoration(
                    hintText: 'Nama',
                    focusColor: Color(0xFFF7F8F9),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(width: 1, color: Color(0xFFE8ECF4)),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                  ),
                  // Other properties for the TextField can be added here
                ),
              ),
              SizedBox(height: 20),
              Container(
                width: 351,
                height: 56,
                child: TextFormField(
                  controller: nomorTelepon,
                  decoration: InputDecoration(
                    hintText: 'Nomor Telepon',
                    focusColor: Color(0xFFF7F8F9),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(width: 1, color: Color(0xFFE8ECF4)),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                  ),
                  // Other properties for the TextField can be added here
                ),
              ),
              SizedBox(height: 20),
              Container(
                width: 351,
                height: 56,
                child: TextFormField(
                  controller: alamat,
                  decoration: InputDecoration(
                    hintText: 'Alamat',
                    focusColor: Color(0xFFF7F8F9),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(width: 1, color: Color(0xFFE8ECF4)),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                  ),
                  // Other properties for the TextField can be added here
                ),
              ),
              SizedBox(height: 20),
              Container(
                width: 351,
                height: 56,
                child: TextFormField(
                  controller: email,
                  decoration: InputDecoration(
                    hintText: 'Email',
                    focusColor: Color(0xFFF7F8F9),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(width: 1, color: Color(0xFFE8ECF4)),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                  ),
                  // Other properties for the TextField can be added here
                ),
              ),
              SizedBox(height: 20),
              Container(
                width: 351,
                height: 56,
                child: TextFormField(
                  obscureText: true,
                  controller: password,
                  decoration: InputDecoration(
                    hintText: 'Password',
                    focusColor: Color(0xFFF7F8F9),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(width: 1, color: Color(0xFFE8ECF4)),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                  ),
                  // Other properties for the TextField can be added here
                ),
              ),
              SizedBox(height: 20),
              Container(
                width: 351,
                height: 56,
                child: TextFormField(
                  controller: noIdentitas,
                  decoration: InputDecoration(
                    hintText: 'Nomor Identitas',
                    focusColor: Color(0xFFF7F8F9),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(width: 1, color: Color(0xFFE8ECF4)),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                  ),
                  // Other properties for the TextField can be added here
                ),
              ),
              SizedBox(height: 50),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(351, 56),
                    backgroundColor: Color(0xFF1E232C),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  onPressed: () {
                    register(email.text, password.text, nama.text, nomorTelepon.text, alamat.text, noIdentitas.text);
                  },
                  child: Text('Register'),
                ),
              ),
            ],
          ),
        ),
      )
    );
  }
  }