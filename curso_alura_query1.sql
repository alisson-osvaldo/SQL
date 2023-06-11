-- Filtros Quantitativos -----------------------------------------------------------------

-- Se se aplicarmos <> 18 no código veremos todos menos quem 18 anos.
SELECT * FROM tabela_de_clientes WHERE idade <> 18;

-- Buscando por todos os Clientes com idade de 10 entre 22 anos.
SELECT * FROM tabela_de_clientes WHERE idade BETWEEN 10 AND 22;


-- DISTINCT ------------------------------------------------------------------------------
-- A cláusula DISTINCT não permite que o resultado final tenha linhas repetidas. Só vai exibir as combinações diferentes.

-- Sabor laranja tem embalagem de Lata, Pet e Garrafa.
SELECT DISTINCT EMBALAGEM FROM TABELA_DE_PRODUTOS WHERE SABOR = 'Laranja';

-- Sabor maça tem apenas embalagem de Lata e Pet.
SELECT DISTINCT EMBALAGEM FROM TABELA_DE_PRODUTOS WHERE SABOR = 'Maca';


-- ROWNUM ------------------------------------------------------------------------------
-- Limita a saída da consulta

-- Mostrando a coluna ROWNUM escondida.
SELECT ROWNUM, TABELA_DE_PRODUTOS.* FROM TABELA_DE_PRODUTOS;

-- Limitando a saída em 5 linhas
SELECT TP.* FROM TABELA_DE_PRODUTOS TP WHERE ROWNUM <= 5;


-- ORDER BY -----------------------------------------------------------------------------

-- Ordenando clientes pela data de nascimento na ordem decrescente: 
SELECT * FROM tabela_de_clientes ORDER BY data_de_nascimento DESC;

-- Ordenando pelo preço do produto do mais barato para o mais caro:
SELECT * FROM TABELA_DE_PRODUTOS ORDER BY PRECO_DE_LISTA ASC;

-- Ordenando produtos pela embalagem na ordem crecente de depois o nome do produto na ordem crecente:
SELECT * FROM TABELA_DE_PRODUTOS ORDER BY EMBALAGEM ASC, NOME_DO_PRODUTO ASC;


-- GROUP BY -----------------------------------------------------------------------------
/*
O agrupamento é feito pela cláusula GROUP BY, que deve ficar depois do filtro e antes do ORDER BY, caso exista.

-- SELECT (DISTINCT)
-- <Lista de campos> ou *
-- FROM
-- <Nome da Tabela>
-- WHERE
-- <Filtro>
-- AND ROWNUM <= <VALOR>
-- GROUP BY <CAMPOS>
-- ORDER BY <CAMPOS> (ASC,DESC)

Após GROUP BY, colocamos a lista de campos que não são numéricos para usar como critério de agrupamento.

Porém, quando você utilizar o GROUP BY, você precisa especificar após o comando SELECT a fórmula matemática na lista de campos numéricos que você está escolhendo para agrupar, sendo:

SUM: soma
AVG: média
MIN: mínimo
MAX: máximo

*/

-- Agrupando por estado a soma dos clientes que estão fazendo a primeira compra:
SELECT ESTADO, SUM(primeira_compra) FROM tabela_de_clientes GROUP BY ESTADO;

-- Cliente mais novo cadastrado de São Paulo e Rio.
select estado, MIN(idade) menor_idade_cliente FROM tabela_de_clientes GROUP BY estado;

-- Ordenando por idade e cidade distinta:
select distinct cidade, SUM(idade)
from tabela_de_clientes
GROUP BY cidade
order by cidade;

-- agrupando produto de maior preço por embalagem:
select embalagem, max(preco_de_lista)
from tabela_de_produtos
group by embalagem;

-- Quantidade total de produtos por embalagem:
select embalagem, count(*) Qtd
from tabela_de_produtos
group by embalagem
order by embalagem;

/* Cada item da nota fiscal representa uma venda de um determinado produto. Vimos na atividade anterior que temos várias vendas com quantidade igual a 99 litros para o produto 1101035.
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
A cláusula HAVING está associada a uma consulta que tenha GROUP BY, ou seja, uma agregação. Pois, permite que seja aplicado um filtro sobre o resultado da agregação.

-- SELECT (DISTINCT)
-- <Lista de campos> ou *
-- FROM
-- <Nome da Tabela>
-- WHERE
-- <Filtro>
-- AND ROWNUM <= <VALOR>
-- GROUP BY <CAMPOS>
-- ORDER BY <CAMPOS> (ASC,DESC)
-- HAVING <CONDIÇÃO>

*/

-- Pegando o maior e o menor preço por embalagem, em seguida pegando o resultado do agrupamento e pegando o preço >= 20.  
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
Quando fazemos o comando de seleção, podemos aplicar uma classificação sobre o campo que queremos exibir.
Um exemplo é a classificação da nota de alunos, onde quem tirou mais do que 5 foi aprovado e quem tirou menos que 5 foi reprovado. Outro exemplo, para saber se um produto é caro ou barato.
Podemos fazer vários critérios de classificação, utilizando CASE WHEN.
*/

-- Classificando Clientes por idade: 
select nome,
(case when idade >= 18 then 'De Maior'
    else 'De Menor'
END)
from tabela_de_clientes;

-- Classificando produtos por preço BARATO - CARO - EM CONTA:
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
Para cada cliente, temos seus limites de crédito mensais. Liste somente os nomes dos clientes e os classifique por:

Acima ou igual a 150.000 de limite de crédito - Clientes grandes
Entre 150.000 e 110.000 de limite de crédito - Clientes médios
Menores que 110.000 de limite de crédito - Clientes pequenos
*/
select nome,
(case
    when limite_de_credito >= 150000 then 'Clientes grandes' 
    when limite_de_credito >= 110000 then 'Clientes médios'
    else 'Clientes pequenos'
end) as CLASSIFICACAO
from tabela_de_clientes;


-- INNER JOIN -----------------------------------------------------------------------------
/*
 Só faz junção se existir conjunto nas duas tabelas, ex: tabela_1 chave_primaria 05 na tabela_2 cheve_estranjeira 05, 
 casso não tenha um conjunto não traz nada.
*/

--Juntando a tabela de notas com a de vendedor, para saber a qtd. de vendas:
SELECT
    nf.matricula,
    v.nome,
    COUNT(*) numero_de_notas
FROM
         notas_fiscais nf
    INNER JOIN tabela_de_vendedores v ON nf.matricula = v.matricula
GROUP BY
    nf.matricula,
    v.nome;


-- Na atividade onde pretendíamos obter os produtos que venderam mais que 394000 litros, executamos esta consulta:
SELECT
    inf.codigo_do_produto,
    tb.nome_do_produto,
    SUM(inf.quantidade)
FROM
         itens_notas_fiscais inf
    INNER JOIN tabela_de_produtos tb ON inf.codigo_do_produto = tb.codigo_do_produto
GROUP BY
    inf.codigo_do_produto,
    tb.nome_do_produto
HAVING
    SUM(inf.quantidade) >= 394000
ORDER BY
    SUM(inf.quantidade) DESC;
    

-- LEFT JOIN -----------------------------------------------------------------------------
/*
 Traz todos da tabela da esquerda e somente quem tem indentificação, cojunto da tabela da direita. 
*/
 select te.nome, td.matricula
 from tabela_esquerda te
 left join
 tabela_direita td
 on te.identificador = td.identificador;




-- RIGHT JOIN -----------------------------------------------------------------------------
/*
 Traz todos da tabela da direita e somente quem tem indentificação, cojunto da tabela da esquerda. 
*/
 select te.nome, td.matricula
 from tabela_esquerda te
 right join
 tabela_direita td
 on te.identificador = td.identificador;





-- FULL JOIN -----------------------------------------------------------------------------
/*
 Traz todos, combinação do que tem em comum e do que não tem.
*/
 select te.nome, td.matricula
 from tabela_esquerda te
 full join
 tabela_direita td
 on te.identificador = td.identificador;



-- CROSS JOIN -----------------------------------------------------------------------------
/*
 Faz uma analise combinatória de todos da esquerda com todos que tenho na direita.
 EX: 
 tabela_1 
 nome   Identificador
 Maria   01
 João    02
 
 tabela-2
 Identificador  Hobby
 01             Futebol
 02             Fotografia
 
 RESULTADO DO CROSS JOIN:
 nome   Hobby
 João   Futebol
 João   Fotografia
 Maria  Futebol
 Maria  Fotografia

*/
SELECT te.nome, td.hobby
FROM tabela_esquerda te,
tabela_direita td;


-- UNION -----------------------------------------------------------------------------
/*
 Une o resultado de duas consultas.
 
 Requisito: O resultado das duas consultas devem trazer o mesmo númeor de campos e 
            corresponderem ao mesmo tipo.
            
 - Elimina os repetidos, para não eliminar utilizar o UNION ALL.
*/

SELECT DISTINCT BAIRRO, 'CLIENTE' AS ORIGEM FROM TABELA_DE_CLIENTES
UNION ALL
SELECT DISTINCT BAIRRO, 'FORNECEDOR' AS ORIGEM FROM TABELA_DE_VENDEDORES;


-- Subconsultas no comando IN -----------------------------------------------------------------------------

select * from tabela_de_clientes where bairro in 
(select distinct bairro from tabela_de_clientes);


-- Subconsultas substituindo o HAVING -----------------------------------------------------------------------------

-- 1.agrupando por embalagens
select embalagem, sum(preco_de_lista) as soma_preco
from tabela_de_produtos group by embalagem;

-- 2.Utilizando HAVING
select embalagem, sum(preco_de_lista) as soma_preco
from tabela_de_produtos group by embalagem
having sum(preco_de_lista)>= 80;

-- 2.Utilizando subconsulta
SELECT
    soma_embalagens.embalagem,
    soma_embalagens.soma_preco
FROM
    (
        SELECT
            embalagem,
            SUM(preco_de_lista) AS soma_preco
        FROM
            tabela_de_produtos
        GROUP BY
            embalagem
    ) soma_embalagens
WHERE
    soma_embalagens.soma_preco >= 80;



-- Exercício Redesenhe esta consulta usando subconsultas :
SELECT INF.CODIGO_DO_PRODUTO, TP.NOME_DO_PRODUTO, SUM(INF.QUANTIDADE) FROM ITENS_NOTAS_FISCAIS INF
INNER JOIN TABELA_DE_PRODUTOS TP 
ON INF.CODIGO_DO_PRODUTO = TP.CODIGO_DO_PRODUTO
GROUP BY INF.CODIGO_DO_PRODUTO, TP.NOME_DO_PRODUTO HAVING SUM(INF.QUANTIDADE) > 394000 
ORDER BY SUM(INF.QUANTIDADE) DESC;

--RESULTADO:
SELECT
    sc.codigo_do_produto,
    sc.nome_do_produto,
    sc.quantidade_total
FROM
    (
        SELECT
            inf.codigo_do_produto,
            tp.nome_do_produto,
            SUM(inf.quantidade) AS quantidade_total
        FROM
                 itens_notas_fiscais inf
            INNER JOIN tabela_de_produtos tp ON inf.codigo_do_produto = tp.codigo_do_produto
        GROUP BY
            inf.codigo_do_produto,
            tp.nome_do_produto
    ) sc
WHERE
    sc.quantidade_total > 394000
ORDER BY
    sc.quantidade_total DESC;


-- Views -----------------------------------------------------------------------------
/*
 Permite a criação de uma tabela virtual,Essas tabelas, na verdade, não existem, mas se comportam como tais.
 É uma tabela lógica, resultado de uma consulta, que pode ser usada depois em qualquer outra consulta.
 O resultado é o mesmo, seja aplicando subconsultas ou HAVING. A diferença é que essa view fica salva no banco de dados como se fosse uma tabela e ela é muito dinâmica. 
 Dessa forma, conforme a tabela de clientes vai sendo atualizada, ela retorna resultados diferentes.
 primeiro é feito a consulta da tabela original para criar a view e só depois disso que é realizada a seleção final. Porém, a view funciona como se fosse um relatório,
 ou seja, podemos construir grandes SQLs, salvá-las como views e possibilitar que usuário possa acessá-la por meio de uma consulta simples, afinal, já estamos fazendo cálculos complexos internamente.
*/


-- Criando uma VIEW
CREATE VIEW vw_soma_embalagens AS 
SELECT embalagem, SUM(preco_de_lista) AS soma_preco
FROM tabela_de_produtos GROUP BY embalagem;

-- Select na VIEW
SELECT * FROM VW_SOMA_EMBALAGENS;

SELECT embalagem, soma_preco FROM VW_SOMA_EMBALAGENS
WHERE soma_preco >= 80;

SELECT * FROM tabela_de_produtos tp
INNER JOIN vw_soma_embalagens vw
ON tp.embalagem = vw.embalagem 
WHERE vw.soma_preco >= 80;



--Exercício: Redesenhe esta consulta, criando uma view para a lista de quantidades totais por produto e aplicando a condição e ordenação sobre essa mesma visão.
SELECT
    inf.codigo_do_produto,
    tp.nome_do_produto,
    SUM(inf.quantidade) 
FROM
         itens_notas_fiscais inf
    INNER JOIN tabela_de_produtos tp ON inf.codigo_do_produto = tp.codigo_do_produto
GROUP BY
    inf.codigo_do_produto,
    tp.nome_do_produto
HAVING
    SUM(inf.quantidade) > 394000
ORDER BY
    SUM(inf.quantidade) DESC;

--RESULTADO:
CREATE VIEW vw_quantidade_total_de_produtos AS
SELECT
    inf.codigo_do_produto,
    tp.nome_do_produto,
    SUM(inf.quantidade) AS quantidade_total
FROM
         itens_notas_fiscais inf
    INNER JOIN tabela_de_produtos tp ON inf.codigo_do_produto = tp.codigo_do_produto
GROUP BY
    inf.codigo_do_produto,
    tp.nome_do_produto
HAVING
    SUM(inf.quantidade) > 394000
ORDER BY
    SUM(inf.quantidade) DESC;


-- FUNCTIONS -----------------------------------------------------------------------------
-- FUNCTION STRING:
-- LOWER - Tudo em minusculo:
    select nome, LOWER(nome) from tabela_de_clientes;

-- UPPER - Tudo em maiusculo:
    select nome, UPPER(nome) from tabela_de_clientes;

-- INITCAP - Deixa a primeira letra de cada palavra em Maiusculo
    select nome_do_produto, INITCAP(nome_do_produto) from tabela_de_produtos;

-- CONCAT - Junta duas colunas em uma (aceita apenas 2 aparâmetros): 
    select endereco_1, bairro, CONCAT(CONCAT(endereco_1, ' '), bairro) from tabela_de_clientes;
-- Também pode ser usado || para representar CONCAT:
    SELECT ENDERECO_1 || ' ' || BAIRRO || ' ' || CIDADE || ' ' || ESTADO || ' - ' || CEP RESULTADO_DA_CONCATENACAO FROM TABELA_DE_CLIENTES;

-- LPAD - Completa uma determinada quantidade de caractéres, começando pelo lado esquerdo:
    SELECT NOME_DO_PRODUTO, LPAD(NOME_DO_PRODUTO,70,'*') FROM TABELA_DE_PRODUTOS;

-- RPAD - Completa uma determinada quantidade de caractéres, começando pelo lado Direito:
    SELECT NOME_DO_PRODUTO, RPAD(NOME_DO_PRODUTO,70,'*') FROM TABELA_DE_PRODUTOS;
    
-- SUBSTR - Pega uma parte do texto de dentro do texto original:
 select nome_do_produto, SUBSTR(nome_do_produto, 3, 5) from tabela_de_produtos;

-- INSTR - Mostra a posição da string onde está a palavrva ou caracter em que estamos buscando:
    select nome, INSTR(nome, 'Mattos') from tabela_de_clientes;

-- LTRIM, RTRIM, TRIM - Removem os espaços:
    select '   OSVALDO   ' X, LTRIM('   OSVALDO   ') Y, RTRIM('   OSVALDO   ') Z, TRIM('   OSVALDO   ') W FROM DUAL;

-- REPLACE - Faz a substituição de caractéres: 
    -- Utlilizamos aqui dois RAPLACES por que tinha a palavra 'Litro' e 'Litros' então sobrava o 's' ficando 'Ls' o segundo REPLACE substitui o 'LS' por 'L'.
    select nome_do_produto, REPLACE(REPLACE(nome_do_produto, 'Litro', 'L'), 'Ls', 'L') from tabela_de_produtos;


-- DATE -----------------------------------------------------------------------------
-- Data do computador
    select sysdate from dual;

-- Mostrar data+hora do cumputador
    select to_char(sysdate, 'DD/MM/YYYY HH:MI:SS') from dual;

-- Visualizando data em outro formato:
    select nome, to_char(data_de_nascimento, 'DD MONTH YYYY, DAY') from tabela_de_clientes;

-- Verificando data daqui a 127 dias apartir do dia da busca:
    select sysdate + 127 from dual;

-- Descobrindo idade apartir da data de nascimento:
    select nome, (sysdate - data_de_nascimento)/365 from tabela_de_clientes;

-- MONTHS_BETWEEN retorna número de meses entre as datas:
    select MONTHS_BETWEEN(SYSDATE, data_de_nascimento)/12 from tabela_de_clientes;

-- ADD_MONTHS o dia de hoje adicionado + 10 meses, Bom para calcular o vencimento de uma fatura:
    select ADD_MONTHS(SYSDATE, 10) from dual; 
    
-- NEX_DAY Mostra quando é o próximo dia:
    select sysdate, NEXT_DAY(sysdate, 'SEXTA') from dual;
  
-- LAST_DAY Mostra qual é o ultimo dia do mês em que estamos:
    select sysdate, LAST_DAY(sysdate) from dual;


-- Funções Númericas -----------------------------------------------------------------------------
-- ROUND Faz o arredondoamento de valores decimais:
    select ROUND(3.4) from dual;
    select ROUND(3.5) from dual;
    select ROUND(3.6) from dual;

-- TRUNC Arredando para baixo
    select TRUNC(3.4) from dual;
    select TRUNC(3.5) from dual;
    select TRUNC(3.6) from dual;

-- CEIL Arredondo para cima
    select CEIL(3.4) from dual;
    select CEIL(3.5) from dual;
    select CEIL(3.6) from dual;

-- FLOOR 
    select FLOOR(3.4) from dual;
    select FLOOR(3.5) from dual;
    select FLOOR(3.6) from dual;

-- POWER 10 elevado a 4 = 10.000:
    select POWER(2, 4) from dual;

-- EXP eleva um número exponencial
    select EXP(4) from dual;

-- SQRT Raiz Quadrada 
    select SQRT(10) from dual;

-- ABS Valor absoluto

-- MOd pega o resto de uma divisão
    select MOD(10, 6) from dual;

/*
Na tabela de notas fiscais, temos o valor do imposto. Já na tabela de itens, 
temos a quantidade e o faturamento. Calcule o valor do imposto pago no ano de 2016, 
arredondando para o menor inteiro.
*/
SELECT TO_CHAR(DATA_VENDA, 'YYYY'), FLOOR(SUM(IMPOSTO * (QUANTIDADE * PRECO))) 
FROM NOTAS_FISCAIS NF
INNER JOIN ITENS_NOTAS_FISCAIS INF ON NF.NUMERO = INF.NUMERO
WHERE TO_CHAR(DATA_VENDA, 'YYYY') = 2016
GROUP BY TO_CHAR(DATA_VENDA, 'YYYY');


-- Funções de Conversões -----------------------------------------------------------------------------







