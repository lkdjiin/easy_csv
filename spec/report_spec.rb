require 'spec_helper'

describe Report do

  describe 'name' do

    it 'has a name' do
      report = Report.new('Report')
      expect(report.name).to eq 'Report'
    end

    it 'aliases [] to new' do
      report = Report['Report']
      expect(report.name).to eq 'Report'
    end

    it 'has a default name' do
      report1 = Report.new
      report2 = Report.new
      expect(report1.name).to eq 'Report #1'
      expect(report2.name).to eq 'Report #2'
    end
  end

  describe 'fields' do

    it 'uses << to add one field' do
      field = Field['Foo']
      report = Report['Report']
      report << field
      expect(report.field('Foo')).to eq field
    end

    it 'uses << to add a list of values' do
      field1 = Field['Foo']
      field2 = Field['Bar']
      report = Report['Report']
      report << [field1, field2]
      expect(report.field('Foo')).to eq field1
      expect(report.field('Bar')).to eq field2
    end

    it 'adds & finds a field at the same time' do
      report = Report['Report']
      report << Field['Foo']
      expect(report.field('Foo').header).to eq 'Foo'
    end
  end

  describe 'to_s' do
    it 'raises an error if not all fields have same size' do
      report = Report['Report']
      field = Field['Foo']
      field << [1, 2, 3]
      field = Field['Bar']
      field << 1

      expect{report.to_s}.to raise_error(FieldsSizeError)
    end
  end

  describe 'debug' do
    it 'replaces missing values by a dot' do
      report = Report['Report']
      field = Field['Foo']
      field << [1, 2, 3]
      field = Field['Bar']
      field << 1

      expect(report.debug).to eq "Foo , Bar\n" +
                                "---------\n" +
                                "  1 ,   1\n" +
                                "  2 , .\n" +
                                "  3 , .\n"
    end
  end
end
