import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import '../domain/entities/chat_message.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  DatabaseHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, 'chat.db');
    return openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE chats (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        text TEXT,
        imageUrl TEXT,
        userId TEXT,
        createdAt TEXT
      )
    ''');
  }

  Future<void> insertMessage(ChatMessage message) async {
    final db = await database;
    await db.insert('chats', message.toMap());
  }

  Future<List<ChatMessage>> getMessages() async {
    final db = await database;
    final maps = await db.query('chats', orderBy: 'createdAt DESC');
    return List.generate(maps.length, (i) {
      return ChatMessage.fromMap(maps[i]);
    });
  }
}
