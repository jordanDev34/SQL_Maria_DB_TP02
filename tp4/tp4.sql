USE COMPTA2;

-- a. Listez les articles dans l'ordre alphabétique des désignations
SELECT * 
FROM article 
ORDER BY designation ASC;

-- b. Listez les articles dans l'ordre des prix du plus élevé au moins élevé
SELECT * 
FROM article 
ORDER BY prix DESC;

-- c. Listez tous les articles qui sont des « boulons » et triez les résultats par ordre de prix ascendant
SELECT * FROM article WHERE designation = 'boulon' ORDER BY prix ASC;

-- d. Listez tous les articles dont la désignation contient le mot « sachet ».
SELECT * 
FROM article 
WHERE designation LIKE '%sachet%';

-- e. Listez tous les articles dont la désignation contient le mot « sachet » indépendamment de la casse !
SELECT * 
FROM article 
WHERE LOWER(designation) LIKE '%sachet%';

-- f. Listez les articles avec les informations fournisseur correspondantes. 
-- Les résultats doivent être triées dans l'ordre alphabétique des fournisseurs et par article du prix le plus élevé au moins élevé.
SELECT * 
FROM article, fournisseur 
WHERE article.ID_FOU=fournisseur.ID 
ORDER BY fournisseur.NOM ASC, article.PRIX DESC;

-- g. Listez les articles de la société « Dubois & Fils »
SELECT * 
FROM article, fournisseur 
WHERE article.ID_FOU=fournisseur.ID AND fournisseur.NOM='Dubois & Fils'

-- h. Calculez la moyenne des prix des articles de la société « Dubois & Fils »
SELECT AVG(prix)
FROM article, fournisseur
WHERE article.ID_FOU=fournisseur.ID AND fournisseur.NOM='Dubois & Fils'
ORDER BY fournisseur.NOM ASC, article.PRIX DESC;

-- i. Calculez la moyenne des prix des articles de chaque fournisseur
SELECT fournisseur.NOM, AVG(prix)
FROM article, fournisseur
WHERE article.ID_FOU=fournisseur.ID
GROUP BY fournisseur.NOM

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
SELECT id_bon, SUM(qte*prix) 
FROM bon, compo, article 
WHERE bon.ID=compo.ID_BON AND compo.ID_ART=article.ID
GROUP BY id_bon

-- n. Comptez le nombre d'articles de chaque bon de commande
SELECT id_bon, sum(qte)
FROM bon, compo, article 
WHERE bon.ID=compo.ID_BON AND compo.ID_ART=article.ID
GROUP BY id_bon

-- o. Affichez les numéros de bons de commande qui contiennent plus de 25 articles et affichez le nombre d'articles de chacun de ces bons de commande
SELECT id_bon, SUM(qte)
FROM bon, compo, article 
WHERE bon.ID=compo.ID_BON AND compo.ID_ART=article.ID
GROUP BY id_bon 
HAVING SUM(qte)>25

-- p. Calculez le coût total des commandes effectuées sur le mois d'avril
SELECT SUM(qte*prix) 
FROM bon, compo, article 
WHERE bon.ID=compo.ID_BON AND compo.ID_ART=article.ID
AND MONTH(date_cmde)=4

-- a. Sélectionnez les articles qui ont une désignation identique mais des fournisseurs différents (indice : réaliser une auto jointure i.e. de la table avec elle-même)
SELECT * 
FROM article a, article b
WHERE a.DESIGNATION=b.DESIGNATION AND a.ID_FOU!=b.ID_FOU;

-- b.	Calculez les dépenses en commandes mois par mois (indice : utilisation des fonctions MONTH et YEAR)
SELECT year(date_cmde), month(date_cmde), sum(qte*prix) 
FROM bon, compo, article 
WHERE bon.ID=compo.ID_BON and compo.ID_ART=article.ID
GROUP BY year(date_cmde), month(date_cmde);

-- c.	Sélectionnez les bons de commandes sans article (indice : utilisation de EXISTS)
SELECT * FROM bon
WHERE bon.ID NOT IN (SELECT Bon.id FROM BON, COMPO
                  WHERE compo.ID_BON = bon.id);

-- Ou avec EXISTS
SELECT * FROM bon a
WHERE NOT EXISTS (SELECT id_bon FROM COMPO WHERE id_bon=a.id);


-- d.	Calculez le prix moyen des bons de commande par fournisseur.
SELECT BON.id_fou, avg(virtual_table.cout) 
FROM BON, ( select bon.id, sum(qte*prix) as cout
            from bon, compo, article 
            where bon.ID=compo.ID_BON and compo.ID_ART=article.ID
            GROUP BY bon.id) as virtual_table 
WHERE BON.id= virtual_table.id
GROUP BY BON.id_fou ;
