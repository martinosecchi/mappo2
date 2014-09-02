class DatasetsController < ApplicationController
  before_filter :get_globals_for_single, :except => [:index, :new, :create, :destroy]
  #:only => [:show, :edit, :update, :map, :works_of, :locations_of, :dataset_map, :get_globals_for_single, :open_dataset]
  before_filter :open_dataset, :only => [:show, :edit, :update, :works_of, :locations_of, :dataset_map, :timeline, :geochart_region, :geochart_markers]
  before_filter :map, :only => [:show, :works_of, :dataset_map]
  before_filter :authenticate_user!

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
    @dataset.destroy

    respond_to do |format|
      format.html { redirect_to root_path }
      format.json { head :no_content }
    end
  end

  #embed
  def embedmap
    @open_dataset = Dataset.find(params[:id])
    map
    @style = 'width: '+ params[:width] +'px; height: '+ params[:height] +'px;'
  end
  
  #pagine
  def works_of
  end

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

  #visualizzazioni
  def prepare_timeline
    data_table = GoogleVisualr::DataTable.new

    data_table.new_column('string', 'Name')
    data_table.new_column('string', 'Label')
    data_table.new_column('date', 'Start')
    data_table.new_column('date', 'End')

    @works.each do |work|
      data_table.add_row([work.name.to_s, work.name.to_s, work.start.to_date, work.end.to_date])
    end
    heightpx = (@works.length * 45)+40
    options = { :height => heightpx, :timeline => {singleColor: '#0080ff'} }
    GoogleVisualr::Interactive::Timeline.new(data_table, options)
  end

  def prepare_timeline_inline
    data_table = GoogleVisualr::DataTable.new

    data_table.new_column('string', 'Name')
    data_table.new_column('string', 'Label')
    data_table.new_column('date', 'Start')
    data_table.new_column('date', 'End')

    @works.each do |work|
      data_table.add_row([" ", work.name.to_s, work.start.to_date, work.end.to_date])
    end
    options = { :height => 150 }
    GoogleVisualr::Interactive::Timeline.new(data_table, options)
  end

  def pie_chart
    data_table = GoogleVisualr::DataTable.new
    data_table.new_column('string', 'Country')
    data_table.new_column('number', 'Projects')
    
    get_countries.each do |country|
      data_table.add_row([country.to_s, get_works_in_country(country)])
    end
    opts   = { :width => 400, :height => 300, :title => 'Projects per Country', :is3D => true }
    GoogleVisualr::Interactive::PieChart.new(data_table, opts)
  end

  def geo_chart_region_mode
    data_table_regions = GoogleVisualr::DataTable.new
    data_table_regions.new_column('string'  , 'Country'   )
    data_table_regions.new_column('number'  , 'Projects')
    
    get_countries.each do |country|
      data_table_regions.add_row([country.to_s, get_works_in_country(country)])
    end

    opts   = { :dataMode => 'regions', :width => 800 }
    GoogleVisualr::Interactive::GeoMap.new(data_table_regions, opts) 
  end

  def geo_chart_marker_mode
    data_table_markers = GoogleVisualr::DataTable.new
    data_table_markers.new_column('string', 'name')
    data_table_markers.new_column('number', 'projects')

    @locations.each do |loc|
      isocountry = IsoCountryCodes.search_by_name(loc.country.to_s).first
      if loc.name
        name= loc.name.to_s + ", " +  isocountry.alpha2 || loc.country.to_s
      else
        name = isocountry.alpha2 || loc.country.to_s
      end
      data_table_markers.add_row([name, loc.get_works_length_in_ds(@open_dataset) ])
    end

    opts   = { :dataMode => 'markers', :colors => ['0xFF8747', '0xFFB581', '0xc06000'], :width => 800, :showZoomOut => true}
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


  def get_globals_for_single
    @dataset = Dataset.find(params[:id])
    @works = @dataset.works 
    @locations = @dataset.locations.find(:all, :order => :name).uniq
  end

  def open_dataset
    @open_dataset = @dataset
    @@open_ds = @open_dataset
  end
end
