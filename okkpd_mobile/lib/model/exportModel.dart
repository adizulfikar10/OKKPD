class ExportModel {
  String namaProduk;
  String jenisProduk;
  String nomorHs;
  String namaEksportir;
  String alamatKantor;
  String alamatGudang;
  String id;
  String consignmentCode;
  String jumlahLot;
  String beratLot;
  String jumlahKemasan;
  String jenisKemasan;
  String beratKotor;
  String beratBersih;
  String pelabuhanBerangkat;
  String identitasTransportasi;
  String pelabuhanTujuan;
  String negaraTujuan;
  String negaraTransit;
  String pelabuhanTransit;
  String transportasiTransit;
  String idLayanan;
  String sertifikat;
  String mimeType;
  String tanggalUnggah;

  ExportModel(
    this.sertifikat,
    this.mimeType,
    this.idLayanan,
    this.id,
    this.alamatGudang,
    this.alamatKantor,
    this.beratBersih,
    this.beratKotor,
    this.beratLot,
    this.consignmentCode,
    this.identitasTransportasi,
    this.jenisKemasan,
    this.jenisProduk,
    this.jumlahKemasan,
    this.jumlahLot,
    this.namaEksportir,
    this.namaProduk,
    this.negaraTransit,
    this.negaraTujuan,
    this.nomorHs,
    this.pelabuhanBerangkat,
    this.pelabuhanTransit,
    this.pelabuhanTujuan,
    this.tanggalUnggah,
    this.transportasiTransit,
  );

  ExportModel.fromJson(Map<String, dynamic> json)
      : namaProduk = json['nama_produk'],
        jenisProduk = json['jenis_produk'],
        nomorHs = json['nomor_hs'],
        namaEksportir = json['nama_eksportir'],
        alamatKantor = json['alamat_kantor'],
        alamatGudang = json['alamat_gudang'],
        id = json['id'],
        consignmentCode = json['consignment_code'],
        jumlahLot = json['jumlah_lot'],
        beratLot = json['berat_lot'],
        jumlahKemasan = json['jumlah_kemasan'],
        jenisKemasan = json['jenis_kemasan'],
        beratKotor = json['berat_kotor'],
        beratBersih = json['berat_bersih'],
        pelabuhanBerangkat = json['pelabuhan_berangkat'],
        identitasTransportasi = json['identitas_transportasi'],
        pelabuhanTujuan = json['pelabuhan_tujuan'],
        negaraTujuan = json['negara_tujuan'],
        negaraTransit = json['negara_transit'],
        pelabuhanTransit = json['pelabuhan_transit'],
        transportasiTransit = json['transportasi_transit'],
        idLayanan = json['id_layanan'],
        sertifikat = json['sertifikat'],
        mimeType = json['mime_type'],
        tanggalUnggah = json['tanggal_unggah'];

  Map<String, dynamic> toJson() => {
        'nama_produk': namaProduk,
        'jenis_produk': jenisProduk,
        'nomor_hs': nomorHs,
        'nama_eksportir': namaEksportir,
        'alamat_kantor': alamatKantor,
        'alamat_gudang': alamatGudang,
        'id': id,
        'consignment_code': consignmentCode,
        'jumlah_lot': jumlahLot,
        'berat_lot': beratLot,
        'jumlah_kemasan': jumlahKemasan,
        'jenis_kemasan': jenisKemasan,
        'berat_kotor': beratKotor,
        'berat_bersih': beratBersih,
        'pelabuhan_berangkat': pelabuhanBerangkat,
        'identitas_transportasi': identitasTransportasi,
        'pelabuhan_tujuan': pelabuhanTujuan,
        'negara_tujuan': negaraTujuan,
        'negara_transit': negaraTransit,
        'pelabuhan_transit': pelabuhanTransit,
        'transportasi_transit': transportasiTransit,
        'id_layanan': idLayanan,
        'sertifikat': sertifikat,
        'mime_type': mimeType,
        'tanggal_unggah': tanggalUnggah
      };
}
