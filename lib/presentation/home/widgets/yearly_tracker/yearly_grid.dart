import 'dart:math';

import 'package:flutter/material.dart';

import '../../../../core/constants/common.dart';
import '../../../../core/l10n/app_localizations.dart';
import '../../../../domain/entities/journal.dart';
import 'week_column.dart';
import 'weekday_labels.dart';

// 월 라벨 위치 정보 클래스
class MonthPosition {
  final String monthName;
  final double left;
  final double top;
  final int weekday; // 해당 월 1일의 요일 (0=일요일, 6=토요일)
  
  MonthPosition({
    required this.monthName,
    required this.left,
    required this.top,
    required this.weekday,
  });
}

class YearlyGrid extends StatelessWidget {
  final DateTime now;
  final Map<DateTime, List<Journal>> yearlyJournals;

  const YearlyGrid({
    super.key,
    required this.now,
    required this.yearlyJournals,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    // GitHub 스타일 잔디밭 생성
    final (weeks, monthPositions) = _generateGithubStyleGrid(context);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 좌측 고정 요소들
        Column(
          children: [
            const SizedBox(height: 24), // 월 라벨 높이 (20 * 1.2)
            const SizedBox(height: Spacing.xs),
            const WeekdayLabels(),
          ],
        ),
        const SizedBox(width: Spacing.xs),

        // 스크롤 가능한 영역 (그리드 + 월 라벨 오버레이)
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Stack(
              children: [
                // 주별 그리드
                Column(
                  children: [
                    const SizedBox(height: 24), // 월 라벨 공간
                    const SizedBox(height: Spacing.xs),
                    SizedBox(
                      height: 144, // 120 * 1.2
                      child: Row(
                        children: weeks
                            .map(
                              (week) => WeekColumn(
                                week: week,
                                yearlyJournals: yearlyJournals,
                                now: now,
                              ),
                            )
                            .toList(),
                      ),
                    ),
                  ],
                ),
                
                // 월 라벨들 (오버레이)
                ...monthPositions.map((position) => _buildMonthLabel(
                  position, textTheme, colorScheme
                )),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // GitHub 스타일 잔디밭 데이터 생성
  (List<List<DateTime?>>, List<MonthPosition>) _generateGithubStyleGrid(BuildContext context) {
    // 올해 첫날부터 마지막날까지
    final firstDayOfYear = DateTime(now.year, 1, 1);
    final lastDayOfYear = DateTime(now.year, 12, 31);
    
    // 1월 1일이 포함된 주의 일요일 찾기
    final firstWeekday = firstDayOfYear.weekday == 7 ? 0 : firstDayOfYear.weekday;
    final startDate = firstDayOfYear.subtract(Duration(days: firstWeekday));
    
    // 12월 31일이 포함된 주의 토요일까지 찾기
    final lastWeekday = lastDayOfYear.weekday == 7 ? 0 : lastDayOfYear.weekday;
    final endDate = lastDayOfYear.add(Duration(days: 6 - lastWeekday));
    
    // 모든 날짜 생성
    final allDates = <DateTime>[];
    DateTime current = startDate;
    while (!current.isAfter(endDate)) {
      allDates.add(current);
      current = current.add(const Duration(days: 1));
    }
    
    // 주단위로 그룹화 (7일씩)
    final weeks = <List<DateTime?>>[];
    final monthPositions = <MonthPosition>[];
    
    for (int i = 0; i < allDates.length; i += 7) {
      final weekDates = allDates.skip(i).take(7).toList();
      if (weekDates.length == 7) {
        // 현재 년도가 아닌 날짜는 null로 변경
        final processedWeek = weekDates.map((date) {
          return date.year == now.year ? date : null;
        }).toList();
        weeks.add(processedWeek);
        
        // 월 라벨 위치 계산: 해당 주에 현재 년도의 1일이 있는지 확인
        for (int dayIndex = 0; dayIndex < weekDates.length; dayIndex++) {
          final date = weekDates[dayIndex];
          if (date.year == now.year && date.day == 1) {
            // 해당 월 1일의 위치 계산
            final weekIndex = weeks.length - 1;
            final left = weekIndex * 18.8; // 주별 너비 (16.8 + 2 마진)
            
            // 월 라벨을 모두 상단 한 줄에 정렬
            final top = 4.0; // 상단 고정 위치
            
            monthPositions.add(MonthPosition(
              monthName: _getMonthName(date.month, context),
              left: left,
              top: top,
              weekday: dayIndex, // 0=일요일, 6=토요일
            ));
            break;
          }
        }
      }
    }
    
    return (weeks, monthPositions);
  }

  // 월 라벨 위젯 생성 (요일 텍스트와 동일한 스타일)
  Widget _buildMonthLabel(MonthPosition position, TextTheme textTheme, ColorScheme colorScheme) {
    return Positioned(
      left: position.left,
      top: position.top,
      child: Text(
        position.monthName,
        style: textTheme.bodySmall?.copyWith(
          color: colorScheme.onSurfaceVariant,
          fontSize: 10, // 요일과 동일한 크기
        ),
      ),
    );
  }

  String _getMonthName(int month, BuildContext context) {
    // 짧은 형식의 월 이름 반환 (1~3글자)
    final t = AppLocalizations.of(context)!;
    switch (month) {
      case 1:
        return t.calendar_month_jan.substring(
          0,
          min(t.calendar_month_jan.length, 3),
        );
      case 2:
        return t.calendar_month_feb.substring(
          0,
          min(t.calendar_month_feb.length, 3),
        );
      case 3:
        return t.calendar_month_mar.substring(
          0,
          min(t.calendar_month_mar.length, 3),
        );
      case 4:
        return t.calendar_month_apr.substring(
          0,
          min(t.calendar_month_apr.length, 3),
        );
      case 5:
        return t.calendar_month_may.substring(
          0,
          min(t.calendar_month_may.length, 3),
        );
      case 6:
        return t.calendar_month_jun.substring(
          0,
          min(t.calendar_month_jun.length, 3),
        );
      case 7:
        return t.calendar_month_jul.substring(
          0,
          min(t.calendar_month_jul.length, 3),
        );
      case 8:
        return t.calendar_month_aug.substring(
          0,
          min(t.calendar_month_aug.length, 3),
        );
      case 9:
        return t.calendar_month_sep.substring(
          0,
          min(t.calendar_month_sep.length, 3),
        );
      case 10:
        return t.calendar_month_oct.substring(
          0,
          min(t.calendar_month_oct.length, 3),
        );
      case 11:
        return t.calendar_month_nov.substring(
          0,
          min(t.calendar_month_nov.length, 3),
        );
      case 12:
        return t.calendar_month_dec.substring(
          0,
          min(t.calendar_month_dec.length, 3),
        );
      default:
        return '';
    }
  }
}
