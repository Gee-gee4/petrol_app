enum PaymentMethod {
  cash("Cash"),
  credit("Credit"),
  cashOrCredit("Cash/Credit"),
  bankCheck("Bank Check"),
  debitOrCreditCard("Debit or Credit card"),
  mobileMoney("Mobile Money"),
  other("Other");

  final String val;
  const PaymentMethod(this.val);
}
