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

    it 'has a default header' do
      field1 = Field.new
      field2 = Field.new
      expect(field1.header).to eq 'A'
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
      expect(field.data[0]).to eq '111'
      expect(field.data[1]).to eq '222'
    end
  end

end