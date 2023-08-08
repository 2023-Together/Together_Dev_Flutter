class ClubSearchModel {
  int clubId;
  int clubLeaderId;
  int clubBoardId;
  String clubName;
  String clubDescription;
  bool clubRecruiting;
  // String clubMaster;
  // int clubMembers;

  ClubSearchModel({
    required this.clubId,
    required this.clubLeaderId,
    required this.clubBoardId,
    required this.clubName,
    required this.clubDescription,
    required this.clubRecruiting,
    // required this.clubMaster,
    // required this.clubMembers,
  });

  factory ClubSearchModel.fromJson(Map<String, dynamic> json) {
    return ClubSearchModel(
      clubId: json['clubId'],
      clubLeaderId: json['clubLeaderId'],
      clubBoardId: json['clubBoardId'],
      clubName: json['clubName'],
      clubDescription: json['clubDescription'],
      clubRecruiting: json['clubRecruiting'],
      // clubMaster: 'Your Club Master Name', // 동아리장 이름을 여기에 할당하세요
      // clubMembers: 0, // 동아리원 수를 여기에 할당하세요
    );
  }
}
