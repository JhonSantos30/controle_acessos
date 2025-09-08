import 'package:flutter/material.dart';

class Valores extends StatefulWidget {
  const Valores({super.key});

  @override
  State<Valores> createState() => _ValoresState();
}

class _ValoresState extends State<Valores> {
  // Valor selecionado
  String? valorSelecionado;

  // Opções da lista
  final List<String> opcoes = ["Carro", "Moto", "Caminhão"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Exemplo Dropdown")),
      body: Center(
        child: DropdownButton<String>(
          hint: const Text("Selecione um veículo"),
          value: valorSelecionado,
          items: opcoes.map((String item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Text(item),
            );
          }).toList(),
          onChanged: (novoValor) {
            setState(() {
              valorSelecionado = novoValor;
            });
            print("Selecionado: $novoValor");
          },
        ),
      ),
    );
  }
}
