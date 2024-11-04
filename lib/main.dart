import 'package:flutter/material.dart';
import 'package:nota/colors/colores.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 200.0,
                height: 250.0,
                child: Image.asset('assets/2Inicio.png'),
              ),
              const Text(
                "Inicia Creando tus Notas ",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 50.0,
                    fontWeight: FontWeight.w900,
                    color: primaryColor),
              ),
              const Text(
                "Personaliza tus notas, realiza recordatorio para eventos, citas y mucho más ¡Todo en un solo lugar!",
                textAlign: TextAlign.center,
                style: TextStyle(),
              ),
              const SizedBox(
                height: 50.0,
              ),
              SizedBox(
                width: 166.0,
                height: 44.0,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ButtonStyle(
                    backgroundColor: const WidgetStatePropertyAll(
                        primaryColor), // Usando primaryColor

                    shape: WidgetStatePropertyAll(
                      RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(15.0), // Redondear bordes
                      ),
                    ),
                  ),
                  child: const Text(
                    "¡EscribeYa!",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0),
                  ),
                ),
              ),
              const SizedBox(
                height: 80.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: const EdgeInsets.only(
                        left: 16.0), // Margin a la izquierda
                    child: const Text("Politica de Privacidad"),
                  ),
                  Container(
                      margin: const EdgeInsets.only(
                          right: 16.0), // Margin a la izquierda
                      child: const Text("Términos fffgit ady condiciones"))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
