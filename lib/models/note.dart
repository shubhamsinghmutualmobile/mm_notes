class Note {
  int id;
  String title, body;
  double dateCreated;
  NoteColor noteColor;

  Note(this.id,
      {required this.title,
      required this.body,
      required this.dateCreated,
      required this.noteColor});
}

enum NoteColor { violet, indigo, blue, green, yellow, orange, red, grey }
