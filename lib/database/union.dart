import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:union/models/patient.dart';

class UnionDB {
  static final UnionDB instance = UnionDB._init();

  static Database? _database;
  static const patientTable = 'patients';


  UnionDB._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('union.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  static Future _createDB(Database db, int version) async {
    const idAutoType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const integerType = 'INTEGER NOT NULL';
    const integerNULLType = 'INTEGER';
    const textType = 'TEXT NOT NULL';
    const textNullType = 'TEXT';
    const blobType = 'BLOB';
    const realType = 'REAL NOT NULL';


    await db.execute('''  
        CREATE TABLE $patientTable (
          id $idAutoType,
          name $textNullType,
          age $integerNULLType,
          sex $textNullType,
          address $textNullType,
          is_VOT $textNullType,
          treatment_start_date $textNullType,
          isSync $integerNULLType)''');
  }

  static Future<void> batchInsertPatients(List<dynamic> patients) async {
    final Database db = await instance.database;

    var batch = db.batch();

    for (var patient in patients) {
      patient['isSync'] = 1;
      batch.insert(patientTable, {
        "name": patient['name'],
        "age": patient['age'],
        "sex": patient['sex'],
        "address": patient['address'],
        "is_VOT": patient['is_VOT'],
        "treatment_start_date": patient['treatment_start_date'],
        "isSync": 1,
      });
    }
    await batch.commit();
  }

  Future<PatientModel> createPatient(PatientModel data) async {
    final db = await instance.database;

    final id = await db.insert(patientTable, {
      'name' : data.name,
      'age' : data.age,
      'sex' : data.sex,
      'address' : data.address,
      'is_VOT' : data.is_VOT,
      'treatment_start_date' : data.treatment_start_date,
      'isSync' : 0,
    });

    return readPatient(id);
    // return data.copy(id: id);
  }

  static Future<PatientModel> readPatient(int id) async {
    final db = await instance.database;
    final maps = await db.query(
      patientTable,
      // columns: PatientField.values,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return PatientModel.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  static Future<List<PatientModel>> readAllPatients() async {
    final db = await instance.database;
//     await db.execute('''ALTER TABLE $patientTable
// ADD COLUMN address TEXT''');

    String query =
        'SELECT * FROM patients';

    final List<Map<String, dynamic>> result = await db.rawQuery(query);
    return result.map((json) => PatientModel.fromJson(json)).toList();
  }

  static Future<List<PatientModel>> notSyncPatients(
    ) async {
    final db = await instance.database;
    String query =
        'SELECT * FROM patients WHERE isSync = "0"';

    final List<Map<String, dynamic>> result = await db.rawQuery(query);
    return result.map((json) => PatientModel.fromJson(json)).toList();
  }

  Future<int> delete(int id) async {
    final db = await instance.database;

    return await db.delete(
      patientTable,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future close() async {
    final db = await instance.database;
    _database = null;
    db.close();
  }

  Future<int> updatePatient(int id, Map<String, dynamic> updates) async {
    final db = await instance.database;

    final result =
        await db.update('patients', updates, where: 'id = ?', whereArgs: [id]);
    return result;
  }

  static Future<void> deleteAllPatients() async {
    final db = await instance.database;
    await db.delete(
      patientTable,
    );
  }
}
