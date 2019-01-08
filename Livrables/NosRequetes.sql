-- Requête 1

SELECT divinite, ID_Lieu
Count(divinite)
FROM Vente
WHERE divinite IS NOT NULL
GROUP BY divinite, ID_Lieu
ORDER BY divinite;

-- Requête 2

DECLARE @i int = 0
WHILE @i < 6
BEGIN
    SET @i = @i + 1
   SELECT objet.nom_objet AS "Objet" , SUM(AVG( Quantite_obelos.ID = '@i' * conversion_monnaie.ID ='@i' ) AS 'type_obelos.ID ='@i' ', VENTE.ID_vente 
END
FROM Vente
RIGHT JOIN Monnaie ON VENTE.ID_vente = conversion.ID_Monnaie
INNER JOIN UTILISE ON VENTE.ID_vente = UTILISE.ID_Monnaie
INNER JOIN UTILISE ON UTILISE.ID_Monnaie = UTILISE.Quantite_obelos
WHERE ID_VENTE IS NOT NULL
GROUP BY VENTE.ID_VENTE;

-- Requête 3

SELECT Utilise.ID_Province, avg(Utilise.Vente_Oo) AS "moy_Obéron d'Or", avg(Utilise.Vente_Oa) AS "moy_Obéron d'Argent", avg(Utilise.Vente_Of) AS "moy_Obéron de fer",
CASE
WHEN avg(Utilise.Vente_Oo) > avg(Utilise.Vente_Oa) AND avg(Utilise.Vente_Of)  THEN "l'or est préferé"
WHEN avg(Utilise.Vente_Oa) > avg(Utilise.Vente_Oo) AND avg(Utilise.Vente_Of)  THEN "l'argent est préferé"
WHEN avg(Utilise.Vente_Of) > avg(Utilise.Vente_Oa) AND avg(Utilise.Vente_Oo)  THEN "le fer est préferé"
ELSE "false" 
END
FROM Vente
GROUP BY Vente.ID_Lieu;

-- Requête 4

SELECT Vente.ID_lieu, COUNT(vente.ID_Vente) as `Vente total`, Moyenne.`Moyenne vente`, (COUNT(vente.ID_Vente) / Moyenne.`Moyenne vente`) as `Vente Total`

FROM vente,
(SELECT (COUNT(Vente.ID_lieu) / count(DISTINCT(Vente.ID_lieu))) as `Moyenne vente`
FROM Vente as Lieu as Moyenne
GROUP BY Vente.ID_lieu;


-- Requête 5

SELECT vente.ID_Lieu, Guerre.ID_Lieu,
COUNT(vente.ID_Vente) as `Vente total`,
COUNT(CASE WHEN LOCATE(vente.anne_vente, Guerre.ID_Lieu) != 0 THEN 1 ELSE NULL END) as `Vente en guerre`,
COUNT(CASE WHEN LOCATE(vente.anne_vente, Guerre.ID_Lieu) = 0 or ISNULL(Guerre.ID_Lieu) = 1 THEN 1 ELSE NULL END) as `Vente hors guerre`,
( COUNT(CASE WHEN LOCATE(vente.anne_vente, Guerre.ID_Lieu) != 0 THEN 1 ELSE NULL END) / ( CASE WHEN  ISNULL(Guerre.ID_Lieu) = 0 THEN ROUND( ( LENGTH(Guerre.ID_Lieu) - LENGTH( REPLACE ( Guerre.ID_Lieu, ";", "") ) ) / LENGTH(";") ) ELSE -1 END) ) AS `Ratio Vente en guerre-Années en guerre`,
( COUNT(CASE WHEN LOCATE(vente.anne_vente,Guerre.ID_Lieu) = 0 or ISNULL(Guerre.ID_Lieu) = 1 THEN 1 ELSE NULL END) / ( COUNT(DISTINCT(vente.anne_vente)) - ( CASE WHEN  ISNULL(Guerre.ID_Lieu) = 0 THEN ROUND( ( LENGTH(Guerre.ID_Lieu) - LENGTH( REPLACE ( Guerre.ID_Lieu, ";", "") ) ) / LENGTH(";") ) ELSE -1 END) ) )  as `Ratio Vente hors guerre-Années en paix`
FROM vente
INNER JOIN lieu ON lieu.ID_Province = vente.ID_Province
GROUP BY vente.ID_Province;

-- Requête 6

SELECT MAX(vente.V_Oo * Oo.M_Value + Vente.V_Oa * Oa.M_Value + Vente.V_Of * Of.M_Value ) as `Oberon de cuivre`, TeamArtisan.`Artisan(s)`, mois.ID_Divinite
FROM vente
LEFT JOIN creer ON vente.ID_Vente = creer.ID_Vente
LEFT JOIN monnaie Oo ON Oo.M_ID = "Oo"
LEFT JOIN monnaie Oa ON Oa.M_ID = "Oa"
LEFT JOIN monnaie Of ON Of.M_ID = "Of"
INNER JOIN mois ON vente.V_Mois = mois.V_Mois
INNER JOIN (    SELECT pointVente.ID_Vente as IDvente, CONCAT(MIN(creator.ID_Artisan), (CASE WHEN MAX(creator.ID_Artisan) = MIN(creator.ID_Artisan) THEN " " ELSE CONCAT( " & ", MAX(creator.ID_Artisan)) END)) as `Artisan(s)`
    FROM vente pointVente
    INNER JOIN creer creator ON creator.ID_Vente = pointVente.ID_Vente
    GROUP BY pointVente.ID_Vente) TeamArtisan ON TeamArtisan.IDvente = vente.ID_Vente
GROUP BY TeamArtisan.`Artisan(s)`

-- Requête 7

SELECT vente.ID_Vente,
CONCAT (V_Jour, ' ',V_mois, ' de l\'an ', V_Annee) AS Date, 
objet.O_Objet AS Objet, 
pouvoir.ID_Pouvoir AS Pouvoir,
CONCAT(MIN(detenir.ID_decoration), (CASE WHEN MAX(detenir.ID_decoration) = MIN(detenir.ID_decoration) THEN " " ELSE CONCAT( " & ", MAX(detenir.ID_decoration)) END)) as `Décoration(s)`,
vente.V_Oo AS `Oberon d'or`, 
vente.V_Oa AS `Oberon d'argent`, 
vente.V_Of AS `Oberon de fer`,
(vente.V_Oo * Oo.M_Value + Vente.V_Oa * Oa.M_Value + Vente.V_Of * Of.M_Value ) as `Oberon de cuivre`,
CONCAT(MIN(creer.ID_Artisan), (CASE WHEN MAX(creer.ID_Artisan) = MIN(creer.ID_Artisan) THEN " " ELSE CONCAT( " & ", MAX(creer.ID_Artisan)) END)) as `Artisan(s)`,
lieu.ID_Province AS `Dans la province de`,
ville.ID_Cite AS `Pour la ville de`,
vente.V_Quantite AS Quantité
FROM vente

LEFT JOIN objet ON vente.ID_Objet = objet.ID_Objet
LEFT JOIN pouvoir ON vente.ID_Pouvoir = pouvoir.ID_Pouvoir
LEFT JOIN detenir ON vente.ID_Vente = detenir.ID_Vente
LEFT JOIN creer ON vente.ID_Vente = creer.ID_Vente
LEFT JOIN lieu ON vente.ID_Province = lieu.ID_Province
LEFT JOIN ville ON vente.ID_Cite = ville.ID_Cite
LEFT JOIN monnaie Oo ON Oo.M_ID = "Oo"
LEFT JOIN monnaie Oa ON Oa.M_ID = "Oa"
LEFT JOIN monnaie Of ON Of.M_ID = "Of"
GROUP BY vente.ID_Vente