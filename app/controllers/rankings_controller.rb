class RankingsController < ApplicationController
  before_action :set_ranking, only: [:show, :edit, :update, :destroy]

  # GET /rankings
  # GET /rankings.json
  def index
    @comp_ranks = {}
    @qty = Ranking.all.count
    @loop_times = 0
    @reset_times = 0
    @reg_times = 0
    Ranking.all.each do |rank|
      @loop_times += 1 
      @comp_ranks[rank.player.id] ||= {}
      @comp_ranks[rank.player.id][:overall_rank] ||= 0.0
      @comp_ranks[rank.player.id][:name] ||= "#{rank.player.first_name} #{rank.player.last_name}"
      @comp_ranks[rank.player.id][:position] ||= rank.player.position.name
      @comp_ranks[rank.player.id][:team] ||= rank.player.team
      @comp_ranks[rank.player.id][:overall_rank] += (rank.source.weight.to_f/100.0) * rank.overall_rank
    end
  end

  # GET /rankings/1
  # GET /rankings/1.json
  def show
  end

  # GET /rankings/new
  def new
    @ranking = Ranking.new
  end

  # GET /rankings/1/edit
  def edit
  end

  # POST /rankings
  # POST /rankings.json
  def create
    @ranking = Ranking.new(ranking_params)

    respond_to do |format|
      if @ranking.save
        format.html { redirect_to @ranking, notice: 'Ranking was successfully created.' }
        format.json { render action: 'show', status: :created, location: @ranking }
      else
        format.html { render action: 'new' }
        format.json { render json: @ranking.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /rankings/1
  # PATCH/PUT /rankings/1.json
  def update
    respond_to do |format|
      if @ranking.update(ranking_params)
        format.html { redirect_to @ranking, notice: 'Ranking was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @ranking.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /rankings/1
  # DELETE /rankings/1.json
  def destroy
    @ranking.destroy
    respond_to do |format|
      format.html { redirect_to rankings_url }
      format.json { head :no_content }
    end
  end

  def fetch
    @ret = Ranking.fetch
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ranking
      @ranking = Ranking.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def ranking_params
      params.require(:ranking).permit(:first_name, :last_name, :position_id, :team)
    end
end
