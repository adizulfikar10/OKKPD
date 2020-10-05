class MasterLayananModel {
  final String kodeLayanan;
  final String namaLayanan;
  final String route;
  final String path;

  const MasterLayananModel(
      this.kodeLayanan, this.namaLayanan, this.route, this.path);

  MasterLayananModel.fromJson(Map<String, dynamic> json)
      : kodeLayanan = json['kodeLayanan'],
        namaLayanan = json['namaLayanan'],
        route = json['route'],
        path = json['path'];

  Map<String, dynamic> toJson() => {
        'kodeLayanan': kodeLayanan,
        'namaLayanan': namaLayanan,
        'route': route,
        'path': path,
      };
}
