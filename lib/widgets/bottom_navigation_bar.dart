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
    final screenWidth = MediaQuery.of(context).size.width;
    final navBarWidth = screenWidth;
    
    // Calculate positions based on screen width
    final itemWidth = (navBarWidth - 40) / 4; // 4 items with 20px padding on each side
    final itemSpacing = (navBarWidth - 4 * 36 - 40) / 3; // Space between 36px icons
    
    return Container(
      width: navBarWidth,
      height: 76,
      decoration: const BoxDecoration(color: Colors.white),
      child: Stack(
        children: [
          // Active indicator
          if (currentIndex == 0)
            Positioned(
              left: 20 + (itemSpacing + 36) * 0 - 12, // Center on icon (60/2 - 36/2 = 12)
              top: 14,
              child: Container(
                width: 60,
                height: 47,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(40),
                ),
              ),
            )
          else if (currentIndex == 1)
            Positioned(
              left: 20 + (itemSpacing + 36) * 1 - 12, // Center on icon
              top: 14,
              child: Container(
                width: 60,
                height: 47,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(40),
                ),
              ),
            )
          else if (currentIndex == 2)
            Positioned(
              left: 20 + (itemSpacing + 36) * 3 - 12, // Center on account icon (last position)
              top: 14,
              child: Container(
                width: 60,
                height: 47,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(40),
                ),
              ),
            )
          else if (currentIndex == 3)
            Positioned(
              left: 20 + (itemSpacing + 36) * 1 - 12, // Center on forum icon (second position)
              top: 14,
              child: Container(
                width: 60,
                height: 47,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(40),
                ),
              ),
            ),

          // Navigation items
          Positioned(
            left: 20 + (itemSpacing + 36) * 0,
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
            left: 20 + (itemSpacing + 36) * 1,
            top: 20,
            child: GestureDetector(
              onTap: () => onNavigate?.call('forum'),
              child: SizedBox(
                width: 36,
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
            left: 20 + (itemSpacing + 36) * 2,
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
            left: 20 + (itemSpacing + 36) * 3,
            top: 20,
            child: GestureDetector(
              onTap: () => onNavigate?.call('profile'), // Changed from 'account' to 'profile'
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
