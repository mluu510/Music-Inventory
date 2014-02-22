class BandsController < ApplicationController
  def new
    @band = Band.new
    render :new
  end

  def create
    @band = Band.new(band_params)
    if @band.save
      redirect_to band_url(@band)
    else
      flash.now[:errors] = @band.errors.full_messages
      render :new
    end
  end

  def index
    @bands = Band.all
    render :index
  end

  def show
    @band = Band.find(params[:id])
    @albums = @band.albums
    render :show
  end

  def destroy
    @band = Band.find(params[:id])
    if @band.destroy
      redirect_to bands_url
    else
      flash.now[:errors] = @band.errors.full_messages
      redirect_to band_url(@band)
    end
  end

  def band_params
    params.require(:band).permit(:name)
  end
end
