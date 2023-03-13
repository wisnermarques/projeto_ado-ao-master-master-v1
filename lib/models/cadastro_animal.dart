import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/tela_inicial.dart';
import 'package:image_picker/image_picker.dart';
import 'package:scoped_model/scoped_model.dart';
import '../models/user_model.dart';

class CadastroAnimal extends StatefulWidget {
  const CadastroAnimal({Key? key}) : super(key: key);

  @override
  createState() => _CadastroAnimalState();
}

class _CadastroAnimalState extends State<CadastroAnimal> {
  final nomeAnimalController = TextEditingController();
  final especieController = TextEditingController();
  final descricaoAnimalController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<UserModel>(
      builder: (context, child, model) => Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Center(
            child: Form(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.pets,
                    color: Colors.lightGreen,
                    size: 50,
                  ),
                  const SizedBox(width: 10),
                  const Text(
                    ' Hora de criar um perfil para seu animal !',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontStyle: FontStyle.italic,
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                      color: Colors.lightGreen,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.green.withOpacity(0.5),
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: TextFormField(
                      textAlign: TextAlign.center,
                      controller: nomeAnimalController,
                      autofocus: true,
                      keyboardType: TextInputType.text,
                      style: const TextStyle(
                        color: Colors.green,
                        fontSize: 18,
                      ),
                      decoration: InputDecoration(
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 310),
                        labelText: 'Nome do seu animalzinho!',
                        labelStyle: TextStyle(
                          color: Colors.black.withOpacity(0.5),
                          fontSize: 15,
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.green.withOpacity(0.5),
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: TextFormField(
                      textAlign: TextAlign.center,
                      controller: descricaoAnimalController,
                      autofocus: true,
                      keyboardType: TextInputType.text,
                      style: const TextStyle(color: Colors.green, fontSize: 18),
                      decoration: InputDecoration(
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 300),
                        labelText: 'Adicione aqui a descrição do animal',
                        labelStyle: TextStyle(
                          color: Colors.black.withOpacity(0.5),
                          fontSize: 15,
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Escolha uma imagem para dar identidade ao seu animalzinho ! Imagens que ferem as diretrizes da comunidade muito provavelmente vão acarretar em "perma-ban" ( banimento vitalício por justa causa ). Recomenda-se ler as diretrizes de usuário',
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 10),
                  // Select Image Button

                  Container(
                    margin: const EdgeInsets.only(top: 10),
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.lightGreen[300],
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: TextButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text(
                                "Selecione uma imagem",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                ),
                              ),
                              content: SingleChildScrollView(
                                child: ListBody(
                                  children: <Widget>[
                                    GestureDetector(
                                      child: const Text("Galeria"),
                                      onTap: () {
                                        _pickImage(ImageSource.gallery);
                                        Navigator.pop(context);
                                      },
                                    ),
                                    const Padding(padding: EdgeInsets.all(8.0)),
                                    GestureDetector(
                                      child: const Text("Câmera"),
                                      onTap: () {
                                        _pickImage(ImageSource.camera);
                                        Navigator.pop(context);
                                      },
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      },
                      child: const Center(
                        child: Text(
                          'Selecionar imagem',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 10),
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.lightGreen[300],
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: TextButton(
                        child: const Center(
                          child: Text(
                            'Criar cadastro do animal',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            model.cadastroAnimal(
                                nome: nomeAnimalController.text,
                                descricao: descricaoAnimalController.text,
                                idCategoria: model.categoriaId,
                                onFail: _onFail,
                                onSuccess: _onSuccess);

                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const TelaAnimais()));
                          }
                        }),
                  ),
                ], // fim do children
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _pickImage(ImageSource gallery) {}
  // uploader ( está acima )

  void _onSuccess() {
    Navigator.of(context).pushReplacementNamed('/');
  }

  void _onFail() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Falha ao cadastrar!'),
        backgroundColor: Colors.red,
        duration: Duration(seconds: 2),
      ),
    );
  }
} // fim do class