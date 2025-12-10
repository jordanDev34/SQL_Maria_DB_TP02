-- Utilisation de la base de données compta2
use COMPTA2;

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

