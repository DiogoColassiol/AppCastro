import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:project/entity/result.dart';
import 'package:project/print/pdf_utils.dart';

class ResumoPdfUtil {
  Result result;
  late PdfPageFormat format;

  ResumoPdfUtil({required this.result});

  Future<ThemeData> _myTheme() async {
    return ThemeData.withFont(
        base: Font.ttf(
            await rootBundle.load("assets/fonts/static/Roboto-Regular.ttf")));
  }

  Future<Document> createResumoPDF() async {
    final pdf = Document(theme: await _myTheme());
    final formatedData = DateFormat('dd/MM/yyyy').format(result.dataDoc!);
    final formatedHora = DateFormat('HH:mm').format(result.dataDoc!);

    pdf.addPage(MultiPage(
      maxPages: 100,
      pageFormat: PdfPageFormat.a4,
      mainAxisAlignment: MainAxisAlignment.start,
      footer: (context) => Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Align(
          alignment: Alignment.centerRight,
          child: Text(''),
        ),
      ),
      build: (context) => [
        Header(
          level: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Relatório Final',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              Text(
                "Data: $formatedData - Horário: $formatedHora",
                style: TextStyle(fontSize: 12, fontStyle: FontStyle.italic),
              ),
            ],
          ),
        ),
        SizedBox(height: 16),
        Text(
          'Relatório gerado com base nas escolhas do Segmento/Regime tributário informado:',
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        Text('Cliente: ${result.cliente}'),
        Text('Segmento: ${result.segmento?.nome ?? "N/A"}'),
        Text('Regime Tributário: ${result.documento?.nome ?? "N/A"}'),
        SizedBox(height: 20),
        Text(
          'Documentos requeridos:',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            decoration: TextDecoration.underline,
          ),
        ),
        SizedBox(height: 10),
        if (result.docsNecessarios != null)
          ...result.docsNecessarios!.map((doc) => Bullet(text: doc)),
        SizedBox(height: 20),
        Text(
          'Teses Consolidadas:',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            decoration: TextDecoration.underline,
          ),
        ),
        SizedBox(height: 10),
        if (result.teses != null)
          ...result.teses!.map((tese) => Bullet(text: tese.descricao ?? '')),
      ],
    ));

    await _print(pdf.save(), suffix: result.cliente);

    return pdf;
  }

  Future<void> _print(Future<Uint8List> save, {String? suffix}) async {
    var printUtil = PrintUtils(
      format: format,
      doc: save,
      title: "Relatório_${suffix.toString()}",
    );
    await printUtil.sharePDF();
  }
}
