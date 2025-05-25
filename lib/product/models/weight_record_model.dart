import 'package:equatable/equatable.dart';

class WeightRecordModel extends Equatable {
  final String id;
  final double weight;
  final DateTime date;
  final String? note;

  const WeightRecordModel({
    required this.id,
    required this.weight,
    required this.date,
    this.note,
  });

  @override
  List<Object?> get props => [id, weight, date, note];

  WeightRecordModel copyWith({
    String? id,
    double? weight,
    DateTime? date,
    String? note,
  }) {
    return WeightRecordModel(
      id: id ?? this.id,
      weight: weight ?? this.weight,
      date: date ?? this.date,
      note: note ?? this.note,
    );
  }

  factory WeightRecordModel.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return WeightRecordModel(
        id: '',
        weight: 0.0,
        date: DateTime.now(),
      );
    }
    return WeightRecordModel(
      id: json['id']?.toString() ?? '',
      weight: (json['weight'] as num?)?.toDouble() ?? 0.0,
      date: json['date'] != null ? DateTime.parse(json['date'].toString()) : DateTime.now(),
      note: json['note']?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'weight': weight,
      'date': date.toIso8601String(),
      'note': note,
    };
  }
}
