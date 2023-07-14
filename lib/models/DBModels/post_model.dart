class PostModel {
  int postId; // 게시글 고유 아이디
  int postBoardDid; // 어떤 게시판에 속해있는지
  int postUserDid; // 게시글 작성 유저 did
  String postTitle; // 게시글 제목
  String postContent; // 게시글 내용(평문)
  List<Map<String, dynamic>>?
      postTag; // 게시글 태그(없으면 null) 태그 있으면 List[Json] 형식으로 저장
  DateTime postDtime; // 게시물 작성시간(행 생성기준 자동으로)

  PostModel({
    required this.postId,
    required this.postBoardDid,
    required this.postUserDid,
    required this.postTitle,
    required this.postContent,
    this.postTag,
    required this.postDtime,
  });

  PostModel.fromJson(Map<String, dynamic> json)
      : postId = json['post_id'],
        postBoardDid = json['post_board_id'],
        postUserDid = json['post_user_did'],
        postTitle = json['post_title'],
        postContent = json['post_content'],
        postTag = json['post_tag'],
        postDtime = json['post_dtime'];
}
