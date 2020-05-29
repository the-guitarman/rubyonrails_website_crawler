class UserAgentsController < ApplicationController
  before_action :set_user_agent, only: [:show, :edit, :update, :destroy]

  # GET /user_agents
  # GET /user_agents.json
  def index
    @pagy, @user_agents = pagy(UserAgent)
  end

  # GET /user_agents/1
  # GET /user_agents/1.json
  def show
  end

  # GET /user_agents/new
  def new
    @user_agent = UserAgent.new
  end

  # GET /user_agents/1/edit
  def edit
  end

  # POST /user_agents
  # POST /user_agents.json
  def create
    @user_agent = UserAgent.new(user_agent_params)

    respond_to do |format|
      if @user_agent.save
        format.html { redirect_to @user_agent, notice: 'User agent was successfully created.' }
        format.json { render :show, status: :created, location: @user_agent }
      else
        format.html { render :new }
        format.json { render json: @user_agent.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /user_agents/1
  # PATCH/PUT /user_agents/1.json
  def update
    respond_to do |format|
      if @user_agent.update(user_agent_params)
        format.html { redirect_to @user_agent, notice: 'User agent was successfully updated.' }
        format.json { render :show, status: :ok, location: @user_agent }
      else
        format.html { render :edit }
        format.json { render json: @user_agent.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /user_agents/1
  # DELETE /user_agents/1.json
  def destroy
    @user_agent.destroy
    respond_to do |format|
      format.html { redirect_to user_agents_url, notice: 'User agent was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user_agent
      @user_agent = UserAgent.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_agent_params
      params.require(:user_agent).permit(:name)
    end
end
