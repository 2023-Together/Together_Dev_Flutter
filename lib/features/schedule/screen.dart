import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class TableCalendarPage extends StatefulWidget {
  const TableCalendarPage({super.key});

  @override
  State<TableCalendarPage> createState() => _TableCalendarPageState();
}

class _TableCalendarPageState extends State<TableCalendarPage> {
  late DateTime _selectedDay;
  late DateTime _focusedDay;
  bool _selectedDayIsWeekend = false;

  @override
  void initState() {
    super.initState();
    _focusedDay = DateTime.now();
    _selectedDay = DateTime.now();
  }

  // 선택한 날짜가 주말이면 폰트 글씨가 빨간색을 유지하도록 함. 주말이 아니면 검은색.
  void isWeekend({required DateTime dateTime}) {
    if (dateTime.weekday == 6 || dateTime.weekday == 7) {
      _selectedDayIsWeekend = true;
    } else {
      _selectedDayIsWeekend = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: TableCalendar(
          locale: 'ko-KR',
          focusedDay: _focusedDay,
          firstDay: DateTime(2023, 1, 1), // 달력 범위 처음
          lastDay: DateTime(2023, 12, 31), // 달력 범위 마지막
          onDaySelected: (DateTime selectedDay, DateTime focusedDay) {
            setState(() {
              _selectedDay = selectedDay;
              _focusedDay = focusedDay;
              isWeekend(dateTime: selectedDay);
            });
            // print(focusedDay);
          },
          onPageChanged: (focusedDay) {
            _focusedDay = focusedDay;
          },
          selectedDayPredicate: (day) {
            return isSameDay(_selectedDay, day);
          },
          // currentDay: DateTime(2023, 3, 28),
          daysOfWeekHeight: 20,
          // ignore: prefer_const_constructors
          headerStyle: HeaderStyle(
            titleCentered: true,
            formatButtonVisible: false,
            leftChevronVisible: false,
            rightChevronVisible: false,
            titleTextFormatter: (date, locale) {
              return '${date.year}.${date.month}';
            },
          ),
          calendarStyle: CalendarStyle(
            defaultTextStyle: const TextStyle(),
            weekendTextStyle: const TextStyle(color: Colors.red),
            selectedTextStyle: TextStyle(
                color: _selectedDayIsWeekend ? Colors.red : Colors.black),
            todayTextStyle: const TextStyle(
              color: Colors.white,
            ),
            todayDecoration: const BoxDecoration(
              color: Color(0xFF6120FF),
              shape: BoxShape.circle,
            ),
            selectedDecoration: const BoxDecoration(
              color: Color(0xFFDBDBDB),
              shape: BoxShape.circle,
            ),
            markerSize: 4,
            markerMargin: const EdgeInsets.only(top: 5),
            markerDecoration: const BoxDecoration(
              color: Colors.grey,
              shape: BoxShape.circle,
            ),
          ),
          eventLoader: (day) {
            // 임의로 짝수 일만 점 찍히도록 해놓음.
            if (day.day % 2 == 0) return [''];
            return [];
          },
        ),
      ),
    );
  }
}
