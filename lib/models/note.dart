class Note {
  final String id;
  final String title;
  final String content;
  final String userId;

  Note({
    required this.id,
    required this.title,
    required this.content,
    required this.userId
  });

  factory Note.fromMap(Map<String, dynamic> map) {
    return Note(
      id: map['id'],
      title: map['title'],
      content: map['content'],
      userId: map['userId']
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'userId': userId
    };
  }

  Note copyWith({String? userId}) {
    return Note(
      id: id,
      title: title,
      content: content,
      userId: userId ?? this.userId
    );
  }
}