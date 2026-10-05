# Clave Sol — Harpa Cristã

Hinário independente com a identidade visual do Clave Sol, busca por número ou título, partitura e player com andamento em BPM e cursor sincronizado.

Os MIDI originais ficam em `/home/djames/Documents/ClaveSol/HarpaCrista/`. A conversão usa o MuseScore para obter a notação, depois o importador validado gera MusicXML, SVG, MuseScore e cursor. Sem PDFs. O áudio é sintetizado pelo player. A grafia musical é inferida do MIDI; arquivos incompatíveis ficam registrados para revisão.

Acervo preparado: **639 hinos**. Um MIDI ficou pendente; consulte [o relatório](docs/RESULTADO-CONVERSAO.md).

## Conversão

Veja [docs/CONVERTER-HARPA-CRISTA.md](docs/CONVERTER-HARPA-CRISTA.md). O processo é retomável, não altera os originais e não faz commit ou push automaticamente.

## Estrutura

- `partituras/hinos/harpa-crista/_index.md`: apresentação da coleção.
- `partituras/hinos/harpa-crista/hino-NNN.md`: cadastro de cada hino.
- `assets/music/hinos/harpa-crista/hino-NNN/`: arquivos para a partitura e o player.
- `catalog_home.py` e `assets/hymn-search.*`: listagem com busca parcial, sem distinção de acentos ou maiúsculas; números completos (`10` não encontra `110`).

## GitHub Pages

Repositório preparado para **Settings → Pages → Source → GitHub Actions**. O workflow **Publicar Harpa Cristã** permite publicação manual ou por push em `main`. O commit inicial usa `[skip ci]`; o envio completo do acervo aciona a publicação.

Endereço configurado: https://harpa.clavesol.com.br/. O build também aceita o `base_path` fornecido pelo Pages para um domínio personalizado configurado posteriormente.

## Prévia local

```bash
python3 -m venv .venv
.venv/bin/pip install -r requirements-converter.txt
BASE_PATH= .venv/bin/python build.py
BASE_PATH= .venv/bin/python scripts/check_links.py
python3 -m http.server 8000 --directory dist
```
