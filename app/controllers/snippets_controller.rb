class SnippetsController < ApplicationController
  before_action :set_snippet, only: [:show, :edit, :update, :destroy]
  before_action :set_box

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
      @snippet = Snippet.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def snippet_params
      params.require(:snippet).permit(:box_id, :token, :haiku, :title, :code)
    end

    def set_box
      @box = Box.find params[:box_id]
    end
end
