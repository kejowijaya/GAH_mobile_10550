class Kamar {
  int nomorKamar;
  int idJenis;
  JenisKamar jenisKamar;
  String gambar;

  Kamar({
    required this.nomorKamar,
    required this.idJenis,
    required this.jenisKamar,
    required this.gambar,
  });

  factory Kamar.fromJson(Map<String, dynamic> json) {
    return Kamar(
      nomorKamar: json['nomor_kamar'],
      idJenis: json['id_jenis'],
      jenisKamar: JenisKamar.fromJson(json['jenis_kamar']),
      gambar: "https://images.unsplash.com/photo-1595526114035-0d45ed16cfbf?ixid=MXwxMjA3fDB8MHxzZWFyY2h8MTF8fGZhc2hpb258ZW58MHx8MHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=60",
    );
  }
}

class JenisKamar {
  final int idJenis;
  final String namaJenis;
  final String tipeRanjang;
  final String fasilitas;
  final int harga;
  final int ukuranKamar;
  final int kapasitas;

  JenisKamar({
    required this.idJenis,
    required this.namaJenis,
    required this.tipeRanjang,
    required this.fasilitas,
    required this.harga,
    required this.ukuranKamar,
    required this.kapasitas,
  });

  factory JenisKamar.fromJson(Map<String, dynamic> json) {
    return JenisKamar(
      idJenis: json['id_jenis'],
      namaJenis: json['jenis_kamar'],
      tipeRanjang: json['tipe_ranjang'],
      fasilitas: json['fasilitas'],
      harga: json['harga'],
      ukuranKamar: json['luas_kamar'],
      kapasitas: json['kapasitas'],
    );
  }
}
