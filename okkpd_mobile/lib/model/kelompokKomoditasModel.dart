class KelompokKomoditasModel{
  String idSektor;
  String idKelompok;
  String namaKelompok;
  String namaSektorKomoditas;

  KelompokKomoditasModel(this.idSektor,this.idKelompok,this.namaKelompok,this.namaSektorKomoditas);

  KelompokKomoditasModel.fromJson(Map<String, dynamic> json)
      : idSektor = json['id_sektor'],
        idKelompok= json['id_kelompok'],
        namaKelompok = json['nama_kelompok'],
        namaSektorKomoditas = json['nama_sektor_komoditas'];

  Map<String, dynamic> toJson() =>
      {
        'id_sektor': idSektor,
        'id_kelompok': idKelompok,
        'nama_kelompok': namaKelompok,
        'nama_sektor_komoditas': namaSektorKomoditas,
      };
}