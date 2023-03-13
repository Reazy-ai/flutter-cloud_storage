import 'dart:convert';

class CloudFile {
  final String fileName;
  final String ownerUserId;
  final String fileUrl;
  final String fileId;
  final DateTime createdAt;

  CloudFile({
    required this.fileName,
    required this.ownerUserId,
    required this.fileUrl,
    required this.fileId,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'fileName': fileName,
      'ownerUserId': ownerUserId,
      'fileUrl': fileUrl,
      'fileId': fileId,
      'createdAt': createdAt.millisecondsSinceEpoch,
    };
  }

  factory CloudFile.fromMap(Map<String, dynamic> map) {
    return CloudFile(
      fileName: map['fileName'] ?? '',
      ownerUserId: map['ownerUserId'] ?? '',
      fileUrl: map['fileUrl'] ?? '',
      fileId: map['fileId'],
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt']),
    );
  }

  String toJson() => json.encode(toMap());

  factory CloudFile.fromJson(String source) =>
      CloudFile.fromMap(json.decode(source));
}
