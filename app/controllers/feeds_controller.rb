class FeedsController < ApplicationController
  before_action :set_feed, only: [:show, :edit, :update, :destroy]

  def index
    @feeds = Feed.all.order(created_at: :desc)
  end

  def show
  end

  def new
    if params[:back]
    @feed = Feed.new(feed_params)
    else
    @feed = Feed.new
    end
  end

  def confirm
    @feed = Feed.new(feed_params)
    @feed.user_id = current_user.id

    render :new if @feed.invalid?
  end

  def edit
  end

  def create
    @feed = Feed.new(feed_params)
    @feed.user_id = current_user.id
      respond_to do |format|
        if @feed.save
          format.html { redirect_to @feed, notice: '投稿されました' }
          format.json { render :show, status: :created, location: @feed }
        else
          format.html { render :new }
          format.json { render json: @feed.errors, status: :unprocessable_entity }
        end
      end
  end

  def update
    respond_to do |format|
      if @feed.update(feed_params)
        format.html { redirect_to @feed, notice: '更新されました' }
        format.json { render :show, status: :ok, location: @feed }
      else
        format.html { render :edit }
        format.json { render json: @feed.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @feed.destroy
    respond_to do |format|
      format.html { redirect_to feeds_url, notice: '削除されました.' }
      format.json { head :no_content }
    end
  end

############################################################
  private

  def set_feed
   @feed = Feed.find(params[:id])
  end


  def feed_params
    params.require(:feed).permit(:image, :message, :image_cache)
  end

end
