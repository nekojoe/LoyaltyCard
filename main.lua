--- STEAMODDED HEADER
--- MOD_NAME: Loyalty Card
--- MOD_ID: loyalty
--- PREFIX: loyalty
--- MOD_AUTHOR: [nekojoe, Luigicat11]
--- MOD_DESCRIPTION: A Balatro x D&DG Content Mod
--- BADGE_COLOUR: DC3E5C
--- PRIORITY: 0
--- VERSION: 1.0a

----------------------------------------------
---------------- MOD CODE --------------------
local nativefs = require("nativefs")
local lovely = require("lovely")

-- local mod_icon = SMODS.Atlas({
--     key = "modicon",
--     path = "loyalty_icon.png",
--     px = 32,
--     py = 32
-- })

LoyaltyCard = {}

LoyaltyCard.MOD_PATH = (nativefs.getInfo(lovely.mod_dir .. '/LoyaltyCard/') and lovely.mod_dir .. '/LoyaltyCard/') or 
nativefs.getInfo(lovely.mod_dir .. '/LoyaltyCard-main/') and lovely.mod_dir .. '/LoyaltyCard-main/' or false

LoyaltyCard.COMPAT = {}

LoyaltyCard.FUNCS = {}

LoyaltyCard.FUNCS.read_files = function()
    if not LoyaltyCard.MOD_PATH then return end
    for path_prefix, paths in pairs(LoyaltyCard.ITEMS) do
        if type(paths) == 'table' then
            for _, path in pairs(paths) do
                assert(load(nativefs.read(LoyaltyCard.MOD_PATH .. path_prefix .. '/' .. path .. '.lua')))()
            end
        else
            assert(load(nativefs.read(LoyaltyCard.MOD_PATH .. paths .. '.lua')))()
        end
    end
end

LoyaltyCard.C = {
    loyalty_mod_badge = HEX('DC3E5C'),
    loyalty_temporary = HEX('47B2FF'),
}

LoyaltyCard.ITEMS = {
    items = {
        'card',
        'cardarea',
        'funcs',
        'jokers',
        'perks',
        'stickers',
        'ui',
    },
}

LoyaltyCard.FUNCS.read_files()

function SMODS.current_mod.reset_game_globals()
end

function get_perk_pool(key)
    --create the pool
    G.ARGS.TEMP_POOL = EMPTY(G.ARGS.TEMP_POOL)
    local pool = G.ARGS.TEMP_POOL
    local starting_pool = G.P_CENTER_POOLS['Perk']

    -- add any non shredded perks to pool
    for k, v in pairs(starting_pool) do
        if G.GAME.loyalty_card.shredded and not G.GAME.loyalty_card.shredded[v.key] then
            pool[#pool+1] = v
        end
    end

    if #pool == 0 then
        pool[#pool+1] = G.P_CENTERS['perk_loyalty_example']
    end

    return pool, key .. G.GAME.round_resets.ante
end

function poll_perk()
    local pool, pool_key = get_perk_pool('perk')
    if #pool == 0 then return false end
    local perk = pseudorandom_element(pool, pseudoseed(pool_key))
    return perk
end

function pick_from_deck(seed)
    local valid_cards = {}
    for k, v in ipairs(G.playing_cards) do
        if v.ability.effect ~= 'Stone Card' then
            valid_cards[#valid_cards+1] = v
        end
    end
    if valid_cards[1] then 
        local random_card = pseudorandom_element(valid_cards, pseudoseed(seed..G.GAME.round_resets.ante))
        return {
            rank = random_card.base.value,
            suit = random_card.base.suit,
            id = random_card.base.id,
        }
    else
        return {
            rank = 'Ace',
            suit = 'Spades',
            id = 14,
        }
    end
end

----------------------------------------------
---------------- MOD CODE END ----------------