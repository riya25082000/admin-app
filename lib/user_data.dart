

class UserData{
  final String UserName;
  final String UserID;

  UserData(
  {
    this.UserName,
    this.UserID,
});
}

List<UserData> loadUserData(){
  var data = <UserData>[
    UserData(
      UserName: 'Test',
      UserID: '123456789',
    )

  ];

  return data;
}