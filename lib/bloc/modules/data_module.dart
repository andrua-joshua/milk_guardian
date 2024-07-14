class DataModule{
  final String label;
  final String summary;
  final String healthImplications;
  final double min;
  final double max;

  DataModule({
    required this.label,
    required this.healthImplications,
    required this.summary,
    required this.max,
    required this.min
  });

  


 factory DataModule.fromJson(Map<String, dynamic> json)
   => DataModule(
    label: json['label'], 
    healthImplications: json["health_implications"], 
    summary: json["summary"], 
    max: json["range"]['max'], 
    min: json["range"]['min']);
}