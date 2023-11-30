import 'package:flutter/material.dart';
import 'package:gah_mobile_10550/detail_reservasi.dart';
import 'package:gah_mobile_10550/model/reservasi.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class RiwayatReservasi extends StatefulWidget {
  const RiwayatReservasi({Key? key}) : super(key: key);

  @override
  _RiwayatReservasiState createState() => _RiwayatReservasiState();
}

class _RiwayatReservasiState extends State<RiwayatReservasi> {
  late List<Reservasi> reservasiList = [];
  List<Reservasi> filteredReservasiList = [];
  TextEditingController searchController = TextEditingController();
  bool showCancelableOnly = false;

  @override
  void initState() {
    super.initState();
    getRiwayatReservasi();
  }

  void filterSearchResults(String query) {
    List<Reservasi> searchResults = reservasiList
        .where((reservasi) =>
        reservasi.idBooking.toString().toLowerCase().contains(query.toLowerCase()))
        .toList();

    setState(() {
      filteredReservasiList = showCancelableOnly
          ? searchResults
          .where((reservasi) =>
      reservasi.status == "Sudah DP" || reservasi.status == "Belum DP")
          .toList()
          : searchResults;
    });
  }

  void filterCancelableOnly() {
    setState(() {
      showCancelableOnly = !showCancelableOnly;
      filterSearchResults(searchController.text);
    });
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

  Future<void> getRiwayatReservasi() async {
    int id = await fetchLoggedInCustomerId();

    var url = Uri.parse('https://kejowijaya.com/backend/public/api/riwayatTransaksi/$id');
    var response = await http.get(url);

    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      var items = jsonResponse['data'] as List;
      setState(() {
        reservasiList = items.map((item) => Reservasi.fromJson(item)).toList();
        filteredReservasiList = reservasiList;
      });
    } else {
      print('Gagal mendapatkan data. Status code: ${response.statusCode}');
    }
  }

  Future<void> batalReservasi(int idReservasi) async {
    final confirmation = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Konfirmasi Pembatalan'),
          content: Text('Apakah anda yakin ingin membatalkan reservasi ini?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text('Tidak'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: Text('Ya'),
            ),
          ],
        );
      },
    );

    if (confirmation ?? false) {
      try {
        final response = await http.post(
          Uri.parse('https://kejowijaya.com/backend/public/api/batal/$idReservasi'),
          headers: {'Content-Type': 'application/json'},
        );

        if (response.statusCode == 200) {
          final responseData = json.decode(response.body);
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Pembatalan Berhasil'),
                content: Text(responseData['message']),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      getRiwayatReservasi();
                    },
                    child: Text('OK'),
                  ),
                ],
              );
            },
          );
        } else {
          final responseData = json.decode(response.body);
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Gagal Membatalkan Reservasi'),
                content: Text('Gagal membatalkan reservasi: ${responseData['message']}'),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text('OK'),
                  ),
                ],
              );
            },
          );
        }
      } catch (error) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Gagal Membatalkan Reservasi'),
              content: Text('Gagal membatalkan reservasi: $error'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Riwayat Reservasi'),
        actions: [
          IconButton(
            icon: Icon(showCancelableOnly ? Icons.filter_list_alt : Icons.filter_alt),
            onPressed: () {
              filterCancelableOnly();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: searchController,
              onChanged: (query) {
                filterSearchResults(query);
              },
              decoration: InputDecoration(
                labelText: 'Cari data reservasi',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(25.0)),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredReservasiList.length,
              itemBuilder: (context, index) {
                final Reservasi reservasi = filteredReservasiList[index];
                return InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) {
                      return DetailReservasiScreen(reservasi: reservasi);
                    }));
                  },
                  child: Card(
                    child: ListTile(
                      title: Text('Tanggal Booking: ${reservasi.idBooking}'),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('Check-In: ${reservasi.tanggalCheckIn}'),
                          Text('Check-Out: ${reservasi.tanggalCheckOut}'),
                          Text('Total Harga: ${reservasi.totalHarga.toString()}'),
                          Text('Status: ${reservasi.status}'),
                        ],
                      ),
                      trailing: showCancelableOnly
                          ? IconButton(
                        icon: Icon(Icons.cancel),
                        onPressed: () {
                          batalReservasi(reservasi.idReservasi);
                        },
                      )
                          : null, // Show the cancel icon only when filtering cancelable reservations
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}