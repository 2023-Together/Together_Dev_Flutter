// ignore_for_file: public_member_api_docs, sort_constructors_first
class ClubDataModel {
  final int clubDid; // 동아리 고유 아이디
  final int clubMaster; // 동아리장 유저 고유 아이디
  final int clubBoardId; // 동아리 게시판 고유 아이디
  final String clubName; // 동아리 이름
  final String clubDef; // 동아리 설명

  ClubDataModel({
    required this.clubDid,
    required this.clubMaster,
    required this.clubBoardId,
    required this.clubName,
    required this.clubDef,
  });

  ClubDataModel.fromJson(Map<String, dynamic> json)
      : clubDid = json['club_did'],
        clubMaster = json['club_master'],
        clubBoardId = json['club_board_id'],
        clubName = json['club_name'],
        clubDef = json['club_def'];
}
