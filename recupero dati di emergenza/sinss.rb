#save in spreadsheet

Work
Dataset
datasets=Dataset.all
ds=[]
(0...datasets.length).each do |i|
	ds[i]="/Users/martinosecchi/Desktop/ds#{i}.csv"
end
#ds=["/Users/martinosecchi/Desktop/ds1.csv", "/Users/martinosecchi/Desktop/ds2.csv", "/Users/martinosecchi/Desktop/ds3.csv"]
(0...datasets.length).each do |i|
	File.open(ds[i], "w") do |csv|
		csv << 'name,start,end,places,extra'
		csv << "\n"
		datasets[i].works.each do |w|
			csv << "#{w.name},"
			csv << "#{w.start.to_s},"
			csv << "#{w.end.to_s},"
			csv << '"'
			csv << "#{w.places}"
			csv << '",'
			csv << '"'
			csv << "#{w.extra}"
			csv << '"'
			csv << "\n"
		end
	end
end