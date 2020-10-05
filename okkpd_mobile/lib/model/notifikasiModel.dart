class NotifikasiModel {

  final String idNotif;
  final String dari;
  final String kepada;
  final String tanggal;
  final String title;
  final String body;
  final String isRead;

  const NotifikasiModel(
      this.idNotif,
      this.dari,
      this.kepada,
      this.tanggal,
      this.title,
      this.body,
      this.isRead);

  NotifikasiModel.fromJson(Map<String, dynamic> json)
      : idNotif = json['id_notif'],
        dari = json['dari'],
        kepada = json['kepada'],
        tanggal = json['tanggal'],
        title = json['title'],
        body = json['body'],
        isRead = json['isread'];

  Map<String, dynamic> toJson() => {
    'id_notif': idNotif,
    'dari': dari,
    'kepada': kepada,
    'tanggal': tanggal,
    'title': title,
    'body': body,
    'isread': isRead,
  };
}
