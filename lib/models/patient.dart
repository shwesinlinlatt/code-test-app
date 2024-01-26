class PatientModel {
  final String name;
  final int age;
  final String sex;
  final String address;
  final String is_VOT;
  final String treatment_start_date;
  final int? isSync;
  final int? id;

  PatientModel(
      {required this.name,
      required this.age,
      required this.sex,
      required this.address,
      required this.is_VOT,
      required this.treatment_start_date,
      this.isSync,
      this.id});

  // static final List<String> values = [
  //   id,
  //   name,
  //   age,
  //   sex,
  //   address,
  //   is_VOT,
  //   isSync,
  //   treatment_start_date
  // ];

  // static const String id = 'id';
  // static const String name = 'name';
  // static const String age = 'age';
  // static const String address = 'address';
  // static const String is_VOT = 'is_VOT';
  // static const String isSync = 'isSync';
  // static const String treatment_start_date = 'treatment_start_date';

  static PatientModel fromJson(Map<String, Object?> json) => PatientModel(
        name: json['name'] as String,
        age: json['age'] as int,
        sex: json['sex'] as String,
        address: json['address'] as String,
        is_VOT: json['is_VOT'] as String,
        treatment_start_date: json['treatment_start_date'] as String,
        isSync: json['isSync'] as int,
      );

        Map<String, Object?> toJson() => {
          'name' : 'name',
          'age' : 'age',
          'sex' : 'sex',
          'address' : 'address',
          'is_VOT' : 'is_VOT',
          'treatment_start_date' : 'treatment_start_date'
        };
}
