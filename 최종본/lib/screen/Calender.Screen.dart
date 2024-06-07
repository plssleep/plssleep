import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:todobest_home/Setting.MainPage.dart';
import 'package:todobest_home/community/Community.MainPage.dart';
import '../utils/CalenderNavi.dart';
import 'Week.Screen.dart';

class CalenderScreen extends StatefulWidget {
  @override
  _CalenderScreenState createState() => _CalenderScreenState();
}

class _CalenderScreenState extends State<CalenderScreen> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  final ScrollController _scrollController = ScrollController();

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    setState(() {
      _selectedDay = selectedDay;
      _focusedDay = focusedDay;
    });
  }

  void _onFormatChanged(CalendarFormat format) {
    if (_calendarFormat != format) {
      setState(() {
        _calendarFormat = format;
      });
    }
  }

  void _onPageChanged(DateTime focusedDay) {
    setState(() {
      _focusedDay = focusedDay;
    });
  }

  void _onPrevMonth() {
    setState(() {
      _focusedDay = DateTime(_focusedDay.year, _focusedDay.month - 1);
    });
  }

  void _onNextMonth() {
    setState(() {
      _focusedDay = DateTime(_focusedDay.year, _focusedDay.month + 1);
    });
  }

  @override
  Widget build(BuildContext context) {
    final appBarColor = Colors.orange.withOpacity(0.7); // 연한 주황색 배경

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'ToDoBest',
          style: TextStyle(fontSize: 26), // 글자 크기 키움
        ),
        centerTitle: true, // 제목을 중앙으로 정렬
        backgroundColor: appBarColor, // 연한 주황색 배경
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset('assets/images/ToDoBest.png'), // 아이콘 경로 설정
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          CalenderNavi(
            focusedDay: _focusedDay,
            calendarFormat: _calendarFormat,
            onPrevMonth: _onPrevMonth,
            onNextMonth: _onNextMonth,
            onFormatChanged: _onFormatChanged,
          ),
          if (_calendarFormat == CalendarFormat.week)
            WeekScreen(
              focusedDay: _focusedDay,
              scrollController: _scrollController,
            ),
          if (_calendarFormat != CalendarFormat.week)
            Expanded(
              child: TableCalendar(
                firstDay: DateTime.utc(2010, 10, 16),
                lastDay: DateTime.utc(2030, 3, 14),
                focusedDay: _focusedDay,
                calendarFormat: _calendarFormat,
                headerVisible: false,
                selectedDayPredicate: (day) {
                  return isSameDay(_selectedDay, day);
                },
                onDaySelected: _onDaySelected,
                onFormatChanged: _onFormatChanged,
                onPageChanged: _onPageChanged,
              ),
            ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: appBarColor, // AppBar 배경색과 동일하게 설정
        child: Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: 'Chat',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: 'Star',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.more_horiz),
            label: 'More',
          ),
        ],
        selectedItemColor: Colors.amber[800],
        onTap: (int index) {
          // 여기에 각 인덱스별로 수행할 작업을 추가하세요.
          switch (index) {
            case 0:
              Get.to(() => CalenderScreen());
              break;
            case 1:
              Get.to(() => CommunityMainPage());
              break;
            case 2:
              print('Star clicked');
              break;
            case 3:
              Get.to(() =>SettingMainPage());
              break;
          }
        },
      ),
    );
  }
}