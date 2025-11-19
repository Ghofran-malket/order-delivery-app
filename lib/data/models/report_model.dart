class Report {
  String orderId;
  String customerId;
  String genieId;
  List<String> reports;
  String description;

  Report({required this.orderId, required this.customerId, required this.genieId, required this.reports, required this.description});


  factory Report.fromJson(Map<String, dynamic> json) {
    return Report(
      orderId: json['orderId'] ,
      customerId: json['customerId'],
      genieId: json['genieId'],
      reports: List<String>.from(json['reports'] ?? []),
      description: json['description']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'orderId': orderId,
      'customerId': customerId,
      'genieId': genieId,
      'reports': reports,
      'description': description
    };
  }
}