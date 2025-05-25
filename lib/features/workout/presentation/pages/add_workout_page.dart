import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';
import 'package:weight_tracker_app/core/mixins/localization_mixin.dart';
import 'package:weight_tracker_app/product/models/set_model.dart';
import '../../../../core/extensions/context_extension.dart';
import '../../../../product/models/exercise_model.dart';
import '../../../exercise/data/repositories/exercise_repository.dart';
import '../bloc/workout_bloc.dart';
import '../bloc/workout_event.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/custom_dropdown.dart';
import 'select_exercise_page.dart';

class AddWorkoutPage extends StatefulWidget {
  const AddWorkoutPage({super.key});

  @override
  State<AddWorkoutPage> createState() => _AddWorkoutPageState();
}

class _AddWorkoutPageState extends State<AddWorkoutPage> with LocalizationMixin {
  final _formKey = GlobalKey<FormState>();
  final _exerciseRepository = ExerciseRepository();
  ExerciseModel? _selectedExercise;
  final _weightController = TextEditingController();
  final _repsController = TextEditingController();
  final _notesController = TextEditingController();

  SetType _selectedSetType = SetType.rir1_2;
  bool _isLoading = false;

  @override
  void dispose() {
    _weightController.dispose();
    _repsController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate() && _selectedExercise != null) {
      setState(() {
        _isLoading = true;
      });

      final workoutSet = SetModel(
        id: const Uuid().v4(),
        weight: double.parse(_weightController.text),
        reps: int.parse(_repsController.text),
        setType: _selectedSetType,
        exercise: _selectedExercise!,
      );

      context.read<WorkoutBloc>().add(AddWorkout(workoutSet));

      setState(() {
        _isLoading = false;
      });

      if (mounted) {
        Navigator.pop(context);
      }
    }
  }

  Future<void> _selectExercise() async {
    final exercise = await Navigator.push<ExerciseModel>(
      context,
      MaterialPageRoute(
        builder: (context) => const SelectExercisePage(),
      ),
    );

    if (exercise != null) {
      setState(() {
        _selectedExercise = exercise;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.addWorkout),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Card(
                child: ListTile(
                  leading: _selectedExercise != null
                      ? SizedBox(
                          width: 40,
                          height: 40,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.asset(
                              _selectedExercise!.imageUrl ?? '',
                              width: 40,
                              height: 40,
                              fit: BoxFit.cover,
                            ),
                          ),
                        )
                      : const SizedBox(
                          width: 40,
                          height: 40,
                          child: Icon(Icons.fitness_center),
                        ),
                  title: Text(
                    _selectedExercise?.name ?? l10n.selectExercise,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  subtitle: _selectedExercise != null
                      ? Text(_exerciseRepository.getMuscleGroupTranslation(
                          context, _selectedExercise!.muscleGroup ?? ''))
                      : null,
                  trailing: const Icon(Icons.chevron_right),
                  onTap: _selectExercise,
                ),
              ),
              if (_selectedExercise == null) ...[
                const SizedBox(height: 16),
                Text(
                  l10n.selectExerciseFirst,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).colorScheme.error,
                      ),
                  textAlign: TextAlign.center,
                ),
              ],
              if (_selectedExercise != null) ...[
                const SizedBox(height: 16),
                CustomTextField(
                  controller: _weightController,
                  labelText: l10n.weight,
                  hintText: '${l10n.weight} (${l10n.kg})',
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return l10n.requiredField;
                    }
                    if (double.tryParse(value) == null) {
                      return l10n.enterValidNumber;
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                CustomTextField(
                  controller: _repsController,
                  labelText: l10n.reps,
                  hintText: l10n.reps,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return l10n.requiredField;
                    }
                    if (int.tryParse(value) == null) {
                      return l10n.enterValidInteger;
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                CustomDropdown<SetType>(
                  value: _selectedSetType,
                  labelText: l10n.setType,
                  hintText: l10n.selectSetType,
                  items: SetType.values.map((type) {
                    return DropdownMenuItem(
                      value: type,
                      child: Text(type.toString().split('.').last.toUpperCase()),
                    );
                  }).toList(),
                  onChanged: (SetType? value) {
                    if (value != null) {
                      setState(() {
                        _selectedSetType = value;
                      });
                    }
                  },
                  menuMaxHeight: context.height * 0.3,
                ),
                const SizedBox(height: 16),
                CustomTextField(
                  controller: _notesController,
                  labelText: l10n.notes,
                  hintText: l10n.notes,
                  maxLines: 3,
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: _isLoading ? null : _submitForm,
                  child: _isLoading
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                          ),
                        )
                      : Text(l10n.save),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
