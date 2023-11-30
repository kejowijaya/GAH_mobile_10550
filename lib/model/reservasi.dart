import 'package:gah_mobile_10550/Model/customer.dart';
import 'package:gah_mobile_10550/Model/pegawai.dart';

class Reservasi {
  int idReservasi;
  int idPegawai;
  int idCustomer;
  String idBooking;
  String tanggalBooking;
  String tanggalCheckIn;
  String tanggalCheckOut;
  int dewasa;
  int anak;
  int totalHarga;
  String permintaanKhusus;
  String status;

  Reservasi({
    required this.idReservasi,
    required this.idPegawai,
    required this.idCustomer,
    required this.idBooking,
    required this.tanggalBooking,
    required this.tanggalCheckIn,
    required this.tanggalCheckOut,
    required this.dewasa,
    required this.anak,
    required this.totalHarga,
    required this.permintaanKhusus,
    required this.status,
  });

  factory Reservasi.fromJson(Map<String, dynamic> json) {
    return Reservasi(
      idReservasi: json['id_reservasi'],
      idPegawai: json['id_pegawai'] ?? 0,
      idCustomer: json['id_customer'],
      idBooking: json['id_booking'],
      tanggalBooking: json['tanggal_booking'],
      tanggalCheckIn: json['tanggal_check_in'],
      tanggalCheckOut: json['tanggal_check_out'],
      dewasa: json['dewasa'],
      anak: json['anak'],
      totalHarga: json['total_harga'],
      permintaanKhusus: json['permintaan_khusus'] ?? '',
      status: json['status'],
    );
  }
}