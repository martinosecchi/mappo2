# == Schema Information
#
# Table name: datasets
#
#  id          :integer          not null, primary key
#  title       :string(255)
#  description :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  works_id    :integer
#  user_id     :integer
#

class Dataset < ActiveRecord::Base
  include Obfuscate
  attr_accessible :description, :title
  attr_accessible :works, :work_attributes, :work_ids, :user_id

  belongs_to :work
  has_many :works
  has_many :locations, :through => :works 
  accepts_nested_attributes_for :works
  belongs_to :user

  def to_param
    encrypt id
  end

  #def self.find(id)
    #id=decrypt id
    #super
  #end


  def auto_marker_icon(current_user)
  	hexcolor=select_color(current_user)
  	first = title.split('').first.upcase
  	# chld = letter(s) written in the marker | marker's hex color | letter(s) color
  	"http://chart.apis.google.com/chart?chst=d_map_pin_letter&chld="+first+"|"+hexcolor+"|"
  end

  def select_color(current_user)
  	# 		red 		blue 	yellow 		orange 	lightblue	green	purple		brown	white	gray
  	colors=["FF0000", "0000ff", "ffff00", "ffa500", "add8e6", "00ff00", "a020f0", "a52a2a", "fff", "bebebe"]
  	num=0
  	ids=current_user.dataset_ids
  	ids.each do |usr_id|
  		if usr_id == id
  			break
  		else
  			num+=1
  		end
  	end
  	if num > colors.length
  		num=0
  	end
  	colors[num]
  end
end
