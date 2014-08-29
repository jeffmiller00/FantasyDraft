class PlayersController < ApplicationController
  before_action :set_player, only: [:show, :edit, :update, :destroy]

  # GET /players
  # GET /players.json
  def index
    @players = Player.all
  end

  # GET /players/1
  # GET /players/1.json
  def show
  end

  # GET /players/new
  def new
    @player = Player.new
  end

  # GET /players/1/edit
  def edit
  end

  # POST /players
  # POST /players.json
  def create
    @player = Player.new(player_params)

    respond_to do |format|
      if @player.save
        format.html { redirect_to @player, notice: 'Player was successfully created.' }
        format.json { render action: 'show', status: :created, location: @player }
      else
        format.html { render action: 'new' }
        format.json { render json: @player.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /players/1
  # PATCH/PUT /players/1.json
  def update
    respond_to do |format|
      if @player.update(player_params)
        format.html { redirect_to @player, notice: 'Player was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @player.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /players/1
  # DELETE /players/1.json
  def destroy
    @player.destroy
    respond_to do |format|
      format.html { redirect_to players_url }
      format.json { head :no_content }
    end
  end

  def fetch
    @ret = Player.fetch
    redirect_to rankings_url
  end

  def clear
    Player.clear_picks!
    redirect_to rankings_url
  end

  # PATCH/PUT /players/pick/1
  # PATCH/PUT /players/pick/1.json
  def pick
    @player = Player.find(params[:id])
    @player.pick!
    redirect_to rankings_url
  end

  def unpick
    @player = Player.find(params[:id])
    @player.unpick!
    redirect_to rankings_url
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_player
      @player = Player.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def player_params
      params.require(:player).permit(:first_name, :last_name, :position_id, :team)
    end
end
