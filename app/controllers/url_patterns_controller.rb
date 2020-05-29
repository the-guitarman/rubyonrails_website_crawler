class UrlPatternsController < ApplicationController
  before_action :set_url_pattern, only: [:show, :edit, :update, :destroy]

  # GET /url_patterns
  # GET /url_patterns.json
  def index
    @pagy, @url_patterns = pagy(UrlPattern.order(:name, :asc))
  end

  # GET /url_patterns/1
  # GET /url_patterns/1.json
  def show
  end

  # GET /url_patterns/new
  def new
    @url_pattern = UrlPattern.new
  end

  # GET /url_patterns/1/edit
  def edit
  end

  # POST /url_patterns
  # POST /url_patterns.json
  def create
    @url_pattern = UrlPattern.new(url_pattern_params)

    respond_to do |format|
      if @url_pattern.save
        format.html { redirect_to @url_pattern, notice: 'Url pattern was successfully created.' }
        format.json { render :show, status: :created, location: @url_pattern }
      else
        format.html { render :new }
        format.json { render json: @url_pattern.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /url_patterns/1
  # PATCH/PUT /url_patterns/1.json
  def update
    respond_to do |format|
      if @url_pattern.update(url_pattern_params)
        format.html { redirect_to @url_pattern, notice: 'Url pattern was successfully updated.' }
        format.json { render :show, status: :ok, location: @url_pattern }
      else
        format.html { render :edit }
        format.json { render json: @url_pattern.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /url_patterns/1
  # DELETE /url_patterns/1.json
  def destroy
    @url_pattern.destroy
    respond_to do |format|
      format.html { redirect_to url_patterns_url, notice: 'Url pattern was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_url_pattern
      @url_pattern = UrlPattern.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def url_pattern_params
      params.require(:url_pattern).permit(:url, :active)
    end
end
