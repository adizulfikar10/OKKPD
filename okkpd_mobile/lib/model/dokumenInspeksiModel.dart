class DokumenInspeksiModel{
  String keterangan;
  String idHasil;
  String idGambar;
  String idLayanan;
  String gambar;

  DokumenInspeksiModel(this.keterangan,this.idHasil,this.idGambar,this.idLayanan,this.gambar);

  DokumenInspeksiModel.fromJson(Map<String, dynamic> json)
      : keterangan = json['keterangan'],
        idHasil= json['id_hasil'],
        idGambar= json['id_gambar'],
        idLayanan = json['id_layanan'],
        gambar = json['gambar'];

  Map<String, dynamic> toJson() =>
      {
        'keterangan': keterangan,
        'id_hasil': idHasil,
        'id_gambar': idGambar,
        'id_layanan': idLayanan,
        'gambar': gambar,
      };
}
