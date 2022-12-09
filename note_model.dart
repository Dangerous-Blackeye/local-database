class Note{
  final int? id;
  final String name;
  final String weight;

  const Note({required this.name, required this.weight, this.id});

  factory Note.fromJson(Map<String,dynamic> json) => Note(
    id: json['id'],
    name: json['name'],
    weight: json['weight']
  );

  Map<String,dynamic> toJson() => {
    'id': id,
    'name': name,
    'weight': weight
  };
}