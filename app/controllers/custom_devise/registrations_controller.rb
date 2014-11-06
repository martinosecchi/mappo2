class CustomDevise::RegistrationsController < Devise::RegistrationsController
	def destroy
		resource.datasets.each do |ds|
			ds.works.each do |w|
				w.destroy
			end
			ds.destroy
		end
		Location.destroy_unused
		super 
	end
end