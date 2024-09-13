local loyalty_booster_atlas = SMODS.Atlas{
    key = 'boosters',
    path = 'boosters.png',
    px = 71,
    py = 95,
    atlas_table = 'ASSET_ATLAS',
}

local perk_booster_one = SMODS.Booster{
    key = "perk_normal_1",
    kind = "Perk",
    atlas = "boosters",
    pos = {
        x = 0,
        y = 0
    },
    config = {
        extra = 3,
        choose = 1
    },
    cost = 4,
    weight = 0.96,
    discovered = false,

    create_card = function(self, card)
        local card = create_card('Base', G.pack_cards, nil, nil, true, true, nil, 'cere')
        local perk = poll_perk()
        local edition = nil
        card:set_perk(perk)
        card:set_edition(nil, true, true)
        return card
    end,

    ease_background_colour = function(self)
        ease_colour(G.C.DYN_UI.MAIN, G.C.GREEN)
        ease_background_colour{new_colour = G.C.GREEN, special_colour = G.C.BLACK, contrast = 2}
    end,

    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = {set = 'Other', key = 'loyalty_perk_card'}
		return { vars = {card.config.center.config.choose, card.ability.extra} }
	end,

    group_key = "k_perk_pack"
}

local perk_booster_two = SMODS.Booster{
    key = "perk_normal_2",
    kind = "Perk",
    atlas = "boosters",
    pos = {
        x = 1,
        y = 0
    },
    config = {
        extra = 3,
        choose = 1
    },
    cost = 4,
    weight = 0.96,
    discovered = false,

    create_card = function(self, card)
        local card = create_card('Base', G.pack_cards, nil, nil, true, true, nil, 'cere')
        local perk = poll_perk()
        local edition = nil
        card:set_perk(perk)
        card:set_edition(nil, true, true)
        return card
    end,

    ease_background_colour = function(self)
        ease_colour(G.C.DYN_UI.MAIN, G.C.SECONDARY_SET.Tarot)
        ease_background_colour{new_colour = G.C.SECONDARY_SET.Tarot, special_colour = G.C.BLACK, contrast = 2}
    end,

    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = {set = 'Other', key = 'loyalty_perk_card'}
		return { vars = {card.config.center.config.choose, card.ability.extra} }
	end,

    group_key = "k_perk_pack"
}

local perk_booster_jumbo = SMODS.Booster{
    key = "perk_jumbo",
    kind = "Perk",
    atlas = "boosters",
    pos = {
        x = 2,
        y = 0
    },
    config = {
        extra = 5,
        choose = 1
    },
    cost = 6,
    weight = 0.48,
    discovered = false,

    create_card = function(self, card)
        local card = create_card('Base', G.pack_cards, nil, nil, true, true, nil, 'cere')
        local perk = poll_perk()
        local edition = nil
        card:set_perk(perk)
        card:set_edition(nil, true, true)
        return card
    end,

    ease_background_colour = function(self)
        ease_colour(G.C.DYN_UI.MAIN, LoyaltyCard.C.loyalty_mod_badge)
        ease_background_colour{new_colour = LoyaltyCard.C.loyalty_mod_badge, special_colour = G.C.BLACK, contrast = 2}
    end,

    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = {set = 'Other', key = 'loyalty_perk_card'}
		return { vars = {card.config.center.config.choose, card.ability.extra} }
	end,

    group_key = "k_perk_pack"
}

local perk_booster_mega = SMODS.Booster{
    key = "perk_mega",
    kind = "Perk",
    atlas = "boosters",
    pos = {
        x = 3,
        y = 0,
    },
    config = {
        extra = 5,
        choose = 2,
    },
    cost = 8,
    weight = 0.12,
    discovered = false,

    create_card = function(self, card)
        local card = create_card('Base', G.pack_cards, nil, nil, true, true, nil, 'cere')
        local perk = poll_perk()
        local edition = nil
        card:set_perk(perk)
        card:set_edition(nil, true, true)
        return card
    end,

    ease_background_colour = function(self)
        ease_colour(G.C.DYN_UI.MAIN, LoyaltyCard.C.loyalty_temporary)
        ease_background_colour{new_colour = LoyaltyCard.C.loyalty_temporary, special_colour = G.C.BLACK, contrast = 2}
    end,

    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = {set = 'Other', key = 'loyalty_perk_card'}
		return { vars = {card.config.center.config.choose, card.ability.extra} }
	end,

    group_key = "k_perk_pack"
}

local tarot_booster_one = false and SMODS.Booster{
    key = "tarot_normal_1",
    kind = "Joker",
    atlas = "boosters",
    pos = {
        x = 0,
        y = 1
    },
    config = {
        extra = 3,
        choose = 1
    },
    cost = 6,
    weight = 0.2,
    discovered = false,

    create_card = function(self, card)
        local key = get_tarot_joker()
        _card = create_card("Joker", G.pack_cards, nil, nil, true, true, key, 'cere')
        create_booster_reverse_card_ui(_card)
        return _card
    end,

    ease_background_colour = function(self)
        ease_colour(G.C.DYN_UI.MAIN, G.C.GREEN)
        ease_background_colour{new_colour = G.C.GREEN, special_colour = G.C.BLACK, contrast = 2}
    end,

    loc_vars = function(self, info_queue, card)
		return { vars = {card.config.center.config.choose, card.ability.extra} }
	end,

    group_key = "k_tarot_joker_pack"
}