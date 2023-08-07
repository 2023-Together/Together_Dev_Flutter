class VolunteerModel {
  String? seq;
  String? listApiType;
  String? title;
  String? centName;
  String? actPlace;
  String? areaName;
  String? actTypeName;
  int? status;
  String? teenager;

  VolunteerModel({
    this.seq,
    this.listApiType,
    this.title,
    this.centName,
    this.areaName,
    this.actPlace,
    this.actTypeName,
    this.status,
    this.teenager,
  });

  factory VolunteerModel.fromJson(Map<String, dynamic> json) {
    return VolunteerModel(
      seq: json['seq'],
      listApiType: json['listApiType'],
      title: json['title'],
      centName: json['centName'],
      areaName: json['areaName'],
      actPlace: json['actPlace'],
      actTypeName: json['actTypeName'],
      status: json['status'],
      teenager: json['teenager'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'seq': seq,
      'listApiType': listApiType,
      'title': title,
      'centName': centName,
      'areaName': areaName,
      'actPlace': actPlace,
      'actTypeName': actTypeName,
      'status': status,
      'teenager': teenager,
    };
  }
}
