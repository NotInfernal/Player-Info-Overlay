-- TOUCH THESE

--=======================================================================DEFAULT COLORS=====================================================================================================================

--Multiply 0.003921568627451 x [R/G/B Value].
-- 255 = 1.00 and 0 = 0.00
header_color = {
    r = 0.133,
    g = 0.121,
    b = 0.196,
    a = 1.0
}
sub_header_colour = {
    r = 0.745,
    g = 0.533,
    b = 0.988,
    a = 1.0
}
background_color = {
    r = 0.133,
    g = 0.121,
    b = 0.196,
    a = 0.92
}
highlight_color = {
    r = 0.745,
    g = 0.533,
    b = 0.988,
    a = 1.0
}
label_color = {
    r = 0.745,
    g = 0.533,
    b = 0.988,
    a = 1.0
}
label_text_color = {
    r = 1.0,
    g = 1.0,
    b = 1.0,
    a = 1.0
}
dinamic_label_text_color_1 = {
    r = 0.0,
    g = 1.0,
    b = 1.0,
    a = 1.0
}
dinamic_label_text_color_2 = {
    r = 0.666,
    g = 0.666,
    b = 0.666,
    a = 1.0
}
button_color = {
    r = 0.745,
    g = 0.533,
    b = 0.988,
    a = 1.0
}
button_highlight_colour = {
    r = 0.745,
    g = 0.533,
    b = 0.988,
    a = 0.5
}
money_colour = {
    r = 0.341,
    g = 0.807,
    b = 0.337,
    a = 1.0
}
armor_colour = {
    r = 0.282,
    g = 0.541,
    b = 0.870,
    a = 1.0
}
full_healt_colour = {
    r = 0.341,
    g = 0.807,
    b = 0.337,
    a = 1.0
}
mid_healt_colour = {
    r = 0.747,
    g = 0.330,
    b = 0.0,
    a = 1.0
}
low_healt_colour = {
    r = 1,
    g = 0.0,
    b = 0.0,
    a = 1.0
}

-- Change true to false to hide credits list
 showcreditslist = false


-- DO NOT TOUCH ANYTHING BELOW
-- UNLESS OF COURSE YOU KNOW WHAT YOU ARE DOING!
--===========================================================================================================================================================================================================
require("natives-1627063482") -- da natives
require("imgui_for_glance_custom_v5")
function reinit_window()
    glance = UI.new()
    glance.set_background_colour(background_color.r, background_color.g, background_color.b, background_color.a)
    glance.set_highlight_colour(highlight_color.r, highlight_color.g, highlight_color.b, highlight_color.a)
    glance.set_header_colour(header_color.r, header_color.g, header_color.b, header_color.a)
end

reinit_window()

-- credits to https://stackoverflow.com/questions/10989788/format-integer-in-lua
function format_int(number)
    local i, j, minus, int, fraction = tostring(number):find('([-]?)(%d+)([.]?%d*)')
    -- reverse the int-string and append a comma to all blocks of 3 digits
    int = int:reverse():gsub("(%d%d%d)", "%1,")
    -- reverse the int-string back remove an optional comma and put the 
    -- optional minus and fractional part back
    return minus .. int:reverse():gsub("^,", "") .. fraction
end

local StandEdition = menu.get_edition()

function do_percentage_scale_color_healt(perc)
    if perc > 0.66 then
        return full_healt_colour
    elseif perc < 0.66 and perc > 0.35 then 
        return mid_healt_colour
    elseif perc < 0.35 then
        return low_healt_colour
    end
end

function do_percentage_scale_color_armor(perc)
    if perc > 0 then 
        return armor_colour
    else 
        return dinamic_label_text_color_2
    end
end

function conditional_color(stringy) 
    if stringy == "None" then 
        return dinamic_label_text_color_2
    end
    return dinamic_label_text_color_1
end

function bool_to_yes_no(bool)
    if bool then 
        return "Yes"
    else
        return "No"
    end
end

function inputbool(bool)
    if bool then 
        return "Controller"
    else
        return "Keyboard"
    end
end

local function isFriend(PlayerId)
    return table.contains(players.list(false,true,false), PlayerId)
end

local languages = {
[0] = "English",
[1] = "French",
[2] = "German",
[3] = "Italian",
[4] = "Spanish",
[5] = "Brazilian",
[6] = "Polish",
[7] = "Russian",
[8] = "Korean",
[9] = "Chinese (Traditional)",
[10] = "Japanese",
[11] = "Mexican",
[12] = "Chinese (Simplified)"
}
blur_strength = 0
overlay_x_offset = 0.00
overlay_y_offset = 0.00
------------------------------------------------Overlay Position List-------------------------------------------------------
local pos_list = menu.list(menu.my_root(), "Overlay Position", {"polpos"}, "")
x_offset_slider = menu.slider_float(pos_list, "Overlay X Offset", {"polxoffset"}, "", -1000, 1000, 0, 1, function(s)
    overlay_x_offset = s * 0.001
    reinit_window()
end)

y_offset_slider = menu.slider_float(pos_list, "Overlay Y Offset", {"polyoffset"}, "", -1000, 1000, 0, 1, function(s)
    overlay_y_offset = s * 0.001
    reinit_window()
end)
------------------------------------------------Change Colours List---------------------------------------------------------
local colours_list = menu.list(menu.my_root(), "Overlay Colours", {"polcolurs"}, "")

color1 = menu.colour(colours_list, "Header Colour", {"polheadcolor"}, "", header_color, true, function(on_change)
    header_color = on_change
    reinit_window()
end)

color0 = menu.colour(colours_list, "Sub Header Text Colour", {"polsubheadtxtcolor"}, "", sub_header_colour, true, function(on_change)
    sub_header_colour = on_change
    reinit_window()
end)

color2 = menu.colour(colours_list, "Background Colour", {"polbgcolor"}, "", background_color, true, function(on_change)
    background_color  = on_change
    reinit_window()
end)

color3 = menu.colour(colours_list, "Highlight Colour", {"polhighlightcolor"}, "", highlight_color, true, function(on_change)
    highlight_color  = on_change
    reinit_window()
end)

color4 = menu.colour(colours_list, "Labels Colour", {"pollabelcolor"}, "", label_color, true, function(on_change)
    label_color  = on_change
    reinit_window()
end)

color5 = menu.colour(colours_list, "Labels Text Colour", {"pollabeltxtcolor"}, "", label_text_color, true, function(on_change)
    label_text_color  = on_change
    reinit_window()
end)

color6 = menu.colour(colours_list, 'Dinamic Labels "Vehicles/Weapons"', {"poldinlabel1"}, "", dinamic_label_text_color_1, true, function(on_change)
    dinamic_label_text_color_1  = on_change
    reinit_window()
end)

color6 = menu.colour(colours_list, 'Dinamic Labels "Hidden/None"', {"poldinlabel2"}, "", dinamic_label_text_color_2 , true, function(on_change)
    dinamic_label_text_color_2   = on_change
    reinit_window()
end)

color7 = menu.colour(colours_list, "Buttons Colour", {"polbtncolor"}, "", button_color , true, function(on_change)
    button_color  = on_change
    reinit_window()
end)

color8 = menu.colour(colours_list, "Highlighted Buttons Colour", {"polhlbtncolor"}, "", button_highlight_colour  , true, function(on_change)
    button_highlight_colour   = on_change
    reinit_window()
end)

color9 = menu.colour(colours_list, "Money Colour", {"polmoneycolor"}, "", money_colour, true, function(on_change)
    money_colour = on_change
    reinit_window()
end)

local armor_healt_colours_list = menu.list(colours_list, "Armor & Healt", {""}, "")

color10 = menu.colour(armor_healt_colours_list, "Armor Colour", {"polarmorcolor"}, "", armor_colour , true, function(on_change)
    armor_colour  = on_change
    reinit_window()
end)

color11 = menu.colour(armor_healt_colours_list, "Full Health Colour", {"polfullhealth"}, "", full_healt_colour , true, function(on_change)
    full_healt_colour  = on_change
    reinit_window()
end)

color12 = menu.colour(armor_healt_colours_list, "Mid Health Colour", {"polmidhealth"}, "", mid_healt_colour , true, function(on_change)
    mid_healt_colour  = on_change
    reinit_window()
end)

color13 = menu.colour(armor_healt_colours_list, "Low Health Colour", {"pollowhealth"}, "", low_healt_colour , true, function(on_change)
    low_healt_colour  = on_change
    reinit_window()
end)

local Hide_List = menu.list(menu.my_root(), "Hide Information", {}, "")
hide_option1 = menu.toggle(Hide_List, "Hide Self Info", {"polhideself"}, "", function(toggle)
    if toggle then
        hideselfinfo = true
    elseif not toggle then
        hideselfinfo = false
    end
end, toggle)
hide_option2 = menu.toggle(Hide_List, "Hide Friends Info", {"polhidefriends"}, "", function(toggle)
    if toggle then
        hidefriendinfo = true
    elseif not toggle then
        hidefriendinfo = false
    end
end, toggle)
hide_option3 = menu.toggle(Hide_List, "Hide Strangers Info", {"polhidestrangers"}, "", function(toggle)
    if toggle then
        hidestrangerinfo = true
    elseif not toggle then
        hidestrangerinfo = false
    end
end, toggle)
hide_option4 = menu.toggle(Hide_List, "Hide Header Names", {"polhidenames"}, "", function(toggle)
    if toggle then
        hidenames = true
    elseif not toggle then
        hidenames = false
    end
end, toggle)

if showcreditslist == true then
local credits_list = menu.list(menu.my_root(), "Credits", {}, 'If you want to disable this list open the lua file and change  "showcreditslist" value to false.')

menu.action(credits_list, "Lance", {}, "For making the version this script is based on", function()
    util.toast("Discord: lance#8011")
    util.toast("Thanks to Lance for making the version this script is based on")
end)

menu.action(credits_list, "Murten", {}, "For making the libery this Script and the original Lance's release uses.", function()   
    util.toast("Discord: Murten#0001")
    util.toast("Thanks to Murten for making the library this Script and the original Lance's release uses.")
end)

menu.action(credits_list, "Claud", {}, "For helping me to test the script and giving ideas.", function()
    util.toast("Discord: Cloudys#3090")
    util.toast("Thanks to Claud for helping me to test the script and giving ideas.")
end)

menu.action(credits_list, "Infernal", {}, 'Author of this version of "gLance', function()
    util.toast("Discord: Infernal#1157")
end)


else
    --
end

preview_window = false

x_offset_focused = menu.on_focus(x_offset_slider, function()
    preview_window = true
end)

menu.on_focus(y_offset_slider, function()
    preview_window = true  
end)
menu.on_focus(hide_option1, function()
    preview_window = true
end)
menu.on_focus(hide_option2, function()
    preview_window = true
end)
menu.on_focus(hide_option3, function()
    preview_window = true
end)
menu.on_focus(hide_option4, function()
    preview_window = true
end)

menu.on_focus(color0, function()
    preview_window = true
end)
menu.on_focus(color1, function()
    preview_window = true
end)

menu.on_focus(color2, function()
    preview_window = true
end)

menu.on_focus(color3, function()
    preview_window = true
end)

menu.on_focus(color4, function()
    preview_window = true
end)

menu.on_focus(color5, function()
    preview_window = true
end)

menu.on_focus(color6, function()
    preview_window = true
end)

menu.on_focus(color7, function()
    preview_window = true
end)

menu.on_focus(color8, function()
    preview_window = true
end)
menu.on_focus(color9, function()
    preview_window = true
end)
menu.on_focus(color10, function()
    preview_window = true
end)
menu.on_focus(color11, function()
    preview_window = true
end)
menu.on_focus(color12, function()
    preview_window = true
end)
menu.on_focus(color13, function()
    preview_window = true
end)
--
menu.on_focus(pos_list, function()
    preview_window = false
end)

menu.on_focus(colours_list, function()
    preview_window = false
end)
menu.on_focus(Hide_List, function()
    preview_window = false
end)

all_weapons = {}
temp_weapons = util.get_weapons()
-- create a table with just weapon hashes, labels
for a,b in pairs(temp_weapons) do
    all_weapons[#all_weapons + 1] = {hash = b['hash'], label_key = b['label_key']}
end
function get_weapon_name_from_hash(hash) 
    for k,v in pairs(all_weapons) do 
        if v.hash == hash then 
            return util.get_label_text(v.label_key)
        end
    end
    return 'None'
end
-- shamelessly stolen from keks
function dec_to_ipv4(ip)
	return string.format(
		"%i.%i.%i.%i", 
		ip >> 24 & 0xFF, 
		ip >> 16 & 0xFF, 
		ip >> 8  & 0xFF, 
		ip 		 & 0xFF
	)
end

function cursor_off()
    cursor_mode = false
    util.yield(250)
    menu.trigger_commands("disablelookud off")
    util.yield(250)
    menu.trigger_commands("disablelooklr off")
    util.yield(250)
    menu.trigger_commands("disableattack off")
    util.yield(250)
    menu.trigger_commands("disableattack2 off")
    cursor_status = false
end
cursor_status = false
shownames = true
while true do
    if not util.is_session_transition_active() and NETWORK.NETWORK_IS_SESSION_STARTED() then
        local focused_tbl = players.get_focused()
        if not menu.is_open() and cursor_status == true then
            cursor_off()
            util.yield(50)
        end
        if focused_tbl[1] ~= nil and menu.is_open() or (preview_window) then             
            if PAD.IS_CONTROL_JUST_PRESSED(2, 29) then
                glance.toggle_cursor_mode()
            end
            if (preview_window) then 
                focused = players.user()
            else
                focused = focused_tbl[1]
            end
            if not menu.is_open() then
                preview_window = false
            elseif not menu.is_open() and cursor_status == true then
                preview_window = false
                cursor_off()
            end
            

            local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(focused)
            local playerpos = players.get_position(focused)
            local playername = players.get_name(focused)
            local tags = players.get_tags_string(focused)
            local m_x, m_y = menu.get_position()

            showinfo = true
            friendcheck = bool_to_yes_no(isFriend(focused))
            if hideselfinfo == false and focused == players.user() then
                showinfo = true
            elseif hideselfinfo == true and focused == players.user() then
                showinfo = false
            elseif focused ~= players.user() and friendcheck == "No" and hidestrangerinfo == true then
                showinfo = false
            elseif focused ~= players.user() and friendcheck == "No" and hidestrangerinfo == false then
                showinfo = true
            elseif friendcheck == "Yes" and hidefriendinfo == true then
                showinfo = false
            elseif friendcheck == "Yes" and hidefriendinfo == false then
                showinfo = true
            end

            shownames = true
            if hidenames == true and hideselfinfo == false and focused == players.user() then
                shownames = true
            elseif hidenames == true and hideselfinfo == true and focused == players.user() then
                shownames = false
            elseif  focused ~= players.user() and friendcheck == "No" and hidestrangerinfo == true and hidenames == true then
                shownames = false
            elseif  focused ~= players.user() and friendcheck == "No" and hidestrangerinfo == true and hidenames == false then
                shownames = true
            elseif friendcheck == "Yes" and hidefriendinfo == true and shownames == true then
                shownames = false 
            elseif friendcheck == "Yes" and hidefriendinfo == true and shownames == false then
                shownames = true
            end
            if shownames == false then
                glance.begin(("[Hidden] "..tags), m_x - 0.3 + overlay_x_offset, m_y + overlay_y_offset)
            else
                glance.begin((playername.." "..tags), m_x - 0.3 + overlay_x_offset, m_y + overlay_y_offset)
            end
            glance.text(" ")
            glance.start_horizontal()
            glance.label("Wallet:", '$' .. format_int(players.get_wallet(focused)), label_color, money_colour)
            glance.divider()
            glance.label("Total:", '$' .. format_int(players.get_money(focused)), label_color, money_colour)
            glance.end_horizontal()
            glance.start_horizontal()
            glance.end_horizontal()
            glance.text(" ")
            local rid = players.get_rockstar_id(focused)
            local rid2 = players.get_rockstar_id_2(focused)
            glance.start_horizontal()
            glance.label("Rank:", players.get_rank(focused), label_color, label_text_color)
            glance.divider()

            if showinfo == false then
                glance.label("RID:", "[Hidden]", label_color, dinamic_label_text_color_2)
            else
            glance.label("RID:", if rid == rid2 then rid else rid .. '/' .. rid2, label_color, label_text_color)
            end
            glance.divider()
            if showinfo == false then
                glance.label("IP:", "[Hidden]", label_color, dinamic_label_text_color_2)
            else
            glance.label("IP:", dec_to_ipv4(players.get_connect_ip(focused)), label_color, label_text_color)
            end
            glance.end_horizontal()
            glance.text(" ")
            local kd = tonumber(string.format("%.2f", players.get_kd(focused)))
            local kills = players.get_kills(focused)
            local deaths = players.get_deaths(focused)
            glance.start_horizontal()
            glance.label("K/D:", kd, label_color, label_text_color)
            glance.divider()
            glance.label("Kills:", kills, label_color, label_text_color)
            glance.divider()
            glance.label("Deaths:", deaths, label_color, label_text_color)
            glance.end_horizontal()
            glance.text(" ")
            glance.start_horizontal()
            glance.label("Wanted:", PLAYER.GET_PLAYER_WANTED_LEVEL(focused), label_color, label_text_color)
            glance.divider()
            glance.label("Lang:", languages[players.get_language(focused)], label_color, label_text_color)
            glance.divider()
            glance.label("Input:", inputbool(players.is_using_controller(focused)), label_color, label_text_color)
            glance.end_horizontal()
            glance.text(" ")
            if ENTITY.DOES_ENTITY_EXIST(ped) then 
                glance.start_horizontal()
                local vehicle = players.get_vehicle_model(focused)
                if vehicle == 0 then 
                    disp_vehicle = "None"
                else
                    disp_vehicle = util.get_label_text(VEHICLE.GET_DISPLAY_NAME_FROM_VEHICLE_MODEL(vehicle))
                end
                glance.label("Vehicle:", disp_vehicle, label_color, conditional_color(disp_vehicle)) 
                glance.divider()
                local c1 = players.get_position(players.user())
                local c2 = players.get_position(focused)
                glance.label("Distance:", math.ceil(MISC.GET_DISTANCE_BETWEEN_COORDS(c1.x, c1.y, c1.z, c2.x, c2.y, c2.z)), label_color, label_text_color)
                glance.end_horizontal()
                glance.text(" ")
                glance.start_horizontal()
                local health_perc = ENTITY.GET_ENTITY_HEALTH(ped) / ENTITY.GET_ENTITY_MAX_HEALTH(ped)
                local hp_color = do_percentage_scale_color_healt(health_perc)
                glance.label("Health:", tostring(ENTITY.GET_ENTITY_HEALTH(ped)) .. '/' .. tostring(ENTITY.GET_ENTITY_MAX_HEALTH(ped)), label_color, hp_color)
                glance.divider()
                local armor_perc = PED.GET_PED_ARMOUR(ped)/PLAYER.GET_PLAYER_MAX_ARMOUR(pid)
                local armor_color_perc = do_percentage_scale_color_armor(armor_perc)
                glance.label("Armor:", tostring(PED.GET_PED_ARMOUR(ped)) .. '/' .. tostring(PLAYER.GET_PLAYER_MAX_ARMOUR(pid)), label_color, armor_color_perc)
                glance.end_horizontal()
                glance.text(" ")
                local wep_hash = WEAPON.GET_SELECTED_PED_WEAPON(ped)
                glance.start_horizontal()
                local wep_name =  get_weapon_name_from_hash(wep_hash)
                glance.label("Weapon:", wep_name, label_color, conditional_color(wep_name))
                glance.divider()
                local ammo_in_clip_alloc = memory.alloc_int()
                WEAPON.GET_AMMO_IN_CLIP(ped, wep_hash, ammo_in_clip_alloc)
                clip = memory.read_int(ammo_in_clip_alloc)
                if clip == 0 then 
                    glance.label("Clip:", "None", label_color, dinamic_label_text_color_2)
                elseif clip > 0 then
                glance.label("Clip:", clip .. '/' .. WEAPON.GET_MAX_AMMO_IN_CLIP(ped, wep_hash, true), label_color, label_text_color)
                end
                glance.end_horizontal()
            end
            glance.text(" ")
            glance.subhead("Player Options")
            glance.start_horizontal()
            if glance.button("TP", button_color, button_highlight_colour) then
                local c = players.get_position(focused)
                PED.SET_PED_COORDS_KEEP_VEHICLE(players.user_ped(), c.x, c.y, c.z)
            end
            if glance.button("Spec", button_color, button_highlight_colour) then
                menu.trigger_commands("spectate " .. players.get_name(focused))
            end
            if glance.button("Gift Veh", button_color, button_highlight_colour) then
                menu.trigger_commands("gift " .. players.get_name(focused))
            end
            if glance.button("In History", button_color, button_highlight_colour) then
                menu.trigger_commands("Findplayer " .. players.get_name(focused))
            end
            if glance.button("Block", button_color, button_highlight_colour) then
                menu.trigger_commands("historyblock " .. players.get_name(focused).." on")
                util.toast("Added ".. playername .." to blocked list.")
            end
            ----------------- Track Button For Stand Ultimate Users----------------------------
            if StandEdition == 3 then        
                if glance.button("Track", button_color, button_highlight_colour) then
                menu.trigger_commands("track" .. players.get_name(focused).." on")
                util.toast("Added ".. playername .." to track list.")
                end
            else
                -- no track button
            end
            ---------
            if glance.button("Timeout", button_color, button_highlight_colour) then
                menu.trigger_commands("timeout " .. players.get_name(focused))
            end
            glance.end_horizontal()
            glance.start_horizontal()
            ------------------------- Kicks For Stand Basic Users-------------------------------------
            if StandEdition == 1 then
                if glance.button("Smart", button_color, button_highlight_colour) then
                    menu.trigger_commands("kick " .. players.get_name(focused))
                end
                if glance.button("Desync", button_color, button_highlight_colour) then
                    menu.trigger_commands("loveletterkick " .. players.get_name(focused))
                end
            else
            --
            end-----
            ------------------------ Breakup and Breakdown Kicks For Stand Regular/Ultimate Users------
            if StandEdition > 2 then
                if glance.button("BD", button_color, button_highlight_colour) then
                menu.trigger_commands("breakdown " .. players.get_name(focused))
                end
                if glance.button("BU", button_color, button_highlight_colour) then
                menu.trigger_commands("breakup " .. players.get_name(focused))
                end
            else
            -- no Breakup and Breakdown Kicks.
            end
            ---------
            ----------------------- Stand Built-in Crashes----------------------------------------------
            if glance.button("E-Crash", button_color, button_highlight_colour) then
                menu.trigger_commands("crash " .. players.get_name(focused))
            end
            if glance.button("NG-Crash", button_color, button_highlight_colour) then
                menu.trigger_commands("ngcrash " .. players.get_name(focused))
            end
            if glance.button("BK-Crash", button_color, button_highlight_colour) then
                menu.trigger_commands("footlettuce " .. players.get_name(focused))
            end
            if glance.button("VM-Crash", button_color, button_highlight_colour) then
                menu.trigger_commands("slaughter " .. players.get_name(focused))
            end
            glance.end_horizontal()
            glance.finish()
        end
    end
    util.yield() -- keeps the script running at all times.
end