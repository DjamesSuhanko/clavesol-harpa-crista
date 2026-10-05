export function normalize(value){return String(value).normalize('NFD').replace(/[\u0300-\u036f]/g,'').toLowerCase().replace(/(\d+)/g,n=>String(Number(n))).replace(/[^a-z0-9]+/g,' ').trim();}
export function matches(text,query){
 const words=normalize(text).split(' '),tokens=normalize(query).split(' ').filter(Boolean);
 return tokens.every(token=>/^\d+$/.test(token)?words.includes(token):words.some(word=>word.includes(token)));
}
if(typeof document!=='undefined'&&document.getElementById('hymn-search')){
 const input=document.getElementById('hymn-search'),cards=[...document.querySelectorAll('[data-hymn-search]')];
 function filter(){
  let visible=0;for(const card of cards){card.hidden=!matches(card.dataset.hymnSearch,input.value);if(!card.hidden)visible++;}
  document.getElementById('hymn-count').textContent=cards.length?`${visible} de ${cards.length} hinos`:'Nenhum hino publicado ainda.';
  document.getElementById('hymn-no-results').hidden=visible>0||cards.length===0;
  document.getElementById('hymn-clear').disabled=!input.value;
 }
 input.addEventListener('input',filter);
 document.getElementById('hymn-clear').addEventListener('click',()=>{input.value='';filter();input.focus();});
 document.getElementById('hymn-search-controls').hidden=false;filter();
}
