
class DecodedJson {
  String t;

  DecodedJson({
    required this.t,
  });

  factory DecodedJson.fromJson(Map<String, dynamic> json) => DecodedJson(
    t: json["__cdata"],
  );

  Map<String, dynamic> toJson() => {
    "__cdata": t,
  };
}