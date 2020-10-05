class ProdukModel {
  String id;
  String idLayanan;
  String namaProdukPangan;
  String namaDagang;
  String idKemasan;
  String netto;
  String idSatuan;
  String satuan;
  String sertifikat;
  String mimeType;
  String tanggalUnggah;

  ProdukModel(
      this.id,
      this.idKemasan,
      this.idLayanan,
      this.idSatuan,
      this.mimeType,
      this.namaDagang,
      this.namaProdukPangan,
      this.netto,
      this.satuan,
      this.sertifikat,
      this.tanggalUnggah);

  ProdukModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        idLayanan = json['id_layanan'],
        idKemasan = json['id_kemasan'],
        idSatuan = json['id_satuan'],
        mimeType = json['mime_type'],
        namaDagang = json['nama_dagang'],
        namaProdukPangan = json['nama_produk_pangan'],
        netto = json['netto'],
        satuan = json['satuan'],
        sertifikat = json['sertifikat'],
        tanggalUnggah = json['tanggal_unggah '];

  Map<String, dynamic> toJson() => {
        'id': id,
        'id_layanan': idLayanan,
        'id_kemasan': idKemasan,
        'id_satuan': idSatuan,
        'mime_type': mimeType,
        'nama_dagang': namaDagang,
        'nama_produk_pangan': namaProdukPangan,
        'netto': netto,
        'satuan': satuan,
        'sertifikat': sertifikat,
        'tanggal_unggah': tanggalUnggah,
      };
}
