class PostsController < ApplicationController
 
  def index 

  @posts = Post.all
    respond_to do |format|
      format.html 
      format.json { render json: @posts }
    end
  end

  def show
    @post = Post.find(params[:id])
    votes = Vote.find_all_by_post_id(@post.id)
    userid = session[:user_logged_in]
    count = votes.size

    userpresent = false
    votesstr = ""
    votes.each do |vote|
      if vote.user_id == userid
        userpresent = true
        break
      end
    end
    if userpresent == true
      votestr = "You and "<<(count-1).to_s<<" others voted this"
    else
      votestr = count.to_s << " people voted this"
    end
    puts votestr.to_s

     @votestr = votestr

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @post }
    end
  end
  def new
    @post = Post.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @post }
    end
  end


  def edit
    @post = Post.find(params[:id])
  end
  def create
    @post = Post.new(params[:post])
    @categories = Category.find_all_by_id(@post.category_id)
    @post.user_id = session[:user_logged_in]

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

  def search
    @post = Post.search(params[:search],params[:search_by])
  end

  def update
    @post = Post.find(params[:id])

    respond_to do |format|
      if @post.update_attributes(params[:post])
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy

    respond_to do |format|
      format.html { redirect_to posts_url }
      format.json { head :no_content }
    end
  end
end
