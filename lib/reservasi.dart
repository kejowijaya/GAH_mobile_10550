import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ReservationScreen extends StatefulWidget {
  @override
  _ReservationScreenState createState() => _ReservationScreenState();
}

class _ReservationScreenState extends State<ReservationScreen> {
  late String idCustomer;
  late String tanggalCheckIn;
  late String tanggalCheckOut;
  late int dewasa;
  late int anak;
  late String nomorRek;
  late String permintaanKhusus;
  late String jenisKamarInputs;

  Future<void> makeReservation() async {
    try {
      final response = await http.post(
        Uri.parse('https://kejowijaya.com/backend/public/api/tambahReservasi'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'id_customer': idCustomer,
          'tanggal_check_in': tanggalCheckIn,
          'tanggal_check_out': tanggalCheckOut,
          'dewasa': dewasa,
          'anak': anak,
          'nomor_rek': nomorRek,
          'permintaan_khusus': permintaanKhusus,
          'jenis_kamar': jenisKamarInputs,
        }),
      );

      if (response.statusCode == 200) {
        // Reservasi berhasil
        final responseData = json.decode(response.body);
        final idReservasi = responseData['data']['id_reservasi'];

        // Logika untuk memesan fasilitas tambahan (confirmation2)
      } else {
        // Gagal reservasi
        print('Failed to make reservation. Status code: ${response.statusCode}');
        // alert("Gagal reservasi : " + JSON.stringify(responseData['message'])); // Ganti dengan logika Anda
      }
    } catch (error) {
      // Handle error
      print('Error: $error');
      // alert("Gagal reservasi : " + JSON.stringify(error)); // Ganti dengan logika Anda
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reservation Screen'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              onChanged: (value) {
                // Atur nilai idCustomer saat input berubah
                idCustomer = value;
              },
              decoration: InputDecoration(labelText: 'ID Customer'),
            ),
            TextFormField(
              onChanged: (value) {
                // Atur nilai tanggalCheckIn saat input berubah
                tanggalCheckIn = value;
              },
              decoration: InputDecoration(labelText: 'Tanggal Check-In'),
            ),
            TextFormField(
              onChanged: (value) {
                // Atur nilai tanggalCheckOut saat input berubah
                tanggalCheckOut = value;
              },
              decoration: InputDecoration(labelText: 'Tanggal Check-Out'),
            ),
            TextFormField(
              onChanged: (value) {
                // Atur nilai dewasa saat input berubah
                dewasa = int.parse(value);
              },
              decoration: InputDecoration(labelText: 'Jumlah Dewasa'),
            ),
            TextFormField(
              onChanged: (value) {
                // Atur nilai anak saat input berubah
                anak = int.parse(value);
              },
              decoration: InputDecoration(labelText: 'Jumlah Anak'),
            ),
            TextFormField(
              onChanged: (value) {
                // Atur nilai nomorRek saat input berubah
                nomorRek = value;
              },
              decoration: InputDecoration(labelText: 'Nomor Rekening'),
            ),
            TextFormField(
              onChanged: (value) {
                // Atur nilai permintaanKhusus saat input berubah
                permintaanKhusus = value;
              },
              decoration: InputDecoration(labelText: 'Permintaan Khusus'),
            ),
            TextFormField(
              onChanged: (value) {
                // Atur nilai jenisKamarInputs saat input berubah
                jenisKamarInputs = value;
              },
              decoration: InputDecoration(labelText: 'Jenis Kamar'),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                // Panggil fungsi makeReservation setelah mendapatkan nilai dari inputan pengguna
                makeReservation();
              },
              child: Text('Make Reservation'),
            ),
          ],
        ),
      ),
    );
  }
}
