class ActivityTotalStatistics{
  ///activity id
  String activityId;
  ActivityTotalStatisticsType type;
  ///team total cost
  double totalCost;

  double averageDayCost;

}

enum ActivityTotalStatisticsType{
  Team,
  OnlyMe
}