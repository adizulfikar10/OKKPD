class LayananModel {
  final String uid;
  final String kodeLayanan;
  final String namaLayanan;
  final String idIdentitasUsaha;
  final String kodePendaftaran;
  final String status;
  final String level;
  final String tanggalBuat;
  final String alasanPenolakan;
  final String namaUsaha;
  final String idUSer;
  //tambahan untuk petugas inspeksi
  final String inspektor;
  final String pelaksana;
  final String ppc;
  final String suratTugas;
  final String latitude;
  final String longitude;

  const LayananModel(
    this.uid,
    this.namaLayanan,
    this.kodeLayanan,
    this.idIdentitasUsaha,
    this.kodePendaftaran,
    this.status,
    this.level,
    this.tanggalBuat,
    this.alasanPenolakan,
    this.namaUsaha,
    this.idUSer,
    this.inspektor,
    this.pelaksana,
    this.ppc,
    this.suratTugas,
    this.latitude,
    this.longitude,
  );

  LayananModel.fromJson(Map<String, dynamic> json)
      : uid = json['uid'],
        namaLayanan = json['nama_layanan'],
        kodeLayanan = json['kode_layanan'],
        idIdentitasUsaha = json['id_identitas_usaha'],
        kodePendaftaran = json['kode_pendaftaran'],
        status = json['status'],
        level = json['level'],
        tanggalBuat = json['tanggal_buat'],
        alasanPenolakan = json['alasan_penolakan'],
        namaUsaha = json['nama_usaha'],
        idUSer = json['id_user'],
        inspektor = json['inspektor'],
        pelaksana = json['pelaksana'],
        ppc = json['ppc'],
        suratTugas = json['surat_tugas'],
        latitude = json['latitude'],
        longitude = json['longitude'];

  Map<String, dynamic> toJson() => {
        'uid': uid,
        'nama_layanan': namaLayanan,
        'kode_layanan': kodeLayanan,
        'id_identitas_usaha': idIdentitasUsaha,
        'kode_pendaftaran': kodePendaftaran,
        'status': status,
        'level': level,
        'tanggal_buat': tanggalBuat,
        'alasan_penolakan': alasanPenolakan,
        'nama_usaha': namaUsaha,
        'id_user': idUSer,
        'inspektor': inspektor,
        'pelaksana': pelaksana,
        'ppc': ppc,
        'surat_tugas': suratTugas,
        'latitude': latitude,
        'longitude': longitude,
      };
}
