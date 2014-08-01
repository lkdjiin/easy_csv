require 'spec_helper'

describe Field do

  describe 'header' do

    it 'has a header' do
      field = Field.new('Foo')
      expect(field.header).to eq 'Foo'
    end

    it 'aliases [] to new' do
      field = Field['Foo']
      expect(field.header).to eq 'Foo'
    end

    it 'alphabetically increases the default header' do
      field1 = Field.new
      field2 = Field.new
      expect(field2.header).to eq 'B'
    end

  end

  describe 'to_s' do

    context 'with no data' do
      it 'returns the header' do
        field = Field['Foo']
        expect(field.to_s).to eq 'Foo'
      end
    end

    context 'with one data' do
      it 'returns the header following by the data' do
        field = Field['Foo']
        field << 'bépo'
        expect(field.to_s).to eq "Foo\nbépo"
      end
    end

  end

  describe 'data' do
    it 'uses << to add one value' do
      field = Field['Foo']
      field << 'bépo'
      expect(field.data[0]).to eq 'bépo'
    end

    it 'cast an number into a string' do
      field = Field['Foo']
      field << 123
      expect(field.data[0]).to eq '123'
    end

    it 'cast a symbol into a string' do
      field = Field['Foo']
      field << :green
      expect(field.data[0]).to eq 'green'
    end

    it 'uses << to add a list of values' do
      field = Field['Foo']
      field << [111, 222]
      expect(field.data.last).to eq '222'
    end

    describe 'equality' do

      it 'matches an array of string' do
        field = Field['Foo']
        field << [111, 222]
        expect(field.data).to eq %w( 111
                                     222 )
      end

      it 'matches an array of number' do
        field = Field['Foo']
        field << [111, 222]
        expect(field.data).to eq [ 111, 222 ]
      end

    end
  end


  describe 'order' do

    it 'has an order of 0 at creation' do
      field = Field['Foo']
      expect(field.order).to eq 0
    end

    it 'sets his order' do
      field = Field['Foo']
      field.order = 2
      expect(field.order).to eq 2
    end

  end

end
