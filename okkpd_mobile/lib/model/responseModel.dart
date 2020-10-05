class ResponseModel{
  final String status;
  final String message;
  final Map<String,dynamic> data;

  ResponseModel(this.status,this.message,this.data);

  ResponseModel.fromJson(Map<String, dynamic> json)
      : status = json['STATUS'],
        message = json['MESSAGE'],
        data = json['DATA'];

  Map<String, dynamic> toJson() =>
    {
      'STATUS': status,
      'MESSAGE': message,
      'DATA': data,
    };
}