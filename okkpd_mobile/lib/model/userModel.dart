class UserModel {
  String username;
  String namaLengkap;
  String alamatLengkap;
  String kodeKota;
  String kodeRole;
  String idUser;
  String idIdentitasUsaha;
  String folder;
  String noKtp;
  String jenisUsaha;
  String namaUsaha;
  String noHp;
  String namaRole;
  String longitude;
  String latitude;

  UserModel(
      this.username,
      this.namaLengkap,
      this.alamatLengkap,
      this.kodeKota,
      this.kodeRole,
      this.idUser,
      this.idIdentitasUsaha,
      this.folder,
      this.noKtp,
      this.namaUsaha,
      this.jenisUsaha,
      this.noHp,
      this.namaRole,
      this.longitude,
      this.latitude);

  UserModel.fromJson(Map<String, dynamic> json)
      : username = json['username'],
        namaLengkap = json['nama_lengkap'],
        alamatLengkap = json['alamat_lengkap'],
        noKtp = json['no_ktp_pemohon'],
        kodeKota = json['kode_kota'],
        kodeRole = json['kode_role'],
        idUser = json['id_user'],
        idIdentitasUsaha = json['id_identitas_usaha'],
        namaUsaha = json['nama_usaha'],
        jenisUsaha = json['jenis_usaha'],
        noHp = json['no_hp_pemohon'],
        folder = json['folder'],
        namaRole = json['nama_role'],
        longitude = json['longitude'],
        latitude = json['latitude'];

  Map<String, dynamic> toJson() => {
        'username': username,
        'nama_lengkap': namaLengkap,
        'alamat_lengkap': alamatLengkap,
        'no_ktp_pemohon': noKtp,
        'kode_kota': kodeKota,
        'kode_role': kodeRole,
        'id_user': idUser,
        'id_identitas_usaha': idIdentitasUsaha,
        'folder': folder,
        'nama_usaha': namaUsaha,
        'jenis_usaha': jenisUsaha,
        'no_hp_pemohon': noHp,
        'nama_role': namaRole,
        'longitude': longitude,
        'latitude': latitude,
      };
}
