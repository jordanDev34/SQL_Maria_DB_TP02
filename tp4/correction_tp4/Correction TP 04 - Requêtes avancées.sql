-- Utilisation de la base de données compta2
USE COMPTA2;

-- a. Listez les articles dans l’ordre alphabétique des désignations
SELECT *
FROM article 
ORDER BY designation ASC;

-- b. Listez les articles dans l’ordre des prix du plus élevé au moins elevé
SELECT *
FROM article 
ORDER BY prix DESC;

-- c. Listez tous les articles qui sont des « boulons » et triez les résultats par ordre de prix ascendant
SELECT *
FROM article 
WHERE designation like 'Boulon%'
ORDER BY prix ASC;

-- d. Listez tous les articles dont la désignation contient le mot « sachet ».
SELECT * 
FROM article
WHERE designation LIKE '%sachet%';

-- e. Listez tous les articles dont la désignation contient le mot « sachet » indépendamment de la casse !
SELECT *
FROM article 
WHERE LOWER(designation) LIKE '%sachet%';

-- f. Listez les articles avec les informations fournisseur correspondantes.
-- Les résultats doivent être triées dans l’ordre alphabétique des fournisseurs et par article du prix le plus élevé au moins élevé.
SELECT *
FROM article, fournisseur
WHERE article.ID_FOU=fournisseur.ID
ORDER BY fournisseur.NOM ASC, article.PRIX DESC;

-- g. Listez les articles de la société « Dubois & Fils »
SELECT *
FROM article, fournisseur
WHERE article.ID_FOU=fournisseur.ID AND fournisseur.NOM='Dubois & Fils';

-- h. Calculez la moyenne des prix des articles de la société « Dubois & Fils » 
SELECT AVG(prix)
FROM article, fournisseur
WHERE article.ID_FOU=fournisseur.ID AND fournisseur.NOM='Dubois & Fils'
ORDER BY fournisseur.NOM ASC, article.PRIX DESC;

-- i. Calculez la moyenne des prix des articles de chaque fournisseur 
SELECT fournisseur.nom, AVG(prix)
FROM article, fournisseur
WHERE article.ID_FOU=fournisseur.ID
GROUP BY fournisseur.nom;

-- j. Sélectionnez tous les bons de commandes émis entre le 01/03/2019 et le 05/04/2019 à 12h00.
SELECT * 
FROM bon 
WHERE date_cmde BETWEEN '2019-03-01' AND '2019-04-05 12:00:00';

-- k. Sélectionnez les divers bons de commande qui contiennent des boulons
SELECT DISTINCT bon.NUMERO 
FROM bon, compo, article 
WHERE bon.ID=compo.ID_BON AND compo.ID_ART=article.ID
AND designation like 'Boulon%';

-- l. Sélectionnez les divers bons de commande qui contiennent des boulons avec le nom du fournisseur associé.
SELECT DISTINCT bon.NUMERO, fournisseur.nom 
FROM bon, compo, article, fournisseur 
WHERE bon.ID=compo.ID_BON AND bon.ID_FOU=fournisseur.ID
AND compo.ID_ART=article.ID
AND designation like 'Boulon%';


-- m. Calculez le prix total de chaque bon de commande
-- Requête avec uniquement les bons de commandes ayant au moins un article :
select id_bon, sum(qte*prix) 
from bon, compo, article 
where bon.ID=compo.ID_BON and compo.ID_ART=article.ID
GROUP BY id_bon;


-- Requête qui inclut également le bon de commandes qui n’a pas d’article – dans ce cas SUM affiche NULL :
select bon.id, sum(qte*prix) 
from bon
LEFT JOIN (compo INNER JOIN article ON compo.ID_ART=article.ID) ON bon.ID=compo.ID_BON 
GROUP BY bon.id;


-- Requête qui inclut également le bon de commandes qui n’a pas d’article – dans ce cas SUM affiche 0 :
select bon.id, COALESCE(sum(qte*prix),0) 
from bon
LEFT JOIN (compo INNER JOIN article ON compo.ID_ART=article.ID) ON bon.ID=compo.ID_BON 
GROUP BY bon.id;


-- n. Comptez le nombre d’articles de chaque bon de commande
SELECT id_bon, sum(qte)
FROM bon, compo, article 
WHERE bon.ID=compo.ID_BON AND compo.ID_ART=article.ID
GROUP BY id_bon;

-- o. Affichez les numéros de bons de commande qui contiennent plus de 25 articles et affichez le nombre d’articles de chacun de ces bons de commande 
SELECT id_bon, SUM(qte)
FROM bon, compo, article 
WHERE bon.ID=compo.ID_BON AND compo.ID_ART=article.ID
GROUP BY id_bon 
HAVING SUM(qte)>25;

-- p. Calculez le coût total des commandes effectuées sur le mois d’avril 
SELECT sum(qte*prix) 
FROM bon, compo, article 
WHERE bon.ID=compo.ID_BON and compo.ID_ART=article.ID
AND month(date_cmde)=4;