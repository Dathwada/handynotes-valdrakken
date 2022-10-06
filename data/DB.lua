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
        [56603821] = { icon="portal", label=PtoOG, note=Durotar, faction="Horde" }, -- DONE3 , quest=?, level=?
        [59834172] = { icon="portal", label=PtoSW, note=ElwynnForest, faction="Alliance" }, -- DONE3 , quest=?, level=?
        [61963208] = { icon="tpplatform", label=L["Teleport to Seat of the Aspects"], level=64 }, -- DONE3

        -- Banker
        [61085510] = { icon="banker", npc=186794 }, -- DONE3 Numernormi
        [60575701] = { icon="banker", npc=189168 }, -- DONE3 Aeoreon
        [60015392] = { icon="banker", npc=185572 }, -- DONE3 Vekkalis
        [58225436] = { icon="guildvault", label=guildvault }, -- DONE3

        [35455968] = { icon="mail", label=mailbox }, -- DONE3
        [37654949] = { icon="mail", label=mailbox }, -- DONE3
        [45565906] = { icon="mail", label=mailbox }, -- DONE3
        [48445104] = { icon="mail", label=mailbox }, -- DONE3


        [47444620] = { icon="innkeeper", npc=185562 }, -- DONE3 Tithris
        [46934566] = { icon="vendor", npc=188747 }, -- DONE3 Kitror

        [42365930] = { icon="auctioneer", npc=185714, sublabel=L["config_auctioneer"] }, -- DONE3 Imporigo
        [42405995] = { icon="auctioneer", npc=197912, sublabel=L["config_auctioneer"] }, -- DONE3 Antiqdormi
        [42626047] = { icon="auctioneer", npc=188661, sublabel=L["config_auctioneer"] }, -- DONE3 Expordira

        -- Juwe
        [39066180] = { icon="vendor", npc=198586, profession=755, picon="jewelcrafting" }, -- DONE3 Shakey Flatlap
        [40786113] = { icon="trainer", npc=190094, profession=755, picon="jewelcrafting" }, -- DONE3 Tuluradormi
        -- Engineer
        [41514881] = { icon="vendor", npc=198580, profession=202, picon="engineering" }, -- DONE3 Kognir
        [42244863] = { icon="trainer", npc=185548, profession=202, picon="engineering" }, -- DONE3 Clinkyclick Shatterboom
        -- Alchemy and Inscription
        [36006796] = { icon="vendor", npc=185569 }, -- DONE3 Gohfyrr
        -- Alchemy
        [60811741] = { icon="vendor", npc=198438, profession=171, picon="alchemy" }, -- DONE3 Gerdener Rafalsia
        [36387171] = { icon="trainer", npc=185545, profession=171, picon="alchemy" }, -- DONE3 Conflago
        -- Inscription
        [38847339] = { icon="trainer", npc=185540, profession=773, picon="inscription" }, -- DONE3 Talendara
        -- Herbalism
        [37376687] = { icon="trainer", npc=185549, profession=182, picon="herbalism" }, -- DONE3 Agrikus
        -- Mining
        [38875149] = { icon="trainer", npc=185553, profession=186, picon="mining" }, -- DONE3 Sekita the Burrower
        -- Blacksmith
        [36565063] = { icon="anvil", npc=193659, profession=164, picon="blacksmithing" }, -- DONE3 Provisioner Thom
        [36944709] = { icon="trainer", npc=185546, profession=164, picon="blacksmithing" }, -- DONE3 Metalshaper Kuroko
        -- Skinning
        [28536036] = { icon="trainer", npc=193846, profession=393, picon="skinning" }, -- DONE3 Ralathor the Rugged
        -- Leatherworking
        [28816099] = { icon="anvil", npc=195785, profession=165, picon="leatherworking" }, -- DONE3 Samar
        [28776236] = { icon="anvil", npc=196960, profession=165, picon="leatherworking" }, -- DONE3 Nehmeh
        [28526132] = { icon="trainer", npc=185551, profession=165, picon="leatherworking" }, -- DONE3 Hideshaper Koruz
        -- Tailor
        [32126626] = { icon="trainer", npc=195850, profession=197, picon="tailoring" }, -- DONE3 Threadfinder Pax
        [31966720] = { icon="trainer", npc=193649, profession=197, picon="tailoring" }, -- DONE3 Threadfinder Fulafong
        -- Cooking, profession=185
        [46464620] = { icon="trainer", npc=185556, picon="cooking" }, -- DONE3 Erugosa
        -- Fishing, profession=356
        [43477500] = { icon="vendor", npc=187783, picon="fishing" }, -- DONE3 Pakak
        [44837473] = { icon="trainer", npc=185359, picon="fishing" }, -- DONE3 Toklo
        -- Enchanting
        [30806081] = { icon="vendor", npc=198587, profession=333, picon="enchanting" }, -- DONE3 Andoris
        [31066137] = { icon="trainer", npc=193744, profession=333, picon="enchanting" }, -- DONE3 Soragosa

        [26735732] = { icon="vendor", npc=196805 }, -- DONE3 Ryen Levenson
        [27264736] = { icon="trainer", npc=193364 }, -- DONE3 Lithragosa DRAGONRIDING
        [25835076] = { icon="trainer", npc=190839 }, -- DONE3 Glensera TRANSFORMATION
        [25045064] = { icon="rostrum", label=L["Rostrum of Transformation"] }, -- DONE3

        [35954970] = { icon="vendor", npc=195770 }, -- DONE3 Armorsmith Terisk
        [36165194] = { icon="vendor", npc=195769 }, -- DONE3 Weaponsmith Koref

        [43374251] = { icon="anvil", npc=196191 }, -- DONE3 Malicia
        [43064241] = { icon="vendor", npc=197553 }, --DONE3 Fieldmaster Emberath

        [38093772] = { icon="vendor", npc=196516 }, -- DONE3 Mythressa
        [38443674] = { icon="vendor", npc=196598 }, -- DONE3 Rethelshi

        [46677895] = { icon="stablemaster", npc=185561 }, -- DONE3 Kaestrasz
        [58173499] = { icon="vendor", npc=193015 }, -- DONE3 Unatos

        [57482359] = { icon="vendor", npc=198441 }, -- DONE3 Gardener Cereus

        [25563355] = { icon="anvil", npc=196637 }, -- DONE3 Tethalash
        [22623065] = { icon="innkeeper", npc=196640 }, -- DONE3 Yzinia INNKEEPER BUGGY
        [26064004] = { icon="vendor", npc=195768 }, -- DONE 3 Sorotis
        -- [34833584] = { icon="vendor", npc=187788 }, -- DONE3 Tukkuttok WALKS AROUND

        -- [12895714] = { icon="vendor", npc=182082 }, -- DONE3 Agapanthus
        [48298294] = { icon="vendor", npc=193029 }, -- DONE3 Lysindra PET SUPPLIES
        [35425910] = { icon="vendor", npc=194057 }, -- DONE3 Rabul

        [10425826] = { icon="vendor", npc=185563, sublabel=L["Expert Pet Trainer"] }, -- DONE3 Jyhanna

        [30354590] = { icon="barber", label=L["Visage of True Self"] }, -- DONE3

        -- [20254911] = { icon="auctioneer", npc=189676 }, -- DONE3 Madam Goya
        -- [19215030] = { icon="auctioneer", npc=189644 }, -- DONE3 MS. Xiulan

        [73975645] = { icon="void", npc=185689 }, -- DONE3 Vaultkeeper Aleer
        [74485605] = { icon="transmogrifier", npc=185570 }, -- DONE3 Warpweaver Dayelis
        [72504716] = { icon="innkeeper", npc=197574 }, -- DONE3 Mairadormi

        [31626932] = { icon="vendor", npc=195782 }, -- DONE3 Giera
        [31286972] = { icon="vendor", npc=195783 }, -- DONE3 Clerk Nemora
        [29886737] = { icon="vendor", npc=195788 }, -- DONE3 Nallu
        [28826631] = { icon="vendor", npc=196975 }, -- DONE3 Tonko Trickybits
        [29006488] = { icon="vendor", npc=196729 }, -- DONE3 Gorgonzormu
        -- [28796431] = { icon="bubble", npc=194480 }, -- DONE3 Nomi

        [36436280] = { icon="vendor", npc=191000 }, -- DONE3 Dothenos

        [44046794] = { icon="flightmaster", npc=193321 }, -- DONE3 Aluri
        [35056314] = { icon="bubble", npc=190084 }, -- DONE3 Scaravelle CRAFTING ORDERS

        -- [39325386] = { icon="bubble", npc=189535 }, -- ? Blacktalon Watcher
        -- [33606320] = { icon="bubble", npc=185542 }, -- ? Mimzy Sprazzlerock
        -- [39405950] = { icon="bubble", npc=194418 }, -- ? Norilune
        -- [38203760] = { icon="bubble", npc=195768 }, -- ? Sorotis
        -- [34002790] = { icon="bubble", npc=187647 }, -- ? Libergo
        -- [35102790] = { icon="bubble", npc=189973 }, -- ? Kemora
        -- [61401180] = { icon="bubble", npc=189479 }, -- ? Rumiastrasza
        -- [68705640] = { icon="bubble", npc=189222 }, -- ? Wistera
        -- [72706580] = { icon="bubble", npc=192522 }, -- ? Thalendra
        -- [77106670] = { icon="bubble", npc=189364 }, -- ? Tender Xina
        -- [74006250] = { icon="bubble", npc=189197 }, -- ? Groundskeeper Kama






    }

} -- DB ENDE