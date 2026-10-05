# Conversão da Harpa Cristã

Origem: `/home/djames/Documents/ClaveSol/HarpaCrista/` (640 MIDI).
Destino: este repositório, exclusivamente nas pastas `partituras/hinos/harpa-crista/` e `assets/music/hinos/harpa-crista/`.

O script converte um arquivo por vez, preserva os originais e as letras de versões nos identificadores e deriva o título do nome do arquivo. Usa o andamento do MIDI; se não houver indicação, o padrão do formato é 120 BPM. Quando há mudanças de andamento, usa as indicações importadas pelo MuseScore. A notação é uma interpretação do MIDI, não uma reprodução da edição impressa.

Cada hino tem limite de 15 minutos. Falhas são registradas e o lote continua. Não são gerados PDFs. Ao final, o script gera o site local e verifica seus links. Ele não publica, não acompanha GitHub e não muda o blog principal.

## Iniciar ou retomar em segundo plano

```bash
bash /home/djames/Documents/ClaveSol/site/clavesol-harpa-crista/scripts/iniciar_conversao.sh
```

O lançador usa o Python do ambiente do blog; pode ser substituído pela variável `HARPA_PYTHON`. As dependências estão em `requirements-converter.txt`. Requer MuseScore em `~/bin/musescore`.

A retomada ignora os sucessos quando o SHA-256 do original e de todos os arquivos gerados permanece igual. Arquivos que falharam são tentados novamente. Um bloqueio impede duas conversões simultâneas.

## Acompanhar

```bash
watch -n 5 cat /home/djames/Documents/ClaveSol/lab/harpa-crista-conversao/resumo.txt
```

Estado e logs em `/home/djames/Documents/ClaveSol/lab/harpa-crista-conversao/`:

- `resumo.txt`: estado, arquivo atual, total, sucessos, já prontos e falhas.
- `status.json`: relatório detalhado por arquivo.
- `execucao.log`: saída geral.
- `logs/hino-NNN.log`: detalhes de cada conversão.
- `build.log`: validação final do site.

`completed` significa que o lote e a validação local terminaram; confira também a quantidade de falhas. `validation_failed` indica que a validação final precisa de correção. A publicação é uma etapa posterior.
