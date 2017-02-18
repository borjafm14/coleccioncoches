CREATE TABLE CARS(
 id INT NOT NULL IDENTITY (1, 1),
 marca NVARCHAR(max) NOT NULL,
 modelo NVARCHAR(max) NOT NULL,
 nacionalidad_coche VARCHAR(40) NULL,
 year INT NULL,
 competicion NVARCHAR(max) NULL, 
 categoria NVARCHAR(max) NULL,
 piloto NVARCHAR(max) NULL,
 nacionalidad_piloto NVARCHAR(max) NULL,
 copiloto NVARCHAR(max) NULL,
 nacionalidad_copiloto NVARCHAR(max) NULL,
 descripcion NVARCHAR(max) NULL,
 enlace_foto NVARCHAR(max) NOT NULL,
 fecha_hora DATETIME NOT NULL DEFAULT (getdate()),
 tipo INT NOT NULL, --1 para rally, 2 para circuito, 3 para calle
 precio INT NULL,
 fabricante NVARCHAR(50) NULL, --IXO, etc
 CONSTRAINT PK_Coches PRIMARY KEY (id)
);

GO



create procedure CARS__insert
	@marca nvarchar(max),
	@modelo nvarchar(max),
	@nacionalidad_coche nvarchar(40) null,
	@year int null,
	@enlace_foto nvarchar(max),
	@tipo int,
	@competicion nvarchar(max) null,
	@categoria nvarchar(max) null,
	@piloto nvarchar(max) null,
	@nacionalidad_piloto nvarchar(max) null,
	@copiloto nvarchar(max) null,
	@nacionalidad_copiloto nvarchar(max) null,
	@precio int null,
	@fabricante nvarchar(50) null,
	@descripcion nvarchar(max) null
AS
BEGIN
INSERT INTO [dbo].[cars](
marca, modelo, nacionalidad_coche, year, enlace_foto, tipo, competicion, categoria, piloto, nacionalidad_piloto, copiloto, nacionalidad_copiloto, precio, fabricante, descripcion
)
VALUES
(@marca, @modelo, @nacionalidad_coche, @year, @enlace_foto, @tipo, @competicion, @categoria, @piloto, @nacionalidad_piloto, @copiloto, @nacionalidad_copiloto, @precio, @fabricante, @descripcion)

RETURN 200

END

GO





CREATE PROCEDURE CARS__list
	@marca nvarchar(max),
	@modelo nvarchar(max),
	@nacionalidad_coche nvarchar(40),
	@year int,
	@tipo int,
	@competicion nvarchar(max),
	@categoria nvarchar(max),
	@piloto nvarchar(max),
	@nacionalidad_piloto nvarchar(max),
	@copiloto nvarchar(max),
	@nacionalidad_copiloto nvarchar(max),
	@precio int,
	@fabricante nvarchar(50),
	@desde nvarchar(20)
AS
BEGIN

IF(@year = 0 AND @precio = 0)
	BEGIN
	--NO BUSCO NI POR AÑO NI POR PRECIO

		IF(@desde = 'hoy')
			BEGIN
			
				select * from CARS where marca like '%'+@marca+'%' and modelo like '%'+@modelo+'%'
					and nacionalidad_coche like '%'+@nacionalidad_coche+'%' and tipo = @tipo 
					and competicion like '%'+@competicion+'%' and categoria like '%'+@categoria+'%'
					and piloto like '%'+@piloto+'%' and nacionalidad_piloto like '%'+@nacionalidad_piloto+'%' 
					and copiloto like '%'+@copiloto+'%' and nacionalidad_copiloto like '%'+@nacionalidad_copiloto+'%'
					and fabricante like '%'+@fabricante+'%' 
					and fecha_hora > DATEADD(day, -1, GETDATE())
			END
		ELSE IF(@desde = 'ultimoMes')
			BEGIN
				select * from CARS where marca like '%'+@marca+'%' and modelo like '%'+@modelo+'%'
					and nacionalidad_coche like '%'+@nacionalidad_coche+'%' and tipo = @tipo 
					and competicion like '%'+@competicion+'%' and categoria like '%'+@categoria+'%'
					and piloto like '%'+@piloto+'%' and nacionalidad_piloto like '%'+@nacionalidad_piloto+'%' 
					and copiloto like '%'+@copiloto+'%' and nacionalidad_copiloto like '%'+@nacionalidad_copiloto+'%'
					and fabricante like '%'+@fabricante+'%' 
					and fecha_hora > DATEADD(month, -1, GETDATE())
			END
		ELSE 
			--SIEMRPE
			BEGIN
				select * from CARS where marca like '%'+@marca+'%' and modelo like '%'+@modelo+'%'
					and nacionalidad_coche like '%'+@nacionalidad_coche+'%' and tipo = @tipo 
					and competicion like '%'+@competicion+'%' and categoria like '%'+@categoria+'%'
					and piloto like '%'+@piloto+'%' and nacionalidad_piloto like '%'+@nacionalidad_piloto+'%' 
					and copiloto like '%'+@copiloto+'%' and nacionalidad_copiloto like '%'+@nacionalidad_copiloto+'%'
					and fabricante like '%'+@fabricante+'%' 		
			END
			
	END
ELSE IF(@year = 0 AND @precio <> 0)
	BEGIN
	--NO BUSCO POR AÑO
			
		IF(@desde = 'hoy')
			BEGIN
			
				select * from CARS where marca like '%'+@marca+'%' and modelo like '%'+@modelo+'%'
					and nacionalidad_coche like '%'+@nacionalidad_coche+'%' and tipo = @tipo 
					and competicion like '%'+@competicion+'%' and categoria like '%'+@categoria+'%'
					and piloto like '%'+@piloto+'%' and nacionalidad_piloto like '%'+@nacionalidad_piloto+'%' 
					and copiloto like '%'+@copiloto+'%' and nacionalidad_copiloto like '%'+@nacionalidad_copiloto+'%'
					and precio = @precio and fabricante like '%'+@fabricante+'%' 
					and fecha_hora > DATEADD(day, -1, GETDATE())
			END
		ELSE IF(@desde = 'ultimoMes')
			BEGIN

				select * from CARS where marca like '%'+@marca+'%' and modelo like '%'+@modelo+'%'
					and nacionalidad_coche like '%'+@nacionalidad_coche+'%' and tipo = @tipo 
					and competicion like '%'+@competicion+'%' and categoria like '%'+@categoria+'%'
					and piloto like '%'+@piloto+'%' and nacionalidad_piloto like '%'+@nacionalidad_piloto+'%' 
					and copiloto like '%'+@copiloto+'%' and nacionalidad_copiloto like '%'+@nacionalidad_copiloto+'%'
					and precio = @precio and fabricante like '%'+@fabricante+'%' 
					and fecha_hora > DATEADD(month, -1, GETDATE())
			END
		ELSE 
			--SIEMPRE
			BEGIN

				select * from CARS where marca like '%'+@marca+'%' and modelo like '%'+@modelo+'%'
					and nacionalidad_coche like '%'+@nacionalidad_coche+'%' and tipo = @tipo 
					and competicion like '%'+@competicion+'%' and categoria like '%'+@categoria+'%'
					and piloto like '%'+@piloto+'%' and nacionalidad_piloto like '%'+@nacionalidad_piloto+'%' 
					and copiloto like '%'+@copiloto+'%' and nacionalidad_copiloto like '%'+@nacionalidad_copiloto+'%'
					and precio = @precio and fabricante like '%'+@fabricante+'%' 
			END
	END
ELSE IF(@year <> 0 AND @precio = 0)
	BEGIN
		--NO BUSCO POR PRECIO
			
		IF(@desde = 'hoy')
			BEGIN
			
				select * from CARS where marca like '%'+@marca+'%' and modelo like '%'+@modelo+'%'
					and nacionalidad_coche like '%'+@nacionalidad_coche+'%' and tipo = @tipo 
					and competicion like '%'+@competicion+'%' and categoria like '%'+@categoria+'%'
					and piloto like '%'+@piloto+'%' and nacionalidad_piloto like '%'+@nacionalidad_piloto+'%' 
					and copiloto like '%'+@copiloto+'%' and nacionalidad_copiloto like '%'+@nacionalidad_copiloto+'%'
					and year = @year and fabricante like '%'+@fabricante+'%' 
					and fecha_hora > DATEADD(day, -1, GETDATE())
			END
		ELSE IF(@desde = 'ultimoMes')
			BEGIN

				select * from CARS where marca like '%'+@marca+'%' and modelo like '%'+@modelo+'%'
					and nacionalidad_coche like '%'+@nacionalidad_coche+'%' and tipo = @tipo 
					and competicion like '%'+@competicion+'%' and categoria like '%'+@categoria+'%'
					and piloto like '%'+@piloto+'%' and nacionalidad_piloto like '%'+@nacionalidad_piloto+'%' 
					and copiloto like '%'+@copiloto+'%' and nacionalidad_copiloto like '%'+@nacionalidad_copiloto+'%'
					and year = @year and fabricante like '%'+@fabricante+'%' 
					and fecha_hora > DATEADD(month, -1, GETDATE())
			END
		ELSE
			--siempre
			BEGIN

				select * from CARS where marca like '%'+@marca+'%' and modelo like '%'+@modelo+'%'
					and nacionalidad_coche like '%'+@nacionalidad_coche+'%' and tipo = @tipo 
					and competicion like '%'+@competicion+'%' and categoria like '%'+@categoria+'%'
					and piloto like '%'+@piloto+'%' and nacionalidad_piloto like '%'+@nacionalidad_piloto+'%' 
					and copiloto like '%'+@copiloto+'%' and nacionalidad_copiloto like '%'+@nacionalidad_copiloto+'%'
					and year = @year and fabricante like '%'+@fabricante+'%' 
			END
	END
ELSE
	BEGIN
	--BUSCO POR TODO
			
		IF(@desde = 'hoy')
			BEGIN
				
				select * from CARS where marca like '%'+@marca+'%' and modelo like '%'+@modelo+'%'
					and nacionalidad_coche like '%'+@nacionalidad_coche+'%' and tipo = @tipo 
					and competicion like '%'+@competicion+'%' and categoria like '%'+@categoria+'%'
					and piloto like '%'+@piloto+'%' and nacionalidad_piloto like '%'+@nacionalidad_piloto+'%' 
					and copiloto like '%'+@copiloto+'%' and nacionalidad_copiloto like '%'+@nacionalidad_copiloto+'%'
					and year = @year and precio = @precio and fabricante like '%'+@fabricante+'%' 
					and fecha_hora > DATEADD(day, -1, GETDATE())
			END
		ELSE IF(@desde = 'ultimoMes')
			BEGIN
				select * from CARS where marca like '%'+@marca+'%' and modelo like '%'+@modelo+'%'
					and nacionalidad_coche like '%'+@nacionalidad_coche+'%' and tipo = @tipo 
					and competicion like '%'+@competicion+'%' and categoria like '%'+@categoria+'%'
					and piloto like '%'+@piloto+'%' and nacionalidad_piloto like '%'+@nacionalidad_piloto+'%' 
					and copiloto like '%'+@copiloto+'%' and nacionalidad_copiloto like '%'+@nacionalidad_copiloto+'%'
					and year = @year and precio = @precio and fabricante like '%'+@fabricante+'%' 
					and fecha_hora > DATEADD(month, -1, GETDATE())
			END
		ELSE 
			--siempre
			BEGIN
				select * from CARS where marca like '%'+@marca+'%' and modelo like '%'+@modelo+'%'
					and nacionalidad_coche like '%'+@nacionalidad_coche+'%' and tipo = @tipo 
					and competicion like '%'+@competicion+'%' and categoria like '%'+@categoria+'%'
					and piloto like '%'+@piloto+'%' and nacionalidad_piloto like '%'+@nacionalidad_piloto+'%' 
					and copiloto like '%'+@copiloto+'%' and nacionalidad_copiloto like '%'+@nacionalidad_copiloto+'%'
					and year = @year and precio = @precio and fabricante like '%'+@fabricante+'%' 
			END
	END

END

GO




CREATE PROCEDURE CARS__delete
	@ID int
AS
BEGIN

	DELETE FROM CARS WHERE ID = @ID

RETURN 200

END

GO



CREATE PROCEDURE CARS__list_last
AS
BEGIN

	SELECT TOP(10) * FROM CARS ORDER BY ID DESC

RETURN 200

END

GO
