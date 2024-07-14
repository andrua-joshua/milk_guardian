class Record {

  final int id;
  final double pH;
  final String summary;
  final String healthImplications;
  final String createdAt;



  const Record({
    required this.id,
    required this.pH,
    required this.summary,
    required this.healthImplications,
    required this.createdAt
  });

  factory Record.fromJson(Map<String, dynamic> json)
    => Record(
      id: json["id"], 
      pH: json["pH"], 
      summary: json["summary"], 
      healthImplications: json["healthImplications"], 
      createdAt: json["createdAt"]);


  Map<String , dynamic> toJson() 
    =>{
      "id":id,
      "pH": pH,
      "summary": summary,
      "healthImplications": healthImplications,
      "createdAt": createdAt
    };

}