class Client {
  int? id;
  String clientName;
  String clientEmail;
  String clientNumber;
  String subscriptionEmail;
  String subscriptionDate;
  String subscriptionEnd;
  int subscriptionDuration;

  Client({
    this.id,
    required this.clientName,
    required this.clientEmail,
    required this.clientNumber,
    required this.subscriptionEmail,
    required this.subscriptionDate,
    required this.subscriptionEnd,
    required this.subscriptionDuration,
  });

  // Add the copyWith method
  Client copyWith({
    int? id,
    String? clientName,
    String? clientEmail,
    String? clientNumber,
    String? subscriptionEmail,
    String? subscriptionDate,
    String? subscriptionEnd,
    int? subscriptionDuration,
  }) {
    return Client(
      id: id ?? this.id,
      clientName: clientName ?? this.clientName,
      clientEmail: clientEmail ?? this.clientEmail,
      clientNumber: clientNumber ?? this.clientNumber,
      subscriptionEmail: subscriptionEmail ?? this.subscriptionEmail,
      subscriptionDate: subscriptionDate ?? this.subscriptionDate,
      subscriptionEnd: subscriptionEnd ?? this.subscriptionEnd,
      subscriptionDuration: subscriptionDuration ?? this.subscriptionDuration,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'clientName': clientName,
      'clientEmail': clientEmail,
      'clientNumber': clientNumber,
      'subscriptionEmail': subscriptionEmail,
      'subscriptionDate': subscriptionDate,
      'subscriptionEnd': subscriptionEnd,
      'subscriptionDuration': subscriptionDuration,
    };
  }

  factory Client.fromMap(Map<String, dynamic> map) {
    return Client(
      id: map['id'],
      clientName: map['clientName'],
      clientEmail: map['clientEmail'],
      clientNumber: map['clientNumber'],
      subscriptionEmail: map['subscriptionEmail'],
      subscriptionDate: map['subscriptionDate'],
      subscriptionEnd: map['subscriptionEnd'],
      subscriptionDuration: map['subscriptionDuration'],
    );
  }

  factory Client.fromJson(Map<String, dynamic> json) {
    return Client(
      id: json['id'],
      clientName: json['clientName'],
      clientEmail: json['clientEmail'],
      clientNumber: json['clientNumber'],
      subscriptionEmail: json['subscriptionEmail'],
      subscriptionDate: json['subscriptionDate'],
      subscriptionEnd: json['subscriptionEnd'],
      subscriptionDuration: json['subscriptionDuration'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "clientName": clientName,
      "clientEmail": clientEmail,
      "clientNumber": clientNumber,
      "subscriptionEmail": subscriptionEmail,
      "subscriptionDate": subscriptionDate,
      "subscriptionEnd": subscriptionEnd,
      "subscriptionDuration": subscriptionDuration,
    };
  }
}
