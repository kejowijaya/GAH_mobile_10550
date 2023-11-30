class Customer {
  String noIdentitas;
  String nama;
  String nomorTelepon;
  String namaInstitusi;
  String email;
  String password;
  String alamat;
  String jenisTamu;
  int idCustomer;

  Customer({
    required this.noIdentitas,
    required this.namaInstitusi,
    required this.nama,
    required this.nomorTelepon,
    required this.email,
    required this.password,
    required this.alamat,
    required this.jenisTamu,
    required this.idCustomer,
  });

  factory Customer.fromJson(Map<String, dynamic> json) {
    return Customer(
      noIdentitas: json['no_identitas'] ?? '',
      namaInstitusi: json['nama_institusi'] ?? '',
      nama: json['nama'] ?? '',
      nomorTelepon: json['nomor_telepon'] ?? '',
      email: json['email'],
      alamat: json['alamat'] ?? '',
      password: json['password'],
      jenisTamu: json['jenis_tamu'] ?? '',
      idCustomer: json['id_customer'],
    );
  }
}
