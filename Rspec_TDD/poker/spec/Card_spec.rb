require 'rspec'
require 'Card'

describe Card do 
	subject(:card) { Card.new('K', '♥') }
	describe '#initialize' do 
		it 'sets the type of the card' do 
			expect(card.type).to eq('K')
		end
		it 'sets the suit of the card' do
			expect(card.suit).to eq('♥')
		end
	end

	describe '#to_s' do 
		let(:card2) { Card.new('Q', '♠') }
		it 'outputs the type of each card, with the suit' do
			expect(card2.to_s).to eq('Q♠')
			expect(card.to_s).to eq('K♥')
		end
	end


end