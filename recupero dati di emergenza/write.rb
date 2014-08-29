locations= Location.all
works= Work.all
datasets= Dataset.all

File.open('/Users/martinosecchi/Desktop/locations.yaml', 'w'){ |f| f.write(YAML.dump(locations))}
File.open('/Users/martinosecchi/Desktop/works.yaml', 'w'){ |f| f.write(YAML.dump(works))}
File.open('/Users/martinosecchi/Desktop/datasets.yaml', 'w'){ |f| f.write(YAML.dump(datasets))}

#variable = YAML.load(File.read('path'))
