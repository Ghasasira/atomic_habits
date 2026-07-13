import 'package:drift/drift.dart' as drift;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/utils/format.dart';
import '../../data/database/database.dart';
import '../../providers/goal_provider.dart';

/// Create or edit a goal defined by a start, a target and a timeline (FR-4.1).
class GoalFormScreen extends StatefulWidget {
  const GoalFormScreen({super.key, this.goal});

  final Goal? goal;

  @override
  State<GoalFormScreen> createState() => _GoalFormScreenState();
}

class _GoalFormScreenState extends State<GoalFormScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _name;
  late final TextEditingController _description;
  late final TextEditingController _start;
  late final TextEditingController _target;
  late final TextEditingController _unit;
  late DateTime _startDate;
  late DateTime _endDate;

  bool get _isEditing => widget.goal != null;

  @override
  void initState() {
    super.initState();
    final goal = widget.goal;
    _name = TextEditingController(text: goal?.name ?? '');
    _description = TextEditingController(text: goal?.description ?? '');
    _start = TextEditingController(
        text: goal != null ? formatMetric(goal.startValue) : '');
    _target = TextEditingController(
        text: goal != null ? formatMetric(goal.targetValue) : '');
    _unit = TextEditingController(text: goal?.unit ?? '');
    _startDate = goal?.startDate ?? DateTime.now();
    _endDate =
        goal?.endDate ?? DateTime.now().add(const Duration(days: 30));
  }

  @override
  void dispose() {
    _name.dispose();
    _description.dispose();
    _start.dispose();
    _target.dispose();
    _unit.dispose();
    super.dispose();
  }

  Future<void> _pickDate({required bool isStart}) async {
    final initial = isStart ? _startDate : _endDate;
    final picked = await showDatePicker(
      context: context,
      initialDate: initial,
      firstDate: DateTime(2020),
      lastDate: DateTime(2035),
    );
    if (picked == null) return;
    setState(() {
      if (isStart) {
        _startDate = picked;
        if (_endDate.isBefore(_startDate)) {
          _endDate = _startDate.add(const Duration(days: 1));
        }
      } else {
        _endDate = picked;
      }
    });
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    if (!_endDate.isAfter(_startDate)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('End date must be after the start date.')),
      );
      return;
    }

    final provider = context.read<GoalProvider>();
    final name = _name.text.trim();
    final description = _description.text.trim();
    final startValue = double.parse(_start.text.trim());
    final targetValue = double.parse(_target.text.trim());
    final unit = _unit.text.trim();

    if (_isEditing) {
      await provider.updateGoal(
        widget.goal!.copyWith(
          name: name,
          description: drift.Value(description.isEmpty ? null : description),
          startValue: startValue,
          targetValue: targetValue,
          unit: unit,
          startDate: _startDate,
          endDate: _endDate,
        ),
      );
    } else {
      await provider.createGoal(
        GoalsCompanion.insert(
          name: name,
          description: drift.Value(description.isEmpty ? null : description),
          startValue: drift.Value(startValue),
          targetValue: targetValue,
          unit: drift.Value(unit),
          startDate: _startDate,
          endDate: _endDate,
        ),
      );
    }
    if (mounted) Navigator.of(context).pop();
  }

  String? _numberValidator(String? value) {
    if (value == null || value.trim().isEmpty) return 'Required';
    if (double.tryParse(value.trim()) == null) return 'Enter a number';
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_isEditing ? 'Edit goal' : 'New goal')),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 96),
          children: [
            TextFormField(
              controller: _name,
              textCapitalization: TextCapitalization.sentences,
              decoration: const InputDecoration(
                labelText: 'Goal name',
                hintText: 'e.g. Lose weight',
              ),
              validator: (v) =>
                  (v == null || v.trim().isEmpty) ? 'Required' : null,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _description,
              textCapitalization: TextCapitalization.sentences,
              maxLines: 2,
              decoration: const InputDecoration(
                labelText: 'Description (optional)',
              ),
            ),
            const SizedBox(height: 16),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _start,
                    keyboardType: const TextInputType.numberWithOptions(
                        decimal: true, signed: true),
                    decoration: const InputDecoration(labelText: 'Start'),
                    validator: _numberValidator,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: TextFormField(
                    controller: _target,
                    keyboardType: const TextInputType.numberWithOptions(
                        decimal: true, signed: true),
                    decoration: const InputDecoration(labelText: 'Target'),
                    validator: _numberValidator,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _unit,
              decoration: const InputDecoration(
                labelText: 'Unit (optional)',
                hintText: 'e.g. kg, km, \$',
              ),
            ),
            const SizedBox(height: 24),
            _DateTile(
              label: 'Start date',
              date: _startDate,
              onTap: () => _pickDate(isStart: true),
            ),
            _DateTile(
              label: 'Target date',
              date: _endDate,
              onTap: () => _pickDate(isStart: false),
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
}

class _DateTile extends StatelessWidget {
  const _DateTile({
    required this.label,
    required this.date,
    required this.onTap,
  });

  final String label;
  final DateTime date;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: const Icon(Icons.calendar_today),
      title: Text(label),
      subtitle: Text(formatDayLabel(date)),
      trailing: const Icon(Icons.edit),
      onTap: onTap,
    );
  }
}
