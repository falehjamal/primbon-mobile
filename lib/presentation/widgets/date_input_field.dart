import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateInputField extends StatelessWidget {
  const DateInputField({
    super.key,
    required this.label,
    required this.value,
    required this.onChanged,
  });

  final String label;
  final DateTime? value;
  final ValueChanged<DateTime?> onChanged;

  @override
  Widget build(BuildContext context) {
    final fmt = DateFormat('d MMMM yyyy', 'id_ID');
    final display = value != null ? fmt.format(value!) : 'Pilih tanggal';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
                fontWeight: FontWeight.w500,
              ),
        ),
        const SizedBox(height: 8),
        InkWell(
          onTap: () => _pickDate(context),
          borderRadius: BorderRadius.circular(12),
          child: InputDecorator(
            decoration: const InputDecoration(
              suffixIcon: Icon(Icons.calendar_today_outlined),
            ),
            child: Text(
              display,
              style: TextStyle(
                color: value != null
                    ? Theme.of(context).colorScheme.onSurface
                    : Theme.of(context).hintColor,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _pickDate(BuildContext context) async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: value ?? DateTime(now.year - 25),
      firstDate: DateTime(1940),
      lastDate: now,
      locale: const Locale('id', 'ID'),
      helpText: label,
    );
    if (picked != null) {
      onChanged(DateTime(picked.year, picked.month, picked.day));
    }
  }
}
