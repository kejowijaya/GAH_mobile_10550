import 'package:flutter/material.dart';
import 'package:gah_mobile_10550/model/reservasi.dart';

class DetailReservasiScreen extends StatelessWidget {
  final Reservasi reservasi;

  const DetailReservasiScreen({Key? key, required this.reservasi}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(top: 16.0),
              child: Text(
                'Detail Reservasi',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 30.0,
                  fontFamily: 'Staatliches',
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('Check-In: ${reservasi.tanggalCheckIn}'),
                  Text('Check-Out: ${reservasi.tanggalCheckOut}'),
                  Text('Total Harga: ${reservasi.totalHarga.toString()}'),
                  Text('Status: ${reservasi.status}'),
                  Text('Tanggal Booking: ${reservasi.tanggalBooking}'),
                  Text('Jumlah Dewasa: ${reservasi.dewasa.toString()}'),
                  Text('Jumlah Anak: ${reservasi.anak.toString()}'),
                  Text('Permintaan Khsus: ${reservasi.permintaanKhusus}'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

