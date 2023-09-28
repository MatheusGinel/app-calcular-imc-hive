# Calculadora de Índice de Massa Corporal (IMC) com App em Flutter

Desafio de projeto proposto pela DIO, no Bootcamp de mobile com flutter. Criar uma aplicação em flutter para realizar o cálculo de IMC e apresentar os resultados em uma lista. Usando o SharedPreferences para salvar o peso e a altura do usuário. E com o Hive realizar as funcionalidades de calculo e inserir na lista.

## 🚀 Funcionamento
Iniciar a aplicação no VS Code juntamente com emulador do Android Studio:

https://github.com/MatheusGinel/app-calcular-imc-hive/assets/99911565/41e937a1-d083-40a7-9827-75bfb3eb5227

O App verifica se os campos de digitação de "Peso" e "Altura" não estão vazio. Após isso realiza o cálculo de acordo com o peso e altura digitados, assim mostrando o resultado do IMC em uma lista. Os valores do peso e altura são salvos com SharedPreferences:

![Screenshot_1](https://github.com/MatheusGinel/app-calcular-imc-hive/assets/99911565/2d6295f7-5b5c-4893-96af-1d27ea86c702)

Com um "ScaffoldMessenger" ele irá retornar uma mensagem sobre a situação do IMC consultado:

![app_imc_scaffold_mensenger2](https://github.com/MatheusGinel/app-flutter-calculadora-imc/assets/99911565/cbf1ff18-5589-45e7-9cea-6810be2eb10e)

Após isso ele envia o peso, a altura e o imc para uma lista. Com o HIve, ele guarda todos os resultados nessa lista. Implementei também a funcionalidade de remover um resultado da lista, bastando arrastar para o lado. Guardando todos os resultados que estejam sendo consultados pelo usuário. O usuário pode optar por clicar no botão "Limpar", onde limpara os campos de peso e altura, assim como a lista também:

![app_imc_lista](https://github.com/MatheusGinel/app-flutter-calculadora-imc/assets/99911565/a1f261c9-82d2-4b33-b5e1-582b24429a04)

- [Clique aqui para maiores informações sobre o Flutter](https://flutter.dev) 
- [Clique aqui para maiores informações sobre o Android Studio](https://developer.android.com/studio)

## ✒️ Desenvolvedor
[Matheus Azevedo Neves](https://github.com/MatheusGinel)
