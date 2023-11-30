import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:gah_mobile_10550/widgets/NavBarGM.dart';
import 'package:gah_mobile_10550/laporan1.dart';

class Laporan2 extends StatefulWidget {
  @override
  _Laporan2State createState() => _Laporan2State();
}

class _Laporan2State extends State<Laporan2> {
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
    var url = Uri.parse('https://kejowijaya.com/backend/public/api/laporan4');
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('LAPORAN 5 CUSTOMER RESERVASI TERBANYAK'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
          Text(
            'LAPORAN 5 CUSTOMER RESERVASI TERBANYAK',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          SizedBox(height: 20),
            Scrollbar(
                thumbVisibility: true,
                trackVisibility: true,
                child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Center(
                  child: DataTable(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                    ),
                    columns: [
                      DataColumn(label: Text('No')),
                      DataColumn(label: Text('Nama Customer')),
                      DataColumn(label: Text('Jumlah Reservasi')),
                      DataColumn(label: Text('Total Pembayaran')),
                    ],
                    rows: data
                        .map(
                            (item) => DataRow(
                          cells: [
                            DataCell(Text(item['no'].toString())),
                            DataCell(Text(item['nama'])),
                            DataCell(
                              Center(
                                child: Text(
                                  item['jumlah_reservasi'].toString(),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                            DataCell(
                              Center(
                                child: Text(
                                  item['total_pembayaran'].toString(),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ],
                        )
                    ).toList(),
                  ),
                )
            )
            )


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
