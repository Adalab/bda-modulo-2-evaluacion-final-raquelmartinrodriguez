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
    
/* EJERCICIO 9: Encuentra la cantidad total de películas en cada clasificación de la tabla `film` y muestra la clasificación junto con el recuento.*/

-- usamos COUNT para que nos cuente el número de películas por su id_film (renombramos la columna como 'total_films'). Con GROUP BY las agrupamos por su clasificación. 
SELECT COUNT(`film_id`) as 'total_films', `rating`
	FROM `film`
    GROUP BY `rating`;

/* EJERCICIO 10: Encuentra la cantidad total de películas alquiladas por cada cliente y muestra el ID del cliente, su nombre y apellido junto con la cantidad de películas alquiladas*/

-- Unimos la tabla customer con la tabla rental para obtener los datos que nos pide el enunciado. Renombramos las columnas creadas para que sea más fácil su visualización. 
-- Obtenemos los resultados agrupados por el id de cliente utilizando GROUP BY. La nueva columna renombrada como 'total_rented_films' nos muestra la cantidad de películas alquiladas por cada cliente. 
SELECT `customer`.`customer_id`, COUNT(`rental`.`rental_id`) AS 'total_rented_films', CONCAT(`customer`.`first_name`,'  ' ,`customer`.`last_name`) AS 'customer_name'
	FROM `customer`
		INNER JOIN  `rental`
			ON `customer`.`customer_id` = `rental`.`customer_id`
	GROUP BY `customer_id`;

/*EJERCICIO 11: Encuentra la cantidad total de películas alquiladas por categoría y muestra el nombre de la categoría junto con el recuento de alquileres.*/

-- Hacemos 4 INNER JOIN para relacionar las películas alquiladas con la categoría. 
-- Renombramos el recuento de películas alquiladas como 'total_rented_films'. 
-- Agrupamos los resultados por el nombre de la categoría para que nos muestra la cantidad de películas alquiladas en función de cada categoría. 
SELECT COUNT(`rental`.`rental_id`) AS 'total_rented_films', `category`.`name`
	 FROM `rental`
     INNER JOIN `inventory`
		ON `rental`. `inventory_id` = `inventory`.`inventory_id`
	INNER JOIN `film`
		ON `inventory`. `film_id`= `film`.`film_id`
	INNER JOIN `film_category`
		ON `film_category`.`film_id`= `film`.`film_id`
	INNER JOIN `category`
		ON `film_category`. `category_id`= `category`.`category_id`
	GROUP BY `category`.`name`
    
/* EJERCICIO 12: Encuentra el promedio de duración de las películas para cada clasificación de la tabla `film` y muestra la clasificación junto con el promedio de duración.*/

-- Calculamos la media de duración de las películas (AVG (length)) y las agrupamos por su clasificación. 
SELECT AVG(`length`) AS 'media_duracion' , `rating`
	FROM `film`
    GROUP BY `rating`;
    
/* EJERCICIO 13: Encuentra el nombre y apellido de los actores que aparecen en la película con title "Indian Love".*/

-- Hacemos dos INNER JOIN para relacionar las tablas 'film' y 'actor'. Filtramos mediante WHERE para que únicamente muestre los acores de la película 'Indian Love'.
SELECT `actor`.`first_name`, `actor`. `last_name`
	FROM `film`
    INNER JOIN `film_actor` ON `film`.`film_id`= `film_actor`. `film_id`
    INNER JOIN `actor` ON `film_actor`.`actor_id`= `actor`.`actor_id`
	WHERE `film`.`title` = "Indian Love";

/* EJERCICIO 14: Muestra el título de todas las películas que contengan la palabra "dog" o "cat" en su descripción.*/

-- Seleccionamos las películas filtrando los resultados para que contengan 'dog' o 'cat' en la descripción mediante el uso del operador de filtro LIKE.
SELECT `title`
	FROM `film`
    WHERE `description` LIKE '%dog%' OR '%cat%';

/* EJERCICIO 15: Hay algún actor o actriz que no apareca en ninguna película en la tabla `film_actor`.*/


/* EJERCICIO 16: Encuentra el título de todas las películas que fueron lanzadas entre el año 2005 y 2010.*/
-- seleccionamos el título de la tabla film y filtramos los resultados para que sólo nos muestre las que se lanzaron entre el 2005 y el 2010

SELECT `title`
	FROM `film`
    WHERE `release_year`>= 2005 AND `release_year` <= 2010;
    
/* EJERCICIO 17: Encuentra el título de todas las películas que son de la misma categoría que "Family".*/

-- Relacionamos la tabla de películas con la de categorías para poder obtener el título de la película y la categoría. 
-- Filtramos los resultados mediante la claúsula WHERE, para que nos muestre todos los títulos de las películas que son de la categoría 'Family' 
SELECT `film`.`title`
	FROM `film`
    INNER JOIN `film_category` 
		ON `film`.`film_id`= `film_category`.`film_id`
	INNER JOIN `category` 
		ON `film_category`.`category_id`= `category`.`category_id`
	WHERE `category`.`name`= 'Family' 

/* EJERCICIO 18: Muestra el nombre y apellido de los actores que aparecen en más de 10 películas.*/

-- Hacemos dos INNER JOIN para relacionar los actores y las películas. Agrupamos por el id del actor, para que nos muestre en cuántas películas aparece cada actor. 
-- Filtramos los resultados para que únicamente nos muestre los actores que aparecen en más de 10 peliculas usando HAVING. 
SELECT `actor`.`first_name`, `actor`.`last_name`
	FROM `film`
    INNER JOIN `film_actor`
		ON `film`.`film_id` = `film_actor`.`film_id`
	INNER JOIN `actor` 
        ON `film_actor`.`actor_id` = `actor`.`actor_id`
	GROUP BY `actor`.`actor_id`
    HAVING COUNT(`film`.`film_id`) > 10;
    
/* EJERCICIO 19:Encuentra el título de todas las películas que son "R" y tienen una duración mayor a 2 horas en la tabla `film`.*/

-- Seleccionamos el título de las películas de la tabla 'film' y filtramos los resultados mediante la claúsula WHERE, teniendo en cuenta que la duración en la tabla está expresada en minutos. 
SELECT `title`
	FROM `film`
    WHERE `rating`= 'R' AND `length` > 120;
    
/* EJERCICIO 20: Encuentra las categorías de películas que tienen un promedio de duración superior a 120 minutos y muestra el nombre de la categoría junto con el promedio de duración.*/

-- Hacemos dos INNER JOIN para relacionar la tabla de películas con la de categorías. 
-- Agrupamos por categoría para que no de la media de cada categoría mediante AVG(`film`.`length`).
-- Mediante la claúsula having, filtramos los grupos generados por la claúsula GROUP BY
SELECT `category`.`name`, AVG(`film`.`length`) AS 'average_length' 
	FROM `film`
		INNER JOIN `film_category` 
			ON `film`.`film_id`= `film_category`.`film_id`
		INNER JOIN `category`
			ON `film_category`.`category_id`= `category`.`category_id`
	GROUP BY `category`. `name`
	HAVING `average_length` > 120
    
/* EJERCICIO 21: Encuentra los actores que han actuado en al menos 5 películas y muestra el nombre del actor junto con la cantidad de películas en las que han actuado.*/

-- Al igual que en el ejercicio 18, hacemos dos INNER JOIN para relacionar los actores y las películas. 
-- Agrupamos por el id del actor, para que nos muestre en cuántas películas aparece cada actor. 
-- Filtramos los resultados para que únicamente nos muestre los actores que aparecen en más de 5 peliculas usando la cláusula HAVING.
SELECT `actor`.`first_name`, `actor`.`last_name`, COUNT(`film`.`film_id`) AS 'total_films' 
	FROM `film`
    INNER JOIN `film_actor`
		ON `film`.`film_id` = `film_actor`.`film_id`
	INNER JOIN `actor` 
        ON `film_actor`.`actor_id` = `actor`.`actor_id`
	GROUP BY `actor`.`actor_id`
    HAVING COUNT(`film`.`film_id`) >= 5;
    
/* EJERCICIO 22: Encuentra el título de todas las películas que fueron alquiladas por más de 5 días.
Utiliza una subconsulta para encontrar los rental_ids con una duración superior a 5 días y luego selecciona las películas correspondientes.*/

-- primero creamos una subconsulta para localizar los inventory_id con una duración superior a 5 días:
SELECT `inventory_id`
	FROM `rental` 
    WHERE DATEDIFF(`return_date`, `rental_date`) > 5

-- La utilizamos para obtener los títulos de las películas alquiladas por más de 5 días
SELECT DISTINCT `film`.`title`
	FROM `rental`
		INNER JOIN `inventory` 
			ON `rental`.`inventory_id` = `inventory`.`inventory_id`
		INNER JOIN `film` 
			ON `inventory`.`film_id` = `film`.`film_id`
	WHERE `inventory`.`inventory_id` IN (SELECT `inventory`.`inventory_id`
											FROM `rental`
												WHERE DATEDIFF(`return_date`, `rental_date`) > 5)
            

/*EJERCICIO 23: Encuentra el nombre y apellido de los actores que no han actuado en ninguna película de la categoría "Horror". 
Utiliza una subconsulta para encontrar los actores que han actuado en películas de la categoría "Horror" y luego exclúyelos de la lista de actores.*/



