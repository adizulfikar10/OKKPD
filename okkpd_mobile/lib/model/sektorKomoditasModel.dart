class SektorKomoditasModel{
  String idSektor;
  String namaSektorKomoditas;

  SektorKomoditasModel(this.idSektor,this.namaSektorKomoditas);

  SektorKomoditasModel.fromJson(Map<String, dynamic> json)
      : idSektor = json['id_sektor'],
        namaSektorKomoditas = json['nama_sektor_komoditas'];

  Map<String, dynamic> toJson() =>
      {
        'id_sektor': idSektor,
        'nama_sektor_komoditas': namaSektorKomoditas,
      };
}