-- Création de la procédure stockée pour rajouter la vente.
DELIMITER |
CREATE PROCEDURE `ajoutvente`(IN jours_vente VARCHAR(25), IN mois_divinite VARCHAR(25), IN anne_vente VARCHAR(25), IN quantite_vente VARCHAR(25), IN ID_objet VARCHAR(25), IN nom_pouvoir VARCHAR(25), IN ID_lieu VARCHAR(25), IN nom_dieu VARCHAR(25))
BEGIN
	SELECT ID FROM vente.mois WHERE Nom = mois_divinite INTO @q_id_mois;
	SELECT ID FROM vente.pouvoir WHERE Denomination = nom_pouvoir INTO @q_id_pouvoir;
	SELECT ID FROM vente.lieu WHERE Nom = ID_lieu INTO @q_id_lieu;
	SELECT ID FROM vente.typeequipement WHERE Denomination = ID_objet INTO @q_id_nom_equipement;
	SELECT ID FROM vente.divinite WHERE Nom = nom_dieu INTO @q_id_divinite;
	INSERT INTO vente.vente(Jour, ID_Mois, Annee, Quantite, ID_TypeEquipement, ID_Pouvoir, ID_Lieu,ID_Divinite) VALUES (p_jour, @q_id_mois, p_annee, p_quantite, @q_id_nom_equipement, @q_id_pouvoir, @q_id_lieu, @q_id_divinite);
END|
DELIMITER ;

-- Jour,'Mois',Année,Quantité,NomEquipement,NomPouvoir,Lieu,Divinite)
-- Exemple :
CALL ajoutvente(5,'Boédromion', 23, 200,'Arc court',"Ailes d'Icare",'Arcadie','Kronos');


