import 'package:flutter/material.dart';
import 'package:meseros_app/providers/main_provider.dart';
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
            child: const Icon(
              Icons.settings_outlined,
              color: Colors.white,
            )),
  
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
        
        SizedBox(
          width: double.infinity,
          
          child: Text('Bienvenido', style: TextStyle(fontSize: 25, ), textAlign: TextAlign.center,),
        ),
        _Formulario()
      ],),
    );
  }
}

class _Formulario extends StatelessWidget {
  const _Formulario();

  @override
  Widget build(BuildContext context) {
    final mainProvider = Provider.of<MainProvider>(context);

    void enterToApp() {
      Navigator.pushReplacementNamed(context, '/');
      // final mainProvider = Provider.of<MainProvider>(context, listen: false);
      // mainProvider.getMovimientos();
    }

    // void showMSG(String title, String msg) {
    //   showDialog(
    //       context: context,
    //       builder: (context) {
    //         return InfoDLG(title: title, text: msg);
    //       });
    // }


    return Form(
      key: mainProvider.loginKey,
      child: 
    Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          DropdownButtonFormField(items: mainProvider.meseros != []
                  ? mainProvider.meseros
                      .map((user) => DropdownMenuItem(
                            value: user,
                            child: Text(user),
                          ))
                      .toList()
                  : [
                      const DropdownMenuItem(
                          value: 'Sin conexion!', child: Text('Sin conexion!'))
                    ]
              // loginForm.usernames.map((user) => DropdownMenuItem(child: Text(data),value: ,))
              ,
              onChanged: (value) => mainProvider.username = value.toString(),
              onSaved: (value) => mainProvider.username = value.toString(),
              validator: (value) => value != null ? null : '*Campo requerido',
              autovalidateMode: AutovalidateMode.always,
          ),
          TextFormField(
            keyboardType: TextInputType.number,
            maxLength: 4,
            onChanged: (value) => mainProvider.password =
                  value, // Actualizar el valor del formulario
              autocorrect: false,
              obscureText: true,
            decoration: InputDecoration(
              labelText: 'Contraseña',
              hintText: 'Ingrese su contraseña',
            ),
          ),
           MaterialButton(
              onPressed: mainProvider.isLoading
                  ? null
                  : () async {
                      FocusScope.of(context).unfocus();
                      mainProvider.isLoading = true;
                      if (mainProvider.isValidForm()) {
                        mainProvider.isLoading = true;
                        bool isOk = await mainProvider.validateUser(
                            mainProvider.username, mainProvider.password);
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
              disabledColor: Colors.grey,
              color: Colors.indigo,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Text(mainProvider.isLoading ? 'Ingresando...' : 'Login',
                      style:
                          const TextStyle(color: Colors.white, fontSize: 20))),
            ),
        ],
      ),
    ));
  }
}