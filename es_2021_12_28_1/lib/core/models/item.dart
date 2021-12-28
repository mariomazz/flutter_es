class Post {
  int userId;
  int id;
  String title;
  String body;

  Post.fromJson(Map<String, dynamic> object) {
    this.id = object['id'];
    this.userId = object['userId'];
    this.title = object['title'];
    this.body = object['body'];
    if (id == null || userId == null || title == null || body == null) {
      throw Exception('ERRORE DI CONVERSIONE - MODELLO : (Item)');
    }
  }
}


