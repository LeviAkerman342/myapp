import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarScreen extends StatefulWidget {
  final DateTime startDate;
  final int courseDuration;

  const CalendarScreen({super.key, required this.startDate, required this.courseDuration});

  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  late CalendarFormat _calendarFormat;
  late DateTime _focusedDay;
  late DateTime _selectedDay;
  late DateTime _endDate;

  @override
  void initState() {
    super.initState();
    _calendarFormat = CalendarFormat.month;
    _focusedDay = widget.startDate;
    _selectedDay = widget.startDate;
    _endDate = widget.startDate.add(Duration(days: widget.courseDuration - 1));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Календарь'),
      ),
      body: Center(
        child: TableCalendar(
          firstDay: DateTime.now().subtract(const Duration(days: 365)),
          lastDay: DateTime.now().add(const Duration(days: 365)),
          focusedDay: _focusedDay,
          calendarFormat: _calendarFormat,
          selectedDayPredicate: (day) {
            return isSameDay(_selectedDay, day);
          },
          onFormatChanged: (format) {
            setState(() {
              _calendarFormat = format;
            });
          },
          onDaySelected: (selectedDay, focusedDay) {
            setState(() {
              _selectedDay = selectedDay;
              _focusedDay = focusedDay;
            });
            print('Selected Day: $_selectedDay');
          },
          calendarBuilders: CalendarBuilders(
            selectedBuilder: (context, date, _) {
              return Container(
                margin: const EdgeInsets.all(4.0),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.blue.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Text(
                  '${date.day}',
                  style: const TextStyle(color: Colors.white),
                ),
              );
            },
            todayBuilder: (context, date, _) {
              return Container(
                margin: const EdgeInsets.all(4.0),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.red.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Text(
                  '${date.day}',
                  style: const TextStyle(color: Colors.white),
                ),
              );
            },
            markerBuilder: (context, date, _) {
              if (isSameDay(date, _selectedDay) ||
                  (date.isAfter(_selectedDay) && date.isBefore(_endDate))) {
                return Positioned(
                  right: 1,
                  bottom: 1,
                  child: Container(
                    width: 5,
                    height: 5,
                    decoration: const BoxDecoration(
                      color: Colors.green,
                      shape: BoxShape.circle,
                    ),
                  ),
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ),
      ),
    );
  }
}
