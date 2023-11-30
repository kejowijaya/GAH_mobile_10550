import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gah_mobile_10550/ganti_password.dart';
import 'package:gah_mobile_10550/home_screen.dart';
import 'package:gah_mobile_10550/register_screen.dart';
import 'package:gah_mobile_10550/laporan1.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  bool isPasswordVisible = false;
  String _token = '';
  String _role = '';
  int _id = 0;

  Future<String> login(String email, String password) async {
    final prefs = await SharedPreferences.getInstance();

    final response = await http.post(
      Uri.parse('https://kejowijaya.com/backend/public/api/login'),
      body: {
        'email': email,
        'password': password,
      },
    );
    print(response);
    if (response.statusCode == 200) {
      _token = json.decode(response.body)['token'];
      _id = json.decode(response.body)['customer']['id_customer'];
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
      Fluttertoast.showToast(
          msg: "Login Berhasil",
          toastLength: Toast.LENGTH_SHORT,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.greenAccent,
          textColor: Colors.black,
          fontSize: 16.0
      );
      await prefs.setString('token', _token);
      await prefs.setInt('id', _id);
      return _token;
    } else {
      Fluttertoast.showToast(
          msg: "Login Gagal",
          toastLength: Toast.LENGTH_SHORT,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.redAccent,
          textColor: Colors.black,
          fontSize: 16.0
      );
      print('Gagal dengan kode status: ${response.statusCode}');
      print('Pesan kesalahan: ${response.body}');
      throw Exception('Failed to login');
    }
  }

  Future<String> loginPegawai(String email, String password) async {
    final prefs = await SharedPreferences.getInstance();

    final response = await http.post(
      Uri.parse('https://kejowijaya.com/backend/public/api/loginPegawai'),
      body: {
        'email': email,
        'password': password,
      },
    );
    print(response);
    if (response.statusCode == 200) {
      _token = json.decode(response.body)['token'];
      _role = json.decode(response.body)['pegawai']['role'];
      _id = json.decode(response.body)['pegawai']['id_pegawai'];
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Laporan1()),
      );
      Fluttertoast.showToast(
          msg: "Login Berhasil",
          toastLength: Toast.LENGTH_SHORT,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.greenAccent,
          textColor: Colors.black,
          fontSize: 16.0
      );
      await prefs.setString('token', _token);
      await prefs.setString('role', _role);
      await prefs.setInt('id', _id);
      return _token;
    } else {
      Fluttertoast.showToast(
          msg: "Login Gagal",
          toastLength: Toast.LENGTH_SHORT,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.redAccent,
          textColor: Colors.black,
          fontSize: 16.0
      );
      print('Gagal dengan kode status: ${response.statusCode}');
      print('Pesan kesalahan: ${response.body}');
      throw Exception('Failed to login');
    }
  }

  @override
  Widget build(BuildContext context) {
      return Scaffold(
        body: SingleChildScrollView(
        child: Center(
          child: Container(
            width: MediaQuery.of(context).size.width * 0.9,
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 120),
                Center(
                    child: Image(
                      image: AssetImage('images/logo.png'),
                      fit: BoxFit.contain,
                      width: 200,
                    ),
                ),
                SizedBox(height: 80),
                TextFormField(
                  controller: email,
                  decoration: InputDecoration(
                      labelText: 'Email',
                    border: OutlineInputBorder()),
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: password,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                    suffixIcon: IconButton(
                      icon: Icon(
                        isPasswordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: Theme.of(context).primaryColorDark,
                      ),
                      onPressed: () {
                        setState(() {
                          isPasswordVisible = !isPasswordVisible;
                        });
                      },
                    ),
                  ),
                  obscureText: !isPasswordVisible,
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => GantiPassword()),
                      );
                    },
                    child: Text('Reset Password'),
                  ),
                ),
                SizedBox(height: 20),
                Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        minimumSize: Size(331, 56),
                        backgroundColor: Color(0xFF1E232C),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    onPressed: () {
                      login(email.text, password.text);
                      },
                    child: Text('Login'),
                  ),
                ),
                SizedBox(height: 10),
                Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(331, 56),
                      backgroundColor: Color(0xFF1E232C),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    onPressed: () {
                      loginPegawai(email.text, password.text);
                    },
                    child: Text('Login Pegawai'),
                  ),
                ),
                SizedBox(height: 70),
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                    Text(
                      'Belum punya akun ?',
                      style: TextStyle(
                        color: Color(0xFF878787),
                        fontSize: 14,
                        fontFamily: 'Plus Jakarta Sans',
                        fontWeight: FontWeight.w500,
                        height: 1.0,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => RegisterScreen()),
                        );
                      },
                      child: Text('Register sekarang'),
                    ),
                  ]
                ),
              ],
            ),
          ),
        ),
      ),
      );
  }
}
