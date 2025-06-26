import 'package:flutter/material.dart';
import 'package:moodlog/presentation/views/onboarding/onboarding_welcome_pageview.dart';
import 'package:moodlog/presentation/widgets/pagination_dot.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  final int _totalPages = 3;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Align(
            alignment: Alignment.topRight,
            child: TextButton(onPressed: () {}, child: Text('건너뛰기')),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: PageView(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _currentPage = index;
                });
              },
              children: [
                OnboardingWelcomePageView(
                  title: "환영합니다",
                  description: "드리프트 ORM을 활용한\n강력한 데이터 관리 앱입니다",
                  image: "assets/onboarding/welcome.png",
                  titleColor: Theme.of(context).primaryColor,
                  isActive: _currentPage == 0,
                ),
                OnboardingWelcomePageView(
                  title: "쉬운 데이터 관리",
                  description: "직관적인 인터페이스로\n데이터를 쉽게 관리하세요",
                  image: "assets/onboarding/data_management.png",
                  titleColor: Theme.of(context).primaryColor,
                  isActive: _currentPage == 1,
                ),
                OnboardingWelcomePageView(
                  title: "지금 시작하세요",
                  description: "모든 준비가 완료되었습니다\n지금 바로 시작해보세요",
                  image: "assets/onboarding/get_started.png",
                  titleColor: Theme.of(context).primaryColor,
                  isActive: _currentPage == 2,
                ),
              ],
            ),
          ),

          PaginationDot(page: _currentPage, total: _totalPages),

          Padding(
            padding: EdgeInsets.all(20),
            child: _currentPage == _totalPages - 1
                ? ElevatedButton(onPressed: () {}, child: Text('시작하기'))
                : ElevatedButton(
                    onPressed: () {
                      _pageController.nextPage(
                        duration: Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    },
                    child: Text('다음'),
                  ),
          ),
        ],
      ),
    );
  }
}
