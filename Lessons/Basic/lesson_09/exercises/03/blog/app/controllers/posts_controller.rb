class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  # GET /posts
  # GET /posts.json
  def index
    byebug
    # Check if the URL requests a date.
    if Date.valid_date?(params[:year].to_i, params[:month].to_i, params[:day].to_i)
      start_date = Date.parse("#{params[:day]}.#{params[:month]}.#{params[:year]}")
      end_date = start_date
    # Check if the URL requests a month
    elsif Date.valid_date?(params[:year].to_i, params[:month].to_i, 1)
      start_date = Date.parse("1.#{params[:month]}.#{params[:year]}")
      end_date = start_date.end_of_month
    # Check if the URL requests a year
    elsif params[:year] && Date.valid_date?(params[:year].to_i, 1, 1)
      start_date = Date.parse("1.1.#{params[:year]}")
      end_date = start_date.end_of_year
    end

    if start_date && end_date
      @posts = Post.where(published_on: start_date..end_date)
    else
      @posts = Post.all
    end
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(post_params)

    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: 'Post was successfully created.' }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def post_params
      params.require(:post).permit(:subject, :content, :published_on)
    end
end
