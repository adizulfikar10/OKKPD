
class TrackSertifikatModel{
  String nomorSertifikat;
  String namaUsaha;
  String namaProduk;
  String keterangan;
  String tanggalCetak;
  String tanggalAkhir;
  String statusAktif;

  TrackSertifikatModel(this.nomorSertifikat,this.namaUsaha,this.namaProduk, this.keterangan,this.tanggalCetak,this.tanggalAkhir,this.statusAktif);

  TrackSertifikatModel.fromJson(Map<String, dynamic> json)
      : nomorSertifikat = json['nomor_sertifikat'],
        namaUsaha = json['nama_usaha'],
        namaProduk = json['nama_produk'],
        keterangan = json['keterangan'],
        tanggalCetak = json['tanggal_cetak'],
        tanggalAkhir = json['tanggal_akhir'],
        statusAktif = json['status_aktif'];

  Map<String, dynamic> toJson() =>
      {
        'nomor_sertifikat': nomorSertifikat,
        'nama_usaha': namaUsaha,
        'nama_produk': namaProduk,
        'keterangan': keterangan,
        'tanggal_cetak': tanggalCetak,
        'tanggal_akhir': tanggalAkhir,
        'status_aktif': statusAktif,
      };
}
