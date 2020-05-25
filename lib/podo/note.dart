class Note {
  String fullName;
  String email;

  Note(this.fullName, this.email);

  Note.fromJson(Map<String, dynamic> json) {
    fullName = json['fullName'];
    email = json['email'];
  }
}
