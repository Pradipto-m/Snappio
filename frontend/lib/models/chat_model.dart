class Messages {
  final String data;
  final String senderId;
  final String timestamp;
  final bool? isme;

  Messages({
    required this.data,
    required this.senderId,
    required this.timestamp,
    this.isme
  });

  factory Messages.fromJson(Map<String, dynamic> json) =>
    Messages(
      data: json['data'],
      senderId: json['senderId'],
      timestamp: json['timestamp']
    );
}