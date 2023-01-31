local L = LibStub("AceLocale-3.0"):NewLocale("HandyNotes_Valdrakken", "frFR", false, true)

if not L then return end
----------------------------------------------------------------------------------------------------
-----------------------------------------------CONFIG-----------------------------------------------
-- French localization by Zickwik ( https://www.curseforge.com/members/zickwik ) & Tulsow

if L then

L["config_plugin_name"] = "Valdrakken"
L["config_plugin_desc"] = "Affiche les emplacements des PNJ et des points d'intérêt à Valdrakken sur la carte du monde et la mini-carte."

L["config_tab_general"] = "Général"
L["config_tab_scale_alpha"] = "Échelle / Transparence"
--L["config_scale_alpha_desc"] = "PH"
L["config_icon_scale"] = "Échelles des icônes"
L["config_icon_scale_desc"] = "Taille des icônes"
L["config_icon_alpha"] = "Transparence des icônes"
L["config_icon_alpha_desc"] = "Modifie la transparence des icônes"
L["config_what_to_display"] = "Que faut-il afficher ?"
L["config_what_to_display_desc"] = "Ces paramètres contrôlent le type d'icônes à afficher."

L["config_auctioneer"] = "Commissaire-priseur"
L["config_auctioneer_desc"] = "Afficher l'emplacement du commissaire-priseur."

L["config_banker"] = "Banquier"
L["config_banker_desc"] = "Afficher les emplacements des banquiers."

L["config_barber"] = "Coiffeur"
L["config_barber_desc"] = "Afficher l'emplacement du coiffeur."

L["config_craftingorders"] = "Marché d'artisanat"
L["config_craftingorders_desc"] = "Afficher l'emplcacement du marché d'artisanat."

L["config_flightmaster"] = "Maître de vol"
L["config_flightmaster_desc"] = "Afficher l'emplacement du maître de vol."

L["config_guildvault"] = "Coffre-fort de Guilde"
L["config_guildvault_desc"] = "Afficher l'emplacement du coffre-fort de guilde."

L["config_innkeeper"] = "Aubergiste"
L["config_innkeeper_desc"] = "Afficher les emplacements des aubergistes."

L["config_mail"] = "Boîte aux lettres"
L["config_mail_desc"] = "Afficher les emplacements des boîtes aux lettres."

L["config_portal"] = "Portail"
L["config_portal_desc"] = "Afficher les emplacements des portails."

L["config_portaltrainer"] = "Maître des portails"
L["config_portaltrainer_desc"] = "Afficher l'emplacement du maître des portails pour les Mages."

L["config_tpplatform"] = "Plateforme de téléportation"
L["config_tpplatform_desc"] = "Afficher l'emplacement de la plateforme de téléportation."

L["config_travelguide_note"] = "|cFFFF0000*Déjà actif via HandyNotes: TravelGuide.|r"

L["config_reforge"] = "Renforceur d'Armure"
L["config_reforge_desc"] = "Afficher l'emplacement du renforceur d'armure."

L["config_rostrum"] = "Tribune de transformation"
L["config_rostrum_desc"] = "Afficher l'emplacement de la Tribune de transformation."

L["config_stablemaster"] = "Maître des écuries"
L["config_stablemaster_desc"] = "Afficher l'emplacement du maître des écuries."

L["config_trainer"] = "Maîtres des Métiers"
L["config_trainer_desc"] = "Afficher les emplacements des maîtres des métiers."

L["config_transmogrifier"] = "Transmogrifieur"
L["config_transmogrifier_desc"] = "Afficher l'emplacement du tranmogrifieur."

L["config_vendor"] = "Marchand"
L["config_vendor_desc"] = "Afficher les emplacements des marchands."

L["config_void"] = "Chambre du Vide"
L["config_void_desc"] = "Afficher l'emplacement de la Chambre du Vide."

L["config_others"] = "Autres"
L["config_others_desc"] = "Afficher tous les autres points d'intérêt."

L["config_onlymytrainers"] = "Afficher uniquement les maîtres et vendeurs pour mes métiers"
L["config_onlymytrainers_desc"] = [[
Affecte uniquement les maîtres et vendeurs de mes métiers principaux.

|cFFFF0000NOTE: Actif uniquement lorsque deux métiers principaux sont appris.|r
]]

L["config_fmaster_waypoint"] = "Point de passage du maître de vol"
L["config_fmaster_waypoint_desc"] = "Définit automatiquement un point de passage vers le maître de vol si vous entrez dans l'Anneau de Transfert."

L["config_easy_waypoints"] = "Points de Passage Facile"
L["config_easy_waypoints_desc"] = "Active la création de points de passage simplifié.\nClic droit permet de définir un point de passage et Ctrl + Clic droit affichera plus d'options."

L["config_waypoint_dropdown"] = "Sélectionner"
L["config_waypoint_dropdown_desc"] = "Sélectionner comment le point de passage doit être créé."
L["Blizzard"] = true
L["TomTom"] = true
L["Both"] = "Les deux"

L["config_picons"] = "Afficher les icônes de profession pour :"
L["config_picons_vendor_desc"] = "Afficher les icônes des professions au lieu de celles des vendeurs."
L["config_picons_trainer_desc"] = "Afficher les îcones de profession au lieu de celles des maîtres de métiers."
L["config_use_old_picons"] = "Afficher les anciennes icônes de profession"
L["config_use_old_picons_desc"] = "Afficher les anciennes icônes de profession au lieu des nouvelles (avant Dragonflight)."

L["config_restore_nodes"] = "Restaurer les nœuds cachés"
L["config_restore_nodes_desc"] = "Restaurer tous les nœuds masqués via le menu contextuel."
L["config_restore_nodes_print"] = "Tous les nœuds cachés ont été restaurés"

----------------------------------------------------------------------------------------------------
-------------------------------------------------DEV------------------------------------------------
----------------------------------------------------------------------------------------------------

L["dev_config_tab"] = "DEV"

L["dev_config_force_nodes"] = "Forcer les nœuds"
L["dev_config_force_nodes_desc"] = "Force l'affichage de tous les nœuds indépendamment de la classe, de la faction ou de la congrégation."

L["dev_config_show_prints"] = "Afficher print()"
L["dev_config_show_prints_desc"] = "Afficher les messages print() dans la fenêtre de discussion."

----------------------------------------------------------------------------------------------------
-----------------------------------------------HANDLER----------------------------------------------
----------------------------------------------------------------------------------------------------

--==========================================CONTEXT_MENU==========================================--

L["handler_context_menu_addon_name"] = "HandyNotes: Valdrakken"
L["handler_context_menu_add_tomtom"] = "Ajouter à TomTom"
L['handler_context_menu_add_map_pin'] = "Définir un point de passage sur la carte"
L["handler_context_menu_hide_node"] = "Masquer ce nœud"

--============================================TOOLTIPS============================================--

L["handler_tooltip_requires"] = "Requiert"
L["handler_tooltip_requires_level"] = "Requiert au moins un niveau de joueur"
L["handler_tooltip_data"] = "RÉCUPÉRATION DES DONNÉES..."
L["handler_tooltip_quest"] = "Débloqué avec la quête"

----------------------------------------------------------------------------------------------------
----------------------------------------------DATABASE----------------------------------------------
----------------------------------------------------------------------------------------------------

L["Crafting Orders"] = "Commandes d'artisanat"
L["Mailbox"] = "Boite aux lettres"
L["Portal to Dalaran"] = "Portail vers Dalaran"
L["Portal to Jade Forest"] = "Portail vers la forêt de Jade"
L["Portal to Orgrimmar"] = "Portail vers Orgrimmar"
L["Portal to Shadowmoon Valley"] = "Portail vers la vallée d'Ombrelune"
L["Portal to Stormwind"] = "Portail vers Hurlevent"
L["Rostrum of Transformation"] = "Tribune de transformation"
L["Teleport to Seat of the Aspects"] = "Se téléporter vers le Siège des Aspects"
L["Visage of True Self"] = true

end
