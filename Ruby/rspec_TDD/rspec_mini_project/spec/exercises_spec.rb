require 'rspec'
require 'exercises'


describe Array do
	subject(:arr) {[1,2,3,4,5]}
	describe '#my_uniq' do
		it 'returns a new array' do
			expect(arr.my_uniq).to be_an(Array)
		end
		it 'removes duplicate values, without modifying original array' do
			arr.push(5)
			expect(arr.my_uniq).to eq([1,2,3,4,5])
			expect(arr).to eq([1,2,3,4,5,5])
		end
	end

	describe '#two_sum' do
		subject(:arr) {[-1, 0, 2, -2, 1]}
		it 'should return a new array' do
			expect(arr.two_sum).to be_an (Array)
		end
		it 'should find pairs of elements that sum to zero' do 
			expect(arr.two_sum).to include( [0,4] ).and include( [2,3] )
		end
		it 'should return an array in dictionary order, sorted on first sub-element' do
			arr.concat([5,-5, 0, -1])
			expect(arr.two_sum).to eq([[0,4], [1,7], [2,3], [4,8], [5,6]])
		end
	end

	describe '#my_transpose' do
		subject(:arr) {[[1,2,3],[4,5,6],[7,8,9]]}
		it 'should transpose the original array' do
			expect(arr.my_transpose).to eq([[1,4,7],[2,5,8],[3,6,9]])
		end

		it 'should not modify the original array' do
			arr.my_transpose
			expect(arr).to eq([[1,2,3],[4,5,6],[7,8,9]])
		end

		it 'should raise an error if the array is not square' do 
			arr.pop
			expect {arr.my_transpose}.to raise_error(ArgumentError)
		end
	end
end

describe '#stock_picker' do
	subject(:arr) {[10,11,12,14,18,9,15]}
	it 'should return the index of elements with the greatest difference' do
		expect(stock_picker(arr)).to eq([0, 4])
	end

	it 'should not have a first element greater than the second element' do
		indices = stock_picker(arr)
		expect(indices[0]).to be < indices[1]
	end
end
