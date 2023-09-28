// ignore_for_file: camel_case_types, constant_identifier_names

import 'package:shared_preferences/shared_preferences.dart';

enum STORAGE_CHAVES {
  CHAVE_CALCULAR_IMC_PESO,
  CHAVE_CALCULAR_IMC_ALTURA,
}

class AppStorageService {
  Future<void> setCalculoImcPeso(double values) async {
    await _setDouble(STORAGE_CHAVES.CHAVE_CALCULAR_IMC_PESO.toString(), values);
  }

  Future<double> getCalculoImcPeso() {
    return _getDouble(STORAGE_CHAVES.CHAVE_CALCULAR_IMC_PESO.toString());
  }

  Future<void> setCalcularImcAltura(double values) async {
    await _setDouble(
        STORAGE_CHAVES.CHAVE_CALCULAR_IMC_ALTURA.toString(), values);
  }

  Future<double> getCalcularImcAltura() {
    return _getDouble(STORAGE_CHAVES.CHAVE_CALCULAR_IMC_ALTURA.toString());
  }

  _setDouble(String chave, double values) async {
    var storage = await SharedPreferences.getInstance();
    storage.setDouble(chave, values);
  }

  Future<double> _getDouble(String chave) async {
    var storage = await SharedPreferences.getInstance();
    return storage.getDouble(chave) ?? 0;
  }
}
