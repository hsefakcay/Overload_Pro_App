import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:overload_pro_app/product/models/user_profile_model.dart';
import 'package:overload_pro_app/product/models/weight_record_model.dart';

/// Repository for managing user profile and weight records in local storage.
class ProfileRepository {
  /// Creates a new instance of [ProfileRepository].
  ProfileRepository(this._prefs);
  static const String _profileKey = 'user_profile';
  static const String _weightRecordsKey = 'weight_records';
  final SharedPreferences _prefs;

  /// Retrieves the user profile from local storage.
  Future<UserProfileModel?> getProfile() async {
    final profileJson = _prefs.getString(_profileKey);
    if (profileJson != null) {
      return UserProfileModel.fromJson(json.decode(profileJson) as Map<String, dynamic>);
    }
    return null;
  }

  /// Saves the user profile to local storage.
  Future<void> saveProfile(UserProfileModel profile) async {
    await _prefs.setString(_profileKey, json.encode(profile.toJson()));
  }

  /// Retrieves all weight records sorted by date in descending order.
  Future<List<WeightRecordModel>> getWeightRecords() async {
    final recordsJson = _prefs.getStringList(_weightRecordsKey);
    if (recordsJson != null) {
      return recordsJson
          .map(
            (record) => WeightRecordModel.fromJson(
              json.decode(record) as Map<String, dynamic>,
            ),
          )
          .toList()
        ..sort((a, b) => b.date.compareTo(a.date));
    }
    return [];
  }

  /// Saves the list of weight records to local storage.
  Future<void> saveWeightRecords(List<WeightRecordModel> records) async {
    final recordsJson = records.map((record) => json.encode(record.toJson())).toList();
    await _prefs.setStringList(_weightRecordsKey, recordsJson);
  }

  /// Adds a new weight record and saves it to local storage.
  Future<void> addWeightRecord(WeightRecordModel record) async {
    final records = await getWeightRecords();
    records.add(record);
    records.sort((a, b) => b.date.compareTo(a.date));
    await saveWeightRecords(records);
  }

  /// Deletes a weight record by its ID from local storage.
  Future<void> deleteWeightRecord(String recordId) async {
    final records = await getWeightRecords();
    records.removeWhere((record) => record.id == recordId);
    await saveWeightRecords(records);
  }
}
