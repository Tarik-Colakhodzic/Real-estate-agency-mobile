class Agent {
  final int id;
  final String fullName;

  Agent({required this.id, required this.fullName});

  factory Agent.fromJson(Map<String, dynamic> json) {
    return Agent(id: int.parse(json["id"].toString()), fullName: json["user"]["fullName"]);
  }

  Map<String, dynamic> toJson() => {"id": id, "fullName": fullName};
}
