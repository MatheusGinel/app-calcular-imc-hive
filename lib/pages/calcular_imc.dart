// ignore_for_file: use_build_context_synchronously, duplicate_ignore

import 'package:calculadoraimc/model/imc_model.dart';
import 'package:calculadoraimc/repositories/imc_repository.dart';
import 'package:calculadoraimc/services/app_storage_service.dart';
import 'package:calculadoraimc/shared/widgets/text_label.dart';
import 'package:flutter/material.dart';

class CalcularImcPage extends StatefulWidget {
  const CalcularImcPage({super.key});

  @override
  State<CalcularImcPage> createState() => _CalcularImcPageState();
}

class _CalcularImcPageState extends State<CalcularImcPage> {
  AppStorageService storage = AppStorageService();
  late ImcRepository imcRepository;

  IMCModel imcModel = IMCModel.criar(0, 0, 0);

  var pesoController = TextEditingController();
  var alturaController = TextEditingController();
  var imcRetorno = [];
  var resultadoImc = "";
  var retornaIMC = const <IMCModel>[];

  @override
  void initState() {
    super.initState();
    obterIMC();
  }

  void obterIMC() async {
    pesoController.text = (await (storage.getCalculoImcPeso())).toString();
    alturaController.text = (await (storage.getCalcularImcAltura())).toString();

    imcRepository = await ImcRepository.carregar();
    retornaIMC = await imcRepository.listarIMC();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Calculando o Índice de Massa Corporal",
            style: TextStyle(
              fontSize: 18.5,
              fontWeight: FontWeight.bold,
            ),
          ),
          leading: const Icon(
            Icons.calculate_outlined,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
          child: Column(
            children: [
              const TextLabel(
                texto: "Peso",
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: pesoController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                    hintText: "Digite o seu peso",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ))),
                onChanged: (value) async {},
              ),
              const SizedBox(
                height: 15,
              ),
              const TextLabel(
                texto: "Altura",
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: alturaController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                    hintText: "Digite a sua altura",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ))),
                onChanged: (value) {},
              ),
              const SizedBox(
                height: 15,
              ),
              TextButton(
                onPressed: () async {
                  FocusManager.instance.primaryFocus?.unfocus();

                  if (pesoController.text.isNotEmpty ||
                      alturaController.text.isNotEmpty) {
                    await storage
                        .setCalculoImcPeso(double.parse(pesoController.text));
                    await storage.setCalcularImcAltura(
                        double.parse(alturaController.text));
                    IMCModel novoImc = IMCModel.criar(
                      double.parse(pesoController.text),
                      double.parse(alturaController.text),
                      0,
                    );

                    await imcRepository.salvar(novoImc);
                    retornaIMC = await imcRepository.listarIMC();
                    setState(() {});
                  } else {
                    // ignore: use_build_context_synchronously
                    showDialog(
                        context: context,
                        builder: (_) {
                          return AlertDialog(
                            title: const Text("Meu IMC"),
                            content: const Text(
                                "Por favor, informar um peso valido"),
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text("OK"))
                            ],
                          );
                        });
                  }

                  await imcRepository.calcularImc(IMCModel.criar(
                      double.parse(pesoController.text),
                      double.parse(alturaController.text),
                      0));

                  setState(() {});
                  if (retornaIMC.isNotEmpty &&
                      retornaIMC.last.calcularIMC() < 16) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text(
                      "DIAGNÓSTICO: Magreza Grave",
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.blueAccent),
                      textAlign: TextAlign.center,
                    )));
                    return;
                  } else if (retornaIMC.isNotEmpty &&
                      retornaIMC.last.calcularIMC() >= 16 &&
                      retornaIMC.last.calcularIMC() < 17) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text(
                      "DIAGNÓSTICO: Magreza Moderada",
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.blueAccent),
                      textAlign: TextAlign.center,
                    )));
                    return;
                  } else if (retornaIMC.isNotEmpty &&
                      retornaIMC.last.calcularIMC() >= 17 &&
                      retornaIMC.last.calcularIMC() < 18.5) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text(
                      "DIAGNÓSTICO: Magreza Leve",
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.blueAccent),
                      textAlign: TextAlign.center,
                    )));
                    return;
                  } else if (retornaIMC.isNotEmpty &&
                      retornaIMC.last.calcularIMC() >= 18.5 &&
                      retornaIMC.last.calcularIMC() < 25) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text(
                      "DIAGNÓSTICO: Saudável",
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.greenAccent),
                      textAlign: TextAlign.center,
                    )));
                    return;
                  } else if (retornaIMC.isNotEmpty &&
                      retornaIMC.last.calcularIMC() >= 25 &&
                      retornaIMC.last.calcularIMC() < 30) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text(
                      "DIAGNÓSTICO: Sobrepeso",
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.amber),
                      textAlign: TextAlign.center,
                    )));
                    return;
                  } else if (retornaIMC.isNotEmpty &&
                      retornaIMC.last.calcularIMC() >= 30 &&
                      retornaIMC.last.calcularIMC() < 35) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text(
                      "DIAGNÓSTICO: Obesidade Grau I",
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.deepOrangeAccent),
                      textAlign: TextAlign.center,
                    )));
                    return;
                  } else if (retornaIMC.isNotEmpty &&
                      retornaIMC.last.calcularIMC() >= 35 &&
                      retornaIMC.last.calcularIMC() <= 40) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text(
                      "DIAGNÓSTICO: Obesidade Grau II",
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.deepOrangeAccent),
                      textAlign: TextAlign.center,
                    )));
                    return;
                  } else if (retornaIMC.isNotEmpty &&
                      retornaIMC.last.calcularIMC() > 40) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text(
                      "DIAGNÓSTICO: Obesidade Grau III",
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.red),
                      textAlign: TextAlign.center,
                    )));
                    return;
                  }
                },
                child: const Text(
                  "Calcular",
                  style: TextStyle(
                    color: Colors.deepOrange,
                    fontSize: 20,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: retornaIMC.length,
                  itemBuilder: (BuildContext bc, int index) {
                    var retornaImc = retornaIMC[index];
                    String imcResultado = (retornaImc.peso /
                            (retornaImc.altura * retornaImc.altura))
                        .toStringAsFixed(2);

                    return Dismissible(
                        key: UniqueKey(),
                        background: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          color: Colors.red, // Define a cor de fundo aqui
                          alignment: Alignment.centerLeft,
                          child: const Icon(
                            Icons.delete,
                            color: Colors.white,
                          ),
                        ),
                        onDismissed: (DismissDirection dismissDirection) async {
                          setState(() {
                            imcRepository.excluir(retornaImc);
                            obterIMC();
                            //retornaIMC.removeAt(index);
                          });
                        },
                        child: ListTile(
                          title: Text(
                            "${retornaImc.peso} kg | ${retornaImc.altura} m | IMC: $imcResultado",
                            textAlign: TextAlign.center,
                          ),
                        ));
                  },
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.yellowAccent,
          onPressed: () {
            setState(() {
              retornaIMC.clear();
              pesoController.clear();
              alturaController.clear();
            });
          },
          tooltip: "Limpar",
          child: const Text("Limpar",
              style: TextStyle(
                decoration: TextDecoration.underline,
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              )),
        ),
      ),
    );
  }
}
