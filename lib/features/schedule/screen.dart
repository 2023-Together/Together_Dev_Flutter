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
  final int _scheduleCount = 4; // 선택 날짜 일정 갯수
  bool _selectedDayIsWeekend = false;

  @override
  void initState() {
    super.initState();
    _focusedDay = DateTime.now();
    _selectedDay = DateTime.now();
    print(_focusedDay);
  }

  // 선택한 날짜가 주말이면 폰트 글씨가 빨간색을 유지하도록 함. 주말이 아니면 검은색.
  void isWeekend({required DateTime dateTime}) {
    if (dateTime.weekday == 6 || dateTime.weekday == 7) {
      _selectedDayIsWeekend = true;
    } else {
      _selectedDayIsWeekend = false;
    }
  }

  Widget _calendar() {
    return TableCalendar(
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
        print(selectedDay);
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
          color: _selectedDayIsWeekend
              ? Colors.red
              : isSameDay(_selectedDay, DateTime.now())
                  ? Colors.white
                  : Colors.black,
        ),
        todayTextStyle: const TextStyle(
          color: Colors.white,
        ),
        todayDecoration: const BoxDecoration(
          color: Color(0xFF6120FF),
          shape: BoxShape.circle,
        ),
        selectedDecoration: BoxDecoration(
          color: isSameDay(_selectedDay, DateTime.now())
              ? const Color(0xFF6120FF)
              : const Color(0xFFDBDBDB),
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
    );
  }

  Widget _scheduleInstance() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      height: 80,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: const [
              Text(
                "진주/봉사", // 봉사 지역
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xFF767676),
                ),
              ),
              SizedBox(width: 5),
              Text(
                "D-4", // D - Day
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF6524FF),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          const Text(
            "투게더 봉사활동", // 봉사활동 이름
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  Widget _scheduleList() {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.only(top: 50),
        width: double.infinity,
        clipBehavior: Clip.hardEdge,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          color: Color(0xFFDBDBDB),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${_focusedDay.month}월 ${_focusedDay.day}일",
                style: const TextStyle(
                  color: Color(0xFF767676),
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(top: 20),
                  child: _scheduleCount > 0 // 일정이 있으면 리스트를 표시하고 없으면 텅 빈 표시
                      ? ListView.separated(
                          itemBuilder: (context, index) {
                            return _scheduleInstance();
                          },
                          separatorBuilder: (context, index) {
                            return const SizedBox(height: 10);
                          },
                          itemCount: _scheduleCount, // 해당 날짜 일정 개수
                        )
                      : Center(
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Text(
                                "텅",
                                style: TextStyle(
                                  color:
                                      const Color(0xFF767676).withOpacity(0.2),
                                  fontSize: 180,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(bottom: 20),
                                child: const Text(
                                  "일정이 없어요.\n즐겨찾기를 통해 관심있는\n봉사를 등록해보세요.",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                    height: 1.4,
                                    color: Color(0xFF767676),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _calendar(),
        _scheduleList(),
      ],
    );
  }
}
