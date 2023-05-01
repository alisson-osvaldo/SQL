--Select para Tabelas
select * from Production.Product ;
select * from Production.WorkOrder ;
select * from Person.Person ;
select * from Person.Address ;
select * from Sales.SalesOrderDetail ;

-----------------------------------------------------------------------------------------------------------------------------

-- Tipos de Dados --

--1.Booleanos
--Por padrão ele é inicializado como null, e pode receber 1 ou 0.
--Tipo : BIT

--2.Caractéres
--Tamanho fixo - CHAR // Permite inserir uma quantidade fixa de caracters e sempre o cupa todo espaço reservado 10/50
--Tamanhos variáveis - VARCHAR ou NVARCHAR //Permite inserir até uma quantidade que for definida, porem só usa o espaço que for preenchido

--3.Números
--## Valores exatos
-- TINYINT  - Não tem valor fracionado (ex: 1.42, 25.65) somente inteiro 1, 123, 456789 ....
-- SMALLINT - Mesma coisa porem limite maior.
-- INT      - Mesma coisa porem limite maior.
-- BIGINT   - Mesma coisa porem limite maior.
-- NUMERIC ou DECIMAL - calores exatos, porem permite ter partes fracionados, que também pode ser especificado a precisão 
--e escala (escala é o número de digitos na parte fracional) Ex: NUMERIC(5,2) 133,42 total de 5 digitos e 2 dpois da virgula.

--## Valores Aproximados
-- REAL  - Tem precisão aprocimada de até 15 digitos, depois da virgula Ex: 12,...
-- FLOAT - Mesmo conceito do REAL.

--4.Temporais
-- DATE - Armazena Data no formato aaa/mm/dd
-- DATATIME - Armazena Data e Hora no formato aaaa/mm/dd:hh:mm:ss
-- DATATIME2 - Data e Hora com edição de milesegundos no formato aaaa/mm/dd:hh:mm:sssssss
-- SMALLDATETIME - Data e Hora respeitando o limite entre '1900-01-01:00:00:00' até '2079-06-06:23:59:59'
-- TIME - Horas, Minutos, Segundos e Milesegundos respeitando o limite de '00:00:0000000' até '23:59:59.9999999'
-- DATETIMEOFFSET - Permite armazenar informações da Data e Hora incluindo o fuso horário

-------------------------------------------------------------------------------------------------------------------------------

-- Chave Primária

* Chave Primária é basicámente uma coluna ou grupo de colunas, usada para indentificar unicamente uma linha em uma tabela.
* Voçe consegue criar essas chaves através de restrições (ou constraints em inglês), que são regras que voçe define quando está criando uma coluna
* Assim quando voçe faz isso está criando um indice único para aquela coluna ou grupo de colunas.

	CREATE TABLE nome_tabela (
		nomeColuna tipoDeDados PRIMARY KEY
		nomeColuna tipoDeDados ...
	)


-- Chave Estrangeira

* Uma chave estrangeira é uma coluna ou grupo de colunas em uma tabela que indentifica unicamente uma linha em outra tabela.
* Ou seja, uma chave estrangeira é definida em uma tabelaonde ela é apenas uma referência e não contem todos os dados ali.
* Tabela que contem uma chave estrangeira é chamada de referênciadora ou tabela Filho. 
E a tabela na qual a chave é referenciada é chamada de tabela Pai.
*Uma tabela pode ter mais de uma chave estrangeira dependendo do total de relacionamentos com as outras tabelas.

-- No SQL Server
* Voçe define uma chave estrageira atraves de um "Foreygn Key Constraint" ou restrição de chave estrangeira.
* Uma restrição de chave estrangeira indica que os valores em uma coluna ou grupo de colunas na tabela filho corresponde a os valores da tabela pai.
* Nós podemos entender que uma chave estrangeira mantem a "integridade referencial".


-- Definindo uma chave estrangeira em uma TB.
ALTER TABLE TB_VENDEDORES ADD CONSTRAINT PK_TB_VENDEDORES PRIMARY KEY (MATRICULA);


-------------------------------------------------------------------------------------------------------------------------------
--CREATE DATABASE

USE master;  
GO  
CREATE DATABASE Youtube 
ON   
( NAME = Canais,  
    FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL14.SQLEXPRESS\MSSQL\DATA\youtube.mdf',  
    SIZE = 10,  
    MAXSIZE = 50,  
    FILEGROWTH = 5 )  
LOG ON  
( NAME = Canai,  
    FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL14.SQLEXPRESS\MSSQL\DATA\youtube.ldf',  
    SIZE = 5MB,  
    MAXSIZE = 25MB,  
    FILEGROWTH = 5MB );  
GO  

-------------------------------------------------------------------------------------------------------------------------------
-- CREATE TABLE --

EX:
	CREATE TABLE nomeTabela(
		coluna1 tipo restriçãoDaColuna,
		coluna2 tipo restriçãoDaColuna,
		coluna3 tipo restriçãoDaColuna,
	);

--Principais tipos de restrições que podem ser aplicadas
NOT NULL    - Não permite nulos.
UNIQUE      - Força que todos os valores em uma coluna sejam diferentes.
PRIMARY KEY - Uma junção do NOT NULL e UNIQUE.
FOREIGN KEY - Identifica unicamente uma linha em outra tabela.
CHECK       - Força uma condição especifica em uma coluna.
DEFAULT     - Força um valor padrão quando nenhum valor é passado.

--Criando tabela Canal
CREATE TABLE Canal (
	CanalId           INT          PRIMARY KEY,
	Nome              VARCHAR(150) NOT NULL,
	ContagemInscritos INT          DEFAULT 0,
	DataCriacao       DATETIME     NOT NULL
);

SELECT * FROM Canal;

CREATE TABLE Video (
	VideoId       INT          PRIMARY KEY,
	Nome          VARCHAR(150) NOT NULL,
	Visualizacoes INT          DEFAULT 0,
	Likes         INT          DEFAULT 0,
	Dislikes      INT          DEFAULT 0,
	Duracao       INT          NOT NULL,
	CanalID       INT          FOREIGN KEY REFERENCES Canal(CanalId)
);

SELECT * FROM Video;
-------------------------------------------------------------------------------------------------------------------------------
-- UPDATE --

UPDATE TB_PRODUTOS SET NOME = 'Clean - 350 ml - Laranja', TAMANHO = '350 ml', PRECO_LISTA = 5.50 WHERE PRODUTO = '1037797';

-------------------------------------------------------------------------------------------------------------------------------
-- DELETE --
DELETE FROM TB_VENDEDORES WHERE MATRICULA = '00400';

-------------------------------------------------------------------------------------------------------------------------------
-- DATE --

--Inserindo
INSERT INTO TB_CLIENTES 
(CPF, NOME, ENDERECO1, ENDERECO2, BAIRRO, CIDADE, ESTADO, CEP, DATA_NASCIMENTO, IDADE, SEXO, LIMITE_CREDITO, VOLUME_COMPRA, PRIMEIRA_COMPRA)
VALUES
('00333434577', 'João da Silva', 'Rua Projetada número 10', NULL, 'VILA ROMAN', 'TRÊS RIOS', 'RJ', '22222222', TO_DATE('12/10/1965', 'DD/MM/YYYY'), 56, 'M', 100000, 2000, 0);

--Buscando 
SELECT * FROM TB_CLIENTES WHERE DATA_NASCIMENTO = '25/03/92';

SELECT * FROM TB_CLIENTES WHERE DATA_NASCIMENTO = TO_DATE('25/03/1992', 'DD/MM/YYYY');

SELECT * FROM TB_CLIENTES WHERE DATA_NASCIMENTO = TO_DATE('03/25/1992', 'MM/DD/YYYY');

SELECT * FROM TB_CLIENTES WHERE DATA_NASCIMENTO > TO_DATE('03/25/1992', 'MM/DD/YYYY');

SELECT * FROM TB_CLIENTES WHERE TO_CHAR(DATA_NASCIMENTO, 'MM') = 9; --Pegar apenas mês de setembro
-------------------------------------------------------------------------------------------------------------------------------

SELECT COUNT(*)
FROM Production.Product

SELECT COUNT(Size)
FROM Production.Product

-------------------------------------------------------------------------------------------------------------------------------

--ORDER BY-
SELECT *
FROM person.person
ORDER BY FirstName asc;

select distinct FirstName 
from person.Person ;
SELECT top 10 ProductId
FROM Production.Product
ORDER BY StandardCost desc;

SELECT top 4 Name,ProductNumber 
FROM Production.Product
ORDER BY ProductId;

--------------------------------------------------------------------------------------------------------------------------------
--BETWEEN-	Trazer lista de preços entre 1000 á 1500
select *
from Production.Product
where ListPrice between 1000 and 1500; 

--Trazer HireDate 2009/01/01 entre 2010/01/01
select HireDate
from HumanResources.Employee
where HireDate BETWEEN '2009/01/01' and '2010/01/01'; 

--LISTQuantos produtos vermelhos tem preço entre 500$ e 1000$ ?
select count(*)
from Production.Product
where Color = 'red' 
and ListPrice between 500 and 1000; 

-------------------------------------------------------------------------------------------------------------------------------

--IN-	Usamos o Operador IN junto com WHERE para verificar se o valor corresponde com o valor passado passado na lista de valores.
select * 
from Person.Person 
where BusinessEntityID in (2, 4, 6);

---------------------------------------------------------------------------------------------------------------------------------

--LIKE-	Vamos dizer que vc quer encontrar uma pessoa no BD que o nome começa com Ovi***
select *
from Person.Person
where FirstName like 'Ovi%' ;

--Quantos produtos cadastrados tem a palavra 'road' no nome?
select count(*)
from Production.Product
where Name like '%road%';

select *
from Production.Product
where Name like '%road%';


---------------------------------------------------------------------------------------------------------------------------------

--COUNT-	Quantos produtos temos cadastrados no sistema que custam mais que 1500$ ?
select count(ListPrice) 
from Production.Product 
where ListPrice > 1500 ;

select ListPrice
from Production.Product
where ListPrice > 1500 ;


--Quantas pessoas temos que o nome inicia com a aletra 'P' ?
select count(FirstName)
from Person.Person
where LastName like 'P%';

select FirstName
from Person.Person
where LastName like 'P%';

----------------------------------------------------------------------------------------------------------------------------------

--DISTINCT-	Em quantas ciadades unicas estão cadastrados nossos clientes?
select count(distinct(City)) 
from Person.Address; 

select distinct City from Person.Address;

----------------------------------------------------------------------------------------------------------------------------------

--MIN,MAX,SUM,AVG- Funçoes de agragação, basicamente agregam ou combinam dados de uma tabela em 1 resultado só
--Soma total de todas as vendas
select top 10 sum(LineTotal) as "Soma"
from Sales.SalesOrderDetail ;

--Menor valor de vendas
select top 10 min(LineTotal)
from Sales.SalesOrderDetail ;

--Maior valor de vendas
select top 10 max(LineTotal)
from Sales.SalesOrderDetail ;

--Media valor de vendas
select top 10 avg(LineTotal)
from Sales.SalesOrderDetail ;

-----------------------------------------------------------------------------------------------------------------------------------

--GROUP BY- 
--Básicamente divide o resultado da sua pesquisa em grupos  

--Fazendo a soma de todos os UnitPrice de SpecialOfferID e agrupando o resultado: 
select SpecialOfferID , sum(UnitPrice) as "Soma"
from Sales.SalesOrderDetail
Group By SpecialOfferID; 

--Quero saber quantos de cada produto foi vendido até hj?
select ProductID, count(ProductID) as "Contagem"
from Sales.SalesOrderDetail
group by ProductID;

--Quantos nomes de cada nome temos cadastrados em nosso BD da tabela de Person.Person, ?
select FirstName, count(FirstName) as "Contagem"
from Person.Person
group by FirstName;

--Na tabela Production.Product quero saber as médias de preço para os produtos que são prata(Silver).
select Color, avg(ListPrice) as "MediaPreco"
from Production.Product
where Color = 'Silver'
group by Color; 

--Preciso saber quantas pessoas tem o mesmo MiddleName a grupadas por o MiddlerName.
select MiddleName, count(MiddleName) "Contagem"
from Person.Person
group by MiddleName ;

--Preciso saber em média qual a quantidade(Quantity)que cada produto é vendido na loja.
select ProductID, avg(OrderQty) "media" --Selecione o produtoID, tire a média da Quantidade de pedido(OrderQty)
from Sales.SalesOrderDetail
group by ProductID; --Juntar td por ProductID

---------------------------------------------------------------------------------------------------------------------------------

--ORDER BY-	Quero saber qual foram as 10 vendas que no total tiveram os maiores valores de venda(line total) por produto do 
-- maior valor para o menor. 
select top 10 ProductID, sum(LineTotal) --2 vai selecoinar os 10, e vai fazer a soma da LineTotal com mesmo ID 
from Sales.SalesOrderDetail 
group by ProductID --1 Vai agrupar todos os ProductID com mesmo ID 
Order by sum(LineTotal) desc; --3 Vai Ordenar os 10 em ordem decrescente

--Quantos produtos e qual a quantidade média de produtos temos cadastrados nas nossas Ordem de serviço(WorkOrder) 
-- agrupados por ProductID.
select ProductID, count(ProductID)"Contagem", 
avg(OrderQty)"Media" 
from Production.WorkOrder
group by ProductID ;

select * from Production.WorkOrder ;

-----------------------------------------------------------------------------------------------------------------------------------

--Having-	
--é basicamente muito usado em conjunção com o Group By para filtrar resultados de um agrupamento
--De uma forma mais simples gosto de enter ele como um Where para dados grupos.

--Queremos saber quais nomes no sisitema tem ocorrencia maior q 10 vez 
select FirstName, count(FirstName) as "Quantidade"
from Person.Person
group by FirstName
having count(FirstName) > 10;

--Queremos saber quais produtos que no tatal de vendas estão entre 162k e 500k
select ProductID, sum(LineTotal) as "Total" 
from Sales.SalesOrderDetail
group by ProductID
having sum(LineTotal) between 162000 and 500000 ; --Trazer somente a Soma dos LineTotal, que estejam entre 162k e 500k 

select * from Sales.SalesOrderDetail ;


--Estamos querendo indentificar as provincias (StateProvinceId) com o maior número de cadastros no nosso sistema, então é precisso
-- encontrar quais provincias estão registradas no BD mais de 100 vez.
select StateProvinceID, count(StateProvinceID) as "Quantidade" 
from Person.Address
group by StateProvinceID
having count(StateProvinceID) > 100; 

--Sendo que se trata de uma multinacional os gerentes querem saber quais produtos(ProductID) não estão trazendo em média no minimo
-- um milhão em total de vendas.
select ProductID, avg(LineTotal) as "TotalVendas" --média do tatal de cada ProductID
from Sales.SalesOrderDetail
group by ProductID --agrupando pelo ProductID
having avg(LineTotal) < 1000000 ;--Somente onde a média dele é menor que um milhão

select * from Sales.SalesOrderDetail ;


-----------------------------------------------------------------------------------------------------------------------------------

--AS-
--Encontrar a FirstName e LastName Person.Person e nomealas para Nome e SobreNome 
select FirstName as "Nome",
LastName as "Sobre Nome"
from Person.Person

-----------------------------------------------------------------------------------------------------------------------------------

--INNER JOIN-	
select p.BusinessEntityID, p.FirstName, p.LastName, pe.EmailAddress --Selecionar as colunas que queremos da primeira p. tabela e das outras tabelas pe. 
from Person.Person as p --aqui vamos extrair as inf. da primeira tabela
INNER JOIN Person.EmailAddress PE on p.BusinessEntityID = pe.BusinessEntityID ; --aqui pegar da tabela Person.EmailAddress apelido PE, ai juntar as informações baseadas em uma coluna em comum

select top 10 * from Person.Person; 
select top 10 * from Person.EmailAddress; 


--Vamos dizer que queremos os nomes dos produtos e informações de suas subcategorias
select p.ListPrice, p.Name, PS.Name
from Production.Product as p
inner join Production.ProductSubcategory PS on  p.ProductSubcategoryID = PS.ProductSubcategoryID ;

select top 10 * from Production.Product;
select top 10 * from Production.ProductSubcategory;


--Exer1.
select top 10 * from Person.PhoneNumberType;
select top 10 * from Person.PersonPhone;

select top 10 b.BusinessEntityId, a.Name, b.PhoneNumberTypeId, b.PhoneNumber
from Person.PhoneNumberType as a
inner join Person.PersonPhone b on a.PhoneNumberTypeID = b.PhoneNumberTypeID;


--Exer2.
select top 10 * from Person.StateProvince;
select top 10 * from Person.Address;

select top 10 "B"."AddressID", "B"."City", "A"."StateProvinceID", "A"."Name" 
from Person.StateProvince as "A"
inner join Person.Address B on "A"."StateProvinceID" = "B"."StateProvinceID" ;


-----------------------------------------------------------------------------------------------------------------------------

--LEFT JOIN
--Pessoas que tem um cartão de crédito registrado
--Inner Join :19.118 Sales.PersonCreditCard; pode excluir linhas null do nosso resultado

--Left Join : 19.972 Person.Person pega as null junto, pessoas q não tem


--OUTER JOIN -Pessoas que não tem um cartão de crédito registrado
select * 
from Person.Person "PP" --left pega esse cara 
left join Sales.PersonCreditCard "PC"  --inner pega esse
on "PP"."BusinessEntityID" = "PC"."BusinessEntityID" 
where "PC"."BusinessEntityID" is null ;

select * from Sales.PersonCreditCard;
select * from Person.Person;

---------------------------------------------------------------------------------------------------------------------------------

--UNION -Une as respectivas tabelas de acordo com as informações requisitadas
select FirstName, MiddleName, LastName, Title
from Person.Person
where Title = 'Ms.' 
union
select FirstName, MiddleName, LastName, Title
from Person.Person
where FirstName like 'M%';

---------------------------------------------------------------------------------------------------------------------------------

--DATEPARTE(year-month-day, ColunaDate) EX:(Informação q eu quero, De qual coluna quero, obs.Tipo Data)
select SalesOrderID, DATEPART(month, OrderDate) as Mes
from Sales.SalesOrderHeader;


--Média de valor devido por mês 
select avg(TotalDue) as Media, DATEPART(month, OrderDate) as Mes  --Pegando a média(TotalDue) eo mês da (Orderdate) 
from Sales.SalesOrderHeader
group by DATEPART(month, OrderDate) --Para funcionar tem q agregar, então agrupando o mês da OrderDate
order by Mes ; --Organizar por Mes 

select top 10 * from Sales.SalesOrderHeader;


--Estudo -Pegando a média da quantidade de pedido por ano
select avg(OrderQty), DATEPART(year, StartDate) as AnoInicio
from Production.WorkOrder 
group by DATEPART(year, StartDate)
order by AnoInicio ;

select * from Production.WorkOrder;


--Estudo -Pegando nome do produto, Quantidade de Pedido, apartir da Data de Vencimento e Ordenando pelo ano 
select PP.Name ,PC.OrderQty as "QuantidadePedido", DATEPART(year, PC.DueDate) as "DataVencimento"
from Production.Product PP
inner join Production.WorkOrder PC
on PP.ProductID = PC.ProductID
order by DataVencimento;


--Pegando a média de Quantidade de pedido por Ano
SELECT AVG(OrderQty), DATEPART(year, DueDate) AS DataVencimento
FROM Production.WorkOrder
GROUP BY DATEPART(year, DueDate)
ORDER BY DataVencimento;

select * from Production.Product ;
select * from Production.WorkOrder;

---------------------------------------------------------------------------------------------------------------------------------

--Manipulação de String

--Concatenando com espaço, para se parar Nome do SobreNome  
select CONCAT(FirstName, ' ', LastName) from Person.Person;

--Maiúsculo e Minúsculo
select UPPER(FirstName) as Maiúsculo, LOWER(LastName) as Minúsculo from Person.Person;

--Contagem de quantos caracteres determinada palavra tem
select FirstName, LEN(FirstName) as QtdCaracteres from Person.Person;

--Pegando caracter de uma sequencia de string (de uma Palavra)
select FirstName, SUBSTRING(FirstName,1,3) from Person.Person; --(Foi do primeiro caracter, e pegou as 3 letras) ex:ALI = ALI

--Substituindo um caracter por outro
select ProductNumber as "Original", REPLACE(ProductNumber, '-', '#') as "Alterado" from Production.Product;


----------------------------------------------------------------------------------------------------------------------------------

--Operações matemáticas SQL server
select ROUND(LineTotal, 2) as Aredondada,--( coluna, Aqual a precisão decimal desse aredondamento)
LineTotal as ValorOriginal
from Sales.SalesOrderDetail;

select SQRT(LineTotal) as RAIZ
from Sales.SalesOrderDetail;


----------------------------------------------------------------------------------------------------------------------------------

--Subqueries (select dentro de outro select)
--Quero saber o nome dos meus fincionarios que tem o cargo de "Desiner engineer".
select FirstName 
from Person.Person
where BusinessEntityID IN (
select BusinessEntityID from HumanResources.Employee
where JobTitle = 'Design Engineer');

select P.FirstName
from Person.Person P
Inner Join HumanResources.Employee E on E.BusinessEntityID = P.BusinessEntityID 
and JobTitle = 'Design Engineer'; 

select * from HumanResources.Employee


--Exercício
--Encontre todos os endereços que estão no estados de "Alberta", pode trazer todas as informações.
select *
from Person.Address PA
Inner Join Person.StateProvince PS on PS.StateProvinceID = PA.StateProvinceID 
and Name = 'Alberta';

select * from Person.Address where StateProvinceID = 1;

select * from Person.Address;
select * from Person.StateProvince;

------------------------------------------------------------------------------------------------------------------------
(NO BD Northwind)

--Self Join (é uma forma de agrupar/ordenar dados dentro de uma mesma tabela)

--Quero todos os clientes que moram na mesma região
select A.ContactName, A.Region, B.ContactName, B.Region
from Customers A, Customers B
where A.Region = B.Region

--Quero (Nome e Data) de contratração de todos, os funcionarios que foram contratados no mesmo ano 
select A.FirstName as AFirsName, A.HireDate as AHireDate, B.FirstName as BFirstName, B.HireDate as BHireDate
from Employees A, Employees B
where DATEPART (year, A.HireDate) = DATEPART (year, B.HireDate);

select * from Employees
select * from Customers


--Quero saber na tabela detalhes de pedidos 'Order Details' quais produtos tem o mesmo percentual de desconto.
select A.ProductID, A.Discount, B.ProductID, B.Discount
from [Order Details] A, [Order Details] B 
where A.Discount = B.Discount 

select * from [Order Details]

---------------------------------------------------------------------------------------------------------------------------------

SELECT A.ContactName, A.Region, B.ContactName, B.Region
FROM Customers A, Customers B  
WHERE A.Region = B.Region

--Quero encontrar (nome e data de contratação) de todos os funcionários que foram contratados no mesmo ano:
SELECT A.FirstName, A.HireDate, B.FirstName, A.HireDate
FROM Employees A, Employees B
WHERE DATEPART(year, A.HireDate) = DATEPART(year, B.HireDate);

--Quero saber na tabela detalhes do pedido [Order Detaius] quais produtos tem o mesmo percentual de desconto:
SELECT A.Discount, A.ProductID, B.Discount, B.ProductID
FROM [Order Details] A, [Order Details] B
WHERE A.Discount = B.Discount;

---------------------------------------------------------------------------------------------------------------------------------
(BD Trescamadas -> registers)
---STORED PROCEDURES---

-- Esta PROCEDURE atualiza o register e tem como retorno a validação do update
--DELETAR--
DROP PROCEDURE UpdatePassword;

--CRIAR--(apenas uma vez)
CREATE PROCEDURE UpdatePassword (@id INT, @username varchar(50), @currentPassword varchar(50), @newPassword varchar(50))
AS
BEGIN
	DECLARE @validacao BIT;

	UPDATE registers SET username = @username, password = @newPassword
	WHERE id = @id AND password = @currentPassword;

	
	SELECT @validacao = 1 from registers where password = @newPassword;
	SELECT @validacao retorno;

	END;
GO

--EXECUTAR--
EXEC UpdatePassword 1014, 'Samurai', '003', '004';

----------------------------------------------------
DROP PROCEDURE RegistrarNovoUsuario;

CREATE PROCEDURE RegistrarNovoUsuario (@username varchar(50), @password varchar(50))
AS
BEGIN
	DECLARE @idRegister INT;
	SELECT @idRegister = MAX(id) from registers;

	INSERT INTO registers (username, password)
	VALUES (@username, @password)
	
	SELECT @idRegister = id from registers where id = @idRegister;
	SELECT @idRegister AS retorno;
END;
GO 

EXEC RegistrarNovoUsuario 'zé', '555';

--------------------------------------------------------------------------------------------------------------------
(BD Trescamadas -> registers)
--OUTPUT--

update registers 
set password = '000'
output inserted.username,
	   inserted.password
where id = 1012


insert into registers (username, password)
output inserted.username, inserted.password
values ('testes', '0')

----------------------------------------------------------------------------------------------------------------------
(BD Trescamadas -> items)
--SCOPE_IDENTITY() , @@IDENTITY , IDENT_CURRENT()--
--Retornam o último valor de identidade inserido em uma coluna de identidade no mesmo escopo.

--retorna o ID do ultimo registro na tabela --
insert into items(idUser, name, username, password, url, note, type) 
values(1, 'Jusé', 'test', '123', 'aaa', 'bbb', 'Login')
DECLARE @id BIGINT
set @id = SCOPE_IDENTITY()
PRINT @id;

insert into items(idUser, name, username, password, url, note, type) 
values(1024, 'Jusé', 'test', '123', 'aaa', 'bbb', 'Login')
SELECT SCOPE_IDENTITY()
--Comando para receber no C# (obs: tive q remover de um código, estava duplicando no BD)
--int idReturn = Convert.ToInt32(command.ExecuteScalar());

SELECT IDENT_CURRENT('dbo.items');


SELECT MAX(Id) FROM Employees -- Display the value of Id in the last row in Employees table.
GO
INSERT INTO Employees (FName, LName, PhoneNumber) -- Insert a new row 
VALUES ('John', 'Smith', '25558696525') 
GO  
SELECT @@IDENTITY 
GO  
SELECT MAX(Id) FROM Employees -- Display the value of Id of the newly inserted row.  
GO

-----------------------------------------------------------------------------------------------------------------------
(BD Trescamadas -> registers)
--@@ROWCOUNT--
--Retorna o número de linhas afetadas pela última instrução. Se o número de linhas for maior que 2 bilhões, use ROWCOUNT_BIG.

UPDATE registers SET username = 'Pedro1', password = 10 WHERE id = 13 and password = 123 SELECT @@ROWCOUNT

DECLARE @teste AS INT = 0;
UPDATE registers SET username = 'Pedro1', password = 10 WHERE id = 13 and password = 123 IF @@ROWCOUNT = 0 print 'ok'

-------------------------------------------------------------------------------------------------------------------------
--Link collation charts: https://collation-charts.org                    (Pesquisar mais sobre...)

--Verificando se é CaseSensitivi ou CaseInsensitivi 
SELECT SERVERPROPERTY ('Collation') AS Collation_Property

--Pesquisa normal vai trazer com ou sem maiusculo
SELECT * FROM registers WHERE password = '19898@Li'

--PEsquisa utilizando COLLATE vai trazer exatamente o formato q está buscando 
SELECT * FROM registers WHERE password COLLATE Latin1_General_CS_AS = '19898@li'

--------------------------------------------------------------------------------------------------------------------------

--A função CONCAT() adiciona duas ou mais strings juntas.

SELECT CONCAT('String1', ' ','String2');

SELECT registers.id,
CONCAT( registers.username, ' ', registers.password) AS "nome_senha",
items.name As "Name_Item",
items.type AS "type"
FROM registers
LEFT JOIN items on items.iduser = registers.id;

--------------------------------------------------------------------------------------------------------------------------
