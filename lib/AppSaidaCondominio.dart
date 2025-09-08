import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:appcondominio/Lista_Entradas.dart';
import 'Saida.dart';
import 'package:intl/intl.dart';

class Appsaidacondominio extends StatefulWidget {
  final String moradia; // recebe os dados
  const Appsaidacondominio({super.key, required this.moradia});



  @override
  State<Appsaidacondominio> createState() => _AppsaidacondominioState();
}

class _AppsaidacondominioState extends State<Appsaidacondominio> {

  final moradiaController = TextEditingController();
  final placaController = TextEditingController();
  final ocupanteController = TextEditingController();
  final condutorController = TextEditingController();
  final observacaoController = TextEditingController();
  final dataSaidaController = TextEditingController();
  final dataEntradaController = TextEditingController();

  int? selecionado;
  late String valorSelecionado;


  void adicionarSaidaPopup(index) {
    final horaAgora = DateFormat('dd/MMM HH:mm').format(DateTime.now());
    dataSaidaController.text = horaAgora;

    // Pega os dados da entrada selecionada
    var entrada = ListaEntradas.listaSaidas[index];

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
                  style: TextStyle(color: Colors.white,fontWeight: FontWeight.w600),
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
                            readOnly: true,
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
                            readOnly: true,
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
                            enabled: false,
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
                            enabled: false,
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
                            enabled: false,
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
                            readOnly: true,
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
                      readOnly: true,
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
                      controller:dataEntradaController,
                      readOnly: true,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          // hintText:'' ,
                          labelText: 'Entrada',
                          labelStyle: TextStyle(color: Colors.green, fontSize:18,fontWeight: FontWeight.w600)
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
                          labelStyle: TextStyle(color: Colors.orange, fontSize:18,fontWeight: FontWeight.w600)
                      ),
                    ),

                    SizedBox(height: 15),

                    TextField(
                      maxLines: null,
                      readOnly: true,
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
                  child: const Text('Voltar',style: TextStyle(color: Colors.red),),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue
                  ),
                  onPressed:(){
                   // adicionarSaida();
                   // removerContato(index);
                    Navigator.pop(context);
                  },
                  child: const Text('Adicionar ao Registro',style: TextStyle(color: Colors.white),),
                )

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
            Text('Registros de Saída',style: TextStyle(fontWeight: FontWeight.w600,fontSize: 25,color: Colors.white),),
            Icon(Icons.directions_car, color: Colors.white,),
            Icon(Icons.directions_bike, color: Colors.white,),
          ],
        ),
        backgroundColor: Colors.orange,
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
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600, color: Colors.white),
                ),
                Text(
                  'Placa',
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600, color: Colors.white),
                ),
                Text(
                  'Tipo',
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600, color: Colors.white),
                ),
                Text(
                  'Data - Horário',
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600, color: Colors.white),
                ),
                Text(
                  'Regi.',
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600, color: Colors.white),)
              ],
            ),
          ),
          Divider(),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.only(bottom: 80),
              itemCount: ListaEntradas.listaSaidas.length,
              itemBuilder: (context, index) {
                var entradas = ListaEntradas.listaSaidas[index];
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
                            padding: const EdgeInsets.only(left: 0),
                            child: IconButton(
                              onPressed: () {
                                adicionarSaidaPopup(index);
                              },
                              icon: Icon(Icons.assignment_outlined, color: Colors.orange,size: 30,)
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
    );
  }
}
