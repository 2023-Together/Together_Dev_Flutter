class BoardModel {
  final int boardId; // 게시판 고유 아이디
  final String boardName; // 게시판 이름
  final String boardDescription; // 게시판 설명
  final String boardType; // 게시판 타입 : 일반 게시판, 동아리 게시판

  BoardModel({
    required this.boardId,
    required this.boardName,
    required this.boardDescription,
    required this.boardType,
  });

  factory BoardModel.fromJson(Map<String, dynamic> json) {
    return BoardModel(
      boardId: json['board_id'],
      boardName: json['board_name'] ?? '',
      boardDescription: json['board_def'] ?? '',
      boardType: json['board_type'] ?? 'default',
    );
  }
}