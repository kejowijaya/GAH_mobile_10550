import 'package:flutter/material.dart';
import 'package:gah_mobile_10550/login_screen.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GantiPassword extends StatefulWidget {
  const GantiPassword({Key? key}) : super(key: key);

  @override
  _GantiPasswordState createState() => _GantiPasswordState();
}

class _GantiPasswordState extends State<GantiPassword> {
  String email = '';
  TextEditingController passwordBaru = TextEditingController();
  TextEditingController emailC = TextEditingController();

  Future<void> gantiPassword(String passwordBaru) async {
    final prefs = await SharedPreferences.getInstance();
    email = emailC.text;

    final response = await http.post(
      Uri.parse('https://kejowijaya.com/backend/public/api/changePassword/$email'),
      body: {
        'password': passwordBaru,
      },
    );
    if (response.statusCode == 200) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
      Fluttertoast.showToast(
          msg: "Ganti Password Berhasil",
          toastLength: Toast.LENGTH_SHORT,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.greenAccent,
          textColor: Colors.black,
          fontSize: 16.0
      );
    } else {
      Fluttertoast.showToast(
          msg: "Ganti Password Gagal",
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
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(20),
        child: Center(
          child: Column(
            children:[
              SizedBox(height: 50),
              TextFormField(
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
              SizedBox(height: 20),
              TextFormField(
                obscureText: true,
                controller: passwordBaru,
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
              SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(331, 56),
                    backgroundColor: Color(0xFF1E232C),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  onPressed: () {
                    gantiPassword(passwordBaru.text);
                  },
                  child: Text('Change Password'),
                ),
              ),
            ],
          ),
        )

      ),
    );
  }
}
