import 'package:flutter/material.dart';
import 'package:meseros_app/providers/main_provider.dart';
import 'package:meseros_app/theme/app_theme.dart';
import 'package:meseros_app/widgets/authbackground.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black54,
        onPressed: () {
          Navigator.pushNamed(context, 'preferences');
        },
        child: const Icon(Icons.settings_outlined, color: Colors.white),
      ),
      body: AuthBackground(
        child: SingleChildScrollView(
          child: Column(children: [const SizedBox(height: 220), _CardLogin()]),
        ),
      ),
    );
  }
}

class _CardLogin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: _customDecoration(),
      height: 300,
      margin: EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: double.infinity,
            child: Text(
              'Bienvenido',
              style: TextStyle(fontSize: 25),
              textAlign: TextAlign.center,
            ),
          ),
          _Formulario(),
        ],
      ),
    );
  }

  BoxDecoration _customDecoration() => BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(20),
    boxShadow: [
      BoxShadow(color: Colors.black26, spreadRadius: 5, blurRadius: 6),
    ],
  );
}

class _Formulario extends StatelessWidget {
  const _Formulario();

  @override
  Widget build(BuildContext context) {
    final mainProvider = Provider.of<MainProvider>(context);

    void enterToApp() {
      mainProvider.getStats();
      Navigator.pushReplacementNamed(context, '/');
    }

    return Form(
      key: mainProvider.loginKey,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            DropdownButtonFormField(
              decoration: AppTheme.normalInputDecoration(
                labelText: 'Usuario',
                hintText: 'Seleccionar usuario',
              ),
              items:
                  mainProvider.waitresses != []
                      ? mainProvider.waitresses
                          .map(
                            (user) => DropdownMenuItem(
                              value: user,
                              child: Text(user),
                            ),
                          )
                          .toList()
                      : [
                        const DropdownMenuItem(
                          value: 'Sin conexion!',
                          child: Text('Sin conexion!'),
                        ),
                      ],
              // loginForm.usernames.map((user) => DropdownMenuItem(child: Text(data),value: ,))
              onChanged: (value) => mainProvider.username = value.toString(),
              onSaved: (value) => mainProvider.username = value.toString(),
              validator: (value) => value != null ? null : '*Campo requerido',
              autovalidateMode: AutovalidateMode.always,
            ),
            TextFormField(
              keyboardType: TextInputType.number,
              maxLength: 4,
              onChanged:
                  (value) =>
                      mainProvider.password =
                          value, // Actualizar el valor del formulario
              autocorrect: false,
              obscureText: true,
              cursorColor: AppTheme.primaryColor,
              decoration: AppTheme.normalInputDecoration(
                labelText: 'Contraseña',
                hintText: 'Ingrese su contraseña',
              ),
            ),
            ElevatedButton(
              onPressed:
                  mainProvider.isLoading
                      ? null
                      : () async {
                        FocusScope.of(context).unfocus();
                        mainProvider.isLoading = true;
                        if (mainProvider.isValidForm()) {
                          mainProvider.isLoading = true;
                          bool isOk = await mainProvider.validateUser(
                            mainProvider.username,
                            mainProvider.password,
                          );
                          if (isOk) {
                            enterToApp();
                          } else {
                            // showMSG('LOGIN', 'Validar campos!');
                          }
                          mainProvider.isLoading = false;
                        } else {
                          mainProvider.isLoading = false;
                        }
                      },

              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                child: Text(
                  mainProvider.isLoading ? 'Ingresando...' : 'Login',
                  style: const TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
