class CommentModel {
  int commentId;
  int commentUserId;
  int commentPostId;
  String commentContent;
  int commentParentnum;
  String userNickname;
  DateTime commentCreationDate;

  CommentModel(
      {required this.commentId,
      required this.commentUserId,
      required this.commentPostId,
      required this.commentContent,
      required this.commentParentnum,
      required this.userNickname,
      required this.commentCreationDate});

  CommentModel.fromJson(Map<String, dynamic> json)
      : commentId = json["commentId"],
        commentUserId = json["commentUserId"],
        commentPostId = json["commentPostId"],
        commentContent = json["commentContent"],
        commentParentnum = json["commentParentnum"],
        userNickname = json["userNickname"],
        commentCreationDate = DateTime.parse(json['commentCreationDate']);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["commentId"] = commentId;
    data["commentUserId"] = commentUserId;
    data["commentPostId"] = commentPostId;
    data["commentContent"] = commentContent;
    data["commentParentnum"] = commentParentnum;
    data["userNickname"] = userNickname;
    data["commentCreationDate"] = commentCreationDate;
    return data;
  }
}