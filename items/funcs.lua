-- HOOKS

local gen_ui_ref = generate_card_ui
function generate_card_ui(_c, full_UI_table, specific_vars, card_type, badges, hide_desc, main_start, main_end, card)
    local ret = gen_ui_ref(_c, full_UI_table, specific_vars, card_type, badges, hide_desc, main_start, main_end, card)
    print(tprint(ret))
    return ret
end

local end_round_ref = end_round
function end_round()
	-- remove any temp jokers
    for _, card in pairs(G.GAME.loyalty_card.cards) do
        if card and type(card) == 'table' and card.start_dissolve then
            card:start_dissolve()
        end
    end
    G.GAME.loyalty_card.cards = EMPTY(G.GAME.loyalty_card.cards)
	-- set hand size back to normal
	G.hand.config.real_card_limit = (G.hand.config.real_card_limit or G.hand.config.card_limit) - G.GAME.loyalty_card.hand_size
    G.hand.config.card_limit = math.max(0, G.hand.config.real_card_limit)
	G.GAME.loyalty_card.hand_size = 0
    ease_advantage(1)
    end_round_ref()
end

local draw_from_hand_to_discard_ref = G.FUNCS.draw_from_hand_to_discard
G.FUNCS.draw_from_hand_to_discard = function(e)
    local count = #G.perks.cards
    for i=1, count do
        draw_card(G.perks,G.discard, i*100/count,'down', nil, nil, 0.07)
    end
    draw_from_hand_to_discard_ref(e)
end

local draw_card_ref = draw_card
function draw_card(from, to, percent, dir, sort, card, delay, mute, stay_flipped, vol, discarded_only)
    if card then
        -- drawing cards from deck to perk area
        if from == G.deck and to == G.hand and card.ability.set == 'Perk' then
            to = G.perks
            dir = 'up'
            sort = true
        end
        if to == G.discard and card.ability.set == 'Perk' and card.ability.calc then
            card.ability.calc = false
        end
    end
    draw_card_ref(from, to, percent, dir, sort, card, delay, mute, stay_flipped, vol, discarded_only)
end

local get_starting_params_ref = get_starting_params
function get_starting_params()
    local ret = get_starting_params_ref()
    ret.advantage = 0
    return ret
end

local controller_queue_R_cursor_press_ref = Controller.queue_R_cursor_press
function Controller:queue_R_cursor_press(x, y)
    if self.locks.frame then return end
    if not G.SETTINGS.paused and G.perks and G.perks.highlighted[1] then 
        if (G.play and #G.play.cards > 0) or
        (self.locked) or 
        (self.locks.frame) or
        (G.GAME.STOP_USE and G.GAME.STOP_USE > 0) then return end
        G.perks:unhighlight_all()
    end
    controller_queue_R_cursor_press_ref(self, x, y)
end

local get_badge_colour_ref = get_badge_colour
function get_badge_colour(key)
    local ref_return = get_badge_colour_ref(key)
    return LoyaltyCard.C[key] or ref_return
end

local loc_colour_ref = loc_colour
function loc_colour(_c, _default)
    return LoyaltyCard.C[_c] or loc_colour_ref(_c, _default)
end