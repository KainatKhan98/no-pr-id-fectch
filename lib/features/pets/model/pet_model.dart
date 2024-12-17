class MedicalRecord {
  List<String> diseases;
  List<String> vaccinations;

  MedicalRecord({
    required this.diseases,
    required this.vaccinations,
  });

  Map<String, dynamic> toMap() {
    return {
      'diseases': diseases,
      'vaccinations': vaccinations,
    };
  }

  factory MedicalRecord.fromMap(Map<String, dynamic> data) {
    return MedicalRecord(
      diseases: List<String>.from(data['diseases'] ?? []),
      vaccinations: List<String>.from(data['vaccinations'] ?? []),
    );
  }
}

class Pet {
  String id;
  String name;
  String type;
  String breed;
  String sex;
  int age;
  double weight;
  String description;
  String imageUrl;
  MedicalRecord medicalRecord;

  Pet({
    required this.id,
    required this.name,
    required this.type,
    required this.breed,
    required this.sex,
    required this.age,
    required this.weight,
    required this.description,
    required this.imageUrl,
    required this.medicalRecord,
  });

  static Pet empty() => Pet(
    id: '',
    name: '',
    type: '',
    breed: '',
    age: 0,
    description: '',
    imageUrl: '',
    medicalRecord: MedicalRecord(diseases: [], vaccinations: []),
    sex: '',
    weight: 0.0,
  );

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'type': type,
      'breed': breed,
      'age': age,
      'sex': sex,
      'weight': weight,
      'description': description,
      'imageUrl': imageUrl,
      'medicalRecord': medicalRecord.toMap(),
    };
  }

  factory Pet.fromMap(Map<String, dynamic> data) {
    return Pet(
      id: data['id'] ?? '',
      name: data['name'] ?? '',
      type: data['type'] ?? '',
      breed: data['breed'] ?? '',
      age: data['age'] ?? 0,
      weight: data['weight'] ?? 0.0,
      sex: data['sex'] ?? '',
      description: data['description'] ?? '',
      imageUrl: data['imageUrl'] ?? '',
      medicalRecord: MedicalRecord.fromMap(data['medicalRecord'] ?? {}),
    );
  }
}
