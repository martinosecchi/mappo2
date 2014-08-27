# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

#rake db:seed
#all migrations required


p1=Work.new
p1.name="progetto1"
p1.places="(Trento, Verona, Bolzano, Milano, Roma), Italia; (Monaco), Germania; (Vienna), Austria;"
p1.save

l1 = Location.new
l1.name = "Trento"
l1.country = "Italia"
l1.save 

p1.locations << l1

l2 = Location.new
l2.name = "Verona"
l2.country = "Italia"
l2.save 

p1.locations << l2

l3 = Location.new
l3.name = "Bolzano"
l3.country = "Italia"
l3.save 

p1.locations << l3

l4 = Location.new
l4.name = "Milano"
l4.country = "Italia"
l4.save 

p1.locations << l4

l5 = Location.new
l5.name = "Roma"
l5.country = "Italia"
l5.save 

p1.locations << l5

l6 = Location.new
l6.name = "Monaco"
l6.country = "Germania"
l6.save 

p1.locations << l6

l7 = Location.new
l7.name = "Vienna"
l7.country = "Austria"
l7.save 

p1.locations << l7

p2=Work.new
p2.name="progetto2"
p2.places="(Berlino), Germania; (Napoli), Italia; (Tokyo), Giappone;"
p2.save

l8 = Location.new
l8.name = "Berlino"
l8.country = "Germania"
l8.save 

p2.locations << l8

l9 = Location.new
l9.name = "Napoli"
l9.country = "Italia"
l9.save 

p2.locations << l9

l10 = Location.new
l10.name = "Tokyo"
l10.country = "Giappone"
l10.save 

p2.locations << l10

p3=Work.new
p3.name="progetto3"
p3.places="(Trento, Verona, Bolzano), Italia;"
p3.save

p3.locations << l1
p3.locations << l2
p3.locations << l3

p4=Work.new
p4.name="progetto4"
p4.places="(Monaco, Berlino), Germania; (Trento), Italia;"
p4.save

p4.locations << l1
p4.locations << l6
p4.locations << l8

p5=Work.new
p5.name="progetto5"
p5.places="(Siena, Arezzo, Firenze, Livorno, Trento), Italia;"
p5.save

p5.locations << l1

l = Location.new
l.name = "Siena"
l.country = "Italia"
l.save 

p5.locations << l

l = Location.new
l.name = "Arezzo"
l.country = "Italia"
l.save 

p5.locations << l

l = Location.new
l.name = "Firenze"
l.country = "Italia"
l.save 

p5.locations << l

l = Location.new
l.name = "Livorno"
l.country = "Italia"
l.save 

p5.locations << l

p6=Work.new
p6.name="progetto6"
p6.places="(New York, Boston, Los Angeles, Las Vegas, Miami), USA;"
p6.save

l = Location.new
l.name = "New York"
l.country = "USA"
l.save 

p6.locations << l

l = Location.new
l.name = "Boston"
l.country = "USA"
l.save 

p6.locations << l

l = Location.new
l.name = "Los Angeles"
l.country = "USA"
l.save 

p6.locations << l

l = Location.new
l.name = "Las Vegas"
l.country = "USA"
l.save 

p6.locations << l

l = Location.new
l.name = "Miami"
l.country = "USA"
l.save 

p6.locations << l

p7=Work.new
p7.name="progetto7"
p7.places="(Tel Aviv, Gerusalemme), Israele; (Parigi), Francia; (Londra), Inghilterra;"
p7.save

l = Location.new
l.name = "Tel Aviv"
l.country = "Israele"
l.save 

p7.locations << l

l = Location.new
l.name = "Gerusalemme"
l.country = "Israele"
l.save 

p7.locations << l

l = Location.new
l.name = "Parigi"
l.country = "Francia"
l.save 

p7.locations << l

l = Location.new
l.name = "Londra"
l.country = "Inghilterra"
l.save 

p7.locations << l

p8=Work.new
p8.name="progetto8"
p8.places="(Praga), Rep.Ceca; (Trento), Italia;"
p8.save

p8.locations << l1

l = Location.new
l.name = "Praga"
l.country = "Rep.Ceca"
l.save 

p8.locations << l

p9=Work.new
p9.name="progetto9"
p9.places="(Onolulu), Hawaii;"
p9.save

l = Location.new
l.name = "Onolulu"
l.country = "Hawaii"
l.save 

p9.locations << l

d1 = Dataset.new
d1.title = "Insieme 1"
d1.category = "Portfolio Progetti"
d1. description = "Un insieme di progetti misti"
d1.works << p1
d1.works << p2
d1.works << p3
d1.works << p4
d1.save

d2 = Dataset.new
d2.title = "Insieme 2"
d2.category = "Portfolio Progetti"
d2. description = "Un insieme di progetti misti"
d2.works << p5
d2.works << p6
d2.save

d3 = Dataset.new
d3.title = "Insieme 3"
d3.category = "Portfolio Progetti"
d3. description = "Un insieme di progetti misti"
d3.works << p7
d3.works << p8
d3.works << p9
d3.save

p1.save
p2.save
p3.save
p4.save
p5.save
p6.save
p7.save
p8.save
p9.save