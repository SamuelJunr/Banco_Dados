
USE company;
---------------------------------------------------
-- Qual o departamento com maior numero de pessoas? 
---------------------------------------------------
SELECT 
	D.Dname AS Departamento,
    COUNT(E.Dno) AS "Quantidade de Empregados"
FROM
	employee E
INNER JOIN
	departament D ON E.Dno = D.Dnumber
GROUP BY 
	D.Dname
ORDER BY 
	2 DESC
LIMIT 1
-- Indice para "departamento com maior numero de pessoas?"
CREATE INDEX idx_employee ON employee(Dno);
-----------------------------------------
-- Quais sao os departamentos por cidade?
-----------------------------------------
SELECT
	DL.Dlocation AS Cidade,
    D.Dname AS Departamento
FROM
	departament D
LEFT JOIN
	departament_locations DL ON D.Dnumber = DL.Dnumber
ORDER BY
	DL.Dlocation;
-- Indice para "Quais sao os departamentos por cidade?"
CREATE INDEX idx_departament ON departament(Dnumber);  
------------------------------------------
-- Relacao de empregados por departamento?
------------------------------------------
SELECT 
	CONCAT(E.Fname, " ", COALESCE(E.Minit, ""), " ", E.Lname) AS Empregado,
    D.Dname AS Departamento
FROM
	employee E
LEFT JOIN
	departament D ON D.Dnumber = E.Dno
ORDER BY 
	D.Dname, E.Fname, E.Fname , E.Lname ; 
-- Indice para "Relacao de empregados por departamento?"
CREATE INDEX idx_employee_FullName ON employee((concat(Fname, " ", Minit, " ", Lname)));
CREATE INDEX idx_employee_Fname ON employee(Fname);
CREATE INDEX idx_employee_Minit ON employee(Minit);
CREATE INDEX idx_employee_Lname ON employee(Lname);


------------------------------------------------------
--procedure para um ecommerce
------------------------------------------------------

USE ecommerce;

CREATE PROCEDURE CRUD(
	IN opcao int, IN id int
)
BEGIN	
	CASE opcao		
		WHEN 1 THEN
			SELECT * FROM orders WHERE idOrder = id ; -- Mostrar order
        WHEN 2 THEN
			UPDATE orders SET orderStatus = 'Confirmado' WHERE idOrder = id; -- confirmar order
		WHEN 3 THEN
			DELETE FROM productOrder WHERE idPOorder = id; -- excluir produtos da order
			DELETE FROM orders WHERE idOrder = id; -- excluir order
	END CASE;
END 
