import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:overload_pro_app/product/models/set_model.dart';
import 'package:flutter/foundation.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  factory DatabaseHelper() => _instance;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'workout_database.db');
    debugPrint('Database path: $path');
    return await openDatabase(
      path,
      version: 3,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE workouts(
        id TEXT PRIMARY KEY,
        exerciseId TEXT NOT NULL,
        exerciseName TEXT NOT NULL,
        exerciseDescription TEXT,
        exerciseImageUrl TEXT,
        exerciseVideoUrl TEXT,
        exerciseMuscleGroup TEXT,
        exerciseEquipment TEXT,
        exerciseIsCustom INTEGER NOT NULL DEFAULT 0,
        weight REAL NOT NULL,
        sets INTEGER NOT NULL,
        reps INTEGER NOT NULL,
        date TEXT NOT NULL,
        notes TEXT,
        setType INTEGER NOT NULL DEFAULT 0
      )
    ''');
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 3) {
      // Eski tabloyu sil ve yeniden oluştur
      await db.execute('DROP TABLE IF EXISTS workouts');
      await _onCreate(db, newVersion);
    }
  }

//insert workout
  Future<int> insertWorkout(SetModel workout) async {
    final db = await database;
    final exercise = workout.exercise;
    final Map<String, dynamic> row = {
      'id': workout.id,
      'exerciseId': exercise.id,
      'exerciseName': exercise.name,
      'exerciseDescription': exercise.description,
      'exerciseImageUrl': exercise.imageUrl,
      'exerciseVideoUrl': exercise.videoUrl,
      'exerciseMuscleGroup': exercise.muscleGroup,
      'exerciseEquipment': exercise.equipment,
      'exerciseIsCustom': exercise.isCustom ? 1 : 0,
      'weight': workout.weight,
      'sets': workout.reps,
      'reps': workout.reps,
      'date': workout.completedAt?.toIso8601String() ?? DateTime.now().toIso8601String(),
      'notes': workout.notes,
      'setType': workout.setType.index,
    };
    return await db.insert(
      'workouts',
      row,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

//get workouts
  Future<List<SetModel>> getWorkouts() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('workouts');
    return List.generate(maps.length, (i) {
      final map = maps[i];
      final exerciseMap = {
        'id': map['exerciseId'],
        'name': map['exerciseName'],
        'description': map['exerciseDescription'],
        'imageUrl': map['exerciseImageUrl'],
        'videoUrl': map['exerciseVideoUrl'],
        'muscleGroup': map['exerciseMuscleGroup'],
        'equipment': map['exerciseEquipment'],
        'isCustom': map['exerciseIsCustom'] == 1,
      };
      final workoutMap = {
        'id': map['id'],
        'weight': map['weight'],
        'reps': map['reps'],
        'setType': map['setType'],
        'order': map['order'],
        'isCompleted': true,
        'notes': map['notes'],
        'completedAt': map['date'],
        'exercise': exerciseMap,
      };
      return SetModel.fromJson(workoutMap);
    });
  }

//delete workout
  Future<int> deleteWorkout(String id) async {
    final db = await database;
    return await db.delete(
      'workouts',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

//update workout
  Future<int> updateWorkout(SetModel workout) async {
    final db = await database;
    final exercise = workout.exercise;
    final Map<String, dynamic> row = {
      'id': workout.id,
      'exerciseId': exercise.id,
      'exerciseName': exercise.name,
      'exerciseDescription': exercise.description,
      'exerciseImageUrl': exercise.imageUrl,
      'exerciseVideoUrl': exercise.videoUrl,
      'exerciseMuscleGroup': exercise.muscleGroup,
      'exerciseEquipment': exercise.equipment,
      'exerciseIsCustom': exercise.isCustom ? 1 : 0,
      'weight': workout.weight,
      'sets': workout.reps,
      'reps': workout.reps,
      'date': workout.completedAt?.toIso8601String() ?? DateTime.now().toIso8601String(),
      'notes': workout.notes,
      'setType': workout.setType.index,
    };
    return await db.update(
      'workouts',
      row,
      where: 'id = ?',
      whereArgs: [workout.id],
    );
  }
}
