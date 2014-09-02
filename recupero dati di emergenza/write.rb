=begin
locations= Location.all
works= Work.all
datasets= Dataset.all

File.open('/Users/martinosecchi/Desktop/locations.yaml', 'w'){ |f| f.write(YAML.dump(locations))}
File.open('/Users/martinosecchi/Desktop/works.yaml', 'w'){ |f| f.write(YAML.dump(works))}
File.open('/Users/martinosecchi/Desktop/datasets.yaml', 'w'){ |f| f.write(YAML.dump(datasets))}

=end
#variable = YAML.load(File.read('path'))
#Location
Work
Dataset

#locations=YAML.load(File.read('/Users/martinosecchi/Desktop/locations.yaml'))
works=YAML.load(File.read('/Users/martinosecchi/Desktop/works.yaml'))
datasets=YAML.load(File.read('/Users/martinosecchi/Desktop/datasets.yaml'))

=begin
locations.each do |loc|
l=Location.new
l.name=loc.name
l.country=loc.country
l.latitude=loc.latitude
l.longitude=loc.longitude
l.save
end
=end

works.each do |work|
w=Work.new
w.name=work.name
w.start=work.start
w.end=work.end
w.places=work.places
w.extra=work.extra

w.dataset_id=work.dataset_id
w.save
end

datasets.each do |dat|
d=Dataset.new
d.title=dat.title
d.category=dat.category
d.description=dat.description
d.works=dat.works
d.save
end