class VolunteerListModel {
  final int volDid; // 봉사활동 고유 아이디
  final String volTitle; // 봉사활동 제목
  final String volContent; // 봉사활동 설명
  final String volHost; // 봉사활동 주체 단체
  final String volUrl; // 봉사활동 링크
  final String volType; // 봉사활동 사이트 대상 1365, vms
  final DateTime? volStartTime; // 봉사활동 모집 시작일
  final DateTime? volEndTime; // 봉사활동 모집 마감일

  VolunteerListModel({
    required this.volDid,
    required this.volTitle,
    required this.volContent,
    required this.volHost,
    required this.volUrl,
    required this.volType,
    required this.volStartTime,
    required this.volEndTime,
  });

  factory VolunteerListModel.fromJson(Map<String, dynamic> json) {
    return VolunteerListModel(
      volDid: json['vol_did'],
      volTitle: json['vol_title'] ?? '',
      volContent: json['vol_content'] ?? '',
      volHost: json['vol_host'] ?? '',
      volUrl: json['vol_url'] ?? '',
      volType: json['vol_type'] ?? '',
      volStartTime:
          json['vol_stime'] != null ? DateTime.parse(json['vol_stime']) : null,
      volEndTime: json['vol_edtime'] != null
          ? DateTime.parse(json['vol_edtime'])
          : null,
    );
  }
}
