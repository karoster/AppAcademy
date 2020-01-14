require 'rspec'
require 'Hand'


describe Hand do 
	subject(:hand) { Hand.new }
	let(:card1) { double("card", :type => 'A', :symbol => '♥') }
	let(:card2) { double("card", :type => 'K', :symbol => '♥') }
	let(:card3) { double("card", :type => 'Q', :symbol => '♥') }
	let(:card4) { double("card", :type => 'J', :symbol => '♥') }
	let(:card5) { double("card", :type => '10', :symbol => '♥') }
	let(:card6) { double("card", :type => '7', :symbol => '♥') }

	before(:each) do 
		allow(card1).to receive(:suit).and_return('♥')
		allow(card2).to receive(:suit).and_return('♥')
		allow(card3).to receive(:suit).and_return('♥')
		allow(card4).to receive(:suit).and_return('♥')
		allow(card5).to receive(:suit).and_return('♥')
		allow(card6).to receive(:suit).and_return('♥')
		allow(card1).to receive(:value).and_return(13)
		allow(card2).to receive(:value).and_return(12)
		allow(card3).to receive(:value).and_return(11)
		allow(card4).to receive(:value).and_return(10)
		allow(card5).to receive(:value).and_return(9)
		allow(card6).to receive(:value).and_return(6)
	end

	describe '#initialize' do
		it 'should initialize an empty array to hold cards' do
			expect(hand.player_hand).to be_empty
		end

		it 'should hold an empty variable that will contain the players best hand' do
			expect(hand.best_hand).to be_nil
		end 

		it 'should hold an empty hash of the number of times a card type is in the hand' do
			expect(hand.pairs_count).to be_empty
		end
	end

	describe '#add_card' do
		#let(:card6) { double("card", :type => '7', :symbol => '♥') }

		before(:each) do 
			hand.add_card(card1); hand.add_card(card2); hand.add_card(card3)
			hand.add_card(card4)
		end

		it 'should add a card to the player hand' do
			expect(hand.player_hand).to eq( [card1, card2, card3, card4] )
		end

		it 'should raise an error if the players hand is full' do 
			hand.add_card(card5)
			expect{ hand.add_card(card6) }.to raise_error("hand is full")
		end

		it 'should call update_best to update the best_hand the player has' do
			expect(hand).to receive(:update_best)
			hand.add_card(card5)
		end
	end

	describe '#update_best' do

		before(:each) do 
			hand.add_card(card1); hand.add_card(card2); hand.add_card(card3)
			hand.add_card(card4); hand.add_card(card5)
		end

		it 'should call #check_pairs to see if there is x-of a kind' do
			expect(hand).to receive(:check_pairs)
			hand.update_best
		end

		it 'should call #check_flush' do
			expect(hand).to receive(:check_flush)
			hand.update_best
		end

		it 'should call #check_straight' do 
			expect(hand).to receive(:check_straight)
			hand.update_best
		end

		it 'should call #check_royal' do
			expect(hand).to receive(:check_royal)
			hand.update_best
		end
	end

end