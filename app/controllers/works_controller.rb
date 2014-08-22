class WorksController < ApplicationController
  before_filter :open_dataset, :only => [:show, :edit, :update, :destroy]
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
    @work = Work.new(params[:work])
    @@open_ds.works << @work
    
    create_locations(@work) if @work.places#.changhed?
   
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
    create_locations(@work) if @work.places

    respond_to do |format|
      if @work.update_attributes(params[:work])
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
      format.html { redirect_to url_for @open_dataset }
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
    b=string.split('')
    #controllo che la prima lettera non sia uno spazio
    if b.first==' '
      b.shift
      string=b.join
    end
    return string
  end

  def create_locations(work)
    #es places= "(Roma, Milano), Italia; Vienna, Austria; Svizzera"
    prima=work.locations #utile per un confronto prima/dopo nel caso update
    work.locations=[]
    arrayplaces=[];
    arrayplaces=work.places.split(';')
    #arayplaces=["(Roma, Milano), Italia", " Vienna, Austria", " Svizzera"]

    arrayplaces.each do |a|
      names=[];
      country="";
      a.delete! ';' #nel caso sia rimasto (nell'ultimo magari)
      a.delete!("\n") #nel caso sia stato inserito
      a=remove_first_space(a)
      
      if a.include? ')'# es a="(Roma, Milano), Italia"
        dati=a.split('),') #["(Roma, Milano", " Italia"]
        dati.first.delete!('(') #Roma, Milano
        names=dati.first.split(',') #["Roma", " Milano"]
        country=dati.second #" Italia"
      else #es: caso "Vienna, Austria" o caso "Svizzera"
        dati=a.split(',') #["Vienna", " Austria"] o [" Svizzera"]
        names.push(dati.first)
        country=dati.second if dati.second
      end

      country=remove_first_space(country)
      country.capitalize!
      if names.length>=1
        names.each do |name|
          name.delete!("\n")
          name.delete!("\r")
          name.delete!(".")
          name.delete!(",")
          name=remove_first_space(name)
          name.capitalize!
          if Location.find_by_name(name) #è già in db (<=> name è univoco, cosa che non è detta)
            loc = Location.find_by_name(name)
            if !(work.locations.include? loc) #se non è già nella lista
              work.locations << loc #la aggiungo
            end
          else #non è in db, la creo e lo aggiungo
            loc=Location.new
            loc.name=name
            loc.country=country
            loc.save
            work.locations << loc
          end
        end #do names
      end #if names length

      if work.locations != prima
        #-> sono state rimosse delle locations nel processo di update
        #se alcune di quelle tolte adesso non hanno più progetti associati le elimino
        prima.each do |before|
          found=false
          work.locations.each do |actual|
            #devo stabilire se la before c'è ancora -> è nell'actual
            if before.id == actual.id
              found=true
            end
          end #ciclo actual
          if found == false
            if before.works.legth == 0
              before.destroy
            end
          end
        end #ciclo prima
      end #if != prima

    end #do arrayplaces.each
  end #create_locations

  def open_dataset
    @work = Work.find(params[:id])
    @open_dataset = Dataset.find(@work.dataset_id)
    @@open_ds = @open_dataset
  end

end #workscontroller
