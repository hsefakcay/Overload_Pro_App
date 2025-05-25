import 'package:flutter/material.dart';
import 'package:overload_pro_app/product/models/set_model.dart'
    show SetModel, SetType, SetTypeExtension;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:overload_pro_app/core/extensions/context_extension.dart';
import 'package:overload_pro_app/core/mixins/localization_mixin.dart';
import 'package:overload_pro_app/features/workout/presentation/bloc/workout_bloc.dart';
import 'package:overload_pro_app/features/workout/presentation/bloc/workout_event.dart';
import 'package:overload_pro_app/features/workout/presentation/widgets/custom_text_field.dart';

class EditWorkoutPage extends StatefulWidget {
  const EditWorkoutPage({
    required this.workout,
    super.key,
  });
  final SetModel workout;

  @override
  State<EditWorkoutPage> createState() => _EditWorkoutPageState();
}

class _EditWorkoutPageState extends State<EditWorkoutPage> with LocalizationMixin {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _weightController;
  late TextEditingController _repsController;
  late TextEditingController _notesController;
  late SetType _selectedSetType;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _weightController = TextEditingController(text: widget.workout.weight.toString());
    _repsController = TextEditingController(text: widget.workout.reps.toString());
    _notesController = TextEditingController(text: widget.workout.notes ?? '');
    _selectedSetType = widget.workout.setType;
  }

  @override
  void dispose() {
    _weightController.dispose();
    _repsController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      final updatedWorkout = widget.workout.copyWith(
        weight: double.parse(_weightController.text),
        reps: int.parse(_repsController.text),
        setType: _selectedSetType,
        notes: _notesController.text.isEmpty ? null : _notesController.text,
      );

      context.read<WorkoutBloc>().add(UpdateWorkout(updatedWorkout));

      setState(() {
        _isLoading = false;
      });

      if (mounted) {
        Navigator.pop(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.edit),
      ),
      body: SingleChildScrollView(
        padding: context.paddingMedium,
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                widget.workout.exercise.name,
                style: context.titleLarge.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: context.mediumValue),
              CustomTextField(
                controller: _weightController,
                labelText: l10n.weight,
                hintText: l10n.weightHint,
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return l10n.requiredField;
                  }
                  final weight = double.tryParse(value);
                  if (weight == null || weight <= 0) {
                    return l10n.enterValidNumber;
                  }
                  return null;
                },
              ),
              SizedBox(height: context.mediumValue),
              CustomTextField(
                controller: _repsController,
                labelText: l10n.reps,
                hintText: l10n.repsHint,
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return l10n.requiredField;
                  }
                  final reps = int.tryParse(value);
                  if (reps == null || reps <= 0) {
                    return l10n.enterValidInteger;
                  }
                  return null;
                },
              ),
              SizedBox(height: context.mediumValue),
              DropdownButtonFormField<SetType>(
                value: _selectedSetType,
                decoration: InputDecoration(
                  labelText: l10n.setType,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(context.lowValue),
                  ),
                  contentPadding: context.paddingMedium,
                ),
                items: SetType.values.map((type) {
                  return DropdownMenuItem(
                    value: type,
                    child: Text(type.displayName),
                  );
                }).toList(),
                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      _selectedSetType = value;
                    });
                  }
                },
              ),
              SizedBox(height: context.mediumValue),
              CustomTextField(
                controller: _notesController,
                labelText: l10n.notes,
                hintText: l10n.notesHint,
                maxLines: 3,
              ),
              SizedBox(height: context.highValue),
              ElevatedButton(
                onPressed: _isLoading ? null : _submitForm,
                style: ElevatedButton.styleFrom(
                  padding: context.paddingMedium,
                ),
                child: _isLoading ? const CircularProgressIndicator() : Text(l10n.save),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
