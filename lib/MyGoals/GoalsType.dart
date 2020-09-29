import 'GoalCategory.dart';

List<String> currentGoals = ['Dream Home', 'Son'];

List<String> completedGoals = ['Study', 'Job', 'Education', 'Marriage'];

final List<String> goalsType = ['Current', 'Completed'];

class GoalInfo {
  final GoalCategory type;
  final String name;
  final String value;
  final String year;
  final double completion;
  GoalInfo({this.type, this.name, this.value, this.year, this.completion});
}

final GoalCategory education = GoalCategory(
  id: 0,
  name: 'Education',
  imageUrl: 'assets/images/books1.png',
);

final GoalCategory vacation = GoalCategory(
  id: 1,
  name: 'Vacation',
  imageUrl: 'assets/images/plane.png',
);

final GoalCategory marriage = GoalCategory(
  id: 2,
  name: 'Marriage',
  imageUrl: 'assets/images/marriage.png',
);

final GoalCategory myCar = GoalCategory(
  id: 3,
  name: 'Car',
  imageUrl: 'assets/images/car.png',
);

final GoalCategory house = GoalCategory(
  id: 4,
  name: 'House',
  imageUrl: 'assets/images/house.png',
);

final GoalCategory electronic = GoalCategory(
  id: 5,
  name: 'Electronic',
  imageUrl: 'assets/images/electronics.png',
);

final GoalCategory business = GoalCategory(
  id: 6,
  name: 'Business',
  imageUrl: 'assets/images/business.png',
);

final GoalCategory other = GoalCategory(
  id: 7,
  name: 'Other',
  imageUrl: 'assets/images/other.jpg',
);

List<GoalCategory> category = [
  education,
  vacation,
  marriage,
  myCar,
  house,
  electronic,
  business,
  other,
];

List<GoalInfo> ownCurrentGoals = [
  GoalInfo(
    type: house,
    name: 'Dream Home',
    value: '120000000',
    year: '2034',
    completion: 50,
  ),
  GoalInfo(
    type: other,
    name: 'Son',
    value: '5000000',
    year: '2020',
    completion: 50,
  ),
];

List<GoalInfo> ownCompletedGoals = [
  GoalInfo(
    type: education,
    name: "Master",
    value: "200000",
    year: "2015",
    completion: 100,
  ),
  GoalInfo(
    type: vacation,
    name: "Solo trip",
    value: "2156000",
    year: "2010",
    completion: 100,
  ),
];
