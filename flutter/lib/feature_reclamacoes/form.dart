import 'package:flutter/material.dart';

class ReclamacaoForm extends StatefulWidget {
  @override
  _ReclamacaoFormState createState() => _ReclamacaoFormState();
}

class _ReclamacaoFormState extends State<ReclamacaoForm> {
  String? _tipoDenuncia = 'Selecione';
  String _descricao = '';
  final _descricaoController = TextEditingController();

  String _gerarProtocolo() {
    return '#${DateTime.now().millisecondsSinceEpoch.toRadixString(36).toUpperCase().substring(0, 6)}';
  }

  void _enviarReclamacao() {
    if (_tipoDenuncia == 'Selecione' || _descricao.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Descreva a sua reclamação')),
      );
      return;
    }

    final protocolo = _gerarProtocolo();
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Reclamação Registrada'),
        content: Text('Seu protocolo é: $protocolo'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).pop();
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Nova Reclamação')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            DropdownButtonFormField<String>(
              value: _tipoDenuncia,
              decoration: const InputDecoration(labelText: 'Tipo de Reclamação'),
              items: ['Selecione', 'Buraco', 'Iluminação', 'Lixo'].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _tipoDenuncia = value;
                });
              },
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _descricaoController,
              decoration: const InputDecoration(labelText: 'Descrição'),
              onChanged: (value) => _descricao = value,
              maxLines: 3,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _enviarReclamacao,
              child: const Text('Enviar Reclamação'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _descricaoController.dispose();
    super.dispose();
  }
}