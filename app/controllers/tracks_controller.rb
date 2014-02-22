class TracksController < ApplicationController

  def new
    @track = Track.new
    @albums = Album.where(:band_id => params[:band_id])
    render :new
  end

  def create
    @track = Track.new(track_params)

    if @track.save
      redirect_to band_album_track_url(params[:band_id], params[:album_id], @track.id)
    else
      flash.now[:errors] = @track.errors.full_messages
      @albums = Album.where(:band_id => params[:band_id])
      render :new
    end
  end

  def index
    @tracks = Track.all
    @band = Band.find(params[:band_id])
    @album = Album.find(params[:album_id])
    render :index
  end

  def show
    @track = Track.find(params[:id])
    render :show
  end

  def track_params
    params.require(:track).permit(:title, :album_id, :track_type, :lyrics)
  end
end
