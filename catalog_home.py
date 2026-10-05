"""Searchable catalog, exclusive to Harpa Cristã; shared player stays unchanged."""
from html import escape as E
from music_pages import score_card


def home(catalog, base):
    scores=sorted(catalog.scores,key=lambda s:(s.lesson or 999999,s.title.casefold()))
    cards=[]
    for score in scores:
        card=score_card(score,base,catalog)
        search=f'{score.lesson or ""} {score.title} {score.author} {score.instrument}'
        cards.append(card.replace('class="score-card"',f'class="score-card" data-hymn-search="{E(search,quote=True)}"',1))
    count=len(scores)
    empty='<div class="hymn-empty"><h2>O acervo está em preparação.</h2><p>Os hinos serão disponibilizados aqui após a preparação das partituras e do áudio.</p></div>' if not scores else ''
    return f'''<link rel="stylesheet" href="{base}/assets/hymn-search.css"><section class="category-page"><a class="text-link" href="https://clavesol.com.br/partituras/">← Partituras do Clave Sol</a><p class="eyebrow">HINÁRIO · CLAVE SOL</p><h1>Harpa<br><em>Cristã.</em></h1><p class="lead">Encontre seu hino e pratique com a partitura e o player.</p>
<div id="hymn-search-controls" hidden><label for="hymn-search">Buscar hino</label><div class="hymn-search-row"><input id="hymn-search" type="search" placeholder="Número ou título do hino" autocomplete="off" aria-controls="hymn-list"><button id="hymn-clear" type="button">Limpar busca</button></div><p id="hymn-count" role="status" aria-live="polite" aria-atomic="true">{count} hinos disponíveis</p></div>
<noscript><p>A busca precisa de JavaScript. Os hinos publicados continuam listados abaixo.</p></noscript>{empty}<p id="hymn-no-results" hidden>Nenhum hino encontrado. Tente outro número ou uma palavra do título.</p><div id="hymn-list" class="score-list">{''.join(cards)}</div></section><script type="module" src="{base}/assets/hymn-search.mjs"></script>'''
