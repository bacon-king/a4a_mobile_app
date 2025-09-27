import 'package:flutter/material.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final Function(String)? onNavigate;

  const CustomBottomNavigationBar({
    super.key,
    required this.currentIndex,
    this.onNavigate,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 412,
      height: 76,
      decoration: const BoxDecoration(color: Colors.white),
      child: Stack(
        children: [
          // Active indicator
          if (currentIndex == 0)
            Positioned(
              left: 19,
              top: 14,
              child: Container(
                width: 80,
                height: 47,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(40),
                ),
              ),
            )
          else if (currentIndex == 1)
            Positioned(
              left: 118,
              top: 14,
              child: Container(
                width: 80,
                height: 47,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(40),
                ),
              ),
            )
          else if (currentIndex == 2)
            Positioned(
              left: 239,
              top: 14,
              child: Container(
                width: 80,
                height: 47,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(40),
                ),
              ),
            )
          else if (currentIndex == 3)
            Positioned(
              left: 140,
              top: 14,
              child: Container(
                width: 80,
                height: 47,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(40),
                ),
              ),
            ),

          // Navigation items
          Positioned(
            left: 41,
            top: 20,
            child: GestureDetector(
              onTap: () => onNavigate?.call('home'),
              child: SizedBox(
                width: 36,
                height: 36,
                child: Icon(
                  Icons.home,
                  color: currentIndex == 0 ? Colors.white : Colors.black,
                  size: 36,
                ),
              ),
            ),
          ),

          Positioned(
            left: 140,
            top: 20,
            child: GestureDetector(
              onTap: () => onNavigate?.call('forum'),
              child: SizedBox(
                width: 36,
                height: 36,
                child: Icon(
                  Icons.forum,
                  color: currentIndex == 3 ? Colors.white : Colors.black,
                  size: 36,
                ),
              ),
            ),
          ),

          Positioned(
            left: 239,
            top: 20,
            child: GestureDetector(
              onTap: () => onNavigate?.call('calendar'),
              child: SizedBox(
                width: 37,
                height: 36,
                child: Icon(
                  Icons.calendar_today,
                  color: currentIndex == 1 ? Colors.white : Colors.black,
                  size: 36,
                ),
              ),
            ),
          ),

          Positioned(
            left: 339,
            top: 20,
            child: GestureDetector(
              onTap: () => onNavigate?.call('account'),
              child: SizedBox(
                width: 36,
                height: 36,
                child: Icon(
                  Icons.account_circle,
                  color: currentIndex == 2 ? Colors.white : Colors.black,
                  size: 36,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
