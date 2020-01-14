require 'rspec'
require 'Player'

describe Player do
	subject(:player) {Player.new(25)}
	let(:card) { double("card", :type => 'A', :symbol => '♥') }
	let(:card2) {double("card", :type => 'K', :symbol => '♥')}

	describe '#initialize' do 
		it 'should have a hand instance' do
			expect(player.hand).to be_a(Hand)
		end

		it 'should have the player start with $25 in the pot' do
			expect(player.pot).to eq(25)
		end
	end

	describe '#take' do
		it 'should have a card as an argument' do
			expect(player).to receive(:take).with(card)
			player.take(card)
		end

		it 'should raise an error if the argument is not a card' do 
			expect{ player.take(10) }.to raise_error(ArgumentError)
		end


		it 'should add a card to the players hand' do 
			allow(card).to receive(:is_a?).and_return(true)

			player.take(card)
			expect(player.hand.player_hand).to eq([card])
		end
	end


	describe '#action' do 
		it 'asks the user if they want to fold, raise, or see' do
			allow(player).to receive(:gets).and_return("f")
			expect{ player.action }.to output("Type f to fold, r to raise, or c to call the bet\n").to_stdout
		end

		it 'gets and returns user input as either f, r, or c' do
			allow(player).to receive(:gets).and_return("f")
			expect(player.action).to eq("f")
		end
	end

end