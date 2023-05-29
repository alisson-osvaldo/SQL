-- Filtros Quantitativos -----------------------------------------------------------------

-- Se se aplicarmos <> 18 no c�digo veremos todos menos quem 18 anos.
SELECT * FROM tabela_de_clientes WHERE idade <> 18;

-- Buscando por todos os Clientes com idade de 10 entre 22 anos.
SELECT * FROM tabela_de_clientes WHERE idade BETWEEN 10 AND 22;


-- DISTINCT ------------------------------------------------------------------------------
-- A cl�usula DISTINCT n�o permite que o resultado final tenha linhas repetidas. S� vai exibir as combina��es diferentes.

-- Sabor laranja tem embalagem de Lata, Pet e Garrafa.
SELECT DISTINCT EMBALAGEM FROM TABELA_DE_PRODUTOS WHERE SABOR = 'Laranja';

-- Sabor ma�a tem apenas embalagem de Lata e Pet.
SELECT DISTINCT EMBALAGEM FROM TABELA_DE_PRODUTOS WHERE SABOR = 'Maca';


-- ROWNUM ------------------------------------------------------------------------------
-- Limita a sa�da da consulta

-- Mostrando a coluna ROWNUM escondida.
SELECT ROWNUM, TABELA_DE_PRODUTOS.* FROM TABELA_DE_PRODUTOS;

-- Limitando a sa�da em 5 linhas
SELECT TP.* FROM TABELA_DE_PRODUTOS TP WHERE ROWNUM <= 5;


-- ORDER BY -----------------------------------------------------------------------------

-- Ordenando clientes pela data de nascimento na ordem decrescente: 
SELECT * FROM tabela_de_clientes ORDER BY data_de_nascimento DESC;

-- Ordenando pelo pre�o do produto do mais barato para o mais caro:
SELECT * FROM TABELA_DE_PRODUTOS ORDER BY PRECO_DE_LISTA ASC;

-- Ordenando produtos pela embalagem na ordem crecente de depois o nome do produto na ordem crecente:
SELECT * FROM TABELA_DE_PRODUTOS ORDER BY EMBALAGEM ASC, NOME_DO_PRODUTO ASC;


-- GROUP BY -----------------------------------------------------------------------------
/*
O agrupamento � feito pela cl�usula GROUP BY, que deve ficar depois do filtro e antes do ORDER BY, caso exista.

-- SELECT (DISTINCT)
-- <Lista de campos> ou *
-- FROM
-- <Nome da Tabela>
-- WHERE
-- <Filtro>
-- AND ROWNUM <= <VALOR>
-- GROUP BY <CAMPOS>
-- ORDER BY <CAMPOS> (ASC,DESC)

Ap�s GROUP BY, colocamos a lista de campos que n�o s�o num�ricos para usar como crit�rio de agrupamento.

Por�m, quando voc� utilizar o GROUP BY, voc� precisa especificar ap�s o comando SELECT a f�rmula matem�tica na lista de campos num�ricos que voc� est� escolhendo para agrupar, sendo:

SUM: soma
AVG: m�dia
MIN: m�nimo
MAX: m�ximo

*/

-- Agrupando por estado a soma dos clientes que est�o fazendo a primeira compra:
SELECT ESTADO, SUM(primeira_compra) FROM tabela_de_clientes GROUP BY ESTADO;

-- Cliente mais novo cadastrado de S�o Paulo e Rio.
select estado, MIN(idade) menor_idade_cliente FROM tabela_de_clientes GROUP BY estado;

-- Ordenando por idade e cidade distinta:
select distinct cidade, SUM(idade)
from tabela_de_clientes
GROUP BY cidade
order by cidade;

-- agrupando produto de maior pre�o por embalagem:
select embalagem, max(preco_de_lista)
from tabela_de_produtos
group by embalagem;

-- Quantidade total de produtos por embalagem:
select embalagem, count(*) Qtd
from tabela_de_produtos
group by embalagem
order by embalagem;

/* Cada item da nota fiscal representa uma venda de um determinado produto. Vimos na atividade anterior que temos v�rias vendas com quantidade igual a 99 litros para o produto 1101035.
 Quantas vendas foram feitas com quantidade igual a 99 litros para o produto 1101035?
 */
select count(*) total_de_vendas_por_produto
from itens_notas_fiscais
where codigo_do_produto = 1101035 
and quantidade = 99;

/*
Atividade:
Vamos voltar aos itens das notas fiscais. As duas atividades anteriores olharam as vendas do produto 1101035, 
mas nossa empresa vendeu mais produtos. 
Verifique as quantidades totais de vendas de cada produto e ordene da maior para a menor.
*/
select codigo_do_produto, sum(quantidade) as Qtd_total
from itens_notas_fiscais
group by codigo_do_produto 
order by sum(quantidade) desc;


select * from tabela_de_clientes;
select * from tabela_de_produtos;
select * from itens_notas_fiscais;

-- HAVING -----------------------------------------------------------------------------
/*
A cl�usula HAVING est� associada a uma consulta que tenha GROUP BY, ou seja, uma agrega��o. Pois, permite que seja aplicado um filtro sobre o resultado da agrega��o.

-- SELECT (DISTINCT)
-- <Lista de campos> ou *
-- FROM
-- <Nome da Tabela>
-- WHERE
-- <Filtro>
-- AND ROWNUM <= <VALOR>
-- GROUP BY <CAMPOS>
-- ORDER BY <CAMPOS> (ASC,DESC)
-- HAVING <CONDI��O>

*/

-- Pegando o maior e o menor pre�o por embalagem, em seguida pegando o resultado do agrupamento e pegando o pre�o >= 20.  
select embalagem, max(preco_de_lista) as maior_preco, min(preco_de_lista) as menor_preco
from tabela_de_produtos
where preco_de_lista >= 10
group by embalagem
having max(preco_de_lista) >= 20;



/*
Atividade:
Vimos os produtos mais vendidos na atividade anterior. 
Agora, liste somente os produtos que venderam mais que 394000 litros.

*/

select codigo_do_produto, sum(quantidade) Qtd_total
from itens_notas_fiscais
group by codigo_do_produto
having sum(quantidade) > 394000
order by sum(quantidade) desc;

-- CASE WHEN -----------------------------------------------------------------------------
/*
Quando fazemos o comando de sele��o, podemos aplicar uma classifica��o sobre o campo que queremos exibir.
Um exemplo � a classifica��o da nota de alunos, onde quem tirou mais do que 5 foi aprovado e quem tirou menos que 5 foi reprovado. Outro exemplo, para saber se um produto � caro ou barato.
Podemos fazer v�rios crit�rios de classifica��o, utilizando CASE WHEN.
*/

-- Classificando Clientes por idade: 
select nome,
(case when idade >= 18 then 'De Maior'
    else 'De Menor'
END)
from tabela_de_clientes;

-- Classificando produtos por pre�o BARATO - CARO - EM CONTA:
select nome_do_produto, preco_de_lista,
(case
    when preco_de_lista >= 12 then 'Produto Caro'
    when preco_de_lista >= 7 and preco_de_lista < 12 then 'Produto Em Conta'
    else 'Produto Barato'
end) as CLASSIFICACAO
from tabela_de_produtos
order by CLASSIFICACAO;


/*
ATIVIDADE:
Para cada cliente, temos seus limites de cr�dito mensais. Liste somente os nomes dos clientes e os classifique por:

Acima ou igual a 150.000 de limite de cr�dito - Clientes grandes
Entre 150.000 e 110.000 de limite de cr�dito - Clientes m�dios
Menores que 110.000 de limite de cr�dito - Clientes pequenos
*/
select nome,
(case
    when limite_de_credito >= 150000 then 'Clientes grandes' 
    when limite_de_credito >= 110000 then 'Clientes m�dios'
    else 'Clientes pequenos'
end) as CLASSIFICACAO
from tabela_de_clientes;










