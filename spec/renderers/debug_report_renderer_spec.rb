require 'spec_helper'

describe DebugReportRenderer do
  specify 'Debug report #1' do
    id_field = Field['ID']
    id_field << [1, 2, 3]
    name_field = Field['Name']
    name_field << %w( Foo )
    renderer = DebugReportRenderer.new({
      'ID'   => id_field,
      'Name' => name_field
    })

    expect(renderer.render).to eq "ID , Name\n" +
                                  "---------\n" +
                                  " 1 , Foo \n" +
                                  " 2 , .   \n" +
                                  " 3 , .   "
  end

  specify 'Debug report #2' do
    id_field = Field['Product ID']
    id_field << [1, 2, 3]
    name_field = Field['Name']
    name_field << %w( Abc )
    price_field = Field['Price']
    price_field << [123.45, 99.99]
    renderer = DebugReportRenderer.new({
      'Product ID' => id_field,
      'Name'       => name_field,
      'Price'      => price_field
    })

    expect(renderer.render).to eq "Product ID , Name , Price \n" +
                                  "--------------------------\n" +
                                  "         1 , Abc  , 123.45\n" +
                                  "         2 , .    ,  99.99\n" +
                                  "         3 , .    , .     "
  end
end
