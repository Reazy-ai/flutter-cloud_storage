import 'dart:convert';

class CloudFile {
  final String fileName;
  final String ownerUserId;
  final String fileUrl;
  final String fileType;
  final DateTime createdAt;

  CloudFile({
    required this.fileName,
    required this.ownerUserId,
    required this.fileUrl,
    required this.fileType,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'fileName': fileName,
      'ownerUserId': ownerUserId,
      'fileUrl': fileUrl,
      'fileType': fileType,
      'createdAt': createdAt.millisecondsSinceEpoch,
    };
  }

  factory CloudFile.fromMap(Map<String, dynamic> map) {
    return CloudFile(
      fileName: map['fileName'] ?? '',
      ownerUserId: map['ownerUserId'] ?? '',
      fileUrl: map['fileUrl'] ?? '',
      fileType: map['fileType'],
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt']),
    );
  }

  String toJson() => json.encode(toMap());

  factory CloudFile.fromJson(String source) =>
      CloudFile.fromMap(json.decode(source));
}
