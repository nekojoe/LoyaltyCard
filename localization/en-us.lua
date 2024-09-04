return {
	['misc'] = {
		['suits_plural'] = {
			['loyalty_all_trades'] = 'All Trades',
		},
		['suits_singular'] = {
			['loyalty_all_trades'] = 'Everything',
		},
		['labels'] = {
			['loyalty_temporary'] = 'Temporary',
		},
		['dictionary'] = {
            ['k_perk_pack'] = "Perk Pack",
            ['k_tarot_joker_pack'] = "Tarot Joker Pack",
			['k_perk'] =  'Perk',
            ['k_hud_advantage'] = "Advantage",
            ['b_reverse'] = "REVERSE",
            ['b_exploit'] = "Exploit",
		},
	},
	['descriptions'] = {
		['Blind'] = {},
		['Joker'] = {
			-- tarot
			['j_loyalty_empress_joker'] = {
				['name'] = 'The Empress III',
				['text'] = {
                    'When {C:attention}first{} hand is drawn, create a {C:loyalty_temporary}Temporary{},',
					'{C:attention}Glass{} Ace of {C:hearts}Hearts{}, with a {C:red}Red Seal{}, in hand',
					' ',
					'{C:inactive}A beautiful, lush forest and winding stream',
					'{C:inactive}surround The Empress, signifying her connection',
					'{C:inactive}with Mother Earth and life itself.',
                },
			},
			['j_loyalty_empress_joker_reversed'] = {
				['name'] = 'The Empress III Reversed',
				['text'] = {
                    'When {C:attention}first{} hand is drawn, create a {C:loyalty_temporary}Temporary{},',
					'{C:attention}Steel{} Ace of {C:hearts}Hearts{}, with a {C:red}Red Seal{}, in hand',
					' ',
					'{C:inactive}A beautiful, lush forest and winding stream',
					'{C:inactive}surround The Empress, signifying her connection',
					'{C:inactive}with Mother Earth and life itself.',
                },
			},
			['j_loyalty_strength_joker'] = {
				['name'] = 'Strength XI',
				['text'] = {
                    'When hand is played, {C:attention}discard{} all cards left in hand, retrigger',
					'each {C:attention}scoring{} card once for every {C:attention}#1#{} cards discarded this way',
					' ',
					'{C:inactive}The woman wears a white robe, showing her purity of spirit,',
					'{C:inactive}and a belt and crown of flowers that represent the fullest,',
					'{C:inactive}most beautiful expression of nature. Over her head is the',
					'{C:inactive}symbol of infinity, representing her potential and wisdom.',
                },
			},
			['j_loyalty_strength_joker_reversed'] = {
				['name'] = 'Strength XI Reversed',
				['text'] = {
                    'When hand is played, {C:attention}destroy{} all but first {C:attention}scoring{} card,',
					'retrigger each card in {C:attention}hand{} once for every card destroyed',
					' ',
					'{C:inactive}The woman wears a white robe, showing her purity of spirit,',
					'{C:inactive}and a belt and crown of flowers that represent the fullest,',
					'{C:inactive}most beautiful expression of nature. Over her head is the',
					'{C:inactive}symbol of infinity, representing her potential and wisdom.',
                },
			},
			['j_loyalty_judgement_joker'] = {
				['name'] = 'Judgement XX',
				['text'] = {
                    'When hand is played, create a {C:loyalty_temporary}Temporary{} copy of',
					'{C:attention}first{} scoring card, and draw it to {C:attention}hand',
					' ',
					'{C:inactive}Archangel Gabriel blows his trumpet. The people',
					'{C:inactive}respond to his call, ready to be judged and find',
					'{C:inactive}out if they will be accepted into the heavens.',
				},
			},
			['j_loyalty_judgement_joker_reversed'] = {
				['name'] = 'Judgement XX Reversed',
				['text'] = {
                    'When hand is played, create a {C:loyalty_temporary}Temporary{} copy of',
					'{C:attention}first{} card in hand, and draw it to {C:attention}hand',
					' ',
					'{C:inactive}Archangel Gabriel blows his trumpet. The people',
					'{C:inactive}respond to his call, ready to be judged and find',
					'{C:inactive}out if they will be accepted into the heavens.',
				},
			},
		},
		['Enhanced'] = {},
		['Back'] = {},
		['Stake'] = {},
		['Spectral'] = {},
		['Edition'] = {},
		['Perk'] = {
			['perk_loyalty_prototype'] = {
				['name'] = 'Prototype',
				['text'] = {
					'On {E:1,C:green}exploit{}:',
					'create a {C:loyalty_temporary}temporary{} {C:attention}Blueprint{},',
					'then {E:1,C:red}burn{}',
				},
			},
			['perk_loyalty_dirty_napkin'] = {
				['name'] = 'Dirty Napkin',
				['text'] = {
					'On {E:1,C:green}exploit{}:',
					'create a {C:loyalty_temporary}temporary{} {C:attention}Brainstorm{},',
					'then {E:1,C:red}burn{}',
				},
			},
			['perk_loyalty_reward_card'] = {
				['name'] = 'Reward Card',
				['text'] = {
					'On {E:1,C:green}exploit{}:',
					'create a {C:attention}Coupon Tag{},',
					'then {E:1,C:red}burn{}',
				},
			},
			['perk_loyalty_business_card'] = {
				['name'] = 'Business Card',
				['text'] = {
					'On {E:1,C:green}exploit{}:',
					'create an {C:attention}Uncommon Tag{},',
					'then {E:1,C:red}burn{}',
				},
			},
			['perk_loyalty_plus_two'] = {
				['name'] = '+2 Card',
				['text'] = {
					'On {E:1,C:green}exploit{}:',
					'gain {C:attention}+#1#{} hand size,',
					'then {E:1,C:red}burn{}',
				},
			},
		},
		['Other'] = {
			['p_loyalty_perk_normal_1'] = {
			    ['name'] = "Perk Pack",
			    ['text'] = {
			        "Choose {C:attention}1{} of up to",
			        "{C:attention}3{C:green} Perk{} cards"
			    }
			},
			['p_loyalty_perk_normal_2'] = {
			    ['name'] = "Perk Pack",
			    ['text'] = {
			        "Choose {C:attention}#1#{} of up to",
			        "{C:attention}#2#{C:green} Perk{} cards"
			    }
			},
            ['p_loyalty_perk_jumbo'] = {
                ['name'] = "Jumbo Perk Pack",
                ['text'] = {
                    "Choose {C:attention}#1#{} of up to",
                    "{C:attention}#2#{C:green} Perk{} cards"
                }
            },
            ['p_loyalty_perk_mega'] = {
                ['name'] = "Mega Perk Pack",
                ['text'] = {
                    "Choose {C:attention}#1#{} of up to",
                    "{C:attention}#2#{C:green} Perk{} cards"
                }
            },
			['p_loyalty_tarot_normal_1'] = {
			    ['name'] = "Tarot Joker Pack",
			    ['text'] = {
                    "Choose {C:attention}#1#{} of up to",
                    "{C:attention}#2#{C:joker} Tarot Jokers{}"
                }
			},
			['loyalty_temporary'] = {
				['name'] = "Temporary",
				['text'] = {
					'Removed at end',
					'of {C:attention}round{}',
				}
			},
			['loyalty_burn'] = {
				['name'] = 'Burn',
				['text'] = {
					'Remove from deck',
					'for rest of {C:attention}ante{}',
				},
			},
			['loyalty_shred'] = {
				['name'] = 'Shred',
				['text'] = {
					'Card will not reappear',
					'for rest of {C:attention}run{}',
				},
			},
			['loyalty_exploit'] = {
				['name'] = 'Exploit',
				['text'] = {
					'Spend {E:1,C:green}Advantage{} to',
					'trigger effect',
				},
			},
			['loyalty_perk_card'] = {
				['name'] = 'Perk Card',
				['text'] = {
					'Spend {E:1,C:green}Advantage{}',
					'to trigger effect',
				},
			},
			['loyalty_advantage'] = {
				['name'] = 'Advantage',
				['text'] = {
					'Spend to trigger',
					'{C:green,E:1}Perk{} card effects',
				},
			},
		},
	},
}