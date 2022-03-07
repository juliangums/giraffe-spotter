class Description {
  String? t;

  Description({
    this.t,
  });

  factory Description.fromJson(Map<String, dynamic> json) => Description(
    t: json["\u0024t"] ?? '',
  );

  Map<String, dynamic> toJson() => {
    "\u0024t": t,
  };
}
