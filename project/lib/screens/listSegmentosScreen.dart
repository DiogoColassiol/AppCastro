import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:project/repositories/segmentoRepo.dart';
import 'package:project/utils/theme_utils.dart';

class SegmentosScreen extends StatelessWidget {
  const SegmentosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final segmentoRepo = context.watch<SegmentoRepository>();
    return Container(
      color: ThemeUtils.surfaceColor,
      child: segmentoRepo.segmentosList.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: segmentoRepo.segmentosList.length,
              itemBuilder: (context, index) {
                final seg = segmentoRepo.segmentosList[index];
                return ListTile(
                  title: Text(seg.segmento.nome ?? 'Sem nome'),
                );
              },
            ),
    );
  }
}
