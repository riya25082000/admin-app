

class AdvisorData{
  final String UserName;
  final String UserID;

  AdvisorData(
      {
        this.UserName,
        this.UserID,
      });
}

List<AdvisorData> loadAdvisorData(){
  var data = <AdvisorData>[
    AdvisorData(
      UserName: 'Test',
      UserID: '123456789',
    )

  ];

  return data;
}