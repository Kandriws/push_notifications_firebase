class PushMessage {
  final String messageId;
  final String title;
  final String body;
  final DateTime sentDateTime;
  final Map<String, dynamic>? data;
  final String? imageUrl;

  PushMessage(
      {required this.messageId,
      required this.title,
      required this.body,
      required this.sentDateTime,
      this.data,
      this.imageUrl});

  @override
  String toString() {
    return 'PushMessage{messageId: $messageId, title: $title, body: $body, sentDateTime: $sentDateTime, data: $data, imageUrl: $imageUrl}';
  }
}
