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

    pdf.addPage(
      MultiPage(
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
          _buildHeader('Relatório Final'),
          SizedBox(height: 16),
          ..._buildInfoText(
              'Relatório gerado com base nas escolhas do Segmento/Regime tributário informado:'),
          SizedBox(height: 10),
          ..._buildClientAndSeg(),
          SizedBox(height: 20),
          ..._buildDocsNedded(),
          SizedBox(height: 20),
          ..._buildTeses(),
          if (result.obs != null && result.obs!.trim().isNotEmpty) ...[
            SizedBox(height: 20),
            Text(
              'Observações:',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.underline,
              ),
            ),
            SizedBox(height: 6),
            ..._buildObservacoes()
          ],
        ],
      ),
    );

    await _print(pdf.save(), suffix: result.cliente);
    return pdf;
  }

  Future<Document> createResumoOutrosPDF() async {
    final pdf = Document(theme: await _myTheme());

    pdf.addPage(
      MultiPage(
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
          _buildHeader('Relatório Outros'),
          SizedBox(height: 16),
          ..._buildInfoText('Relatório gerado com a escolha de "Outros"'),
          SizedBox(height: 10),
          ..._buildClientAndSeg(),
          SizedBox(height: 20),
          ..._buildDocsNedded(),
          SizedBox(height: 20),
          ..._buildTeses(),
          if (result.obs != null && result.obs!.trim().isNotEmpty) ...[
            SizedBox(height: 20),
            Text(
              'Observações:',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.underline,
              ),
            ),
            SizedBox(height: 6),
            ..._buildObservacoes()
          ],
        ],
      ),
    );

    await _print(pdf.save(), suffix: result.cliente);
    return pdf;
  }

  _buildHeader(String? title) {
    final data = DateTime.now();
    final formatedData = DateFormat('dd/MM/yyyy').format(data);
    final formatedHora = DateFormat('HH:mm').format(data);
    return Header(
      level: 0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title ?? 'Relatório Final',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          Text(
            "Data: $formatedData - Horário: $formatedHora",
            style: TextStyle(fontSize: 12, fontStyle: FontStyle.italic),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildInfoText(String text) {
    return [
      Text(
        text,
        style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
      )
    ];
  }

  List<Widget> _buildClientAndSeg() {
    return [
      Text('Cliente: ${result.cliente}'),
      Text('Segmento: ${result.segmento?.nome ?? "N/A"}'),
      if (result.segmento!.id != '7' && result.teses!.isNotEmpty)
        Text('Regime Tributário: ${result.documento?.nome ?? "N/A"}')
    ];
  }

  List<Widget> _buildDocsNedded() {
    List<Widget> widgets = [
      Text(
        'Documentos requeridos:',
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          decoration: TextDecoration.underline,
        ),
      ),
      SizedBox(height: 10),
    ];

    if (result.docsNecessarios != null) {
      widgets.addAll(result.docsNecessarios!
          .map((doc) => Bullet(bulletSize: 3, text: _doc(doc))));
    }

    return widgets;
  }

  List<Widget> _buildTeses() {
    List<Widget> widgets = [
      Text(
        'Teses Consolidadas:',
        style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            decoration: TextDecoration.underline),
      ),
      SizedBox(height: 10),
    ];

    if (result.teses != null) {
      widgets.addAll(result.teses!.map((tese) => Bullet(
          bulletSize: 3,
          text: '${tese.id}- ${tese.descricao}',
          style: const TextStyle(fontSize: 10))));
    }

    return widgets;
  }

  List<Widget> _buildObservacoes() {
    final texto = result.obs;
    final linhas = texto!.split('\n');
    return linhas.map((linha) {
      return Padding(
        padding: const EdgeInsets.only(left: 20),
        child: Text(
          linha,
          style: const TextStyle(fontSize: 12),
        ),
      );
    }).toList();
  }

  _doc(String doc) {
    int ano = DateTime.now().year - 5;
    if (doc == 'Balanço' || doc == 'DRE' || doc == 'Balancete') {
      return '$doc (válido após: $ano)';
    }
    return doc;
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
