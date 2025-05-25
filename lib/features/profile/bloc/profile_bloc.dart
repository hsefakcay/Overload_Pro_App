import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';
import '../../../product/models/user_profile_model.dart';
import '../../../product/models/weight_record_model.dart';
import '../repositories/profile_repository.dart';
import 'profile_event.dart';
import 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final _uuid = const Uuid();
  final ProfileRepository _repository;
  UserProfileModel? _profile;
  List<WeightRecordModel> _weightRecords = [];

  ProfileBloc(this._repository) : super(ProfileInitial()) {
    on<LoadProfile>(_onLoadProfile);
    on<UpdateProfile>(_onUpdateProfile);
    on<AddWeightRecord>(_onAddWeightRecord);
    on<DeleteWeightRecord>(_onDeleteWeightRecord);
  }

  void _onLoadProfile(LoadProfile event, Emitter<ProfileState> emit) async {
    try {
      emit(ProfileLoading());

      _profile = await _repository.getProfile();
      _profile ??= UserProfileModel(
        id: _uuid.v4(),
        name: 'John Doe',
        height: 180,
        targetWeight: 70,
        birthDate: DateTime(1990),
      );

      _weightRecords = await _repository.getWeightRecords();

      emit(ProfileLoaded(
        profile: _profile!,
        weightRecords: _weightRecords,
      ));
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }

  void _onUpdateProfile(UpdateProfile event, Emitter<ProfileState> emit) async {
    try {
      emit(ProfileLoading());

      _profile = _profile?.copyWith(
        name: event.name,
        height: event.height,
        targetWeight: event.targetWeight,
      );

      if (_profile != null) {
        await _repository.saveProfile(_profile!);
        emit(ProfileLoaded(
          profile: _profile!,
          weightRecords: _weightRecords,
        ));
      }
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }

  void _onAddWeightRecord(AddWeightRecord event, Emitter<ProfileState> emit) async {
    try {
      emit(ProfileLoading());

      final newRecord = WeightRecordModel(
        id: _uuid.v4(),
        weight: event.weight,
        date: DateTime.now(),
        note: event.note,
      );

      await _repository.addWeightRecord(newRecord);
      _weightRecords = await _repository.getWeightRecords();

      if (_profile != null) {
        emit(ProfileLoaded(
          profile: _profile!,
          weightRecords: _weightRecords,
        ));
      }
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }

  void _onDeleteWeightRecord(DeleteWeightRecord event, Emitter<ProfileState> emit) async {
    try {
      emit(ProfileLoading());

      await _repository.deleteWeightRecord(event.recordId);
      _weightRecords = await _repository.getWeightRecords();

      if (_profile != null) {
        emit(ProfileLoaded(
          profile: _profile!,
          weightRecords: _weightRecords,
        ));
      }
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }
}
