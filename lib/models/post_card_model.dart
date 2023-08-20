class PostCardModel {
  final int postId; // 게시글 고유 아이디
  final int postBoardId; // 어떤 게시판에 속해있는지
  final int postUserId; // 게시글 작성 유저 did
  final String userNickname; // 작성자 별명
  String postTitle; // 게시글 제목
  String postContent; // 게시글 내용(평문)
  final List<String>? postTag; // 게시글 태그(없으면 null) 태그 있으면 List[Json] 형식으로 저장
  final DateTime postCreationDate; // 게시물 작성시간(행 생성기준 자동으로)
  bool postLikeId; // 좋아요 여부
  final int postLikeCount; // 좋아요 개수
  final int postCommentCount; // 댓글 개수
  final bool isAd; // 광고인지 광고가 아닌지 설정

  PostCardModel({
    required this.postId,
    required this.postBoardId,
    required this.postUserId,
    required this.userNickname,
    required this.postTitle,
    required this.postContent,
    required this.postTag,
    required this.postCreationDate,
    required this.postLikeId,
    required this.postLikeCount,
    required this.postCommentCount,
    this.isAd = false,
  });

  factory PostCardModel.fromJson(Map<String, dynamic> json) {
    return PostCardModel(
      postId: json['postId'],
      postBoardId: json['postBoardId'],
      postUserId: json['postUserId'],
      userNickname: json['userNickname'],
      postTitle: json['postTitle'] ?? '',
      postContent: json['postContent'] ?? '',
      postTag:
          json['postTag'] != null ? List<String>.from(json['postTag']) : null,
      postCreationDate: DateTime.parse(json['postCreationDate']),
      postLikeId: json['postLikeId'] == 0 ? false : true,
      postLikeCount: json['postLikeCount'] ?? 0,
      postCommentCount: json['postCommentCount'] ?? 0,
    );
  }
}
