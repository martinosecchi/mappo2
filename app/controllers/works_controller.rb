class WorksController < ApplicationController
  before_filter :get_work, :only => [:show, :edit, :update, :destroy, :open_dataset]
  before_filter :open_dataset, :only => [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!
  before_filter :user_datasets
  before_filter :check_user, :only => [:show, :edit, :destroy]

   def check_user
    unless current_user.datasets.include? Dataset.find(@work.dataset_id)
      redirect_to root_path
    end
  end
  # GET /works
  # GET /works.json
  def index
    @works = Work.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @works }
    end
  end

  # GET /works/1
  # GET /works/1.json
  def show
    @locations=@work.locations
    map
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @work }
    end
  end

  # GET /works/new
  # GET /works/new.json
  def new
    @work = Work.new
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @work }
    end
  end

  # GET /works/1/edit
  def edit
  end

  # POST /works
  # POST /works.json
  def create
    @work = Work.new(params[:work].except(:extra_keys, :extra_values))
    @work.extra = process_extra if params[:extra_keys]
    
    current_dataset.works << @work
    
    create_locations(@work) if @work.places

    respond_to do |format|
      if @work.save
        format.html { redirect_to @work, notice: 'Work was successfully created.' }
        format.json { render json: @work, status: :created, location: @work }
      else
        format.html { render action: "new" }
        format.json { render json: @work.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /works/1
  # PUT /works/1.json
  def update
    @work.extra = process_extra if params[:work][:extra_keys] && params[:work][:extra_keys]!= ""
    respond_to do |format|
      if @work.update_attributes(params[:work].except(:extra_keys, :extra_values))
        create_locations(@work) if @work.places#.changed?
        format.html { redirect_to @work, notice: 'Work was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @work.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /works/1
  # DELETE /works/1.json
  def destroy
    #controllare che le location che lascia non siano vuote
    check_destroy_locations(@work)

    @work.destroy

    respond_to do |format|
      format.html { redirect_to url_for current_dataset }
      format.json { head :no_content }
    end
  end

  def check_destroy_locations(work)
    locations=work.locations
    locations.each do |location|
      if location.works.length==1 #hanno solo il work che sto distruggendo
        location.destroy
      end
    end
  end

  def remove_first_space(string)
    if string
      if string.split('').first==" "
        b=string.split('')
        #controllo che la prima lettera non sia uno spazio
        if b.first==' '
          b.shift
          string=b.join
        end
        return string
      else #first==" "
        return string
      end
    end
  end

  def create_locations(work)
    #es places= "(Roma, Milano), Italia; Vienna, Austria; Svizzera"
    prima=work.locations #utile per un confronto prima/dopo nel caso update
    work.locations=[]
    arrayplaces=work.places.split(';')
    #arayplaces=["(Roma, Milano), Italia", " Vienna, Austria", " Svizzera"]

    arrayplaces.each do |a|
      if a.include? ','
        a.delete! ';' #nel caso sia rimasto (nell'ultimo magari)
        a.delete!("\n") #nel caso sia stato inserito
        dati=a.split('),') #["(Roma, Milano", " Italia"]
        dati.first.delete!('(') #Roma, Milano
        names=dati.first.split(',') #["Roma", " Milano"]
        country=dati.second #" Italia"
      else #include? ',' considero caso di tipo -> "Svizzera" e non altri
        country = remove_first_space(a)
        names=[]
      end
      country = remove_first_space(country)
      country.capitalize!
      if names.length>=1
        names.each do |name|
          name.delete!("\n")
          name.delete!("\r")
          name=remove_first_space(name)
          name.capitalize!
          save_location(work, name, country)
        end #do names
      else 
        save_location(work, "", country)
      end#if names.length

      if work.locations != prima
        #-> sono state rimosse o aggiunte delle locations nel processo di update
        #se alcune di quelle tolte adesso non hanno più progetti associati le elimino
        prima.each do |before|
          unless work.locations.include? before #se non c'è più
            if before.works.length == 0 #e se non ha più motivo di esistere
              before.destroy
            end
          end
        end
      end #if != prima

    end #do arrayplaces.each
  end #create_locations

  def save_location(work, name, country)
    loc = Location.find_by_name_and_country(name, country) || Location.new
    loc.name=name
    loc.country=country
    work.locations << loc if !(work.locations.include? loc) #la aggiungo se non è già nella lista
    loc.save!
  end

  def get_work
    @work = Work.find(params[:id])
  end

  def open_dataset
    session[:current_dataset_id]=@work.dataset_id
    current_dataset
  end

  def import
    Work.import(params[:file], params[:dataset_id])
    Work.all.each do |work|
      create_locations(work) if work.locations.blank? && !work.places.blank?
    end
    redirect_to dataset_path(Dataset.find(params[:dataset_id])), notice: "File successfully uploaded."
  end

  def process_extra
    params[:work][:extra_keys].delete! "\n"
    params[:work][:extra_keys].delete! "\r"
    params[:work][:extra_values].delete! "\r"
    params[:work][:extra_values].delete! "\n"

    keys=JSON.parse(params[:work][:extra_keys])
    values=JSON.parse(params[:work][:extra_values])
    
    params[:work].delete :extra_keys
    params[:work].delete :extra_values
    

    for i in 0...keys.length
      if keys[i]==""
        keys.delete_at(i)
        values.delete_at(i)
      end
    end
    
    Hash[[keys, values].transpose]
  end

  def map
    @hash = Gmaps4rails.build_markers(@locations) do |location, marker|
      if location.latitude!=nil && location.longitude!=nil 
        marker.lat location.latitude 
        marker.lng location.longitude
        marker.infowindow render_to_string(:partial => "/locations/infowindow", :locals => { :location => location })
      end
    end
    @hash.delete_if{|elem| elem.blank?} if @hash
  end

  def user_datasets
    @datasets = current_user.datasets if current_user
  end
end #workscontroller
