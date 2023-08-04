class VolunteerModel {
  int? volId;
  String? volApiType;
  String? volIdNumber;
  String? volTitle;
  String? volHost;
  String? volAreaName;
  String? volPlace;
  String? volTypeName;
  int? volStatus;
  String? volTeenager;

  VolunteerModel({
    this.volId,
    this.volApiType,
    this.volIdNumber,
    this.volTitle,
    this.volHost,
    this.volAreaName,
    this.volPlace,
    this.volTypeName,
    this.volStatus,
    this.volTeenager,
  });

  factory VolunteerModel.fromJson(Map<String, dynamic> json) {
    return VolunteerModel(
      volId: json['vol_id'],
      volApiType: json['vol_api_type'],
      volIdNumber: json['vol_id_number'],
      volTitle: json['vol_title'],
      volHost: json['vol_host'],
      volAreaName: json['vol_area_name'],
      volPlace: json['vol_place'],
      volTypeName: json['vol_type_name'],
      volStatus: json['vol_status'],
      volTeenager: json['vol_teenager'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'vol_id': volId,
      'vol_api_type': volApiType,
      'vol_id_number': volIdNumber,
      'vol_title': volTitle,
      'vol_host': volHost,
      'vol_area_name': volAreaName,
      'vol_place': volPlace,
      'vol_type_name': volTypeName,
      'vol_status': volStatus,
      'vol_teenager': volTeenager,
    };
  }
}
