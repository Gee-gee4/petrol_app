import 'package:telpo_flutter_sdk/telpo_flutter_sdk.dart';

class PrinterServiceReceiptPage {
  static final _instance = PrinterServiceReceiptPage._internal();

  factory PrinterServiceReceiptPage() => _instance;

  PrinterServiceReceiptPage._internal();

  final TelpoFlutterChannel _printer = TelpoFlutterChannel();

  Future<PrintResult> printReceipt({required Map<String, dynamic> receiptData}) async {
    final sheet = TelpoPrintSheet();

    final items = receiptData['items'] as List<dynamic>? ?? [];
    final taxableAmount = Map<String, dynamic>.from(receiptData['taxableAmount'] ?? {});

    String formatReceiptLine(Map<String, dynamic> item) {
      final itemName = (item['itemName'] ?? '').toString();
      final prod = itemName.length >= 7 ? itemName.substring(0, 7) : itemName.padRight(7);

      final priceNum = (item['price'] ?? 0).toDouble();
      final qtyNum = (item['quantity'] ?? 0).toDouble();
      final discountNum = (item['discountAmount'] ?? 0).toDouble();

      final taxTypeRaw = (item['taxType'] ?? '').toString().toUpperCase();
      final taxType = taxTypeRaw.length >= 3 ? taxTypeRaw.substring(0, 4) : taxTypeRaw.padLeft(4);

      final totalAmt = (priceNum * qtyNum) - discountNum;

      final price = priceNum.toStringAsFixed(2).padLeft(7);
      final qty = qtyNum.toStringAsFixed(0).padLeft(4);
      final total = totalAmt.toStringAsFixed(2).padLeft(10);

      return "$prod$price$qty$total$taxType";
    }

    double calculateGrandTotal(List<dynamic> items) {
      return items.fold(0.0, (sum, item) {
        final priceNum = (item['price'] ?? 0).toDouble();
        final qtyNum = (item['quantity'] ?? 0).toDouble();
        final discountNum = (item['discountAmount'] ?? 0).toDouble();
        final totalAmt = (priceNum * qtyNum) - discountNum;
        return sum + totalAmt;
      });
    }

    void addRow(String label, String value) {
      sheet.addElement(PrintData.text('$label $value', fontSize: PrintedFontSize.size24));
    }

    // Start building receipt
    sheet.addElement(
      PrintData.text(
        receiptData["companyName"]?.toString() ?? 'Company',
        alignment: PrintAlignment.center,
        fontSize: PrintedFontSize.size34,
      ),
    );
    sheet.addElement(PrintData.space(line: 3));
    sheet.addElement(
      PrintData.text(
        'TIN:  ${receiptData["companyTIN"]?.toString() ?? ''}',
        alignment: PrintAlignment.center,
        fontSize: PrintedFontSize.size24,
      ),
    );

    sheet.addElement(PrintData.text('--------------------------------------------------------------------'));

    sheet.addElement(PrintData.space(line: 2));
    sheet.addElement(PrintData.text('TAX INVOICE', alignment: PrintAlignment.center, fontSize: PrintedFontSize.size24));
    sheet.addElement(PrintData.space(line: 2));

    addRow("Buyer's Name:  ", receiptData["buyerName"]?.toString() ?? '');
    sheet.addElement(PrintData.space(line: 2));
    addRow("Buyer's TIN:  ", receiptData["buyerTIN"]?.toString() ?? '');
    sheet.addElement(PrintData.space(line: 2));
    addRow("Buyer's Phone:  ", receiptData["buyerPhone"]?.toString() ?? '');

    sheet.addElement(PrintData.space(line: 2));
    sheet.addElement(PrintData.text('--------------------------------------------------------------------'));

    sheet.addElement(PrintData.text('Prod    Price   Qty      Total  Type', fontSize: PrintedFontSize.size24));
    
    sheet.addElement(PrintData.text('....................................................................'));
    sheet.addElement(PrintData.space(line: 2));

    for (final item in items) {
      sheet.addElement(PrintData.text(formatReceiptLine(item), fontSize: PrintedFontSize.size24));
    }
    
    sheet.addElement(PrintData.text('....................................................................'));
    sheet.addElement(PrintData.space(line: 3));

    sheet.addElement(
      PrintData.text('Bill Total:  ${calculateGrandTotal(items).toStringAsFixed(2)}', fontSize: PrintedFontSize.size24),
    );
    sheet.addElement(PrintData.space(line: 2));
    sheet.addElement(PrintData.text('--------------------------------------------------------------------'));
    sheet.addElement(PrintData.space(line: 2));

    for (var key in taxableAmount.keys) {
      final val = taxableAmount[key];
      if (val is num) {
        sheet.addElement(
          PrintData.text('Taxable (${key.toUpperCase()}): ${val.toStringAsFixed(3)}', fontSize: PrintedFontSize.size24),
        );
      }
    }
    sheet.addElement(PrintData.space(line: 2));
    sheet.addElement(PrintData.text('--------------------------------------------------------------------'));
    sheet.addElement(PrintData.space(line: 3));

    addRow('Tax Receipt No:  ', receiptData["taxRcptNo"]?.toString() ?? '');
    sheet.addElement(PrintData.space(line: 2));
    addRow('Tax SDC ID:  ', receiptData["taxSdcId"]?.toString() ?? '');
    sheet.addElement(PrintData.space(line: 2));
    addRow('Receipt Sign:  ', receiptData["taxRcptSign"]?.toString() ?? '');
    sheet.addElement(PrintData.space(line: 2));
    addRow('MRC No:  ', receiptData["taxMrcNo"]?.toString() ?? '');
    sheet.addElement(PrintData.space(line: 2));

    sheet.addElement(PrintData.text('--------------------------------------------------------------------'));
    sheet.addElement(PrintData.text('--------------------------------------------------------------------'));
    sheet.addElement(PrintData.space(line: 2));

    sheet.addElement(
      PrintData.text(
        'Thank you for your purchase!',
        alignment: PrintAlignment.center,
        fontSize: PrintedFontSize.size24,
      ),
    );
    sheet.addElement(PrintData.space(line: 20));

    return await _printer.print(sheet);
  }
}
