class ClubRequestModel {
  int joinQueueId;
  int joinUserId;
  int joinClubId;
  String? joinContent;

  ClubRequestModel({
    required this.joinQueueId,
    required this.joinUserId,
    required this.joinClubId,
    this.joinContent,
  });

  ClubRequestModel.fromJson(Map<String, dynamic> json)
      : joinQueueId = json["joinQueueId"],
        joinUserId = json["joinUserId"],
        joinClubId = json["joinClubId"],
        joinContent = json["joinContent"] ?? "";

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["joinQueueId"] = joinQueueId;
    data["joinUserId"] = joinUserId;
    data["joinClubId"] = joinClubId;
    data["joinContent"] = joinContent;
    return data;
  }
}
