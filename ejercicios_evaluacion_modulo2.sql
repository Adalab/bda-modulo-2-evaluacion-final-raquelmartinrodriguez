/* EJERCICIO 1: 1. Selecciona todos los nombres de las películas sin que aparezcan duplicados.*/

-- lo primero que hacemos es seleccionar la base de datos con la que vamos a trabajar. En este caso Sakila.
USE `sakila`;

-- Usando el comando distinct, selecionamos todos los nombres de películas sin duplicados
SELECT DISTINCT `title`
	FROM `film`;
    
/* EJERCICIO 2: Muestra los nombres de todas las películas que tengan una clasificación de "PG-13".
rating*/

-- Filtramos los resultados para que nos muestra únicamente los que pertenecen a la clasificación PG-13 usando WHERE
SELECT DISTINCT `title`
	FROM `film`
    WHERE `rating`= 'PG-13';
    
/* EJERCICIO 3: Encuentra el título y la descripción de todas las películas que contengan la palabra "amazing" en su descripción.*/

-- Filtramos los resultados para que nos muestra únicamente los que contienen la palabra 'amazing' en su descripción usando el operador de filtro LIKE
SELECT `title`, `description`
	FROM `film`
    WHERE `description`LIKE '%amazing%'; 
    
/* EJERCICIO 4: Encuentra el título de todas las películas que tengan una duración mayor a 120 minutos.*/

-- Filtramos los resultados para que nos muestre las películas con una duración superior a 120 minutos usando WHERE.
SELECT `title`, `length`
	FROM `film`
    WHERE `length`>120;
    
/* EJERCICIO 5: Recupera los nombres de todos los actores.*/

-- en este caso vamos a utilizar la tabla 'actor' para mostrar el nombre de todos los actores. Usamos CONCAT para que nos muestra nombre y apellido en una sola columna que hemos renombreado como 'actor_name'
SELECT DISTINCT CONCAT(`first_name`,' ' , `last_name`) AS 'actor_name'
	FROM `actor`;

/*EJERCICIO 6: Encuentra el nombre y apellido de los actores que tengan "Gibson" en su apellido*/

-- Usamos de nuevo WHERE para filtrar por apellido
SELECT `first_name`, `last_name`
	FROM `actor`
    WHERE `last_name` = 'Gibson';
    
/* EJERCICIO 7: Encuentra los nombres de los actores que tengan un actor_id entre 10 y 20.*/

-- de nuevo usamos WHERE para filtrar los resultados. Esta vez, acompañado de AND, para meterle dos condiciones:
SELECT `first_name`, `last_name`
	FROM `actor`
    WHERE `actor_id` >= 10 AND `actor_id`<=20;

/* EJERCICIO 8:  Encuentra el título de las películas en la tabla `film` que no sean ni "R" ni "PG-13" en cuanto a su clasificación.*/

-- Usamos el operador de filtro NOT IN para selecionar todas las clasificaciones excepto R y PG-13
SELECT `title`, rating 
	FROM `film`
    WHERE `rating` NOT IN ('R', 'PG-13'); 
    
/* EJERCICIO 9: Encuentra la cantidad total de películas en cada clasificación de la tabla `film` y muestra la clasificación junto con el recuento.
   

