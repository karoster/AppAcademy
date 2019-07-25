require 'rspec'
require 'TowersofHanoi'

describe HanoiGame do
	subject(:game) {HanoiGame.new}
	describe 'initialize' do
		it 'should create three arrays' do 
			expect(game.rod0).to be_an(Array)
			expect(game.rod1).to be_an(Array)
			expect(game.rod2).to be_an(Array)
		end

		it 'should have one array with four disks' do 
			expect(game.rod0).to eq([4,3,2,1])
		end

	end


	describe '#move!' do 
		it 'should take the top element from one of the arrays, and put it on another' do 
			game.move!(0, 1)
			expect(game.rod0).to eq([4,3,2])
			expect(game.rod1).to eq([1])
		end

		it 'should raise an error when attempting to move a larger disk onto a smaller one' do
			game.move!(0, 1)
			expect{game.move!(0,1)}.to raise_error("you cannot place a larger disk onto a smaller one disk")
		end
	end

	describe '#won?' do
		context 'when the disks are stacked on a rod that is not the first' do
			it 'should return true' do
				game.move!(0,1); game.move!(0,2); game.move!(1,2);
				game.move!(0,1); game.move!(2,0); game.move!(2,1); 
				game.move!(0,1); game.move!(0,2); game.move!(1,2);
				game.move!(1,0); game.move!(2,0); game.move!(1,2);
				game.move!(0,1); game.move!(0,2); game.move!(1,2);
				expect(game.won?).to be true
			end
		end
		context 'otherwise' do
			it 'should be false' do
				expect(game.won?).to be false
			end
		end
	end


end