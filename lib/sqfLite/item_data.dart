import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:machine_test_azinova/sqfLite/item.dart';

class ItemDatabase {
  static final ItemDatabase instance = ItemDatabase._init();

  static Database? _database;

  ItemDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('items.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    final textType = 'TEXT NOT NULL';
    final boolType = 'BOOLEAN NOT NULL';
    final integerType = 'INTEGER NOT NULL';

    await db.execute('''
    CREATE TABLE $tableItems (
    ${ItemFields.id} $idType,
  ${ItemFields.itemName} $textType,
  ${ItemFields.itemImage} $textType,
  ${ItemFields.itemDetails} $textType
    )
    ''');
  }

  Future<Items> create(Items items) async {
    final db = await instance.database;

    final id = await db.insert(tableItems, items.toJson());
    return items.copy(id: id);
  }

  Future<Items> readData(int id) async {
    final db = await instance.database;

    final maps = await db.query(tableItems,
        columns: ItemFields.values,
        where: '${ItemFields.id} = ?',
        whereArgs: [id]);

    if (maps.isNotEmpty) {
      return Items.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<List<Items>> readAllStudentData() async {
    final db = await instance.database;

    final result =
    await db.query(tableItems, orderBy: '${ItemFields.id} ASC');

    return result.map((json) => Items.fromJson(json)).toList();
  }

  Future<int> update(Items items) async {
    final db = await instance.database;

    return db.update(
      tableItems,
      items.toJson(),
      where: '${ItemFields.id} = ?',
      whereArgs: [items.id],
    );
  }

  Future<int> delete(int id) async {
    final db = await instance.database;

    return await db.delete(
      tableItems,
      where: '${ItemFields.id} = ?',
      whereArgs: [id],
    );
  }

  Future<int> deleteStatus0(int id) async {
    final db = await instance.database;

    return await db.delete(
      tableItems,
      where: '${ItemFields.itemName} = ?',
      whereArgs: [id],
    );
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
