class VolunteerListModel {
  int volDid; // 봉사활동 고유 아이디
  String volTitle; // 봉사활동 제목
  String volContent; // 봉사활동 설명
  String volHost; // 봉사활동 주체 단체
  String volUrl; // 봉사활동 링크
  String volType; // 봉사활동 사이트 대상 1365, vms
  DateTime volStime; // 봉사활동 모집 시작일
  DateTime volEdtime; // 봉사활동 모집 마감일

  VolunteerListModel({
    required this.volDid,
    required this.volTitle,
    required this.volContent,
    required this.volHost,
    required this.volUrl,
    required this.volType,
    required this.volStime,
    required this.volEdtime,
  });

  VolunteerListModel.fromJson(Map<String, dynamic> json)
      : volDid = json['vol_did'],
        volTitle = json['vol_title'],
        volContent = json['vol_content'],
        volHost = json['vol_host'],
        volUrl = json['vol_url'],
        volType = json['vol_type'],
        volStime = json['vol_stime'],
        volEdtime = json['vol_edtime'];
}
