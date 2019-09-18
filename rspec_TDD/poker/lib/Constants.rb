module C

	def C.suits
		%w(♠ ♥ ♦ ♣)
	end

	def C.types
		[*((2..10).to_a.map(&:to_s)), 'J', 'Q', 'K', 'A']
		
	end

	def C.combos
		{:royal_flush => 10, :straight_flush => 9, :four_kind => 8, 
			:full_house => 7, :flush => 6, :straight => 5, 
			:three_kind => 4, :two_pair => 3, :pair => 2, :high => 1}
	end

	def C.sorter(arr)
		arr.sort{ |x,y| C.types.index(x.type) <=> C.types.index(y.type) }
	end

	def C.hand_type(player)
		player.hand.best_hand
	end

	def C.winner_of(showdown_players)
		best_players = [showdown_players[0]]

		showdown_players[1..-1].each do |player|
			hand_key = player.hand.best_hand
			if C.combos[hand_key] > C.combos[best_players[0].hand.best_hand]
				best_players = [player]
			elsif C.combos[hand_key] == C.combos[best_players[0].hand.best_hand]
				best_players << player
			else
				next
			end
		end
		winner = best_players.length > 1 ? C.break_tie(best_players) : best_players[0]
		
	end

	def C.break_tie(tied_players)
		case C.hand_type(tied_players[0])
		when :royal_flush
			winner = tied_players[0]
		when :straight_flush || :flush || :straight || :high
			winner = C.high_card(tied_players)
		when :four_kind || :two_pair || :three_kind || :full_house
			winner = C.pair_tie(tied_players)
		end					
		winner
	end

	def C.high_card(tied_players)
		winner = nil
		highest_card = nil
		tied_players.each do |player|
			sorted = C.sorter(player.hand.player_hand)
			##might sort reverse##
			winner = player if highest_card < sorted[-1] || highest_card.nil?
			highest_card = sorted[-1] if highest_card < sorted[-1] || highest_card.nil?
		end

	end

	def C.pair_tie(tied_players)
		winner = nil
		highest_card = nil
		tied_players.each do |player|
			pairs_hash = player.hand.pairs_count
			highest_pair = pairs_hash.select { |key, hsh| hsh[key] == pairs_hash.values.max  }.keys
			card_val = C.types.index(highest_pair[0]) 
			highest_card = card_val if card_val > highest_card || highest_card.nil?
			winner = player if card_val > highest_card
		end
		winner
	end
end