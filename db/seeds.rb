# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

colors = ['Зеленый с нормальным рисунком', 'Зеленый с опалиновым рисунком', 'Зеленый с коричневым рисунком',
'Зеленый рецессивный пестрый', 'Зеленый доминантный пестрый', 'Синий с нормальным рисунком',
'Синий с опалиновым рисунком', 'Синий с коричневым рисунком', 'Синий рецессивный пестрый',
'Синий доминантный пестрый', 'Синий желтолицый', 'Кружевной желтый', 'Кружевной белый',
'Альбино', 'Лютино'].map {|c| {name: c} }

Color.create colors
