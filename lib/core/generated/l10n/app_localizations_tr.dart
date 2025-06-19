// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Turkish (`tr`).
class AppLocalizationsTr extends AppLocalizations {
  AppLocalizationsTr([String locale = 'tr']) : super(locale);

  @override
  String get muscleGroupAll => 'Tümü';

  @override
  String get muscleGroupChest => 'Göğüs';

  @override
  String get muscleGroupBack => 'Sırt';

  @override
  String get muscleGroupLegs => 'Bacak';

  @override
  String get muscleGroupShoulders => 'Omuz';

  @override
  String get muscleGroupArms => 'Kol';

  @override
  String get muscleGroupAbs => 'Karın';

  @override
  String get muscleGroupGlutes => 'Kalça';

  @override
  String get categorySelectHint => 'Kategori Seçin';

  @override
  String get categoryLabel => 'Kategori';

  @override
  String get appName => 'Overload Pro';

  @override
  String get save => 'Kaydet';

  @override
  String get cancel => 'İptal';

  @override
  String get delete => 'Sil';

  @override
  String get edit => 'Düzenle';

  @override
  String get navHome => 'Antrenman';

  @override
  String get navHistory => 'Geçmiş';

  @override
  String get navProfile => 'Profil';

  @override
  String get homeTitle => 'Antrenmanlar';

  @override
  String get noWorkouts => 'Henüz hareket eklenmemiş';

  @override
  String get kgFormat => 'kg';

  @override
  String get setFormat => 'set';

  @override
  String get repFormat => 'tekrar';

  @override
  String get addWorkout => 'Yeni Hareket Ekle';

  @override
  String get exerciseName => 'Hareket Adı';

  @override
  String get exerciseHint => 'Örn: Squat, Bench Press';

  @override
  String get weight => 'Ağırlık';

  @override
  String get weightHint => 'Örn: 60.5';

  @override
  String get sets => 'Set Sayısı';

  @override
  String get setsHint => 'Örn: 3';

  @override
  String get reps => 'Tekrar Sayısı';

  @override
  String get repsHint => 'Örn: 12';

  @override
  String get notes => 'Notlar (Opsiyonel)';

  @override
  String get notesHint => 'Eklemek istediğiniz notlar...';

  @override
  String get category => 'Kategori';

  @override
  String get selectCategory => 'Kategori Seçin';

  @override
  String get selectExercise => 'Egzersiz Seç';

  @override
  String get selectExerciseFirst => 'Lütfen önce bir egzersiz seçin';

  @override
  String get setType => 'Set Tipi';

  @override
  String get selectSetType => 'Set Tipini Seçin';

  @override
  String get historyTitle => 'Antrenman Geçmişi';

  @override
  String get noHistory => 'Geçmiş antrenman bulunmuyor';

  @override
  String get profileTitle => 'Profil';

  @override
  String get statistics => 'İstatistikler';

  @override
  String get totalWorkouts => 'Toplam Antrenman';

  @override
  String get mostUsedExercise => 'En Çok Yapılan Hareket';

  @override
  String get maxWeight => 'En Yüksek Kilo';

  @override
  String get requiredField => 'Bu alan zorunludur';

  @override
  String get enterValidNumber => 'Lütfen geçerli bir sayı girin';

  @override
  String get enterValidInteger => 'Lütfen geçerli bir tam sayı girin';

  @override
  String get searchExercise => 'Egzersiz ara...';

  @override
  String get noExercisesFound => 'Egzersiz bulunamadı';

  @override
  String get required => 'Bu alan zorunludur';

  @override
  String get kg => 'kg';

  @override
  String get noCategoryWorkouts => 'Bu kategoride henüz antrenman kaydı yok';

  @override
  String noCategoryWorkoutsDetail(String category) {
    return '$category kategorisinde henüz antrenman kaydınız bulunmuyor. Yeni bir antrenman ekleyerek başlayabilirsiniz.';
  }

  @override
  String get noWorkoutsDetail =>
      'Henüz antrenman kaydınız bulunmuyor. Yeni bir antrenman ekleyerek başlayabilirsiniz.';

  @override
  String get personalBest => 'Rekor';

  @override
  String totalSets(int count) {
    return 'Toplam: $count';
  }

  @override
  String get editPersonalInfo => 'Kişisel Bilgileri Düzenle';

  @override
  String get currentWeight => 'Güncel Kilo';

  @override
  String get targetWeight => 'Hedef Kilo';

  @override
  String get height => 'Boy';

  @override
  String get personalInfo => 'Kişisel Bilgiler';

  @override
  String get weightTracking => 'Kilo Takibi';

  @override
  String get darkMode => 'Karanlık Mod';

  @override
  String get lightMode => 'Aydınlık Mod';

  @override
  String get privacyPolicy => 'Gizlilik Politikası';

  @override
  String get lastWorkoutDetails => 'Son Antrenman Detayları';

  @override
  String progressChart(String exerciseName) {
    return '$exerciseName İlerleme Grafiği';
  }

  @override
  String get highest => 'En Yüksek';

  @override
  String get lowest => 'En Düşük';

  @override
  String get bmi => 'BMI';

  @override
  String get bmiUnderweight => 'Zayıf';

  @override
  String get bmiNormal => 'Normal';

  @override
  String get bmiOverweight => 'Kilolu';

  @override
  String get bmiObese => 'Obez';

  @override
  String get weightHistory => 'Kilo Geçmişi';

  @override
  String get noWeightRecords => 'Kilo kaydı bulunamadı';

  @override
  String get targetReached => 'Tebrikler! Hedef kilona ulaştın!';

  @override
  String kgToTarget(Object kg) {
    return 'Hedefe $kg kg kaldı, devam et!';
  }

  @override
  String belowTarget(Object kg) {
    return 'Hedefinin $kg kg altındasın! Harika!';
  }

  @override
  String get minWeight => 'En Düşük Kilo';

  @override
  String get biggestLoss => 'En Büyük Kilo Kaybı';

  @override
  String get biggestGain => 'En Büyük Kilo Artışı';

  @override
  String get seeWeightHistory => 'Kilo geçmişini görüntüle';
}
