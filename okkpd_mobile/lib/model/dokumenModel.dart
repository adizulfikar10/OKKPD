class DokumenModel{
  String idDokumen;
  String file;
  String namaDokumen;
  String mimeType;
  String idLayanan;
  String folder;

  DokumenModel(this.idDokumen,this.file,this.namaDokumen,this.mimeType,this.idLayanan,this.folder);

  DokumenModel.fromJson(Map<String, dynamic> json)
      : idDokumen = json['id_dokumen'],
        file = json['file'],
        namaDokumen = json['nama_dokumen'],
        mimeType = json['mime_type'],
        idLayanan = json['id_layanan'],
        folder = json['folder'];

  Map<String, dynamic> toJson() =>
      {
        'id_dokumen': idDokumen,
        'file': file,
        'nama_dokumen': namaDokumen,
        'mime_type': mimeType,
        'id_layanan': idLayanan,
        'folder': folder,
      };
}
