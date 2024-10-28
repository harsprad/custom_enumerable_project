# frozen_string_literal: true

require_relative '../lib/my_enumerables'

RSpec.describe Hash do
  subject(:hash) { {foo: 1, bar: 1, bee: 2, bas: 3, fas: 5, fee: 8, foi: 13, flo: 21, fii: 34} }

  describe '#my_each' do
    context 'when given a block' do
      it 'returns the original hash' do
        my_each_results = hash.my_each do |_key, _element|
          # This should return the original hash
          # no matter the contents of the block
        end

        expect(my_each_results).to eq(hash)
      end

      it 'executes the block for each element' do
        my_each_results = []
        each_results = []

        hash.my_each do |key, element|
          my_each_results << element * 2
        end

        hash.each do |key, element|
          each_results << element * 2
        end

        expect(my_each_results).to eq(each_results)
      end
    end
  end
end
