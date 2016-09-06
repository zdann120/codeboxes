# == Schema Information
#
# Table name: snippets
#
#  id         :integer          not null, primary key
#  box_id     :integer
#  token      :string
#  haiku      :string
#  title      :string
#  code       :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  slug       :string
#
# Indexes
#
#  index_snippets_on_box_id  (box_id)
#  index_snippets_on_haiku   (haiku) UNIQUE
#  index_snippets_on_slug    (slug) UNIQUE
#  index_snippets_on_token   (token) UNIQUE
#
# Foreign Keys
#
#  fk_rails_ff583d8192  (box_id => boxes.id)
#

class SnippetsController < ApplicationController
  before_action :authenticate_user!, except: [:show]
  before_action :set_snippet, only: [:show, :edit, :update, :destroy]
  before_action :set_box
  before_action :set_languages

  # GET /snippets
  # GET /snippets.json
  def index
    authorize @snippet, :index?
    @snippets = Snippet.all
  end

  # GET /snippets/1
  # GET /snippets/1.json
  def show
    authorize @snippet, :show?
  end

  # GET /snippets/new
  def new
    @snippet = @box.snippets.new
    authorize @snippet, :new?
  end

  # GET /snippets/1/edit
  def edit
    authorize @snippet, :edit?
  end

  # POST /snippets
  # POST /snippets.json
  def create
    @snippet = @box.snippets.new(snippet_params)
    authorize @snippet, :create?

    respond_to do |format|
      if @snippet.save
        @snippet.save
        format.html { redirect_to [@box, @snippet], notice: 'Snippet was successfully created.' }
        format.json { render :show, status: :created, location: @snippet }
      else
        format.html { render :new }
        format.json { render json: @snippet.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /snippets/1
  # PATCH/PUT /snippets/1.json
  def update
    authorize @snippet, :update?
    respond_to do |format|
      if @snippet.update(snippet_params)
        format.html { redirect_to [@box, @snippet], notice: 'Snippet was successfully updated.' }
        format.json { render :show, status: :ok, location: @snippet }
      else
        format.html { render :edit }
        format.json { render json: @snippet.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /snippets/1
  # DELETE /snippets/1.json
  def destroy
    authorize @snippet, :destroy?
    @snippet.destroy
    respond_to do |format|
      format.html { redirect_to @box, notice: 'Snippet was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_snippet
      @snippet = Snippet.friendly.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def snippet_params
      params.require(:snippet).permit(:box_id, :token, :haiku, :title, :code, :language, :expires, :expiration)
    end

    def set_box
      @box = Box.find params[:box_id]
    end
    
    def set_languages
      @languages = [:ruby, :html, :csv, :css, :erb, :haml, :json, :php, :javascript, :sql, :text, :xml, :yaml]
    end
end
