import 'package:appcondominio/AppSaidaCondominio.dart';
import 'package:appcondominio/Lista_Entradas.dart';
import 'package:appcondominio/Saida.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Appcondominio extends StatefulWidget {
  const Appcondominio({super.key});

  @override
  State<Appcondominio> createState() => _AppcondominioState();
}

class _AppcondominioState extends State<Appcondominio> {
  final moradiaController = TextEditingController();
  final placaController = TextEditingController();
  final ocupanteController = TextEditingController();
  final condutorController = TextEditingController();
  final observacaoController = TextEditingController();
  final dataSaidaController = TextEditingController();
  final dataEntradaController = TextEditingController();

  int? selecionado;
  late String valorSelecionado;
  String mensagem = "";


  //List<Map<String, dynamic>> listaEntrada = [];

  void adicionarEntradas() {
    final dataAtual = DateFormat('dd/MMM HH:mm').format(DateTime.now());
    var moradia = moradiaController.text.toUpperCase();
    var placa = placaController.text.toUpperCase();
    var ocupantes = ocupanteController.text.toUpperCase();
    var condutor = condutorController.text.toUpperCase();
    var observacao = observacaoController.text.toUpperCase();
    dataEntradaController.text = dataAtual;

    // Determina o tipo selecionado
    if (selecionado == 1) {
      valorSelecionado = 'Carro';
    } else if (selecionado == 2) {
      valorSelecionado = 'Moto';
    } else if (selecionado == 3) {
      valorSelecionado = 'Caminh';
    } else {
      valorSelecionado = '';
    }



    // Validação dos campos
    if (moradia.trim().isNotEmpty &&
        placa.trim().isNotEmpty &&
        ocupantes.trim().isNotEmpty &&
        condutor.trim().isNotEmpty &&
        valorSelecionado.isNotEmpty) {

      Map<String, dynamic> listagem = {
        'moradia': moradia,
        'placa': placa,
        'tipo': valorSelecionado,
        'data': dataAtual,
        'ocupantes': ocupantes,
        'condutor': condutor,
        'observacao': observacao,
      };

      setState(() {
        ListaEntradas.listaEntradas.add(listagem);
        print(listagem);
      });

      // Limpa os campos
      moradiaController.clear();
      placaController.clear();
      ocupanteController.clear();
      condutorController.clear();
      observacaoController.clear();
      selecionado = 0;

      // Fecha qualquer snackbar antigo e mostra o de sucesso
      final messenger = ScaffoldMessenger.of(context);
      messenger.hideCurrentSnackBar();
      messenger.showSnackBar(
        SnackBar(
          content: const Text('Registro Salvo!',style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),),
          backgroundColor: Colors.green,
          duration: const Duration(seconds: 4),
        ),
      );

      Navigator.pop(context);
      return; // para não executar o código de erro abaixo
    }
    final messenger = ScaffoldMessenger.of(context);
    messenger.hideCurrentSnackBar();
    messenger.showSnackBar(
      SnackBar(
        content: const Text('Preencha os campos obrigatórios!',style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),),
        backgroundColor: Colors.red,
        duration: const Duration(seconds:10),
      ),
    );



  }


  void adicionarSaida() {
    final dataAtualSaida = DateFormat('dd/MMM HH:mm').format(DateTime.now());
    var moradia = moradiaController.text;
    var placa = placaController.text;
    var ocupantes = ocupanteController.text;
    var condutor = condutorController.text;
    var observacao = observacaoController.text;

    if (selecionado == 1) {
      valorSelecionado = 'Carro';
      print(valorSelecionado);
    }
    if (selecionado == 2) {
      valorSelecionado = 'Moto';
    }
    if (selecionado == 3) {
      valorSelecionado = 'Caminh';
    }

    Map<String, dynamic> listagem = {
      'moradia': moradia,
      'placa': placa,
      'tipo': valorSelecionado,
      'data': dataAtualSaida,
      'ocupantes': ocupantes,
      'condutor': condutor,
      'observacao': observacao,
    };

    setState(() {
      ListaEntradas.listaSaidas.add(listagem);
      print(ListaEntradas.listaSaidas);
    });
    moradiaController.clear();
    placaController.clear();
    ocupanteController.clear();
    condutorController.clear();
    observacaoController.clear();
    selecionado = 0;

    final messenger = ScaffoldMessenger.of(context);
    messenger.hideCurrentSnackBar();
    messenger.showSnackBar(
      SnackBar(
        content:  Text('Saída Confirmada!',style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
        ),
        backgroundColor: Colors.orange,
        duration: const Duration(seconds: 2),
      ),
    );


  }

  void adicionarPopup() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setStateDialog) {
            return AlertDialog(
              insetPadding: EdgeInsets.symmetric(horizontal: 20),
              title: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(15),
                ),
                padding: const EdgeInsets.all(12),
                child: const Text(
                  'Entrada - Informações',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          width: 130,
                          child: TextField(
                            maxLength: 5,
                            controller: moradiaController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),

                              ),
                              hintText: 'Apartamento',
                              labelText: 'Moradia',
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 130,
                          child: TextField(
                            maxLength: 7,
                            controller: placaController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              hintText: 'Placa',
                              labelText: 'Placa',
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: RadioListTile<int>(
                            title: Text("Carro"),
                            value: 1,
                            groupValue: selecionado,
                            onChanged: (value) {
                              setStateDialog(() {
                                selecionado = value!;
                              });
                            },
                          ),
                        ),
                        Expanded(
                          child: RadioListTile<int>(
                            // dense: true,
                            title: Text("Moto"),
                            value: 2,
                            groupValue: selecionado,
                            onChanged: (value) {
                              setStateDialog(() {
                                selecionado = value!;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: RadioListTile<int>(
                            title: Text("Caminhão"),
                            value: 3,
                            groupValue: selecionado,
                            onChanged: (value) {
                              setStateDialog(() {
                                selecionado = value!;
                              });
                            },
                          ),
                        ),
                        SizedBox(
                          width: 100,
                          child: TextField(
                            controller: ocupanteController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              hintText: 'Qtd',
                              labelText: 'Ocupantes',
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 12),
                    TextField(
                      controller: condutorController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        hintText: 'Nome',
                        labelText: 'Condutor',
                      ),
                    ),
                    SizedBox(height: 15),
                    TextField(
                      maxLines: null,
                      controller: observacaoController,
                      //  minLines: 3,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        hintText: 'Observação',
                        labelText: 'Observação',
                      ),
                    ),
                  ],
                ),
              ),
              actions: [
                
                IconButton(onPressed:limpaDadosEntrada, icon: Icon(Icons.cleaning_services,size: 28, color: Colors.blue,))
                ,
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text(
                    'Cancelar',
                    style: TextStyle(color: Colors.red),
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                  ),
                  onPressed: () {
                    adicionarEntradas();
                  },
                  child: const Text(
                    'Salvar',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void removerContato(int index) {
    setState(() {
      ListaEntradas.listaEntradas.removeAt(index);
    });
  }

  void limpaDadosEntrada(){
    moradiaController.clear();
    placaController.clear();
    ocupanteController.clear();
    condutorController.clear();
    observacaoController.clear();
    selecionado = 0;


    final messenger = ScaffoldMessenger.of(context);
    messenger.hideCurrentSnackBar();
    messenger.showSnackBar(
      SnackBar(
        content: const Text('Dados limpos!',style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),),
        backgroundColor: Colors.blue,
        duration: const Duration(seconds:2),
      ),
    );

  }

  void adicionarSaidaPopup(index) {
    final horaAgora = DateFormat('dd/MMM HH:mm').format(DateTime.now());
    dataSaidaController.text = horaAgora;

    // Pega os dados da entrada selecionada
    var entrada = ListaEntradas.listaEntradas[index];

    // Preenche os controllers automaticamente
    moradiaController.text = entrada['moradia'];
    placaController.text = entrada['placa'];
    ocupanteController.text = entrada['ocupantes'];
    condutorController.text = entrada['condutor'];
    observacaoController.text = entrada['observacao'];
    dataEntradaController.text = entrada['data'];
    selecionado = (entrada['tipo'] == 'Carro')
        ? 1
        : (entrada['tipo'] == 'Moto')
        ? 2
        : 3;


    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setStateDialog) {
            return AlertDialog(
              insetPadding: EdgeInsets.symmetric(horizontal: 20),
              title: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.orange,
                  borderRadius: BorderRadius.circular(15),
                ),
                padding: const EdgeInsets.all(12),
                child: const Text(
                  'Saída - Informações',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          width: 130,
                          child: TextField(
                            maxLength: 7,
                            controller: moradiaController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              hintText: 'Apartamento',
                              labelText: 'Moradia',
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 130,
                          child: TextField(
                            maxLength: 7,
                            controller: placaController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              hintText: 'Placa',
                              labelText: 'Placa',
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: RadioListTile<int>(
                            title: Text("Carro"),
                            value: 1,
                            groupValue: selecionado,
                            onChanged: (value) {
                              setStateDialog(() {
                                selecionado = value!;
                              });
                            },
                          ),
                        ),
                        //SizedBox(width: 10,),
                        Expanded(
                          child: RadioListTile<int>(
                            title: Text("Moto"),
                            value: 2,
                            groupValue: selecionado,
                            onChanged: (value) {
                              setStateDialog(() {
                                selecionado = value!;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: RadioListTile<int>(
                            title: Text("Caminhão"),
                            value: 3,
                            groupValue: selecionado,
                            onChanged: (value) {
                              setStateDialog(() {
                                selecionado = value!;
                              });
                            },
                          ),
                        ),
                        SizedBox(
                          width: 100,
                          child: TextField(
                            controller: ocupanteController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              hintText: 'Qtd',
                              labelText: 'Ocupantes',
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 12),
                    TextField(
                      controller: condutorController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        hintText: 'Nome',
                        labelText: 'Condutor',
                      ),
                    ),
                    SizedBox(height: 15),
                    TextField(
                      controller: dataEntradaController,
                      readOnly: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        // hintText:'' ,
                        labelText: 'Entrada',
                        labelStyle: TextStyle(
                          color: Colors.green,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    SizedBox(height: 15),
                    TextField(
                      controller: dataSaidaController,
                      readOnly: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        //hintText: dataAtual,
                        labelText: 'Saída',
                        labelStyle: TextStyle(
                          color: Colors.orange,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),

                    SizedBox(height: 15),

                    TextField(
                      maxLines: null,
                      controller: observacaoController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        hintText: 'Observação',
                        labelText: 'Observação',
                      ),
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text(
                    'Cancelar',
                    style: TextStyle(color: Colors.red),
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                  ),
                  onPressed: () {
                    adicionarSaida();
                    removerContato(index);
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'Registra Saída',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              'Controle de Acessos',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 25,
                color: Colors.white,
              ),
            ),
            Icon(Icons.directions_car, color: Colors.white),
            Icon(Icons.directions_bike, color: Colors.white),
          ],
        ),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: [
          Container(
            color: Colors.grey[800],
            height: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  'Moradia',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                Text(
                  'Placa',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                Text(
                  'Tipo',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                Text(
                  'Data - Horário',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                Text(
                  'Regi.',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          // Divider(),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.only(bottom: 80),
              itemCount: ListaEntradas.listaEntradas.length,
              itemBuilder: (context, index) {
                var entradas = ListaEntradas.listaEntradas[index];
                return Column(
                  children: [
                    ListTile(
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(entradas['moradia']),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Text(entradas['placa']),
                          ),

                          Padding(
                            padding: const EdgeInsets.only(left: 5, right: 6),
                            child: Text(entradas['tipo']),
                          ),

                          Text(entradas['data'].toString()),

                          Padding(
                            padding: const EdgeInsets.only(left: 2),
                            child: IconButton(
                              onPressed: () {
                                adicionarSaidaPopup(index);
                              },
                              icon: Icon(
                                Icons.assignment_outlined,
                                color: Colors.orange,
                                size: 30,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(),
                  ],
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Stack(
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: FloatingActionButton(
              heroTag: "fab_add",
              backgroundColor: Colors.blue,
              onPressed: adicionarPopup,
              child: Icon(Icons.add),
              tooltip: 'Adicionar',
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.only(right: 20),
              child: FloatingActionButton(
                heroTag: "fab_receipt",
                backgroundColor: Colors.orange,
                tooltip: 'Sáida',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          Appsaidacondominio(moradia: moradiaController.text),
                    ),
                  );
                },
                child: Icon(Icons.assignment_outlined),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
