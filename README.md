# EasyCsv

J'ai toujours des soucis quand il s'agit de tester la création d'un
fichier au format CSV. EasyCsv existe pour rendre la création, et surtout
le test, des fichiers CSV le plus simple possible.

## Installation

Add this line to your application's Gemfile:

    gem 'easy_csv'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install easy_csv

## Quick Tutorial

### Les champs

EasyCsv se concentre sur le concept de *champ* (ou colonne) et non pas sur les
lignes d'un fichier CSV.

    require 'easy_csv'
    include EasyCsv

Créer un champ:

    product_field = Field.new('Product ID')

ou plus simple:

    product_field = Field['Product ID']

Afficher un champ:

    puts product_field
    #=> Product ID

Un champ à un nom par défaut:

    field1 = Field.new
    field2 = Field.new
    puts field1
    #=> A
    puts field2
    #=> B

Ajouter des données à un champ:

    product_field << '1234'
    puts product_field
    #=> Product ID
    #=>       1234

Les données sont transformées en string (en utilisant `to_s`):

    product_field << 2345
    puts product_field
    #=> Product ID
    #=>       1234
    #=>       2345

On peut ajouter une liste de données:

    product_field << [3333, 4444]
    puts product_field
    #=> Product ID
    #=>       1234
    #=>       2345
    #=>       3333
    #=>       4444

### Les rapports

Un rapport est une collection ordonnée de champs.

    report = Report.new('Products')

ou encore:

    report = Report['Products']

Un rapport à un nom par défaut:

    Report.new #=> 'Report #1'
    Report.new #=> 'Report #2'

On peut y ajouter un champ:

    report << product_field

On peut aussi ajouter une liste de champs, après les avoir créer:

    name_field    = Field['Name']
    color_field   = Field['Color']
    report << [name_field, color_field]

On aurait pu créer et ajouter un champ en même temps, et le récupérer
par la suite:

    report << Field['Name']
    name_field = report.field('Name')

Si on essaye d'afficher le rapport à ce stade, on obtient une erreur:

    puts report
    #=> EasyCsv::Report::FieldsSizeError

Mais on peut quand même l'obtenir avec `debug`, les données manquantes
sont symbolisées par un point:

    puts report.debug
    #=> Product ID , Name , Color
    #=> -------------------------
    #=>       1234 , .    , .
    #=>       2345 , .    , .
    #=>       3333 , .    , .
    #=>       4444 , .    , .

On va remplir nos données, rappelez vous que tous devient une chaine:

    name_field << ['Small thing', 'Big thing', 'Little thing', 'A thing']
    color_field << [:black, :white, :red, :green]

    puts report
    #=> Product ID , Name         , Color
    #=>       1234 , Small thing  , black
    #=>       2345 , Big thing    , white
    #=>       3333 , Little thing , red
    #=>       4444 , A thing      , green

### Ordre des champs dans un rapport

Les champs dans un rapport on un ordre:

    puts report.fields_order
    #=> Fields order for Product report
    #=> -------------------------------
    #=> 1 Product ID
    #=> 2 Name
    #=> 3 Color

On peut modifier l'ordre des champs:

    report.order(2, 'Color')
    puts report.fields_order
    #=> Fields order for Product report
    #=> -------------------------------
    #=> 1 Product ID
    #=> 2 Color
    #=> 3 Name

On peut modifier l'ordre de plusieurs champs d'un coup (ou bien tous).
Toutes les méthodes qui suivent sont équivalentes:

    report.order(1, 'Color', 2, 'Name', 3, 'Product ID')
    report.order([1, 'Color', 2, 'Name', 3, 'Product ID'])
    report.order([{1 => 'Color'}, {2 => 'Name'}, {3 => 'Product ID'}])
    report.order({1 => 'Color', 2 => 'Name', 3 => 'Product ID'})

### Rendering final

Lorsque vient le moment de produire le rapport pour l'enregistrer dans un
fichier, on utilise la méthode `render`:

    puts report.render
    #=> Product ID,Name,Color
    #=> 1234,Small thing,black
    #=> 2345,Big thing,white
    #=> 3333,Little thing,red
    #=> 4444,A thing,green

C'est moins lisible, hein ?

### Les tests

EasyCsv est cool pour produire des fichiers CSV, mais aussi et surtout pour
*tester* une telle production.

Ce genre de test peut vite être illisible, et il est mal aisé de modifier
l'ordre, surtout quand on a des dizaines de champs:

    report.header == 'Product ID,Name,Color'

Bien plus souple est:

    report.header == %w( Product\ ID
                         Name
                         Color )

On peut tester le header d'un champ:

    product_field.header == 'Product ID'

Et on peut bien sûr tester les données:

    product_field.data == [1234, 2345, 3333, 4444]

Ou comme ceci:

    product_field.data == %w( 1234
                              2345
                              3333
                              4444 )

Et pourquoi pas tester une donnée particulière:

    product_field.data[1] == 2345

## Contributing

1. Fork it ( https://github.com/[my-github-username]/easy_csv/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
