----------------------------------------------------------------------------------------------------
------------------------------------------AddOn NAMESPACE-------------------------------------------
----------------------------------------------------------------------------------------------------

local FOLDER_NAME, private = ...
local L = private.locale

----------------------------------------------------------------------------------------------------
-----------------------------------------------LOCALS-----------------------------------------------
----------------------------------------------------------------------------------------------------

local function GetMapNames(id1, id2)
    return format("%s, %s", C_Map.GetMapInfo(id1).name, C_Map.GetMapInfo(id2).name)
end

local PtoOG = L["Portal to Orgrimmar"]
local Durotar = GetMapNames(12, 1)
local PtoSW = L["Portal to Stormwind"]
local ElwynnForest = GetMapNames(13, 37)

local guildvault = L["config_guildvault"]
local mailbox = L["Mailbox"]

----------------------------------------------------------------------------------------------------
----------------------------------------------DATABASE----------------------------------------------
----------------------------------------------------------------------------------------------------

local DB = {}
private.DB = DB

DB.points = {
    [2112] = { -- Valdrakken


    -- Azure Archives Annex
    -- Cascade's Edge
    -- Fallingwater Overlook
    -- Gladiator's Refuge
    -- Little Scales Daycare
    -- The Black Market
    -- The Parting Glass
    -- The Ruby Feast
    -- The Victorious Visage



        -- The Seat of the Aspects
        [56503740] = { icon="portal", label=PtoOG, note=Durotar, faction="Horde" }, -- DONE2 , quest=60151
        [60204090] = { icon="portal", label=PtoSW, note=ElwynnForest, faction="Alliance" }, -- DONE2 , quest=60151
        [62203200] = { icon="portal", label="Seat of the Aspects" }, -- DONE2

        -- Banker
        [57505570] = { icon="banker", npc=186794 }, -- DONE2 Numernormi
        [56805780] = { icon="banker", npc=189168 }, -- DONE2 Aeoreon
        [56005510] = { icon="banker", npc=185572 }, -- DONE2 Vekkalis
        [34906060] = { icon="mail", label=mailbox }, -- DONE2
        [47605160] = { icon="mail", label=mailbox }, -- DONE2
        [55605840] = { icon="guildvault", label=guildvault }, -- DONE2


        [47204540] = { icon="innkeeper", npc=185562 }, -- DONE2 Tithris
        [48204730] = { icon="bubble", npc=188747 }, -- DONE2 Kitror

        [42605880] = { icon="auctioneer", npc=185714 }, -- DONE2 Imporigo
        [43405970] = { icon="auctioneer", npc=188661 }, -- DONE2 Expordira


        -- Juwe
        -- [34574459] = { icon="vendor", npc=64337, profession=755, picon="jewelcrafting" },
        [40606090] = { icon="trainer", npc=190094, profession=755, picon="jewelcrafting" }, -- DONE2 Tuluradormi
        -- Engineer
        [37684297] = { icon="vendor", npc=64337, profession=202, picon="engineering" },
        [38074470] = { icon="trainer", npc=64337, profession=202, picon="engineering" },

        -- Inscription
        -- [35963855] = { icon="vendor", npc=64337, profession=773, picon="inscription" },
        [38507370] = { icon="trainer", npc=185540, profession=773, picon="inscription" }, -- DONE2 Talendara
        -- [37193554] = { icon="vendor", npc=64337, profession=773, picon="inscription" },
        -- Alchemy
        -- [38873943] = { icon="vendor", npc=64337, profession=171, picon="alchemy" },
        [36407120] = { icon="trainer", npc=185545, profession=171, picon="alchemy" }, -- DONE2 Conflagosa
        -- Herbalism
        [40233828] = { icon="trainer", npc=185549, profession=182, picon="herbalism" }, -- DONE Agrikus

        -- [38653356] = { icon="anvil", npc=64337 },
        -- Mining
        [38605050] = { icon="trainer", npc=185553, profession=186, picon="mining" }, -- DONE2 Sekita the Burrower
        -- Blacksmith
        [36904700] = { icon="trainer", npc=185546, profession=164, picon="blacksmithing" }, -- DONE2 Metalshaper Kuroko
        -- Skinning
        [27905930] = { icon="trainer", npc=193846, profession=393, picon="skinning" }, -- DONE2 Ralathor the Rugged
        -- Leatherworking
        [28206240] = { icon="trainer", npc=185551, profession=165, picon="leatherworking" }, -- DONE2 Hideshaper Koruz
        [29206080] = { icon="vendor", npc=195785, profession=165, picon="leatherworking" }, -- DONE2 Samar
        -- Tailor
        [31306430] = { icon="trainer", npc=195850, profession=197, picon="tailoring" }, -- DONE2 Threadfinder Pax
        [32006700] = { icon="trainer", npc=193649, profession=197, picon="tailoring" }, -- DONE2 Threadfinder Fulafong

        -- Cooking
        -- [47492372] = { icon="vendor", npc=64337, picon="cooking" },
        [46004730] = { icon="trainer", npc=185556, picon="cooking" }, -- , profession=185 -- DONE2 Erugosa
        -- Fishing
        [43307470] = { icon="vendor", npc=187783, picon="fishing" }, -- DONE2 Pakak
        [44107450] = { icon="trainer", npc=185359, picon="fishing" }, -- , profession=356  -- DONE2 Toklo
        -- Enchanting
        [30806060] = { icon="trainer", npc=193744, profession=333, picon="enchanting" }, -- DONE2 Soragosa
        -- [47572905] = { icon="vendor", npc=64337, profession=333, picon="enchanting" },

        [31307000] = { icon="vendor", npc=195783 }, -- DONE2 Clerk Nemora
        [46607930] = { icon="stablemaster", npc=185561 }, -- DONE2 Kaestrasz
        [58203450] = { icon="vendor", npc=193015 }, -- DONE2 Unatos
        [35606750] = { icon="vendor", npc=185569 }, -- DONE2 Gohfyrr
        -- [56465451] = { icon="vendor", npc=195782 }, -- DONE Giera
        [12105680] = { icon="vendor", npc=182082 }, -- PETTRAINER DONE2 Agapanthus
        [49107990] = { icon="vendor", npc=193029 }, -- DONE2 PET SUPPLIES Lysindra
        [35105970] = { icon="vendor", npc=194057 }, -- Quartermaster Rabul -- DONE2


        [10105770] = { icon="vendor", npc=185563 }, -- DONE2 Jyhanna
        [20904860] = { icon="auctioneer", npc=189676 }, -- DONE2 Madam Goya
        [27004720] = { icon="vendor", npc=193364 }, -- DONE2 Lithragosa
        [30104820] = { icon="void", npc=185689 }, -- DONE2 Vaultkeeper Aleer
        [31104780] = { icon="transmogrifier", npc=185570 }, -- DONE2 Warpweaver Dayelis
        [30104430] = { icon="barber", npc=185571 }, -- DONE2 Kiki Goldshears
        [29706740] = { icon="vendor", npc=195788 }, -- DONE2 Nallu
        [28806470] = { icon="vendor", npc=194480 }, -- DONE2 Nomi



        [36205090] = { icon="bubble", npc=193659 }, -- ? Provisioner Thom
        [42404880] = { icon="bubble", npc=189591 }, -- ? Blacktalon Provisioner
        [33606320] = { icon="bubble", npc=185542 }, -- ? Mimzy Sprazzlerock
        [34806300] = { icon="bubble", npc=185542 }, -- ? Scaravelle
        [44206830] = { icon="bubble", npc=193321 }, -- ? Aluri
        [39405950] = { icon="bubble", npc=194418 }, -- ? Norilune
        [38203760] = { icon="bubble", npc=195768 }, -- ? Sorotis
        [34002790] = { icon="bubble", npc=187647 }, -- ? Libergo
        [35102790] = { icon="bubble", npc=189973 }, -- ? Kemora
        [61401180] = { icon="bubble", npc=189479 }, -- ? Rumiastrasza
        [68705640] = { icon="bubble", npc=189222 }, -- ? Wistera
        [72706580] = { icon="bubble", npc=192522 }, -- ? Thalendra
        [77106670] = { icon="bubble", npc=189364 }, -- ? Tender Xina
        [74006250] = { icon="bubble", npc=189197 }, -- ? Groundskeeper Kama






    }

} -- DB ENDE