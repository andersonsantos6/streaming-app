class Channel {
  late final String name;
  late final String category;
  late final String png;
  late final String desc;
  late final String stream;

  Channel(
      {required this.name,
      required this.stream,
      required this.category,
      required this.desc,
      required this.png});
}
