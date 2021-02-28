class Tool {
  int id;
  String title;
  String link;
  String description;
  List<String> tags;

  Tool({this.id, this.title, this.link, this.description, this.tags});

  Tool.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    link = json['link'];
    description = json['description'];
    tags = json['tags'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['link'] = this.link;
    data['description'] = this.description;
    data['tags'] = this.tags;
    return data;
  }
}
