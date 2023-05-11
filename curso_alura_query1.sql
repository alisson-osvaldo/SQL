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


-- 









