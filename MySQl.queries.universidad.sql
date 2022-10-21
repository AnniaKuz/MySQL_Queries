USE universidad;

-- 1.1. Retorna un llistat amb el primer cognom, segon cognom i el nom de tots els/les alumnes.
-- El llistat haurà d'estar ordenat alfabèticament de menor a major pel 1r, 2n cognom i nom.
SELECT apellido1, apellido2, nombre FROM universidad.persona WHERE tipo = 'alumno' ORDER BY apellido1, apellido2, nombre; 

-- 2. Esbrina el nom i els dos cognoms dels alumnes 
-- que no han donat d'alta el seu número de telèfon en la base de dades.
SELECT nombre, apellido1, apellido2 FROM universidad.persona WHERE tipo = 'alumno' AND telefono IS NULL; 

-- 3. Retorna el llistat dels alumnes que van néixer en 1999.
SELECT * FROM universidad.persona WHERE tipo = 'alumno' AND fecha_nacimiento BETWEEN '1999-01-01' AND '1999-12-31'; 

-- 4. Retorna el llistat de professors/es que no han donat d'alta el seu número de telèfon
-- en la base de dades i a més el seu NIF acaba en K.
SELECT * FROM universidad.persona WHERE tipo = 'profesor' AND telefono is NULL AND nif LIKE '%K';

-- 5. Retorna el llistat de les assignatures que s'imparteixen en el primer quadrimestre,
-- en el tercer curs del grau que té l'identificador 7.
SELECT * FROM universidad.asignatura WHERE id_grado = 7 AND cuatrimestre = 1 AND curso = 3;

-- 6. Retorna un llistat dels professors/es juntament amb el nom del departament 
-- al qual estan vinculats. El llistat ha de retornar quatre columnes, 1r cognom,
-- 2n cognom, nom i nom del departament.
-- El resultat estarà ordenat alfabèticament de menor a major pels cognoms i el nom.
SELECT apellido1, apellido2, per.nombre, dep.nombre AS 'departamento' FROM universidad.persona per JOIN universidad.profesor pro ON per.id = pro.id_profesor JOIN universidad.departamento dep ON pro.id_departamento = dep.id ORDER BY apellido1, apellido2, per.nombre;

-- 7. Retorna un llistat amb el nom de les assignatures, any d'inici 
-- i any de fi del curs escolar de l'alumne/a amb NIF 26902806M.
SELECT asi.nombre, c.anyo_inicio, c.anyo_fin FROM universidad.alumno_se_matricula_asignatura mat JOIN universidad.asignatura asi ON mat.id_asignatura = asi.id JOIN universidad.curso_escolar c ON mat.id_curso_escolar = c.id JOIN universidad.persona per ON mat.id_alumno = per.id WHERE  nif = '26902806M';

-- 8. Retorna un llistat amb el nom de tots els departaments que tenen professors/es
-- que imparteixen alguna assignatura en el Grau en Enginyeria Informàtica (Pla 2015).
SELECT DISTINCT dep.nombre FROM universidad.departamento dep JOIN universidad.profesor pro ON dep.id = pro.id_departamento JOIN universidad.asignatura asi ON pro.id_profesor = asi.id_profesor JOIN universidad.grado gr ON asi.id_grado = gr.id WHERE gr.nombre = 'Grado en Ingeniería Informática (Plan 2015)';

-- 9. Retorna un llistat amb tots els alumnes que s'han matriculat 
-- en alguna assignatura durant el curs escolar 2018/2019.
SELECT DISTINCT per.* FROM universidad.persona per JOIN universidad.alumno_se_matricula_asignatura mat ON per.id = mat.id_alumno JOIN universidad.curso_escolar c ON mat.id_curso_escolar = c.id WHERE anyo_inicio = '2018' AND anyo_fin = '2019';

-- Resol les 6 següents consultes utilitzant les clàusules LEFT JOIN i RIGHT JOIN.

-- Retorna un llistat amb els noms de tots els professors/es i els departaments 
-- que tenen vinculats. El llistat també ha de mostrar aquells professors/es
-- que no tenen cap departament associat. El llistat ha de retornar quatre columnes,
-- nom del departament, primer cognom, segon cognom i nom del professor/a.
-- El resultat estarà ordenat alfabèticament de menor a major pel nom del departament,
-- cognoms i el nom.
SELECT dep.nombre AS 'departamento', apellido1, apellido2, per.nombre FROM universidad.profesor pro LEFT JOIN universidad.departamento dep ON pro.id_departamento = dep.id RIGHT JOIN universidad.persona per ON pro.id_profesor = per.id WHERE tipo = 'profesor' ORDER BY departamento, per.apellido1, per.apellido2, per.nombre;

-- 2.Retorna un llistat amb els professors/es que no estan associats a un departament.
SELECT * FROM universidad.persona per LEFT JOIN universidad.profesor pro ON per.id = pro.id_profesor WHERE tipo = 'profesor' AND id_departamento IS NULL;

-- 3.Retorna un llistat amb els departaments que no tenen professors/es associats.
SELECT id, nombre FROM universidad.departamento dep LEFT JOIN universidad.profesor pro ON dep.id = pro.id_departamento WHERE id_profesor is NULL;

-- 4.Retorna un llistat amb els professors/es que no imparteixen cap assignatura.
SELECT per.* FROM universidad.persona per LEFT JOIN universidad.asignatura asi ON per.id = asi.id_profesor WHERE per.tipo = 'profesor' AND asi.id_profesor is NULL;

-- Retorna un llistat amb les assignatures que no tenen un professor/a assignat.
SELECT * FROM universidad.asignatura WHERE id_profesor is NULL;

-- 6.Retorna un llistat amb tots els departaments 
-- que no han impartit assignatures en cap curs escolar.
SELECT dep.* FROM universidad.departamento dep left JOIN universidad.profesor pro ON dep.id = pro.id_departamento LEFT JOIN universidad.asignatura asi ON pro.id_profesor = asi.id_profesor LEFT JOIN universidad.alumno_se_matricula_asignatura mat ON mat.id_asignatura = asi.id GROUP BY dep.id HAVING count(mat.id_asignatura)=0;

-- 1. Retorna el nombre total d'alumnes que hi ha.
SELECT COUNT(id) AS 'numero_alumnos' FROM universidad.persona WHERE tipo = 'alumno';

-- 2. Calcula quants alumnes van néixer en 1999.
SELECT COUNT(id) AS 'numero_alumnos' FROM universidad.persona WHERE tipo = 'alumno' AND fecha_nacimiento BETWEEN '1999-01-01' AND '1999-12-31';

-- 3. Calcula quants professors/es hi ha en cada departament. El resultat només ha de mostrar 
-- dues columnes, una amb el nom del departament i una altra amb el nombre de professors/es 
-- que hi ha en aquest departament. El resultat només ha d'incloure els departaments
-- que tenen professors/es associats i haurà d'estar 
-- ordenat de major a menor pel nombre de professors/es.
SELECT dep.nombre,count(id_profesor) as 'number_profesors' FROM universidad.departamento dep JOIN universidad.profesor pro ON dep.id = pro.id_departamento GROUP BY dep.id ORDER BY number_profesors DESC;

-- 4. Retorna un llistat amb tots els departaments i el nombre de professors/es que hi ha 
-- en cadascun d'ells. Tingui en compte que poden existir departaments que no tenen
-- professors/es associats. Aquests departaments també han d'aparèixer en el llistat.
SELECT dep.nombre,count(id_profesor) as 'number_profesors' FROM universidad.departamento dep LEFT  JOIN universidad.profesor pro ON dep.id = pro.id_departamento GROUP BY dep.id;

-- 5. Retorna un llistat amb el nom de tots els graus existents en la base de dades 
-- i el nombre d'assignatures que té cadascun. Tingues en compte que poden existir graus 
-- que no tenen assignatures associades. Aquests graus també han d'aparèixer en el llistat. 
-- El resultat haurà d'estar ordenat de major a menor pel nombre d'assignatures.
SELECT gr.nombre, count(asi.id) AS 'numero_asignaturas' FROM universidad.grado gr LEFT JOIN universidad.asignatura asi ON gr.id = asi.id_grado GROUP BY gr.nombre ORDER BY numero_asignaturas DESC; 

-- 6. Retorna un llistat amb el nom de tots els graus existents en la base de dades 
-- i el nombre d'assignatures que té cadascun, dels graus 
-- que tinguin més de 40 assignatures associades.
SELECT gr.nombre, COUNT(asi.id) AS 'numero_asignaturas'
FROM universidad.grado gr JOIN universidad.asignatura asi ON gr.id = asi.id_grado GROUP BY gr.nombre HAVING numero_asignaturas > 40;


-- 7. Retorna un llistat que mostri el nom dels graus i la suma del nombre total de crèdits 
-- que hi ha per a cada tipus d'assignatura. El resultat ha de tenir tres columnes:
-- nom del grau, tipus d'assignatura i la suma dels crèdits de totes les assignatures 
-- que hi ha d'aquest tipus.
SELECT gr.nombre,asi.tipo, sum(asi.creditos) as 'total_creditos' FROM  universidad.asignatura asi LEFT JOIN universidad.grado gr ON asi.id_grado = gr.id GROUP BY gr.id, asi.tipo ORDER BY  gr.id, total_creditos DESC;


-- 8. Retorna un llistat que mostri quants alumnes s'han matriculat d'alguna assignatura 
-- en cadascun dels cursos escolars. El resultat haurà de mostrar dues columnes,
--  una columna amb l'any d'inici del curs escolar i una altra amb el nombre 
-- d'alumnes matriculats.
SELECT c.anyo_inicio, count(DISTINCT mat.id_alumno) as number_students FROM curso_escolar cLEFT JOIN alumno_se_matricula_asignatura mat ON c.id=mat.id_curso_escolar GROUP BY c.id;

-- 9. Retorna un llistat amb el nombre d'assignatures que imparteix cada professor/a.
-- El llistat ha de tenir en compte aquells professors/es que no imparteixen cap assignatura. 
-- El resultat mostrarà cinc columnes: id, nom, primer cognom, segon cognom i nombre 
-- d'assignatures. El resultat estarà ordenat de major a menor pel nombre d'assignatures.
SELECT per.id, per.nombre, per.apellido1, per.apellido2, count(asi.id) AS 'numero_asignaturas' FROM universidad.persona per LEFT JOIN universidad.asignatura asi ON per.id = asi.id_profesor WHERE per.tipo = 'profesor' GROUP BY per.id ORDER BY numero_asignaturas DESC;

-- 10. Retorna totes les dades de l'alumne/a més jove.
SELECT * FROM universidad.persona WHERE tipo = 'alumno' ORDER BY fecha_nacimiento DESC LIMIT 1;

-- 11. Retorna un llistat amb els professors/es
-- que tenen un departament associat i que no imparteixen cap assignatura.
SELECT per.* FROM universidad.persona per LEFT JOIN universidad.profesor pro ON per.id = pro.id_profesor LEFT JOIN universidad.asignatura asi ON pro.id_profesor = asi.id_profesor WHERE per.tipo = 'profesor' AND asi.id IS NULL;