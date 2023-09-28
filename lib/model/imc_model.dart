import 'package:hive/hive.dart';
part 'imc_model.g.dart';

@HiveType(typeId: 0)
class IMCModel extends HiveObject {
  @HiveField(0)
  double _peso = 0;

  @HiveField(1)
  double _altura = 0;

  @HiveField(2)
  double _resultado = 0;

  IMCModel.vazio() {
    _peso = 0;
    _altura = 0;
    _resultado = 0;
  }

  IMCModel();

  IMCModel.criar(this._peso, this._altura, this._resultado);

  double get peso => _peso;

  set peso(peso) {
    _peso = peso;
  }

  double get altura => _altura;

  set altura(altura) {
    _altura = altura;
  }

  double get resultado => _resultado;

  set resultado(resultado) {
    _resultado = resultado;
  }

  double calcularIMC() {
    return peso / (altura * altura);
  }
}
