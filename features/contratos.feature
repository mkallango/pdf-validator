#language: pt
@contratos
Funcionalidade: Contratos
  Validação dos dados do contrato a partir de uma tabela de dados

@valida_emitente
Esquema do Cenário: Verificar sessão Emitente do Contrato
Dado as informações de 'Emitente' para cruzamento de dados com contrato  
Dado um contrato <contratoPdf> em PDF
E a seção 'Emitente' do contrato extraída em texto
Então o Nome do Emitente no contrato deve ser igual a <nomeEmitente>
Quando o campo Estado Civil do emitente estiver populado no contrato
Então o campo Regime de Bens do emitente deve estar populado de acordo
E os campos Cônjuge e CPF do conjuge do emitente devem estar populados de acordo
E finaliza o teste da seção emitente

  Exemplos:
    |contratoPdf|nomeEmitente|
    |'Contrato2017000390.pdf'|'Cooperado Joao7986'|
    |'Contrato2017900083.pdf'|'Clinica4567'|
    |'Contrato2017000084.pdf'|'Cooperada Ana330'|
    |'Contrato2017000032.pdf'|'Cooperado Jose130'|
    |'c.20 - Contrato2017000454.pdf'|'Cooperado Joao9674'|
    |'c.21 - Contrato2017100028.pdf'|'Cooperada Maria21940'|
    |'c.27 - Contrato2017000508.pdf'|'Clinica18363'|
    |'c.13 - Contrato2017800172.pdf'|'Cooperado Jose16358'|
    |'c.07 - Contrato2017900074.pdf'|'Clinica18678'|
    |'c.07 - Contrato2017000066.pdf'|'Clinica22662'|
    |'c.05 - Contrato2017000198.pdf'|'Cooperada Ana21122'|
    |'c.05 - Contrato2017900074.pdf'|'Clinica18678'|
    |'c.05 - Contrato2017000311.pdf'|'Clinica18605'|
    |'c.04 - Contrato2017000405.pdf'|'Cooperado Jose365'|
    |'c.03 - Contrato2017000180.pdf'|'Cooperado Jose9704'|
    |'c.03 - Contrato2017000237.pdf'|'Cooperado Jose11218'|
    |'c.03 - Contrato2017000335.pdf'|'Cooperado Jose20088'|