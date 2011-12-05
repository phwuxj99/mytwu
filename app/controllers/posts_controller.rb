class PostsController < ApplicationController
  # GET /posts
  # GET /posts.json
  def index
    @posts = Post.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @posts }
    end
  end

  # GET /posts/1
  # GET /posts/1.json
  def show

    # reset flag
    ActiveRecord::Base.connection.execute("call sp_updateroster('#{params[:id]}')")

    @post = Post.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @post }
    end
  end

  # GET /posts/new
  # GET /posts/new.json
  def new
    @post = Post.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @post }
    end
  end

  # GET /posts/1/edit
  def edit
    @post = Post.find(params[:id])
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(params[:post])

    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: 'Post was successfully created.' }
        format.json { render json: @post, status: :created, location: @post }
      else
        format.html { render action: "new" }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /posts/1
  # PUT /posts/1.json
  def update
    @post = Post.find(params[:id])

    respond_to do |format|
      if @post.update_attributes(params[:post])
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post = Post.find(params[:id])
    @post.destroy

    respond_to do |format|
      format.html { redirect_to posts_url }
      format.json { head :ok }
    end
  end

  # Add player to game
  # Update rosters flags
  def addplayer

    @post = Post.find(params[:post_id])

     @roster =  @post.rosters.find(params[:id])

    # Add new row to games
     @game = @post.games.new
     @game.post_id = @post.id
     @game.playerid =  @roster.id
     @game.fname = @roster.fname
     @game.playerrank = @roster.ranks
     
     @game.save
    
    # update rosters flag
    @roster.update_attribute(:flags , '1')

    # redirect_to post_url(@post)
    redirect_to post_path(@post)
  end

  # Delete player from games
  # update rosters flags
  def remove

    @post = Post.find(params[:post_id])

    @roster =  @post.rosters.find(params[:id])

    @game = @post.games.find(params[:id])

    @game.destroy

    # update rosters flag
    @roster.update_attribute(:flags , '0')

    #@post = Post.find(params[:post_id])
    # @game = @post.games.find(params[:id])
    # @game = Game.find(params[:id])
     #@game.update_attribute(:created_at , '2011/12/01')
    # @game.update_attribute(:selectflag , '0')
    
    redirect_to post_url(@post)
    # redirect_to post_path(@post)
  end

end
