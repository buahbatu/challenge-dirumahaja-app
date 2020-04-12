class Activity {
  final String imagePath;
  final String title;
  final String resPath;

  Activity(this.imagePath, this.title, this.resPath);

  static List<Activity> fromJsonList(dynamic json) {
    final jsonList = (json as List);
    return jsonList.map((i) {
      final json = i as Map<String, dynamic>;
      return Activity(json['image_path'], json['title'], json['res_path']);
    }).toList();
  }
}
