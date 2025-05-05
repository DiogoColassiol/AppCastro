import 'dart:typed_data';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';

class PrintUtils {
  final Future<Uint8List> doc;
  final PdfPageFormat format;
  final String title;

  PrintUtils({
    required this.doc,
    required this.format,
    required this.title,
  });
  Future<void> sharePDF() async {
    Uint8List data = await doc;
    await Printing.sharePdf(bytes: data, filename: '$title.pdf');
  }
}
