// ignore_for_file: public_member_api_docs, sort_constructors_first
class PostLikeModel {
  final int likeId; // 좋아요 고유 아이디
  final int likeUserDid; // 좋아요 누른 대상
  final int likePostId; // 좋아요 누른 게시글

  PostLikeModel({
    required this.likeId,
    required this.likeUserDid,
    required this.likePostId,
  });

  factory PostLikeModel.fromJson(Map<String, dynamic> json) {
    return PostLikeModel(
      likeId: json['like_id'],
      likeUserDid: json['like_user_did'],
      likePostId: json['like_post_id'],
    );
  }
}
