class Voucher {
  final DateTime? date;
  final String? partyname;
  final double? amount;
  final String? masterid;
  final String? iscancelled;
  final String? primaryVoucherType;
  final String? isInvoice;
  final String? type;
  final String? isPostDated;
  final String? reference;
  final String? partyGuid;
  final String? number;

  Voucher(
      {this.date,
      this.partyname,
      this.amount,
      this.masterid,
      this.iscancelled,
      this.primaryVoucherType,
      this.isInvoice,
      this.isPostDated,
      this.reference,
      this.type,
      this.partyGuid,
      this.number});
}
