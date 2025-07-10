import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project/repositories/razaoRepo.dart';
import 'package:project/utils/theme_utils.dart';

class RegimesScreen extends StatefulWidget {
  const RegimesScreen({super.key});

  @override
  State<RegimesScreen> createState() => _ListRegimesScreenState();
}

class _ListRegimesScreenState extends State<RegimesScreen> {
  @override
  Widget build(BuildContext context) {
    final regimeRepo = context.watch<RegimeRepository>();
    return Container(
      color: ThemeUtils.surfaceColor,
      child: regimeRepo.regimesList.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: regimeRepo.regimesList.length,
              itemBuilder: (context, index) {
                final doc = regimeRepo.regimesList[index];
                return ListTile(
                  title: Text(doc.documento.nome ?? 'Sem nome'),
                );
              },
            ),
    );
  }
}
