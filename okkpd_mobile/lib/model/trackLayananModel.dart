class TrackLayananModel{
  String tanggalProses;
  String namaStatus;

  TrackLayananModel(this.tanggalProses,this.namaStatus);

  TrackLayananModel.fromJson(Map<String, dynamic> json)
      : tanggalProses = json['tanggal_proses'],
        namaStatus = json['nama_status'];

  Map<String, dynamic> toJson() =>
      {
        'tanggal_proses': tanggalProses,
        'nama_status': namaStatus,
      };
}