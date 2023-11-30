class Pegawai {
  int idPegawai;
  String role;
  String username;
  String password;
  String namaPegawai;

  Pegawai({
    required this.idPegawai,
    required this.role,
    required this.username,
    required this.password,
    required this.namaPegawai,
  });

  factory Pegawai.fromJson(Map<String, dynamic> json) {
    return Pegawai(
      idPegawai: json['id_pegawai'],
      role: json['role'],
      username: json['username'],
      password: json['password'],
      namaPegawai: json['nama_pegawai'],
    );
  }
}