class Items {
  final String id;
  final String name;
  final String type;
  final String slot;
  final String rank;
  final String rarity;

  Items({
    required this.id,
    required this.name,
    required this.type,
    required this.slot,
    required this.rank,
    required this.rarity,
  });

  factory Items.fromJson(Map<String, dynamic> json) {
    // .toString() avoids crashes if the API returns numbers where we
    // expect strings (e.g. id or rank coming back as int).
    return Items(
      id: json['id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      type: json['type']?.toString() ?? '',
      slot: json['slot']?.toString() ?? '',
      rank: json['rank']?.toString() ?? '',
      rarity: json['rarity']?.toString() ?? '',
    );
  }
}
