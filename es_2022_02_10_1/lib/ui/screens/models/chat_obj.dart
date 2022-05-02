class ChatObj {
  final String value;
  final ChatType type;

  const ChatObj({
    required this.value,
    required this.type,
  });
}

enum ChatType { answer, question }
