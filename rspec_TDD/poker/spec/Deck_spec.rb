require 'rspec'
require 'Deck'

describe Deck do
	subject(:deck) {Deck.new}
	let(:card) { double("card", :type => 'K', :symbol => '♥') }

	describe '#initialize' do
		it 'should have an array variable, @stack, that is length 52' do
			expect(deck.stack.length).to eq(52)
		end

		it 'should have each item inthat array as a Card object' do 
			expect(deck.stack).to all( be_a(Card) )
		end

		it 'should shuffle the cards randomly' do 
			expect(deck.stack).to_not eq(Deck.build_deck)
		end
	end

	describe '#shuffle' do
		it 'should change the order of the deck' do
			temp_deck = deck.stack
			deck.shuffle
			expect(deck.stack).to_not eq(temp_deck)
		end
	end

	describe '#draw' do
		it 'should return the top card from the deck' do
			top_card = deck.stack[-1]
			expect(deck.draw).to eq(top_card)
		end

		it 'should remove the drawn card from the deck' do
			drawn_card = deck.draw
			expect(deck.stack).to_not include(drawn_card)
		end
		
	end
end
	
