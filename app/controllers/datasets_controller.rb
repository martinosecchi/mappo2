class DatasetsController < ApplicationController
  before_filter :get_globals_for_single_ds, :except => [:index, :new, :create, :destroy]
  before_filter :open_dataset, :only => [:show, :edit, :update, :locations_of, :dataset_map, :timeline, :geochart_region, :geochart_markers]
  before_filter :map, :only => [:show, :dataset_map]
  before_filter :authenticate_user!, :except => [:embedmap, :embedtimeline1, :embedtimeline2]
  before_filter :user_datasets
  # GET /datasets
  # GET /datasets.json
  def index
    @datasets = Dataset.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @datasets }
    end
  end

  # GET /datasets/1
  # GET /datasets/1.json
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @dataset }
    end
  end

  # GET /datasets/new
  # GET /datasets/new.json
  def new
    @dataset = Dataset.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @dataset }
    end
  end

  # GET /datasets/1/edit
  def edit
  end

  # POST /datasets
  # POST /datasets.json
  def create
    @dataset = Dataset.new(params[:dataset])
    current_user.datasets << @dataset

    respond_to do |format|
      if @dataset.save
        format.html { redirect_to @dataset, notice: 'Dataset was successfully created.' }
        format.json { render json: @dataset, status: :created, location: @dataset }
      else
        format.html { render action: "new" }
        format.json { render json: @dataset.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /datasets/1
  # PUT /datasets/1.json
  def update
    respond_to do |format|
      if @dataset.update_attributes(params[:dataset])
        format.html { redirect_to @dataset, notice: 'Dataset was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @dataset.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /datasets/1
  # DELETE /datasets/1.json
  def destroy
    @dataset = Dataset.find(params[:id])
    @dataset.works.each do |w|
      check_destroy_locations(w)
      w.destroy
    end
    @dataset.destroy

    respond_to do |format|
      format.html { redirect_to root_path }
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

  #embed
  def embedmap
    @open_dataset = @dataset
    map
    render :layout => false
  end

  def embedtimeline1
    @chart1 = prepare_timeline
    render :layout => false
  end

  def embedtimeline2
    @chart2 = prepare_timeline_inline
    render :layout => false
  end
  
  #pagine
  def locations_of
    @pie_chart = pie_chart
    @region_chart = geo_chart_region_mode
  end

  def dataset_map
  end

  def timeline
    @chart1 = prepare_timeline
    @chart2 = prepare_timeline_inline
  end

  def geochart_region
    @region_chart = geo_chart_region_mode
  end

  def geochart_markers
    @marker_chart = geo_chart_marker_mode
    @marker_chart.add_listener("regionClick", "function(e) {chart.draw(data_table, {dataMode: 'markers', colors: ['0xFF8747', '0xFFB581', '0xc06000'], width: 800, region: e['region'], showZoomOut: true} )}")
    @marker_chart.add_listener("zoomOut", "function(e){ chart.draw(data_table, {dataMode: 'markers', colors: ['0xFF8747', '0xFFB581', '0xc06000'], width: 800, region: 'world', showZoomOut: true} ) }")
    @marker_chart.add_listener( 
      "select", 
      "function(e) {
      var selection = chart.getSelection();
      if(typeof selection[0] !== 'undefined') {
        var value = newInfo.getValue(selection[0].row, 0); 
        var arr = value.slit(', ');
        options={dataMode: 'markers', region: arr[arr.length-1], colors: ['0xFF8747', '0xFFB581', '0xc06000'], width: 800, region: e['region'], showZoomOut: true};
        chart.draw(data_table, options)
      }
      }")
  end

  def length_for_timeline(works)
    cont=0
    works.each do |work|
      if work.start && work.end
        cont+=1
      end
    end
    cont
  end

  #visualizzazioni
  def prepare_timeline
    data_table = GoogleVisualr::DataTable.new

    data_table.new_column('string', t('name'))
    data_table.new_column('string', 'Label')
    data_table.new_column('date', t('start'))
    data_table.new_column('date', t('end'))

    @works.each do |work|
      data_table.add_row([work.name.to_s, work.name.to_s, work.start.to_date, work.end.to_date]) if work.start && work.end && work.name
    end  
    heightpx = (length_for_timeline(@works) * 41)+50
    options = { :height => heightpx, :timeline => {singleColor: '#0080ff'} }
    GoogleVisualr::Interactive::Timeline.new(data_table, options)
  end

  def prepare_timeline_inline
    data_table = GoogleVisualr::DataTable.new
    
    data_table.new_column('string', t('name'))
    data_table.new_column('string', 'Label')
    data_table.new_column('date', t('start'))
    data_table.new_column('date', t('end'))

    @works.each do |work|
      data_table.add_row([" ", work.name.to_s, work.start.to_date, work.end.to_date]) if work.start && work.end && work.name
    end
    options={}
    GoogleVisualr::Interactive::Timeline.new(data_table, options)
  end

  def pie_chart
    data_table = GoogleVisualr::DataTable.new
    data_table.new_column('string', t('country'))
    data_table.new_column('number', t('projects'))
    
    get_countries.each do |country|
      data_table.add_row([country.to_s, get_works_in_country(country)])
    end
    opts   = { :width => 400, :height => 300, :title => t('projects_per_country'), :is3D => true }
    GoogleVisualr::Interactive::PieChart.new(data_table, opts)
  end

  def geo_chart_region_mode
    data_table_regions = GoogleVisualr::DataTable.new
    data_table_regions.new_column('string'  , t('country')   )
    data_table_regions.new_column('number'  , t('projects')  )
    
    get_countries.each do |country|
      data_table_regions.add_row([country.to_s, get_works_in_country(country)])
    end

    opts   = { :dataMode => 'regions', :width => 800 }
    GoogleVisualr::Interactive::GeoMap.new(data_table_regions, opts) 
  end
  def location_name(loc)
    isocountry = IsoCountryCodes.search_by_name(loc.country.to_s).first
      if loc.name
        name= loc.name.to_s + ", " +  isocountry.alpha2 || loc.country.to_s
      else
        name = isocountry.alpha2 || loc.country.to_s
      end
      name
  end
  def one_country(locations)
    countries=[]
    locations.each do |loc|
      countries << loc.country
    end
    countries.uniq.length==1
  end
  def geo_chart_marker_mode
    data_table_markers = GoogleVisualr::DataTable.new
    data_table_markers.new_column('string', t('name'))
    data_table_markers.new_column('number', t('projects'))

    @locations.each do |loc|
      name=location_name(loc)
      data_table_markers.add_row([name, loc.get_works_length_in_ds(@open_dataset) ])
    end
    opts1   = { :dataMode => 'markers', :colors => ['0xFF8747', '0xFFB581', '0xc06000'], :width => 800, :showZoomOut => true}
    opts2   = { :region => IsoCountryCodes.search_by_name(@locations.first.country.to_s).first.alpha2,:dataMode => 'markers', :colors => ['0xFF8747', '0xFFB581', '0xc06000'], :width => 800, :showZoomOut => true}
    if one_country(@locations)
      opts=opts2
    else
      opts=opts1
    end
    GoogleVisualr::Interactive::GeoMap.new(data_table_markers, opts)
  end

  def map
    @hash = Gmaps4rails.build_markers(@locations) do |location, marker|
      if location.latitude!=nil && location.longitude!=nil 
        marker.lat location.latitude 
        marker.lng location.longitude
        marker.infowindow render_to_string(:partial => "/locations/infowindow", :locals => { :location => location })
      end
      @hash.delete_if{|elem| elem.blank?} if @hash
    end
  end
  #utilizzo per le altre funzioni
  def get_countries
    countries=[]
    @locations.each do |loc|
      countries << loc.country.capitalize
    end
    countries.uniq
  end

  def get_works_in_country(country)
    cont=0
    @locations.each do |loc|
      cont+=loc.get_works_length_in_ds(@dataset) if loc.country.capitalize == country
    end
    cont
  end

  def get_globals_for_single_ds
    @dataset = Dataset.find(params[:id])
    @works = @dataset.works 
    @locations = @dataset.locations.find(:all, :order => :name).uniq
  end

  def user_datasets
    @datasets = current_user.datasets if current_user
  end

  def open_dataset
    @open_dataset = @dataset
    @@open_ds = @open_dataset
  end
end
