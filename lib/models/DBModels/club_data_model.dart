// ignore_for_file: public_member_api_docs, sort_constructors_first
class ClubDataModel {
  final int clubId; // 동아리 고유 아이디
  final int clubLeaderId; // 동아리장 유저 고유 아이디
  final int clubBoardId; // 동아리 게시판 고유 아이디
  final String clubName; // 동아리 이름
  final String clubDescription; // 동아리 설명
  final bool clubRecruiting;

  ClubDataModel({
    required this.clubId,
    required this.clubLeaderId,
    required this.clubBoardId,
    required this.clubName,
    required this.clubDescription,
    required this.clubRecruiting,
  });

  factory ClubDataModel.fromJson(Map<String, dynamic> json) {
    return ClubDataModel(
      clubId: json['clubId'],
      clubLeaderId: json['clubLeaderId'],
      clubBoardId: json['clubBoardId'],
      clubName: json['clubName'] ?? '',
      clubDescription: json['clubDescription'] ?? '',
      clubRecruiting: json['clubRecruiting'],
    );
  }
}
