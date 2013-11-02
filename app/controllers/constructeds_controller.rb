class ConstructedsController < ApplicationController
  before_filter :authenticate_user!
  # GET /constructeds
  # GET /constructeds.json
  def index
    @constructeds = Constructed.where(user_id: current_user.id)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @constructeds }
    end
  end

  # GET /constructeds/1
  # GET /constructeds/1.json
  def show
    @constructed = Constructed.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @constructed }
    end
  end

  # GET /constructeds/new
  # GET /constructeds/new.json
  def new
    @constructed = Constructed.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @constructed }
    end
  end

  # GET /constructeds/1/edit
  def edit
    @constructed = Constructed.find(params[:id])
  end

  # POST /constructeds
  # POST /constructeds.json
  def create
    @constructed = Constructed.new(params[:constructed])
    @constructed.deckname = params[:deckname]["0"]
    @constructed.user_id = current_user.id
    @deck = Deck.where(:name => @constructed.deckname)[0]
    if @constructed.win
      @deck.wins = @deck.wins + 1
    else
      @deck.loses = @deck.loses + 1
    end
    @deck.save
    respond_to do |format|
      if @constructed.save
        format.html { redirect_to @constructed, notice: 'Constructed was successfully created.' }
        format.json { render json: @constructed, status: :created, location: @constructed }
      else
        format.html { render action: "new" }
        format.json { render json: @constructed.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /constructeds/1
  # PUT /constructeds/1.json
  def update
    @constructed = Constructed.find(params[:id])

    respond_to do |format|
      if @constructed.update_attributes(params[:constructed])
        format.html { redirect_to @constructed, notice: 'Constructed was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @constructed.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /constructeds/1
  # DELETE /constructeds/1.json
  def destroy
    @constructed = Constructed.find(params[:id])
    @constructed.destroy

    respond_to do |format|
      format.html { redirect_to constructeds_url }
      format.json { head :no_content }
    end
  end
end