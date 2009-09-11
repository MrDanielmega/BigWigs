local L = LibStub("AceLocale-3.0"):NewLocale("Big Wigs", "frFR")
if not L then return end
-- Core.lua
L["%s has been defeated"] = "%s a été vaincu(e)"     -- "<boss> has been defeated"
L["%s have been defeated"] = "%s ont été vaincu(e)s"    -- "<bosses> have been defeated"
L["Bosses"] = "Boss"
L["Options for bosses in %s."] = "Options concernant les boss |2 %s." -- "Options for bosses in <zone>"
L["Options for %s (r%d)."] = "Options concernant %s (r%d)."     -- "Options for <boss> (<revision>)"
L["Plugins"] = "Plugins"
L["Plugins handle the core features of Big Wigs - like displaying messages, timer bars, and other essential features."] = "Les plugins s'occupent des composants centraux de Big Wigs - comme l'affichage des messages, les barres temporelles, ainsi que d'autres composants essentiels."
L["Extras"] = "Extras"
L["Extras are 3rd party and bundled plugins that Big Wigs will function properly without."] = "Les extras sont des plugins tiers et incorporés dont Big Wigs peut se passer pour fonctionner correctement."
L["Active"] = "Actif"
L["Activate or deactivate this module."] = "Active ou désactive ce module."
L["Reboot"] = "Redémarrer"
L["Reboot this module."] = "Redémarre ce module."
L["Options"] = "Options"
L["Minimap icon"] = "Icône de la minicarte"
L["Toggle show/hide of the minimap icon."] = "Affiche ou non l'icône sur la minicarte."
L["Advanced"] = "Avancés"
L["You shouldn't really need to touch these options, but if you want to tweak them then you're welcome to do so!"] = "Vous n'avez normalement pas besoin de toucher à ces options, mais si vous voulez les peaufinez, n'hésitez pas !"

L["Toggles whether or not the boss module should warn about %s."] = "Autorise ou non le module de boss d'afficher des barres temporelles et/ou des alertes concernant %s."
L.bosskill = "Défaite du boss"
L.bosskill_desc = "Prévient quand le boss est vaincu."
L.berserk = "Berserk"
L.berserk_desc = "Prévient quand le boss devient fou furieux."

L["Load"] = "Charger"
L["Load All"] = "Tout charger"
L["Load all %s modules."] = "Charge tous les modules |2 %s."

L.already_registered = "|cffff0000ATTENTION :|r |cff00ff00%s|r (|cffffff00%s|r) existe déjà en tant que module dans Big Wigs, mais quelque chose essaye de l'enregistrer à nouveau. Cela signifie souvent que vous avez deux copies de ce module dans votre répertoire AddOns suite à une mauvaise mise à jour d'un gestionnaire d'addons. Il est recommandé de supprimer tous les répertoires de Big Wigs et de le réinstaller complètement."

-- Loader / Options.lua
L["|cff00ff00Module running|r"] = "|cff00ff00Module actif|r"
L["|cffeda55fClick|r to reset all running modules. |cffeda55fAlt-Click|r to disable them."] = "|cffeda55fClic gauche|r pour redémarrer les modules actifs. |cffeda55fAlt-Clic gauche|r pour les désactiver. |cffeda55fCtrl-Alt-Clic gauche|r pour désactiver complètement Big Wigs."
L["Active boss modules:"] = "Modules de boss actifs :"
L["All running modules have been reset."] = "Tous les modules actifs ont été réinitialisés."
L["Menu"] = "Menu"
L["Menu options."] = "Options du menu."

L["Big Wigs is currently disabled."] = "Big Wigs est actuellement désactivé."
L["|cffeda55fClick|r to enable."] = "|cffeda55fCliquez|r pour l'activer."
L["|cffeda55fClick|r to reset all running modules. |cffeda55fAlt-Click|r to disable them. |cffeda55fCtrl-Alt-Click|r to disable Big Wigs completely."] = "|cffeda55fCliquez|r pour réinitialiser tous les modules actifs. |cffeda55fAlt-clic gauche|r pour les désactiver. |cffeda55fCtrl-Alt-clic gauche|r pour désactiver complètement BigWigs."
L["All running modules have been disabled."] = "Tous les modules actifs ont été désactivés."
