import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:gah_mobile_10550/widgets/NavBarGM.dart';
import 'package:gah_mobile_10550/laporan2.dart';
import 'dart:typed_data';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class Laporan1 extends StatefulWidget {
  @override
  _Laporan1State createState() => _Laporan1State();
}

class _Laporan1State extends State<Laporan1> {
  List<Map<String, dynamic>> data = [];
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    getData();
  }


  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }



  Future<void> getData() async {
    var url = Uri.parse('https://kejowijaya.com/backend/public/api/laporan1');
    var response = await http.get(url);

    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      var items = jsonResponse['data'];

      List<Map<String, dynamic>> dataList = List.generate(items.length, (index) {
        return {
          ...items[index],
          'no': index + 1,
        };
      });

      setState(() {
        data = dataList;
      });
    } else {
      print('Gagal mendapatkan data. Status code: ${response.statusCode}');
    }
  }

  int getTotalJumlah() {
    List<int> jumlahCustomerList = data.map<int>((item) => item['jumlahCustomer'] as int).toList();

    return jumlahCustomerList.fold(0, (total, jumlahCustomer) => total + jumlahCustomer);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('LAPORAN CUSTOMER BARU'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'LAPORAN CUSTOMER BARU',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            Center(
              child: DataTable(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                ),
                columns: [
                  DataColumn(label: Text('No')),
                  DataColumn(label: Text('Bulan')),
                  DataColumn(label: Text('Jumlah')),
                ],
                rows: data
                    .map(
                      (item) => DataRow(
                    cells: [
                      DataCell(Text(item['no'].toString())),
                      DataCell(Text(item['bulan'])),
                      DataCell(
                        Center(
                          child: Text(
                          item['jumlahCustomer'].toString(),
                          textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ],
                  )
                ).toList(),
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Total Jumlah: ${getTotalJumlah()}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
      bottomNavigationBar: NavBarGM(
        currentIndex: _currentIndex,
        onTap: (int index) {
          if (index == 0) {
            Navigator.push(context, MaterialPageRoute(builder: (context) => Laporan1()));
          } else if (index == 1) {
            Navigator.push(context, MaterialPageRoute(builder: (context) => Laporan2()));
          }
        },
      ),
    );
  }
}
