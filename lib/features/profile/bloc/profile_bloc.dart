import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';
import 'package:overload_pro_app/product/models/user_profile_model.dart';
import 'package:overload_pro_app/product/models/weight_record_model.dart';
import 'package:overload_pro_app/features/profile/repositories/profile_repository.dart';
import 'package:overload_pro_app/features/profile/bloc/profile_event.dart';
import 'package:overload_pro_app/features/profile/bloc/profile_state.dart';

/// Profil yönetimi için BLoC sınıfı
/// Kullanıcı profilini ve kilo kayıtlarını yönetir
class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc(this._repository) : super(ProfileInitial()) {
    // Event handler'ları tanımlama
    on<LoadProfile>(_onLoadProfile);
    on<UpdateProfile>(_onUpdateProfile);
    on<AddWeightRecord>(_onAddWeightRecord);
    on<DeleteWeightRecord>(_onDeleteWeightRecord);
  }
  // Benzersiz ID oluşturmak için UUID kütüphanesi
  final _uuid = const Uuid();
  // Profil verilerini yönetmek için repository
  final ProfileRepository _repository;
  // Mevcut kullanıcı profili
  UserProfileModel? _profile;
  // Kullanıcının kilo kayıtları listesi
  List<WeightRecordModel> _weightRecords = [];

  /// Profil bilgilerini yükler
  /// Eğer profil yoksa varsayılan değerlerle yeni profil oluşturur
  Future<void> _onLoadProfile(LoadProfile event, Emitter<ProfileState> emit) async {
    try {
      emit(ProfileLoading());

      // Profil bilgilerini repository'den al
      _profile = await _repository.getProfile();
      // Profil yoksa varsayılan değerlerle oluştur
      _profile ??= UserProfileModel(
        id: _uuid.v4(),
        name: 'John Doe',
        height: 180,
        targetWeight: 70,
        weight: 70,
        birthDate: DateTime(1990),
      );

      // Kilo kayıtlarını al
      _weightRecords = await _repository.getWeightRecords();

      // Profil yüklendi durumunu bildir
      emit(
        ProfileLoaded(
          profile: _profile!,
          weightRecords: _weightRecords,
        ),
      );
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }

  /// Profil bilgilerini günceller
  /// İsim, boy, hedef kilo, kilo ve fotoğraf bilgilerini değiştirir
  Future<void> _onUpdateProfile(UpdateProfile event, Emitter<ProfileState> emit) async {
    try {
      emit(ProfileLoading());

      // Profil bilgilerini güncelle
      final oldWeight = _profile?.weight ?? 0;
      _profile = _profile?.copyWith(
        name: event.name,
        height: event.height,
        targetWeight: event.targetWeight,
        weight: event.weight,
        photoUrl: event.photoUrl,
      );

      // Eğer kilo değiştiyse ve yeni kilo sıfırdan büyükse, her seferinde yeni kayıt ekle
      final now = DateTime.now();
      if (event.weight > 0 && event.weight != oldWeight) {
        final newRecord = WeightRecordModel(
          id: _uuid.v4(),
          weight: event.weight,
          date: now,
        );
        await _repository.addWeightRecord(newRecord);
        _weightRecords = await _repository.getWeightRecords();
      }

      if (_profile != null) {
        // Güncellenmiş profili kaydet
        await _repository.saveProfile(_profile!);
        emit(
          ProfileLoaded(
            profile: _profile!,
            weightRecords: _weightRecords,
          ),
        );
      }
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }

  /// Yeni kilo kaydı ekler
  /// Tarih otomatik olarak şu anki zaman olarak ayarlanır
  Future<void> _onAddWeightRecord(AddWeightRecord event, Emitter<ProfileState> emit) async {
    try {
      emit(ProfileLoading());

      // Yeni kilo kaydı oluştur
      final newRecord = WeightRecordModel(
        id: _uuid.v4(),
        weight: event.weight,
        date: DateTime.now(),
        note: event.note,
      );

      // Kaydı ekle ve güncel listeyi al
      await _repository.addWeightRecord(newRecord);
      _weightRecords = await _repository.getWeightRecords();

      if (_profile != null) {
        emit(
          ProfileLoaded(
            profile: _profile!,
            weightRecords: _weightRecords,
          ),
        );
      }
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }

  /// Kilo kaydını siler
  /// Verilen ID'ye sahip kaydı listeden kaldırır
  Future<void> _onDeleteWeightRecord(DeleteWeightRecord event, Emitter<ProfileState> emit) async {
    try {
      emit(ProfileLoading());

      // Kaydı sil ve güncel listeyi al
      await _repository.deleteWeightRecord(event.recordId);
      _weightRecords = await _repository.getWeightRecords();

      if (_profile != null) {
        emit(
          ProfileLoaded(
            profile: _profile!,
            weightRecords: _weightRecords,
          ),
        );
      }
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }
}
