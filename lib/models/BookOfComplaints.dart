class BookOfComplaints {
  final int? id;
  final int? agentId;
  final int? propertyId;
  final String comment;
  final String dateCreated;

  BookOfComplaints(
      {
        this.id,
        this.agentId,
        this.propertyId,
        required this.comment,
        required this.dateCreated
      });

  factory BookOfComplaints.fromJson(Map<String, dynamic> json) {
    return BookOfComplaints(
        id: int.parse(json["id"].toString()),
        agentId: int.parse(json["agentId"].toString()),
        propertyId: int.parse(json["propertyId"].toString()),
        comment: (json["comment"]),
        dateCreated: json["dateCreated"].toString());
  }

  Map<String, dynamic> toJson() => {
        "propertyId": propertyId,
        "agentId": agentId,
        "dateCreated": dateCreated,
        "comment": comment
      };
}
