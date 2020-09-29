class ICategory {
  final int iid;
  final String iname;
  final String imageUrl;

  ICategory({this.iid, this.iname, this.imageUrl});
}

class ECategory {
  final int eid;
  final String ename;
  final String imageUrl;

  ECategory({this.eid, this.ename, this.imageUrl});
}

final ICategory salary = ICategory(
  iid: 0,
  iname: 'Salary',
  imageUrl: 'assets/images/books1.png',
);

final ICategory investment = ICategory(
  iid: 1,
  iname: 'Investment',
  imageUrl: 'assets/images/books1.png',
);

final ICategory business = ICategory(
  iid: 2,
  iname: 'Business',
  imageUrl: 'assets/images/books1.png',
);

final ICategory extra = ICategory(
  iid: 3,
  iname: 'Others',
  imageUrl: 'assets/images/books1.png',
);

List<ICategory> inccategory = [
  salary,
  investment,
  business,
  extra,
];

final ECategory rent = ECategory(
  eid: 0,
  ename: 'Rent',
  imageUrl: 'assets/images/books1.png',
);

final ECategory ehouse = ECategory(
  eid: 1,
  ename: 'EMI(House)',
  imageUrl: 'assets/images/books1.png',
);

final ECategory ecar = ECategory(
  eid: 2,
  ename: 'EMI(Car)',
  imageUrl: 'assets/images/books1.png',
);

final ECategory car = ECategory(
  eid: 3,
  ename: 'Car Costs',
  imageUrl: 'assets/images/books1.png',
);

final ECategory education = ECategory(
  eid: 4,
  ename: 'Education',
  imageUrl: 'assets/images/books1.png',
);

final ECategory food = ECategory(
  eid: 5,
  ename: 'Food',
  imageUrl: 'assets/images/books1.png',
);

final ECategory home = ECategory(
  eid: 6,
  ename: 'House Expense',
  imageUrl: 'assets/images/books1.png',
);

final ECategory shopping = ECategory(
  eid: 7,
  ename: 'Shopping',
  imageUrl: 'assets/images/books1.png',
);

final ECategory other = ECategory(
  eid: 8,
  ename: 'Others',
  imageUrl: 'assets/images/books1.png',
);

List<ECategory> expcategory = [
  rent,
  ehouse,
  ecar,
  car,
  education,
  food,
  home,
  shopping,
  other,
];
