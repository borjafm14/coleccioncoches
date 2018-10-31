CREATE DATABASE coches;
USE coches;

CREATE TABLE CARS(
 id INT NOT NULL auto_increment,
 marca nvarchar(100) NOT NULL,
 modelo nvarchar(100) NOT NULL,
 nacionalidad_coche nvarchar(40) NULL,
 year_coche nvarchar(4) NULL,
 campeonato nvarchar(100) NULL,
 competicion nvarchar(100) NULL, 
 categoria nvarchar(100) NULL,
 piloto nvarchar(100) NULL,
 nacionalidad_piloto nvarchar(100) NULL,
 copiloto nvarchar(100) NULL,
 nacionalidad_copiloto nvarchar(100) NULL,
 descripcion nvarchar(200) NULL,
 foto longtext NOT NULL,
 fecha_hora datetime NOT NULL DEFAULT NOW(),
 tipo INT NOT NULL, #1 para rally, 2 para circuito, 3 para calle
 precio NVARCHAR(10) NULL,
 fabricante NVARCHAR(50) NULL,
 CONSTRAINT PK_Coches PRIMARY KEY (id)
);





DELIMITER //
create procedure CARS__insert
	(in
		marca nvarchar(100),
		modelo nvarchar(100),
		nacionalidad_coche nvarchar(40),
		year_coche nvarchar(4),
		foto longtext,
		tipo int,
		campeonato nvarchar(100),
		competicion nvarchar(100),
		categoria nvarchar(100),
		piloto nvarchar(100),
		nacionalidad_piloto nvarchar(100),
		copiloto nvarchar(100),
		nacionalidad_copiloto nvarchar(100),
		precio nvarchar(10),
		fabricante nvarchar(50),
		descripcion nvarchar(200),
	out
		proc_return int
	)
BEGIN
INSERT INTO CARS(
marca, modelo, nacionalidad_coche, year_coche, foto, tipo, campeonato, competicion, categoria, piloto, nacionalidad_piloto, copiloto, nacionalidad_copiloto, precio, fabricante, descripcion
)
VALUES
(@marca, @modelo, @nacionalidad_coche, @year_coche, @foto, @tipo, @campeonato, @competicion, @categoria, @piloto, @nacionalidad_piloto, @copiloto, @nacionalidad_copiloto, @precio, @fabricante, @descripcion);

SELECT * FROM CARS WHERE ID = SCOPE_IDENTITY();

SET @proc_return = 200;

END //
DELIMITER ;





DELIMITER //
CREATE PROCEDURE CARS__list
	(in
		marca nvarchar(100),
		modelo nvarchar(100),
		nacionalidad_coche nvarchar(40),
		year nvarchar(4),
		tipo1 int, #rally
		tipo2 int, #circuito
		tipo3 int, #calle
		campeonato nvarchar(100),
		competicion nvarchar(100),
		categoria nvarchar(100),
		piloto nvarchar(100),
		nacionalidad_piloto nvarchar(100),
		copiloto nvarchar(100),
		nacionalidad_copiloto nvarchar(100),
		precio nvarchar(10),
		fabricante nvarchar(50),
		desde nvarchar(20),
	out
		proc_return int
	)
BEGIN

			
		IF @desde = 'hoy' THEN
				
			select * from CARS where marca like CONCAT('%',@marca,'%') and modelo like CONCAT('%',@modelo,'%')
				and nacionalidad_coche like CONCAT('%',@nacionalidad_coche,'%')
				and (tipo = @tipo1 or tipo = @tipo2 or tipo = @tipo3)
				and campeonato like CONCAT('%',@campeonato,'%')  
				and competicion like CONCAT('%',@competicion,'%') and categoria like CONCAT('%',@categoria,'%')
				and piloto like CONCAT('%',@piloto,'%') and nacionalidad_piloto like CONCAT('%',@nacionalidad_piloto,'%')
				and copiloto like CONCAT('%',@copiloto,'%') and nacionalidad_copiloto like CONCAT('%',@nacionalidad_copiloto,'%')
				and year_coche like CONCAT('%',@year_coche,'%') and precio like CONCAT('%',@precio,'%') and fabricante like CONCAT('%',@fabricante,'%') 
				and fecha_hora > DATEADD(day, -1, NOW());

		ELSEIF @desde = 'ultimoMes' THEN
        
			select * from CARS where marca like CONCAT('%',@marca,'%') and modelo like CONCAT('%',@modelo,'%')
				and nacionalidad_coche like CONCAT('%',@nacionalidad_coche,'%')
				and (tipo = @tipo1 or tipo = @tipo2 or tipo = @tipo3)
				and campeonato like CONCAT('%',@campeonato,'%')  
				and competicion like CONCAT('%',@competicion,'%') and categoria like CONCAT('%',@categoria,'%')
				and piloto like CONCAT('%',@piloto,'%') and nacionalidad_piloto like CONCAT('%',@nacionalidad_piloto,'%')
				and copiloto like CONCAT('%',@copiloto,'%') and nacionalidad_copiloto like CONCAT('%',@nacionalidad_copiloto,'%')
				and year_coche like CONCAT('%',@year_coche,'%') and precio like CONCAT('%',@precio,'%') and fabricante like CONCAT('%',@fabricante,'%') 
				and fecha_hora > DATEADD(month, -1, NOW());
			
		ELSE 
			#siempre
			select * from CARS where marca like CONCAT('%',@marca,'%') and modelo like CONCAT('%',@modelo,'%')
				and nacionalidad_coche like CONCAT('%',@nacionalidad_coche,'%')
				and (tipo = @tipo1 or tipo = @tipo2 or tipo = @tipo3)
				and campeonato like CONCAT('%',@campeonato,'%')  
				and competicion like CONCAT('%',@competicion,'%') and categoria like CONCAT('%',@categoria,'%')
				and piloto like CONCAT('%',@piloto,'%') and nacionalidad_piloto like CONCAT('%',@nacionalidad_piloto,'%') 
				and copiloto like CONCAT('%',@copiloto,'%') and nacionalidad_copiloto like CONCAT('%',@nacionalidad_copiloto,'%')
				and year_coche like CONCAT('%',@year_coche,'%') and precio like CONCAT('%',@precio,'%') and fabricante like CONCAT('%',@fabricante,'%');
		END IF;

	SET @proc_return = 200;

END //
DELIMITER ;




DELIMITER //
CREATE PROCEDURE CARS__delete
	(in
		ID int,
	out
		proc_return int
	)
BEGIN

	DELETE FROM CARS WHERE ID = @ID;

    SET @proc_return = 200;

END //
DELIMITER ;



DELIMITER //
CREATE PROCEDURE CARS__list_last
	(out proc_return int)
BEGIN

	SELECT * FROM CARS ORDER BY ID DESC LIMIT 10;

    SET @proc_return = 200;

END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE CARS__get_info
	(out proc_return int)
BEGIN

	SELECT COUNT(*) AS 'Total' FROM CARS
	UNION ALL
	SELECT COUNT(*) AS 'Rally' FROM CARS WHERE tipo = 1
	UNION ALL
	SELECT COUNT(*) AS 'Circuito' FROM CARS WHERE tipo = 2
	UNION ALL
	SELECT COUNT(*) AS 'Calle' FROM CARS WHERE tipo = 3;

    SET @proc_return = 200;

END //
DELIMITER ;
