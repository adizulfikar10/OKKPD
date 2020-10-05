class MediaModel {
  final String kodeLayanan;
  final String kodeDokumen;
  final String idMedia;
  final String namaMedia;
  final String namaDokumen;
  final String sudahAda;
  final String idIdentitasUsaha;
  final String mimeType;
  final String dateUpload;
  final String folder;
  final String visible;

  const MediaModel(
      this.kodeLayanan,
      this.kodeDokumen,
      this.idMedia,
      this.namaMedia,
      this.namaDokumen,
      this.sudahAda,
      this.idIdentitasUsaha,
      this.mimeType,
      this.dateUpload,
      this.folder,
      this.visible);

  MediaModel.fromJson(Map<String, dynamic> json)
      : kodeLayanan = json['kode_layanan'],
        kodeDokumen = json['kode_dokumen'],
        idMedia = json['id_media'],
        namaMedia = json['nama_media'],
        namaDokumen = json['nama_dokumen'],
        sudahAda = json['sudah_ada'],
        idIdentitasUsaha = json['id_identitas_usaha'],
        mimeType = json['mime_type'],
        dateUpload = json['date_upload'],
        folder = json['folder'],
        visible = json['visible'];

  Map<String, dynamic> toJson() => {
        'kode_layanan': kodeLayanan,
        'kode_dokumen': kodeDokumen,
        'id_media': idMedia,
        'nama_media': namaMedia,
        'nama_dokumen': namaDokumen,
        'sudah_ada': sudahAda,
        'id_identitas_usaha': idIdentitasUsaha,
        'mime_type': mimeType,
        'date_upload': dateUpload,
        'folder': folder,
        'visible': visible,
      };
}
