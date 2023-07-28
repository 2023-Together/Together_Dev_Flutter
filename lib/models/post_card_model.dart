class PostCardModel {
  final int postId; // 게시글 고유 아이디
  final int postBoardDid; // 어떤 게시판에 속해있는지
  final int postUserDid; // 게시글 작성 유저 did
  final String postTitle; // 게시글 제목
  final String postContent; // 게시글 내용(평문)
  final List<Map<String, dynamic>>?
      postTag; // 게시글 태그(없으면 null) 태그 있으면 List[Json] 형식으로 저장
  final DateTime postDateTime; // 게시물 작성시간(행 생성기준 자동으로)
  final String postMakeName; // 작성자 이름
  final int favoritedNums; // 좋아요 개수

  PostCardModel({
    required this.postId,
    required this.postBoardDid,
    required this.postUserDid,
    required this.postTitle,
    required this.postContent,
    required this.postTag,
    required this.postDateTime,
    required this.postMakeName,
    required this.favoritedNums,
  });

  factory PostCardModel.fromJson(Map<String, dynamic> json) {
    return PostCardModel(
      postId: json['post_id'],
      postBoardDid: json['post_board_did'],
      postUserDid: json['post_user_did'],
      postTitle: json['post_title'] ?? '',
      postContent: json['post_content'] ?? '',
      postTag: json['post_tag'],
      postDateTime: DateTime.parse(json['post_dtime']),
      postMakeName: json['post_make_name'],
      favoritedNums: json['post_favorited_nums'],
    );
  }
}
