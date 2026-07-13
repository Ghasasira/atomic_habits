import 'package:drift/drift.dart' as drift;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/constants/enums.dart';
import '../../core/theme/app_theme.dart';
import '../../core/utils/date_x.dart';
import '../../core/utils/format.dart';
import '../../data/database/database.dart';
import '../../providers/habit_provider.dart';

/// Create or edit a habit (FR-1.1, FR-1.2, FR-1.3).
class HabitFormScreen extends StatefulWidget {
  const HabitFormScreen({super.key, this.habit});

  /// When non-null the form edits an existing habit, otherwise it creates one.
  final Habit? habit;

  @override
  State<HabitFormScreen> createState() => _HabitFormScreenState();
}

class _HabitFormScreenState extends State<HabitFormScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  late final TextEditingController _categoryController;

  late TimeOfDay _time;
  late FrequencyType _frequency;
  late int _weekdaysMask;
  late int _intervalDays;
  late int _colorValue;
  late bool _reminderEnabled;

  static const _categorySuggestions = [
    'Health',
    'Fitness',
    'Mind',
    'Study',
    'Work',
    'Finance',
  ];

  bool get _isEditing => widget.habit != null;

  @override
  void initState() {
    super.initState();
    final habit = widget.habit;
    _nameController = TextEditingController(text: habit?.name ?? '');
    _categoryController =
        TextEditingController(text: habit?.category ?? 'General');
    _time = TimeOfDay(
      hour: habit?.targetHour ?? 8,
      minute: habit?.targetMinute ?? 0,
    );
    _frequency = habit?.frequency ?? FrequencyType.daily;
    _weekdaysMask = habit?.weekdaysMask ?? kAllWeekdaysMask;
    _intervalDays = habit?.intervalDays ?? 2;
    _colorValue = habit?.colorValue ?? AppTheme.habitPalette.first.toARGB32();
    _reminderEnabled = habit?.reminderEnabled ?? true;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _categoryController.dispose();
    super.dispose();
  }

  Future<void> _pickTime() async {
    final picked = await showTimePicker(context: context, initialTime: _time);
    if (picked != null) setState(() => _time = picked);
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    if (_frequency == FrequencyType.weekly && _weekdaysMask == 0) {
      _showError('Pick at least one day of the week.');
      return;
    }

    final provider = context.read<HabitProvider>();
    final name = _nameController.text.trim();
    final category = _categoryController.text.trim().isEmpty
        ? 'General'
        : _categoryController.text.trim();

    if (_isEditing) {
      await provider.updateHabit(
        widget.habit!.copyWith(
          name: name,
          category: category,
          targetHour: _time.hour,
          targetMinute: _time.minute,
          frequency: _frequency,
          weekdaysMask: _weekdaysMask,
          intervalDays: _intervalDays,
          colorValue: _colorValue,
          reminderEnabled: _reminderEnabled,
        ),
      );
    } else {
      await provider.createHabit(
        HabitsCompanion.insert(
          name: name,
          category: drift.Value(category),
          targetHour: drift.Value(_time.hour),
          targetMinute: drift.Value(_time.minute),
          frequency: drift.Value(_frequency),
          weekdaysMask: drift.Value(_weekdaysMask),
          intervalDays: drift.Value(_intervalDays),
          colorValue: drift.Value(_colorValue),
          reminderEnabled: drift.Value(_reminderEnabled),
        ),
      );
    }
    if (mounted) Navigator.of(context).pop();
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(_isEditing ? 'Edit habit' : 'New habit')),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 96),
          children: [
            TextFormField(
              controller: _nameController,
              textCapitalization: TextCapitalization.sentences,
              decoration: const InputDecoration(
                labelText: 'Habit name',
                hintText: 'e.g. Drink water',
              ),
              validator: (value) =>
                  (value == null || value.trim().isEmpty) ? 'Required' : null,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _categoryController,
              textCapitalization: TextCapitalization.sentences,
              decoration: const InputDecoration(labelText: 'Category'),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              children: [
                for (final suggestion in _categorySuggestions)
                  ActionChip(
                    label: Text(suggestion),
                    onPressed: () =>
                        setState(() => _categoryController.text = suggestion),
                  ),
              ],
            ),
            const SizedBox(height: 24),
            _SectionLabel('Reminder time', theme: theme),
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const Icon(Icons.access_time),
              title: Text(formatHourMinute(_time.hour, _time.minute)),
              trailing: const Icon(Icons.edit),
              onTap: _pickTime,
            ),
            const SizedBox(height: 16),
            _SectionLabel('Frequency', theme: theme),
            const SizedBox(height: 8),
            SegmentedButton<FrequencyType>(
              segments: const [
                ButtonSegment(
                    value: FrequencyType.daily, label: Text('Daily')),
                ButtonSegment(
                    value: FrequencyType.weekly, label: Text('Days')),
                ButtonSegment(
                    value: FrequencyType.interval, label: Text('Interval')),
              ],
              selected: {_frequency},
              onSelectionChanged: (s) => setState(() => _frequency = s.first),
            ),
            const SizedBox(height: 12),
            if (_frequency == FrequencyType.weekly) _buildWeekdayPicker(),
            if (_frequency == FrequencyType.interval) _buildIntervalPicker(),
            const SizedBox(height: 16),
            _SectionLabel('Colour', theme: theme),
            const SizedBox(height: 8),
            _buildColorPicker(),
            const SizedBox(height: 8),
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              value: _reminderEnabled,
              onChanged: (v) => setState(() => _reminderEnabled = v),
              title: const Text('Alarm reminder'),
              subtitle: const Text('Ring at the target time'),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _save,
        icon: const Icon(Icons.check),
        label: Text(_isEditing ? 'Save' : 'Create'),
      ),
    );
  }

  Widget _buildWeekdayPicker() {
    return Wrap(
      spacing: 8,
      children: [
        for (var wd = DateTime.monday; wd <= DateTime.sunday; wd++)
          FilterChip(
            label: Text(kShortWeekdayLabels[wd - 1]),
            selected: _weekdaysMask.hasWeekday(wd),
            onSelected: (sel) => setState(
                () => _weekdaysMask = _weekdaysMask.toggleWeekday(wd, sel)),
          ),
      ],
    );
  }

  Widget _buildIntervalPicker() {
    return Row(
      children: [
        const Text('Every'),
        const SizedBox(width: 12),
        IconButton.filledTonal(
          onPressed: _intervalDays > 1
              ? () => setState(() => _intervalDays--)
              : null,
          icon: const Icon(Icons.remove),
        ),
        SizedBox(
          width: 48,
          child: Text(
            '$_intervalDays',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        IconButton.filledTonal(
          onPressed: () => setState(() => _intervalDays++),
          icon: const Icon(Icons.add),
        ),
        const SizedBox(width: 12),
        const Text('days'),
      ],
    );
  }

  Widget _buildColorPicker() {
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: [
        for (final color in AppTheme.habitPalette)
          GestureDetector(
            onTap: () => setState(() => _colorValue = color.toARGB32()),
            child: CircleAvatar(
              backgroundColor: color,
              radius: 20,
              child: _colorValue == color.toARGB32()
                  ? const Icon(Icons.check, color: Colors.white)
                  : null,
            ),
          ),
      ],
    );
  }
}

class _SectionLabel extends StatelessWidget {
  const _SectionLabel(this.text, {required this.theme});
  final String text;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Text(
      text.toUpperCase(),
      style: theme.textTheme.labelMedium?.copyWith(
        color: theme.colorScheme.primary,
        letterSpacing: 0.8,
      ),
    );
  }
}
