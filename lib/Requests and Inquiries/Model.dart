import 'dart:convert';

Users usersFromJson(String str) => Users.fromJson(json.decode(str));

String usersToJson(Users data) => json.encode(data.toJson());

class Users {
  Users({
    this.status,
    this.message,
    this.requests,
  });

  bool status;
  String message;
  List<Request> requests;

  factory Users.fromJson(Map<String, dynamic> json) => Users(
        status: json["status"],
        message: json["message"],
        requests: List<Request>.from(
            json["requests"].map((x) => Request.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "requests": List<dynamic>.from(requests.map((x) => x.toJson())),
      };
}

class Request {
  Request({
    this.requestId,
    this.date,
    this.remarks,
    this.finalDecision,
    this.requestTypes,
    this.reasons,
    this.reviewedBy,
  });

  int requestId;
  DateTime date;
  String remarks;
  dynamic finalDecision;
  List<RequestType> requestTypes;
  List<Reason> reasons;
  List<dynamic> reviewedBy;

  factory Request.fromJson(Map<String, dynamic> json) => Request(
        requestId: json["requestID"],
        date: DateTime.parse(json["date"]),
        remarks: json["remarks"],
        finalDecision: json["finalDecision"],
        requestTypes: List<RequestType>.from(
            json["requestTypes"].map((x) => RequestType.fromJson(x))),
        reasons:
            List<Reason>.from(json["reasons"].map((x) => Reason.fromJson(x))),
        reviewedBy: List<dynamic>.from(json["reviewedBy"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "requestID": requestId,
        "date": date.toIso8601String(),
        "remarks": remarks,
        "finalDecision": finalDecision,
        "requestTypes": List<dynamic>.from(requestTypes.map((x) => x.toJson())),
        "reasons": List<dynamic>.from(reasons.map((x) => x.toJson())),
        "reviewedBy": List<dynamic>.from(reviewedBy.map((x) => x)),
      };
}

class Reason {
  Reason({
    this.requestId,
    this.reason,
  });

  int requestId;
  String reason;

  factory Reason.fromJson(Map<String, dynamic> json) => Reason(
        requestId: json["requestID"],
        reason: json["reason"],
      );

  Map<String, dynamic> toJson() => {
        "requestID": requestId,
        "reason": reason,
      };
}

class RequestType {
  RequestType({
    this.requestId,
    this.request,
  });

  int requestId;
  String request;

  factory RequestType.fromJson(Map<String, dynamic> json) => RequestType(
        requestId: json["requestID"],
        request: json["request"],
      );

  Map<String, dynamic> toJson() => {
        "requestID": requestId,
        "request": request,
      };
}
