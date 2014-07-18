require 'spec_helper'

describe RealReportRenderer do

  specify 'Final report #1' do
    id_field = Field['ID']
    id_field << [1, 2, 3]
    name_field = Field['Name']
    name_field << %w( Foo Bar Baz )
    renderer = RealReportRenderer.new({
      'ID'   => id_field,
      'Name' => name_field
    })

    expect(renderer.render).to eq "ID,Name\n" +
                                  "1,Foo\n" +
                                  "2,Bar\n" +
                                  "3,Baz"
  end

  specify 'Final report #2' do
    id_field = Field['Product ID']
    id_field << [1, 2, 3]
    name_field = Field['Name']
    name_field << %w( Abc Abcdefg Abcde )
    price_field = Field['Price']
    price_field << [123.45, 99.99, 1129.49]
    renderer = RealReportRenderer.new({
      'Product ID' => id_field,
      'Name'       => name_field,
      'Price'      => price_field
    })

    expect(renderer.render).to eq "Product ID,Name,Price\n" +
                                  "1,Abc,123.45\n" +
                                  "2,Abcdefg,99.99\n" +
                                  "3,Abcde,1129.49"
  end

end
