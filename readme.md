# JOMIDAR ROOF RUNNING 

* NOPIXEL V4 ROOF RUNNING SCRIPT

# Item Icons

* Download the script and open images folder, put it in the qb-inventory/html/images directory.
# Installations

# Add the following code to your qb-core/shared/items.lua

 ```
ac_vent = {
    ["name"] = "ac_vent",
    ["label"] = "AC Vent",
    ["weight"] = 700,
    ["type"] = "item",
    ["image"] = "ac_vent.png",
    ["unique"] = true,
    ["useable"] = true,
    ["shouldClose"] = true,
    ["combinable"] = nil,
    ["description"] = "A vent part of an air conditioning system."
},
ac = {
    ["name"] = "ac",
    ["label"] = "Air Conditioner",
    ["weight"] = 700,
    ["type"] = "item",
    ["image"] = "ac.png",
    ["unique"] = true,
    ["useable"] = true,
    ["shouldClose"] = true,
    ["combinable"] = nil,
    ["description"] = "Air Conditioner"
},
ac_compressor = {
    ["name"] = "ac_compressor",
    ["label"] = "AC Compressor",
    ["weight"] = 700,
    ["type"] = "item",
    ["image"] = "ac_compressor.png",
    ["unique"] = true,
    ["useable"] = true,
    ["shouldClose"] = true,
    ["combinable"] = nil,
    ["description"] = "A Compressor part of an air conditioning system."
},
ac_broken = {
    ["name"] = "ac_broken",
    ["label"] = "Borken AC",
    ["weight"] = 700,
    ["type"] = "item",
    ["image"] = "ac_broken.png",
    ["unique"] = true,
    ["useable"] = true,
    ["shouldClose"] = true,
    ["combinable"] = nil,
    ["description"] = "A Borken part of an air conditioning system."
},
```
# DEPENDENCIES

SKILL CHECK

JOMIDAR-TEXTUI

