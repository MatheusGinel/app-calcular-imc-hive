import 'package:calculadoraimc/model/imc_model.dart';
import 'package:hive/hive.dart';

class ImcRepository {
  static late Box<IMCModel> _imcBox;

  ImcRepository._criar();

  static Future<ImcRepository> carregar() async {
    if (Hive.isBoxOpen('imcBox')) {
      _imcBox = Hive.box('imcBox');
    } else {
      _imcBox = await Hive.openBox('imcBox');
    }
    return ImcRepository._criar();
  }

  salvar(IMCModel imcModel) {
    _imcBox.add(imcModel);
  }

  excluir(IMCModel imcModel) {
    imcModel.delete();
  }

  alterar(IMCModel imcModel) {
    imcModel.save();
  }

  calcularImc(IMCModel imcModel) {
    return imcModel.peso / (imcModel.altura * imcModel.altura);
  }

  Future<List<IMCModel>> listarIMC() async {
    final imcs = _imcBox.values.map((e) => e).toList();
    return imcs;
  }
}
