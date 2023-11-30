import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:gah_mobile_10550/reservasi.dart';

class AvailableRoomsScreen extends StatefulWidget {
  @override
  _AvailableRoomsScreenState createState() => _AvailableRoomsScreenState();
}

class _AvailableRoomsScreenState extends State<AvailableRoomsScreen> {
  List<String> jenisKamar = [];
  List<Map<String, dynamic>> kamar = [];
  TextEditingController checkInController = TextEditingController();
  TextEditingController checkOutController = TextEditingController();

  @override
  void initState() {
    super.initState();
    checkInController.text = DateTime.now().toString();
    checkOutController.text = DateTime.now().add(Duration(days: 1)).toString();
    fetchAvailableRooms();
  }

  Future<void> fetchAvailableRooms() async {
    DateTime checkIn = DateTime.parse(checkInController.text);
    DateTime checkOut = DateTime.parse(checkOutController.text);

    if (checkOut.isBefore(checkIn)) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Tanggal check out tidak boleh lebih awal daripada tanggal check in'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text('OK'),
              ),
            ],
          );
        },
      );
      return;
    }

    try {
      final response = await http.post(
        Uri.parse('https://kejowijaya.com/backend/public/api/kamarTersedia'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'tanggal_check_in': checkIn.toIso8601String(),
          'tanggal_check_out': checkOut.toIso8601String()
        }),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        final List<Map<String, dynamic>> availableRooms = List<Map<String, dynamic>>.from(responseData['data'])
            .where((kamar) => kamar['totalKamar'] > 0)
            .toList();

        setState(() {
          kamar = availableRooms;
          jenisKamar = availableRooms.map((kamar) => kamar['jenis_kamar'].toString()).toList();
        });
        print(availableRooms);
      } else {
        print('Failed to fetch available rooms. Status code: ${response.statusCode}');
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Available Rooms'),
        actions: [
          IconButton(
            icon: Icon(Icons.book),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ReservationScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: checkInController,
                    decoration: InputDecoration(
                      labelText: 'Check-In Date',
                    ),
                  ),
                ),
                SizedBox(width: 16.0),
                Expanded(
                  child: TextFormField(
                    controller: checkOutController,
                    decoration: InputDecoration(
                      labelText: 'Check-Out Date',
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextButton(
              onPressed: () {
                fetchAvailableRooms();
              },
              child: Text('Cari Kamar Tersedia'),
              style: TextButton.styleFrom(
                backgroundColor: Theme.of(context).primaryColor,
                primary: Colors.white,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: kamar.length,
              itemBuilder: (context, index) {
                final Map<String, dynamic> room = kamar[index];

                return Card(
                  child: ListTile(
                    title: Text('Jenis Kamar: ${room['jenis_kamar']['jenis_kamar']}'),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Harga: ${room['harga']}'),
                        Text('Ukuran Kamar: ${room['jenis_kamar']['luas_kamar']}'),
                        Image(image: NetworkImage(room['jenis_kamar']['gambar'])),
                      ],
                    ),
                    onTap: () {
                      showRoomDetail(room);
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );


}

  void showRoomDetail(Map<String, dynamic> room) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => RoomDetailScreen(room: room),
      ),
    );
  }
}

// Layar baru untuk menampilkan detail kamar
class RoomDetailScreen extends StatelessWidget {
  final Map<String, dynamic> room;

  RoomDetailScreen({required this.room});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Kamar'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Jenis Kamar: ${room['jenis_kamar']['jenis_kamar']}'),
          Text('Ukuran Kamar: ${room['jenis_kamar']['luas_kamar']}'),
          Image(image: NetworkImage(room['jenis_kamar']['gambar'])),
          Text('Harga: ${room['harga']}'),
          Text('Fasilitas: ${room['jenis_kamar']['fasilitas']}'),
          Text('Tipe Ranjang: ${room['jenis_kamar']['tipe_ranjang']}'),
          Text('Kapasitas: ${room['jenis_kamar']['kapasitas']}'),
          Text('Luas Kamar: ${room['jenis_kamar']['luas_kamar']}'),
        ],
      ),
    );
  }
}