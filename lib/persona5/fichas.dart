import 'package:flutter/material.dart';
import 'package:rpgmaker/persona5/personagem_model.dart';
import 'package:rpgmaker/db_ficha/fichadao.dart';
import 'package:rpgmaker/api/apifake/items.dart';
import 'package:rpgmaker/api/itemsapi.dart';



const _parchment = Color(0xFF12100E);
const _inkDark = Color(0xFF1C1007);
const _inkMid = Color(0xFF34445D);
const _gold = Color(0xFF2E5B8B);
const _goldLight = Color(0xFF5A788F);
const _crimson = Color(0xFF8B0000);
const _cardBg = Color(0xFFFAF3E0);
const _shadow = Color(0x33000000);

ThemeData get _theme => ThemeData(
      scaffoldBackgroundColor: _parchment,
      colorScheme: const ColorScheme.light(
        primary: _inkDark,
        secondary: _gold,
        surface: _cardBg,
      ),
      fontFamily: 'serif',
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white.withOpacity(0.6),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: const BorderSide(color: _gold, width: 1.5),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: BorderSide(color: _gold.withOpacity(0.5), width: 1.2),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: const BorderSide(color: _gold, width: 2),
        ),
        labelStyle: const TextStyle(color: _inkMid, fontSize: 13),
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      ),
    );



class PersonagemApp extends StatelessWidget {

  const PersonagemApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ficha de Personagem',
      theme: _theme,
      home: const Ficha(),
      debugShowCheckedModeBanner: false,
    );
  }
}



class Ficha extends StatefulWidget {
  const Ficha({super.key});

  @override
  State<Ficha> createState() => _FichaState();
}

class _FichaState extends State<Ficha> {
  final _fichaApi = FichaApiFake();
  final _fichaDao = FichaDao();

  bool _loadingExemplos = true;
  List<FichasP> _exemplos = [];

  bool _loadingSalvas = true;
  List<FichasP> _salvas = [];

  @override
  void initState() {
    super.initState();
    _carregarExemplos();
    _carregarSalvas();
  }

  Future<void> _carregarExemplos() async {
    final lista = await _fichaApi.listarFichasExemplo();
    if (!mounted) return;
    setState(() {
      _exemplos = lista;
      _loadingExemplos = false;
    });
  }

  Future<void> _carregarSalvas() async {
    setState(() => _loadingSalvas = true);
    final lista = await _fichaDao.listarFichas();
    if (!mounted) return;
    setState(() {
      _salvas = lista;
      _loadingSalvas = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _PageTitle(),
              const SizedBox(height: 24),
              _SectionLabel('Fichas de Exemplo'),
              const SizedBox(height: 10),
              if (_loadingExemplos)
                const Center(child: CircularProgressIndicator(color: _gold))
              else
                for (final ficha in _exemplos) ...[
                  PersonagemCard(FichaP: ficha),
                  const SizedBox(height: 28),
                ],
              _SectionLabel('Minhas Fichas'),
              const SizedBox(height: 10),
              if (_loadingSalvas)
                const Center(child: CircularProgressIndicator(color: _gold))
              else if (_salvas.isEmpty)
                Text(
                  'Nenhuma ficha salva ainda. Crie uma abaixo.',
                  style: TextStyle(color: _goldLight.withOpacity(0.8), fontSize: 13),
                )
              else
                for (final ficha in _salvas) ...[
                  PersonagemCard(FichaP: ficha),
                  const SizedBox(height: 28),
                ],
              const SizedBox(height: 4),
              _SectionLabel('Criar Nova Ficha'),
              const SizedBox(height: 10),

              _CriarFichaCard(onSalvo: _carregarSalvas),
              const SizedBox(height: 28),
              _SectionLabel('Itens'),
              const SizedBox(height: 10),

              _ItemSearchCard(),
            ],
          ),
        ),
      ),
    );
  }
}

class _PageTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 4,
              height: 36,
              decoration: BoxDecoration(
                color: _gold,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(width: 12),
            const Text(
              'FICHAS DE\nPERSONAGEM',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.w900,
                color: _gold,
                height: 1.1,
                letterSpacing: 2,
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        Padding(
          padding: const EdgeInsets.only(left: 16),
          child: Text(
            'Registro & Criação de Heróis',
            style: TextStyle(
              fontSize: 13,
              color: _goldLight.withOpacity(0.7),
              letterSpacing: 1.2,
            ),
          ),
        ),
      ],
    );
  }
}

class _SectionLabel extends StatelessWidget {
  final String text;
  const _SectionLabel(this.text);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(Icons.auto_stories, size: 15, color: _gold),
        const SizedBox(width: 6),
        Text(
          text.toUpperCase(),
          style: const TextStyle(
            fontSize: 11,
            letterSpacing: 2,
            color: _gold,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Container(height: 1, color: _gold.withOpacity(0.3)),
        ),
      ],
    );
  }
}



class PersonagemCard extends StatelessWidget {
  final FichasP FichaP;
  const PersonagemCard({super.key, required this.FichaP});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: _cardBg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _gold.withOpacity(0.4), width: 1.5),
        boxShadow: const [BoxShadow(color: _shadow, blurRadius: 8, offset: Offset(0, 3))],
      ),
      child: Column(
        children: [
          _CardHeader(FichaP: FichaP),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(child: _HpBar(FichaP: FichaP)),
                    const SizedBox(width: 12),
                    _CaBox(ca: FichaP.ca),
                  ],
                ),
                const SizedBox(height: 14),
                _Divider(),
                const SizedBox(height: 14),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _StatBox(label: 'FOR', value: FichaP.forca, mod: FichaP.modificadorForca),
                    _StatBox(label: 'AGI', value: FichaP.agilidade, mod: FichaP.modificadorAgilidade),
                    _StatBox(label: 'INT', value: FichaP.inteligencia, mod: FichaP.modificadorInteligencia),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CardHeader extends StatelessWidget {
  final FichasP FichaP;
  const _CardHeader({required this.FichaP});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: _inkDark,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
      ),
      child: Row(
        children: [
          _Avatar(imagem: FichaP.imagem, nome: FichaP.nome),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  FichaP.nome,
                  style: const TextStyle(
                    color: _goldLight,
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(height: 2),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    border: Border.all(color: _gold.withOpacity(0.5)),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    FichaP.classe.toUpperCase(),
                    style: const TextStyle(
                      color: _gold,
                      fontSize: 10,
                      letterSpacing: 2,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Avatar extends StatelessWidget {
  final String imagem;
  final String nome;
  const _Avatar({required this.imagem, required this.nome});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 52,
      height: 52,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: _gold, width: 2),
        color: _inkMid,
      ),
      clipBehavior: Clip.hardEdge,
      child: imagem.isNotEmpty
          ? Image.network(imagem, fit: BoxFit.cover)
          : Center(
              child: Text(
                nome.isNotEmpty ? nome[0].toUpperCase() : '?',
                style: const TextStyle(
                  color: _goldLight,
                  fontSize: 22,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
    );
  }
}

class _HpBar extends StatelessWidget {
  final FichasP FichaP;
  const _HpBar({required this.FichaP});

  Color get _barColor {
    if (FichaP.hpPercent > 0.6) return const Color(0xFF2E7D32);
    if (FichaP.hpPercent > 0.3) return const Color(0xFFF9A825);
    return _crimson;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Row(
              children: [
                Icon(Icons.favorite, size: 13, color: _crimson),
                SizedBox(width: 4),
                Text('PONTOS DE VIDA',
                    style: TextStyle(fontSize: 10, color: _inkMid, letterSpacing: 1, fontWeight: FontWeight.w600)),
              ],
            ),
            Text(
              '${FichaP.pvAtual} / ${FichaP.pvMax}',
              style: const TextStyle(fontSize: 13, color: _inkDark, fontWeight: FontWeight.w700),
            ),
          ],
        ),
        const SizedBox(height: 6),
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: LinearProgressIndicator(
            value: FichaP.hpPercent.clamp(0, 1),
            minHeight: 10,
            backgroundColor: Colors.black12,
            valueColor: AlwaysStoppedAnimation(_barColor),
          ),
        ),
      ],
    );
  }
}

class _CaBox extends StatelessWidget {
  final int ca;
  const _CaBox({required this.ca});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: _inkDark,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: _gold, width: 1.5),
          ),
          child: Center(
            child: Text(
              '$ca',
              style: const TextStyle(color: _goldLight, fontSize: 20, fontWeight: FontWeight.w900),
            ),
          ),
        ),
        const SizedBox(height: 3),
        const Text('CA', style: TextStyle(fontSize: 9, color: _inkMid, letterSpacing: 2, fontWeight: FontWeight.w600)),
      ],
    );
  }
}

class _StatBox extends StatelessWidget {
  final String label;
  final int value;
  final int mod;
  const _StatBox({required this.label, required this.value, required this.mod});

  @override
  Widget build(BuildContext context) {
    final modStr = mod >= 0 ? '+$mod' : '$mod';
    return Container(
      width: 80,
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: _inkDark,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: _gold.withOpacity(0.4)),
      ),
      child: Column(
        children: [
          Text(label,
              style: const TextStyle(color: _gold, fontSize: 10, letterSpacing: 2, fontWeight: FontWeight.w700)),
          const SizedBox(height: 4),
          Text('$value',
              style: const TextStyle(color: Colors.black, fontSize: 22, fontWeight: FontWeight.w900, height: 1)),
          const SizedBox(height: 2),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 1),
            decoration: BoxDecoration(
              color: _gold.withOpacity(0.2),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(modStr,
                style: const TextStyle(color: _goldLight, fontSize: 12, fontWeight: FontWeight.w700)),
          ),
        ],
      ),
    );
  }
}

class _Divider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: Container(height: 1, color: _gold.withOpacity(0.2))),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Icon(Icons.shield, size: 12, color: _gold.withOpacity(0.5)),
        ),
        Expanded(child: Container(height: 1, color: _gold.withOpacity(0.2))),
      ],
    );
  }
}

class _CriarFichaCard extends StatefulWidget {
  /// Called after a ficha has been saved to the database, so the parent
  /// can refresh its "Minhas Fichas" list.
  final VoidCallback? onSalvo;
  const _CriarFichaCard({this.onSalvo});

  @override
  State<_CriarFichaCard> createState() => _CriarFichaCardState();
}

class _CriarFichaCardState extends State<_CriarFichaCard> {
  final _dao = FichaDao();
  final _formKey = GlobalKey<FormState>();
  final _nome = TextEditingController();
  final _classe = TextEditingController();
  final _forca = TextEditingController(text: '10');
  final _agilidade = TextEditingController(text: '10');
  final _inteligencia = TextEditingController(text: '10');
  final _pvAtual = TextEditingController(text: '10');
  final _pvMax = TextEditingController(text: '10');
  final _ca = TextEditingController(text: '10');
  final _imagem = TextEditingController();

  FichasP? _preview;
  bool _salvando = false;

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    final ficha = FichasP(
      nome: _nome.text.trim(),
      classe: _classe.text.trim(),
      forca: int.parse(_forca.text),
      agilidade: int.parse(_agilidade.text),
      inteligencia: int.parse(_inteligencia.text),
      pvAtual: int.parse(_pvAtual.text),
      pvMax: int.parse(_pvMax.text),
      ca: int.parse(_ca.text),
      imagem: _imagem.text.trim(),
    );

    setState(() => _salvando = true);

    try {
      final id = await _dao.inserirFicha(ficha);
      if (!mounted) return;
      setState(() {
        _preview = ficha.copyWith(id: id);
        _salvando = false;
      });
      widget.onSalvo?.call();
    } catch (e) {
      if (!mounted) return;
      setState(() => _salvando = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Não foi possível salvar a ficha: $e')),
      );
    }
  }

  @override
  void dispose() {
    for (final c in [_nome, _classe, _forca, _agilidade, _inteligencia, _pvAtual, _pvMax, _ca, _imagem]) {
      c.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: _cardBg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _gold.withOpacity(0.4), width: 1.5),
        boxShadow: const [BoxShadow(color: _shadow, blurRadius: 8, offset: Offset(0, 3))],
      ),
      child: Column(
        children: [
          // Form header
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: const BoxDecoration(
              color: _inkMid,
              borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
            ),
            child: const Row(
              children: [
                Icon(Icons.edit_note, color: _goldLight, size: 18),
                SizedBox(width: 8),
                Text('NOVA FICHA',
                    style: TextStyle(color: _goldLight, fontSize: 13, letterSpacing: 2, fontWeight: FontWeight.w700)),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  _FormRow(children: [
                    _FieldLabel(label: 'Nome', controller: _nome, hint: 'Ex: Lyra das Sombras'),
                    _FieldLabel(label: 'Classe', controller: _classe, hint: 'Ex: Mago'),
                  ]),
                  const SizedBox(height: 12),
                  _FormRow(children: [
                    _StatField(label: 'Força', controller: _forca),
                    _StatField(label: 'Agilidade', controller: _agilidade),
                    _StatField(label: 'Inteligência', controller: _inteligencia),
                  ]),
                  const SizedBox(height: 12),
                  _FormRow(children: [
                    _StatField(label: 'PV Atual', controller: _pvAtual),
                    _StatField(label: 'PV Máx', controller: _pvMax),
                    _StatField(label: 'CA', controller: _ca),
                  ]),
                  const SizedBox(height: 12),
                  _FieldLabel(label: 'URL da Imagem', controller: _imagem, hint: 'https://...'),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: _salvando ? null : _submit,
                      icon: _salvando
                          ? const SizedBox(
                              width: 16,
                              height: 16,
                              child: CircularProgressIndicator(strokeWidth: 2, color: _goldLight),
                            )
                          : const Icon(Icons.auto_fix_high, size: 16),
                      label: Text(_salvando ? 'Salvando...' : 'Salvar ficha',
                          style: const TextStyle(letterSpacing: 2, fontWeight: FontWeight.w800)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _inkDark,
                        foregroundColor: _goldLight,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                          side: const BorderSide(color: _gold),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (_preview != null) ...[
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: Column(
                children: [
                  _Divider(),
                  const SizedBox(height: 14),
                  _SectionLabel('Pré-visualização'),
                  const SizedBox(height: 10),
                  PersonagemCard(FichaP: _preview!),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _ItemSearchCard extends StatefulWidget {
  @override
  State<_ItemSearchCard> createState() => _ItemSearchCardState();
}

class _ItemSearchCardState extends State<_ItemSearchCard> {
  final _api = ItemsApi();
  final _query = TextEditingController();

  bool _loading = false;
  String? _error;
  Items? _item;

  Future<void> _search() async {
    final name = _query.text.trim();
    if (name.isEmpty) {
      setState(() => _error = 'Digite o nome do item');
      return;
    }

    setState(() {
      _loading = true;
      _error = null;
      _item = null;
    });

    final result = await _api.findByName(name);

    if (!mounted) return;
    setState(() {
      _loading = false;
      _item = result;
      _error = result == null ? 'Item não encontrado' : null;
    });
  }

  @override
  void dispose() {
    _query.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: _cardBg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _gold.withOpacity(0.4), width: 1.5),
        boxShadow: const [BoxShadow(color: _shadow, blurRadius: 8, offset: Offset(0, 3))],
      ),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: const BoxDecoration(
              color: _inkMid,
              borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
            ),
            child: const Row(
              children: [
                Icon(Icons.inventory_2, color: _goldLight, size: 18),
                SizedBox(width: 8),
                Text('BUSCAR ITEM',
                    style: TextStyle(color: _goldLight, fontSize: 13, letterSpacing: 2, fontWeight: FontWeight.w700)),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _query,
                        onSubmitted: (_) => _search(),
                        decoration: const InputDecoration(
                          labelText: 'Nome do item',
                          hintText: 'Ex: Espada Longa',
                        ),
                        style: const TextStyle(fontSize: 14, color: _inkDark),
                      ),
                    ),
                    const SizedBox(width: 10),
                    SizedBox(
                      height: 48,
                      child: ElevatedButton(
                        onPressed: _loading ? null : _search,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _inkDark,
                          foregroundColor: _goldLight,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                            side: const BorderSide(color: _gold),
                          ),
                        ),
                        child: _loading
                            ? const SizedBox(
                                width: 18,
                                height: 18,
                                child: CircularProgressIndicator(strokeWidth: 2, color: _goldLight),
                              )
                            : const Icon(Icons.search, size: 18),
                      ),
                    ),
                  ],
                ),
                if (_error != null) ...[
                  const SizedBox(height: 10),
                  Text(_error!, style: const TextStyle(color: _crimson, fontSize: 13)),
                ],
                if (_item != null) ...[
                  const SizedBox(height: 14),
                  _Divider(),
                  const SizedBox(height: 14),
                  _ItemResultTile(item: _item!),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ItemResultTile extends StatelessWidget {
  final Items item;
  const _ItemResultTile({required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _inkDark,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: _gold.withOpacity(0.4)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            item.name,
            style: const TextStyle(color: _goldLight, fontSize: 16, fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 6),
          Wrap(
            spacing: 8,
            runSpacing: 6,
            children: [
              _ItemTag(label: 'Tipo', value: item.type),
              _ItemTag(label: 'Slot', value: item.slot),
              _ItemTag(label: 'Rank', value: item.rank),
              _ItemTag(label: 'Raridade', value: item.rarity),
            ],
          ),
        ],
      ),
    );
  }
}

class _ItemTag extends StatelessWidget {
  final String label;
  final String value;
  const _ItemTag({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    if (value.isEmpty) return const SizedBox.shrink();
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: _gold.withOpacity(0.15),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        '$label: $value',
        style: const TextStyle(color: _goldLight, fontSize: 11, fontWeight: FontWeight.w600),
      ),
    );
  }
}

class _FormRow extends StatelessWidget {
  final List<Widget> children;
  const _FormRow({required this.children});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: children
          .expand((w) => [Expanded(child: w), const SizedBox(width: 10)])
          .take(children.length * 2 - 1)
          .toList(),
    );
  }
}

class _FieldLabel extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final String hint;
  const _FieldLabel({required this.label, required this.controller, this.hint = ''});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(labelText: label, hintText: hint, hintStyle: TextStyle(color: Colors.black26)),
      style: const TextStyle(fontSize: 14, color: _inkDark),
      validator: (v) {
        if (v == null || v.trim().isEmpty) return 'Obrigatório';
        return null;
      },
    );
  }
}

class _StatField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  const _StatField({required this.label, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(labelText: label),
      keyboardType: TextInputType.number,
      style: const TextStyle(fontSize: 14, color: _inkDark, fontWeight: FontWeight.w700),
      textAlign: TextAlign.center,
      validator: (v) {
        if (v == null || v.isEmpty) return 'Req.';
        final n = int.tryParse(v);
        if (n == null) return 'Nº';
        if (n < 0) return '≥ 0';
        return null;
      },
    );
  }
}