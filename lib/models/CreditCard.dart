class CreditCard {
  final int expMonth;
  final int expYear;
  final String number;
  final String addressCity;
  final String addressCountry;
  final String currency;
  final String cvc;
  final String name;

  CreditCard(
      {required this.expMonth,
      required this.expYear,
      required this.number,
      required this.addressCity,
      required this.addressCountry,
      required this.currency,
      required this.cvc,
      required this.name});

  factory CreditCard.fromJson(Map<String, dynamic> json) {
    return CreditCard(
        expMonth: int.parse(json["expMonth"].toString()),
        expYear: int.parse(json["expYear"].toString()),
        number: json["number"],
        addressCity: json["addressCity"],
        addressCountry: json["addressCountry"],
        currency: json["currency"],
        cvc: json["cvc"],
        name: json["name"]);
  }

  Map<String, dynamic> toJson() => {
        "expMonth": expMonth,
        "expYear": expYear,
        "number": number,
        "addressCity": addressCity,
        "addressCountry": addressCountry,
        "currency": currency,
        "cvc": cvc,
        "name": name
      };
}
