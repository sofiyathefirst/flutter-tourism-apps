import 'package:flutter/material.dart';
import 'package:test_project/screens/booking_receipts_kayak.dart';
import 'package:test_project/screens/home_screen.dart';

class MainScreen extends StatefulWidget {
  MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  PageController pageController = PageController();
  List<Widget> pages = [HomeScreen(), BookingReceiptsKayak()];

  int selectIndex = 0;
  void onPageChanged(int index) {
    setState(() {
      selectIndex = index;
    });
  }

  void onItemTap(int selectedItem) {
    pageController.jumpToPage(selectedItem);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: pageController,
        children: pages,
        onPageChanged: onPageChanged,
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        onTap: onItemTap,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_rounded,
                color: selectIndex == 0 ? Colors.black : Colors.blueGrey),
            label: 'Activities',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_activity_rounded,
                color: selectIndex == 1 ? Colors.black : Colors.blueGrey),
            label: 'Receipts',
          ),
        ],
      ),
    );
  }
}
