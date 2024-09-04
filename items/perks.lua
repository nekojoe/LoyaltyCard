-- new SMODS perk thing

SMODS.Perk = SMODS.Enhancement:extend {
	set = 'Perk',
	class_prefix = 'perk',
	atlas = 'centers',
	pos = { x = 0, y = 0 },
	required_params = {
		'key',
	},
	replace_base_card = true,
	always_scores = true,
	no_suit = true,
	no_rank = true,

	register = function(self)
		self.config = self.config or {}
		-- default area to G.play
		self.config.area = self.config.area or G.play
		-- fill out any missing parts of ability table
		if self.config.tags then
            for k, v in pairs(self.config.tags) do
                v.amount = v.amount or 1
                v.cost = v.cost or 1
			end
		end
        if self.config.jokers then
            for k, v in pairs(self.config.jokers) do
                v.amount = v.amount or 1
                v.cost = v.cost or 1
			end
		end
		SMODS.Perk.super.register(self)
	end,

	inject = function(self)
		G.P_CENTERS[self.key] = self
        if not G.P_CENTER_POOLS[self.set] then G.P_CENTER_POOLS[self.set] = {} end
		SMODS.insert_pool(G.P_CENTER_POOLS[self.set], self)
	end,

	set_card_type_badge = function(self, card, badges)
		badges[#badges + 1] = create_badge(localize('k_perk'), get_badge_colour('loyalty_mod_badge'), nil, 1.2)
	end,

    generate_ui = function(self, info_queue, card, desc_nodes, specific_vars, full_UI_table)
        info_queue[#info_queue+1] = {set = 'Other', key = 'loyalty_exploit'}
        if card.ability.shred then
            info_queue[#info_queue+1] = {set = 'Other', key = 'loyalty_shred'}
        elseif card.ability.burn then
            info_queue[#info_queue+1] = {set = 'Other', key = 'loyalty_burn'}
        end
        SMODS.Enhancement.super.generate_ui(self, info_queue, card, desc_nodes, specific_vars, full_UI_table)
    end,

    process_loc_text = function(self)
        G.localization.descriptions[self.set] = G.localization.descriptions[self.set] or {}
        SMODS.process_loc_text(G.localization.descriptions[self.set], self.key, self.loc_txt)
    end,

	calculate = function(self, context, effect, card)
		if (card and card.ability) and not (card.burnt or card.shredded) then

            -- burn/shred any cards
            if card.ability.shred then
                card.shredded = true
            elseif card.ability.burn then
                card.burnt = true
            end
            
            -- add any jokers
            if card.ability.jokers then
                for i = 1, #card.ability.jokers do
                    for j = 1, card.ability.jokers[i].amount do
                        if #G.jokers.cards + G.GAME.joker_buffer < G.jokers.config.card_limit or card.ability.jokers[i].ignore_space then
                            G.GAME.joker_buffer = G.GAME.joker_buffer + 1
                            G.E_MANAGER:add_event(Event({
                                func = function()
                                    local _card = create_card(nil, G.jokers, nil, nil, nil, nil, card.ability.jokers[i].key)
                                    _card:add_to_deck()
                                    --play_sound('tarot1')
                                    if card.ability.jokers[i].sticker then
                                        _card:set_sticker(card.ability.jokers[i].sticker, true)
                                    end
                                    if card.ability.jokers[i].edition then
                                        _card:set_edition(card.ability.jokers[i].edition, true, true)
                                    end
                                    G.jokers:emplace(_card)
                                    _card:start_materialize()
                                    G.GAME.joker_buffer = 0
                                    return true
                                end
                            }))
                        end
                    end
                end
            end

            -- add any consumables
            if card.ability.consumables then
                for i = 1, #card.ability.consumables do
                    for j = 1, card.ability.consumables[i].amount do
                        if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit or card.ability.consumables[i].ignore_space then
                            G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                            G.E_MANAGER:add_event(Event({
                                func = (function()
                                    local _card = create_card(nil, G.consumeables, nil, nil, nil, nil, card.ability.consumables[i].key)
                                    _card:add_to_deck()
                                    if card.ability.consumables[i].edition then
                                        _card:set_edition(card.ability.consumables[i].edition, true, true)
                                    end
                                    G.consumeables:emplace(_card)
                                    G.GAME.consumeable_buffer = 0
                                    return true
                                end
                            )}))
                        end
                    end
                end
            end

            -- add any tags
            if card.ability.tags then
                for i = 1, #card.ability.tags do
                    for j = 1, card.ability.tags[i].amount do
                        G.E_MANAGER:add_event(Event({func = (function()
                            add_tag(Tag(card.ability.tags[i].key))
                            play_sound('generic1', 0.9 + math.random()*0.1, 0.8)
                            return true 
                        end)}))
                    end
                end
            end

            -- add any money
            if card.ability.dollars then
                ease_dollars(card.ability.dollars)
                G.GAME.dollar_buffer = (G.GAME.dollar_buffer or 0) + card.ability.dollars
                G.E_MANAGER:add_event(Event({func = (function()
                    G.GAME.dollar_buffer = 0
                    return true 
                end)}))
            end

            -- add any handsize
            if card.ability.hand_size then
                G.hand.config.real_card_limit = (G.hand.config.real_card_limit or G.hand.config.card_limit) + card.ability.hand_size
        		G.hand.config.card_limit = math.max(0, G.hand.config.real_card_limit)
				G.GAME.loyalty_card.hand_size = G.GAME.loyalty_card.hand_size + card.ability.hand_size
                G.E_MANAGER:add_event(Event({
					trigger = 'immediate',
					func = function()
						G.FUNCS.draw_from_deck_to_hand()
						return true
					end
				}))
            end
        end
	end,
}

-- actual perk cards

local loyalty_perk_atlas = SMODS.Atlas{
	key = 'perks',
	path = 'perks.png',
	px = 71,
	py = 95,
	atlas_table = 'ASSET_ATLAS',
}

local prototype = SMODS.Perk{
    key = 'prototype',
	atlas = 'perks',
    pos = {
        x = 2,
        y = 1,
    },
    config = {
        jokers = {
            {
                key = 'j_blueprint',
                sticker = 'loyalty_temporary',
                ignore_space = true,
            },
        },
        burn = true,
        message = 'Blueprint!',
        colour = G.C.SECONDARY_SET.Spectral,
	},

    loc_vars = function(self, info_queue)
        info_queue[#info_queue+1] = {set = 'Other', key = 'loyalty_temporary'}
        info_queue[#info_queue+1] = G.P_CENTERS['j_blueprint']
    end,
}

local dirty_napkin = SMODS.Perk{
    key = 'dirty_napkin',
	atlas = 'perks',
    pos = {
        x = 1,
        y = 0,
    },
    config = {
        jokers = {
            {
                key = 'j_brainstorm',
                sticker = 'loyalty_temporary',
                ignore_space = true,
            },
        },
        burn = true,
        message = 'Brainstorm!',
        colour = G.C.RED,
	},

    loc_vars = function(self, info_queue)
        info_queue[#info_queue+1] = {set = 'Other', key = 'loyalty_temporary'}
        info_queue[#info_queue+1] = G.P_CENTERS['j_brainstorm']
    end,
}

local reward_card = SMODS.Perk{
	key = 'reward_card',
	atlas = 'perks',
	pos = {
		x = 2,
		y = 0,
	},
	config = {
        tags = {
            {
                key = 'tag_coupon',
            },
        },
        burn = true,
		message = 'Tag!',
		colour = G.C.GREEN,
	},

	loc_vars = function(self, info_queue)
        info_queue[#info_queue+1] = G.P_TAGS['tag_coupon']
    end,
}

local business_card = SMODS.Perk{
    key = 'business_card',
	atlas = 'perks',
    pos = {
        x = 3,
        y = 0,
    },
	config = {
        tags = {
            {
                key = 'tag_uncommon',
            },
        },
        burn = true,
		message = 'Tag!',
		colour = G.C.GREEN,
	},

    loc_vars = function(self, info_queue)
        info_queue[#info_queue+1] = G.P_TAGS['tag_uncommon']
    end,
}

local plus_two = SMODS.Perk{
    key = 'plus_two',
	atlas = 'perks',
    pos = {
        x = 0,
        y = 1,
    },
	config = {
        hand_size = 2,
        burn = true,
        message = '+2!',
        colour = G.C.RED,
	},

    loc_vars = function(self, info_queue, card)
		return {
			vars = {
				card.ability.hand_size,
			},
		}
    end,
}