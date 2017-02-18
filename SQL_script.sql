CREATE TABLE cars(
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



create procedure insertCar 
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
	fabricante nvarchar(50) null,
	@descripcion nvarchar(max) null
AS
BEGIN
INSERT INTO [dbo].[cars](
marca, modelo, nacionalidad_coche, year, foto, tipo, competicion, categoria, piloto, nacionalidad_piloto, copiloto, nacionalidad_copiloto, precio, fabricante, descripcion
)
VALUES
(@marca, @modelo, @nacionalidad_coche, @year, @imagen, @tipo, @competicion, @categoria, @piloto, @nacionalidad_piloto, @copiloto, @nacionalidad_copiloto, @precio, @fabricante, @descripcion)

RETURN 200

END

GO;