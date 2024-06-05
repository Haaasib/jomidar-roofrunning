Config = {}

Config.CoolDown     =  3600  -- sec

Config.MiniTime     =  1000

Config.Gridx        =  2

Config.Gridy        =  4

Config.spawnedProps = {}


Config.RoofRunning  = {
    ["acprops"] = {
        [1] =  {model = "prop_aircon_s_04a", coords = vector3(-586.45, -282.29, 48.32)},
        [2] =  {model = "prop_aircon_s_04a", coords = vector3(-603.92, -276.48, 49.52)},
        [3] =  {model = "prop_aircon_s_04a", coords = vector3(-597.04, -271.93, 48.52)},
        [4] =  {model = "prop_aircon_s_04a", coords = vector3(-613.37, -254.02, 51.31)},
        [5] =  {model = "prop_aircon_s_04a", coords = vector3(-619.53, -264.32, 50.3)},
        [6] =  {model = "prop_aircon_s_04a", coords = vector3(-621.86, -241.8, 54.66)},
        [7] =  {model = "prop_aircon_s_04a", coords = vector3(-640.3, -222.79, 51.54)},
        [8] =  {model = "prop_aircon_m_02", coords = vector3(-629.29, -212.99, 53.54)}, 
    },
    ["Items"] = {
        [1] = {item = "ac_broken", amount = 1},
        [2] = {item = "ac_compressor", amount = 1},
        [3] = {item = "ac", amount = 1},
        [4] = {item = "ac_vent", amount = 1},
    },

    -- under development

    ["requireditems"] = {
       [1] = {item = "weapon_wrench", amount = 1},
       [2] = {item = "security_card_01", amount = 1},
    }
}
