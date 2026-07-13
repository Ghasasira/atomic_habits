import 'package:drift/drift.dart' as drift;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/constants/enums.dart';
import '../../core/utils/date_x.dart';
import '../../data/database/database.dart';
import '../../providers/goal_provider.dart';

/// Create or edit a deliverable attached to a goal, with its own frequency
/// (FR-4.3) and expected metric input (FR-5.1).
class DeliverableFormScreen extends StatefulWidget {
  const DeliverableFormScreen({
    super.key,
    required this.goalId,
    this.deliverable,
  });

  final int goalId;
  final Deliverable? deliverable;

  @override
  State<DeliverableFormScreen> createState() => _DeliverableFormScreenState();
}

class _DeliverableFormScreenState extends State<DeliverableFormScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _name;
  late final TextEditingController _inputLabel;
  late final TextEditingController _inputUnit;
  late final TextEditingController _target;

  late FrequencyType _frequency;
  late int _weekdaysMask;
  late int _intervalDays;

  bool get _isEditing => widget.deliverable != null;

  @override
  void initState() {
    super.initState();
    final d = widget.deliverable;
    _name = TextEditingController(text: d?.name ?? '');
    _inputLabel = TextEditingController(text: d?.inputLabel ?? 'Value');
    _inputUnit = TextEditingController(text: d?.inputUnit ?? '');
    _target = TextEditingController(
        text: d?.targetInput != null ? '${d!.targetInput}' : '');
    _frequency = d?.frequency ?? FrequencyType.daily;
    _weekdaysMask = d?.weekdaysMask ?? kAllWeekdaysMask;
    _intervalDays = d?.intervalDays ?? 3;
  }

  @override
  void dispose() {
    _name.dispose();
    _inputLabel.dispose();
    _inputUnit.dispose();
    _target.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    if (_frequency == FrequencyType.weekly && _weekdaysMask == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Pick at least one day of the week.')),
      );
      return;
    }

    final provider = context.read<GoalProvider>();
    final name = _name.text.trim();
    final label = _inputLabel.text.trim().isEmpty
        ? 'Value'
        : _inputLabel.text.trim();
    final unit = _inputUnit.text.trim();
    final target = double.tryParse(_target.text.trim());

    if (_isEditing) {
      await provider.updateDeliverable(
        widget.deliverable!.copyWith(
          name: name,
          frequency: _frequency,
          weekdaysMask: _weekdaysMask,
          intervalDays: _intervalDays,
          inputLabel: label,
          inputUnit: unit,
          targetInput: drift.Value(target),
        ),
      );
    } else {
      await provider.addDeliverable(
        DeliverablesCompanion.insert(
          goalId: widget.goalId,
          name: name,
          frequency: drift.Value(_frequency),
          weekdaysMask: drift.Value(_weekdaysMask),
          intervalDays: drift.Value(_intervalDays),
          inputLabel: drift.Value(label),
          inputUnit: drift.Value(unit),
          targetInput: drift.Value(target),
        ),
      );
    }
    if (mounted) Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_isEditing ? 'Edit deliverable' : 'New deliverable'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 96),
          children: [
            TextFormField(
              controller: _name,
              textCapitalization: TextCapitalization.sentences,
              decoration: const InputDecoration(
                labelText: 'Deliverable',
                hintText: 'e.g. Run 3 km',
              ),
              validator: (v) =>
                  (v == null || v.trim().isEmpty) ? 'Required' : null,
            ),
            const SizedBox(height: 20),
            Text('FREQUENCY',
                style: Theme.of(context).textTheme.labelMedium),
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
            if (_frequency == FrequencyType.weekly)
              Wrap(
                spacing: 8,
                children: [
                  for (var wd = DateTime.monday; wd <= DateTime.sunday; wd++)
                    FilterChip(
                      label: Text(kShortWeekdayLabels[wd - 1]),
                      selected: _weekdaysMask.hasWeekday(wd),
                      onSelected: (sel) => setState(() =>
                          _weekdaysMask = _weekdaysMask.toggleWeekday(wd, sel)),
                    ),
                ],
              ),
            if (_frequency == FrequencyType.interval)
              Row(
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
                    child: Text('$_intervalDays',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.titleLarge),
                  ),
                  IconButton.filledTonal(
                    onPressed: () => setState(() => _intervalDays++),
                    icon: const Icon(Icons.add),
                  ),
                  const SizedBox(width: 12),
                  const Text('days'),
                ],
              ),
            const SizedBox(height: 20),
            Text('EXPECTED INPUT',
                style: Theme.of(context).textTheme.labelMedium),
            const SizedBox(height: 4),
            Text(
              'What you record each time you complete this.',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  flex: 3,
                  child: TextFormField(
                    controller: _inputLabel,
                    textCapitalization: TextCapitalization.sentences,
                    decoration: const InputDecoration(
                      labelText: 'Label',
                      hintText: 'Duration',
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  flex: 2,
                  child: TextFormField(
                    controller: _inputUnit,
                    decoration: const InputDecoration(
                      labelText: 'Unit',
                      hintText: 'min',
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _target,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(
                labelText: 'Target per session (optional)',
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _save,
        icon: const Icon(Icons.check),
        label: Text(_isEditing ? 'Save' : 'Add'),
      ),
    );
  }
}
