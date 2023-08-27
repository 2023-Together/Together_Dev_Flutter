class ClubRequestModel {
  int joinQueueId;
  int joinUserId;
  int joinClubId;
  String userNickname;
  String? joinContent;
  int joinState;

  ClubRequestModel({
    required this.joinQueueId,
    required this.joinUserId,
    required this.joinClubId,
    required this.userNickname,
    this.joinContent,
    required this.joinState,
  });

  ClubRequestModel.fromJson(Map<String, dynamic> json)
      : joinQueueId = json["joinQueueId"],
        joinUserId = json["joinUserId"],
        joinClubId = json["joinClubId"],
        userNickname = json["userNickname"],
        joinContent = json["joinContent"] ?? "",
        joinState = json["joinState"];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["joinQueueId"] = joinQueueId;
    data["joinUserId"] = joinUserId;
    data["joinClubId"] = joinClubId;
    data["userNickname"] = userNickname;
    data["joinContent"] = joinContent;
    data["joinState"] = joinState;
    return data;
  }
}
