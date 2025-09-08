import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: ContatoApp(),
  ));
}

class ContatoApp extends StatefulWidget {
  @override
  _ContatoAppState createState() => _ContatoAppState();
}

class _ContatoAppState extends State<ContatoApp> {
  List<Map<String, String>> contatos = [];

  final nomeController = TextEditingController();
  final telefoneController = TextEditingController();

  void adicionarContato() {
    String nome = nomeController.text.trim();
    String telefone = telefoneController.text.trim();

    if (nome.isNotEmpty && telefone.isNotEmpty) {
      setState(() {
        contatos.add({'nome': nome, 'telefone': telefone});
      });
      nomeController.clear();
      telefoneController.clear();
      Navigator.pop(context);
    }
  }

  void mostrarAdicionarPopup() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Adicionar Contato'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nomeController,
                decoration: InputDecoration(labelText: 'Nome'),
              ),
              TextField(
                controller: telefoneController,
                decoration: InputDecoration(labelText: 'Telefone'),
                keyboardType: TextInputType.phone,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: adicionarContato,
              child: Text('Salvar'),
            ),
          ],
        );
      },
    );
  }

  void removerContato(int index) {
    setState(() {
      contatos.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Contatos'),
        backgroundColor: Colors.blue,
      ),
      body: ListView.builder(
        itemCount: contatos.length,
        itemBuilder: (context, index) {
          final contato = contatos[index];
          return ListTile(
            title: Text(contato['nome']!),
            subtitle: Text(contato['telefone']!),
            trailing: IconButton(
              icon: Icon(Icons.delete, color: Colors.red),
              onPressed: () => removerContato(index),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: mostrarAdicionarPopup,
        child: Icon(Icons.add),
      ),
    );
  }
}
