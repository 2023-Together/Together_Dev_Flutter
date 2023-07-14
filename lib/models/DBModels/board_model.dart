class BoardModel {
  final int boardId; // 게시판 고유 아이디
  final String boardName; // 게시판 이름
  final String boardDef; // 게시판 설명
  final String boardType; // 게시판 타입 : 일반 게시판, 동아리 게시판

  BoardModel({
    required this.boardId,
    required this.boardName,
    required this.boardDef,
    required this.boardType,
  });

  BoardModel.fromJson(Map<String, dynamic> json)
      : boardId = json['board_id'],
        boardName = json['board_name'],
        boardDef = json['board_def'],
        boardType = json['board_type'];
}
