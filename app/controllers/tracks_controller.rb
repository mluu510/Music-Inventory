class TracksController < ApplicationController

  def new
    @track = Track.new
    @albums = Album.where(:band_id => params[:band_id])
    render :new
  end

  def create
    @track = Track.new(track_params)

    if @track.save
      redirect_to track_url(@track)
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
    @album = @track.album
    @band = @track.band
    render :show
  end

  def destroy
    @track = Track.find(params[:id])
    album = @track.album
    if @track.destroy
      redirect_to album_url(album)
    else
      flash.now[:errors] = @track.errors.full_messages
      redirect_to track_url(@track)
    end
  end

  def track_params
    params.require(:track).permit(:title, :album_id, :track_type, :lyrics)
  end
end
