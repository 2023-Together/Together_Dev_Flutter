class ClubMemberModel {
  final int memberDid; // 동아리 유저 고유 아이디
  final int memberClubDid; // 동아리 아이디 고유 아이디
  final int memberPermission; // "동아리에서 유저 권한 -> 1 : 동아리원, 9 : 동아리장"

  ClubMemberModel({
    required this.memberDid,
    required this.memberClubDid,
    required this.memberPermission,
  });

  factory ClubMemberModel.fromJson(Map<String, dynamic> json) {
    return ClubMemberModel(
      memberDid: json['member_did'],
      memberClubDid: json['member_club_did'],
      memberPermission: json['member_per'] ?? 1,
    );
  }
}