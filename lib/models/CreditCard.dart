class CreditCard {
  final int expMonth;
  final int expYear;
  final String number;
  final double amount;
  final String addressCity;
  final String addressCountry;
  final String currency;
  final String cvc;
  final String name;
  final int propertyId;
  final String description;

  CreditCard(
      {required this.expMonth,
      required this.expYear,
      required this.number,
      required this.amount,
      required this.addressCity,
      required this.addressCountry,
      required this.currency,
      required this.cvc,
      required this.name,
      required this.propertyId,
      required this.description});

  factory CreditCard.fromJson(Map<String, dynamic> json) {
    return CreditCard(
        expMonth: int.parse(json["expMonth"].toString()),
        expYear: int.parse(json["expYear"].toString()),
        number: json["number"],
        amount: json["amount"],
        addressCity: json["addressCity"],
        addressCountry: json["addressCountry"],
        currency: json["currency"],
        cvc: json["cvc"],
        name: json["name"],
        propertyId: json["propertyId"],
        description: json["description"]);
  }

  Map<String, dynamic> toJson() => {
        "expMonth": expMonth,
        "expYear": expYear,
        "number": number,
        "amount": amount,
        "addressCity": addressCity,
        "addressCountry": addressCountry,
        "currency": currency,
        "cvc": cvc,
        "name": name,
        "propertyId": propertyId,
        "description": description
      };
}
