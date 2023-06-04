class PostModel {
  int id;
  int board_id;
  int user_did;
  String title;
  String content;
  List<String> tag;
  DateTime dtime;

  PostModel({
    required this.id,
    required this.board_id,
    required this.user_did,
    required this.title,
    required this.content,
    required this.tag,
    required this.dtime,
  });

  PostModel.fromJson(Map<String, dynamic> json)
      : id = json['post_id'],
        board_id = json['post_board_id'],
        user_did = json['post_user_did'],
        title = json['post_title'],
        content = json['post_content'],
        tag = json['post_tag'],
        dtime = json['post_dtime'];
}
