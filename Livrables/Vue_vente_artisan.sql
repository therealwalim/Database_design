-- Création de la vue
CREATE VIEW vision_vente_artisan
-- Notre requête SELECT
AS SELECT Artisant.ID_Artisan, Vente.ID_Vente, Vente.name_Objet, Vente.Quantite
FROM Vente
ORDER BY Artisant
WHERE Artisant IS NOT NULL
INNER JOIN Artisant ON Vente.ID_Artisan = Artisant.ID_Artisan;