class BoxesController < ApplicationController
  before_action :authenticate_user!, except: [:show]
  before_action :set_box, only: [:show, :edit, :update, :destroy]
  before_action :set_languages, only: [:new, :edit]

  # GET /boxes
  # GET /boxes.json
  def index
    authorize Box, :index?
    @boxes = current_user.boxes
  end

  def public_index
    @boxes = Box.all.open
  end

  # GET /boxes/1
  # GET /boxes/1.json
  def show
    authorize @box, :show?
  end

  # GET /boxes/new
  def new
    @box = current_user.boxes.new
    authorize @box, :new?
  end

  # GET /boxes/1/edit
  def edit
    authorize @box, :edit?
  end

  # POST /boxes
  # POST /boxes.json
  def create
    @box = current_user.boxes.new(box_params)
    authorize @box, :create?
    respond_to do |format|
      if @box.save
        format.html { redirect_to @box, notice: 'Box was successfully created.' }
        format.json { render :show, status: :created, location: @box }
      else
        format.html { render :new }
        format.json { render json: @box.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /boxes/1
  # PATCH/PUT /boxes/1.json
  def update
    authorize @box, :update?
    respond_to do |format|
      if @box.update(box_params)
        format.html { redirect_to @box, notice: 'Box was successfully updated.' }
        format.json { render :show, status: :ok, location: @box }
      else
        format.html { render :edit }
        format.json { render json: @box.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /boxes/1
  # DELETE /boxes/1.json
  def destroy
    authorize @box, :destroy?
    @box.destroy
    respond_to do |format|
      format.html { redirect_to boxes_url, notice: 'Box was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_box
      @box = Box.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def box_params
      params.require(:box).permit(:token, :user_id, :title, :privacy_level, :box_language)
    end

    def set_languages
      @languages = [:ruby, :html, :csv, :css, :erb, :haml, :json, :php, :javascript, :sql, :text, :xml, :yaml]
    end
end
