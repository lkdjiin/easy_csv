require 'spec_helper'

describe "Report's header" do

  before do
    @report = Report['Report']
    @report << [ Field['Foo'], Field['Bar'], Field['Baz'] ]
  end

  it 'matches againts a string' do
    expect(@report.header).to eq 'Foo,Bar,Baz'
  end

  it 'matches againts an array of strings' do
    expect(@report.header).to eq %w( Foo Bar Baz )
  end

  it 'does not match against other types' do
    expect(@report.header).not_to eq 123
  end
end
