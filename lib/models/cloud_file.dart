import 'dart:convert';

class CloudFile {
  final String fileName;
  final String ownerUserId;
  final String fileUrl;
  final String fileType;

  CloudFile({
    required this.fileName,
    required this.ownerUserId,
    required this.fileUrl,
    required this.fileType,
  });

  Map<String, dynamic> toMap() {
    return {
      'fileName': fileName,
      'ownerUserId': ownerUserId,
      'fileUrl': fileUrl,
      'fileType': fileType,
    };
  }

  factory CloudFile.fromMap(Map<String, dynamic> map) {
    return CloudFile(
      fileName: map['fileName'] ?? '',
      ownerUserId: map['ownerUserId'] ?? '',
      fileUrl: map['fileUrl'] ?? '',
      fileType: map['fileType'],
    );
  }

  String toJson() => json.encode(toMap());

  factory CloudFile.fromJson(String source) =>
      CloudFile.fromMap(json.decode(source));
}
