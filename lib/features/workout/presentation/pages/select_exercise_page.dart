import 'package:flutter/material.dart';
import 'package:weight_tracker_app/core/mixins/localization_mixin.dart';
import '../../../../core/extensions/context_extension.dart';
import '../../../../product/models/exercise_model.dart';
import '../../../exercise/data/repositories/exercise_repository.dart';
import '../../../../core/constants/color_constants.dart';
import '../widgets/custom_dropdown.dart';

class SelectExercisePage extends StatefulWidget {
  const SelectExercisePage({super.key});

  @override
  State<SelectExercisePage> createState() => _SelectExercisePageState();
}

class _SelectExercisePageState extends State<SelectExercisePage> with LocalizationMixin {
  final _exerciseRepository = ExerciseRepository();
  String? _selectedCategory;
  final _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<ExerciseModel> _getFilteredExercises() {
    List<ExerciseModel> exercises =
        _selectedCategory != null && _selectedCategory != l10n.muscleGroupAll
            ? _exerciseRepository.getExercisesByMuscleGroup(_selectedCategory!, context)
            : _exerciseRepository.getAllExercises();

    if (_searchQuery.isNotEmpty) {
      exercises = exercises
          .where((exercise) =>
              exercise.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
              (_exerciseRepository
                  .getMuscleGroupTranslation(context, exercise.muscleGroup ?? '')
                  .toLowerCase()
                  .contains(_searchQuery.toLowerCase())))
          .toList();
    }

    return exercises;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          l10n.searchExercise,
          style: context.titleMedium,
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: context.paddingMedium,
            child: Column(
              children: [
                _buildSearchField(),
                SizedBox(height: context.lowValue),
                _buildCategoryDropdown(),
              ],
            ),
          ),
          Expanded(child: _buildExerciseList()),
        ],
      ),
    );
  }

  Widget _buildSearchField() {
    return TextField(
      controller: _searchController,
      decoration: InputDecoration(
        hintText: l10n.searchExercise,
        prefixIcon: const Icon(Icons.search),
        suffixIcon: _searchQuery.isNotEmpty
            ? IconButton(
                icon: const Icon(Icons.clear),
                onPressed: () {
                  setState(() {
                    _searchController.clear();
                    _searchQuery = '';
                  });
                },
              )
            : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(context.lowValue),
        ),
        contentPadding: EdgeInsets.symmetric(
          horizontal: context.lowValue,
          vertical: context.lowValue,
        ),
      ),
      onChanged: (value) {
        setState(() {
          _searchQuery = value;
        });
      },
    );
  }

  Widget _buildCategoryDropdown() {
    final categories = [l10n.muscleGroupAll, ..._exerciseRepository.getAllMuscleGroups(context)];

    return CustomDropdown<String>(
      value: _selectedCategory,
      labelText: l10n.category,
      hintText: l10n.selectCategory,
      items: categories.map(_buildDropdownMenuItem).toList(),
      onChanged: (value) => setState(() => _selectedCategory = value),
      menuMaxHeight: context.height * 0.6,
    );
  }

  DropdownMenuItem<String> _buildDropdownMenuItem(String? category) {
    if (category == l10n.muscleGroupAll) {
      return DropdownMenuItem(
        value: category,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: context.lowValue,
            vertical: context.lowValue / 2,
          ),
          child: Text(category ?? ""),
        ),
      );
    }

    final color = MuscleGroupColors.getColorForMuscleGroup(category);
    return DropdownMenuItem(
      value: category,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: context.lowValue,
          vertical: context.lowValue / 2,
        ),
        child: Row(
          children: [
            Container(
              width: 12,
              height: 12,
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
              ),
            ),
            SizedBox(width: context.lowValue),
            Text(category ?? ""),
          ],
        ),
      ),
    );
  }

  Widget _buildExerciseList() {
    final exercises = _getFilteredExercises();

    if (exercises.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.search_off,
              size: 48,
              color: Theme.of(context).colorScheme.primary.withOpacity(0.5),
            ),
            const SizedBox(height: 16),
            Text(
              l10n.noExercisesFound,
              style: context.bodyMedium.copyWith(
                color: Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(0.7),
              ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: context.paddingMedium,
      itemCount: exercises.length,
      itemBuilder: (context, index) => _buildExerciseItem(exercises[index]),
    );
  }

  Widget _buildExerciseItem(ExerciseModel exercise) {
    final muscleGroupColor = MuscleGroupColors.getColorForMuscleGroup(
        _exerciseRepository.getMuscleGroupTranslation(context, exercise.muscleGroup ?? ''));
    final lightColor = MuscleGroupColors.getLightColorForMuscleGroup(
        _exerciseRepository.getMuscleGroupTranslation(context, exercise.muscleGroup ?? ''));

    return Card(
      margin: EdgeInsets.only(bottom: context.lowValue),
      child: ListTile(
        contentPadding: EdgeInsets.all(context.lowValue),
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.asset(
            exercise.imageUrl ?? "",
            width: 50,
            height: 50,
            fit: BoxFit.cover,
          ),
        ),
        title: Text(
          exercise.name,
          style: context.bodyMedium.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Container(
          margin: EdgeInsets.only(top: context.lowValue / 2),
          padding: EdgeInsets.symmetric(
            horizontal: context.lowValue,
            vertical: context.lowValue / 2,
          ),
          decoration: BoxDecoration(
            color: lightColor,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            _exerciseRepository.getMuscleGroupTranslation(context, exercise.muscleGroup ?? ''),
            style: context.bodySmall.copyWith(
              color: muscleGroupColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        onTap: () => Navigator.pop(context, exercise),
      ),
    );
  }
}
