require 'spec_helper'

describe Report do

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

  it 'sets the first field order at 1' do
    field = Field['Foo']
    report = Report['Report']
    report << field
    expect(field.order).to eq 1
  end

  it 'sets many fields in sequence' do
    field1 = Field['Foo']
    field2 = Field['Bar']
    report = Report['Report']
    report << [field1, field2]
    expect(field1.order).to eq 1
    expect(field2.order).to eq 2
  end

  it 'displays fields order' do
    report = Report['Test']
    report << [ Field['Foo'], Field['Bar'], Field['Baz'] ]

    expect(report.order).to eq "Fields order for Test report\n" +
                               "----------------------------\n" +
                               "1 Foo\n" +
                               "2 Bar\n" +
                               "3 Baz"
  end

  describe '#to_s' do
    it 'raises an error if not all fields have same size' do
      report = Report['Report']
      field = Field['Foo']
      field << [1, 2, 3]
      report << field
      field = Field['Bar']
      field << 1
      report << field

      expect{report.to_s}.to raise_error(FieldsSizeError)
    end

    it 'returns a «readable» report' do
      report = Report['Report']
      field = Field['ID']
      field << [1, 2, 3]
      report << field
      field = Field['Name']
      field << %w( Foo Bar Baz )
      report << field

      expect(report.to_s).to start_with("ID , Name\n")
    end

  end

  describe '#debug' do

    it 'replaces missing values by a dot' do
      report = Report['Report']
      field = Field['Foo']
      field << [1, 2, 3]
      report << field
      field = Field['Bar']
      field << 1
      report << field

      expect(report.debug).to start_with("Foo , Bar\n")
    end

  end

end
