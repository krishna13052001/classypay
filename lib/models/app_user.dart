class AppUser {
  String id;
  String name;
  String phoneNumber;

  AppUser({
    required this.id,
    required this.name,
    required this.phoneNumber,
  });

  static AppUser fromMap(Map<String, dynamic> doc) =>
      AppUser(id: doc['id'], name: doc['name'], phoneNumber: doc['phNo']);

  Map<String, dynamic> toJson() =>
      {'id': this.id, 'name': this.name, 'phNo': this.phoneNumber};
}
