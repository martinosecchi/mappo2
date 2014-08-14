#load ('populate.rb')

p1=Work.new
p1.name="progetto1"
p1.places="(Trento, Verona, Bolzano, Milano, Roma), Italia; Monaco, Germania; Vienna, Austria"
p1.save

p2=Work.new
p2.name="progetto2"
p2.places="Berlino, Germania; Napoli, Italia; Tokyo, Giappone;"
p2.save

p3=Work.new
p3.name="progetto3"
p3.places="(Trento, Verona, Riva), Italia"
p3.save

p4=Work.new
p4.name="progetto4"
p4.places="(Monaco, Berlino), Germania; Trento, Italia"
p4.save