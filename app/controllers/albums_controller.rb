class AlbumsController < ApplicationController

  def new
    @bands = Band.all
    @album = Album.new
    render :new
  end

  def create
    @album = Album.new(album_params)
    if @album.save
      redirect_to band_album_url(params[:band_id], @album.id)
    else
      flash.now[:errors] = @album.errors.full_messages
      @bands = Band.all
      render :new
    end
  end

  def index
    @band = Band.find(params[:band_id])
    @albums = @band.albums
    render :index
  end

  def show
    @album = Album.find(params[:id])
    @band = @album.band
    @tracks = @album.tracks
    render :show
  end

  def album_params
    params.require(:album).permit(:band_id, :title)
  end

end
