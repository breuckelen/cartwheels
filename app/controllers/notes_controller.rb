class NotesController < ApplicationController
    skip_before_filter :verify_authenticity_token,
        :if => Proc.new { |c| c.request.format == 'application/json' }
    before_action :set_note, only: [:show, :edit, :update, :destroy]

    def index
        @notes = Note.all
    end

    def show
    end

    def new
        @note = Note.new
    end

    def edit
    end

    def create
        @note = current_user.notes.build(note_params)
        @note.menu_item_id = params[:menu_item_id]

        respond_to do |format|
            if @note.save
                flash[:notice] = "Note was successfully created."
                format.html { redirect_to @note }
                format.json { render :show, status: :created,
                    json: {success: true}}
                format.js { render :show, status: :created,
                    json: {success: true}}
            else
                Rails.logger.debug(@note.errors.inspect)
                format.html { render :new }
                format.json { render status: :unprocessable_entity,
                    json: {success: false, errors: @note.errors}}
                format.js { render status: :unprocessable_entity,
                    json: {success: false, errors: @note.errors}}
            end
        end
    end

    def update
        respond_to do |format|
            if @note.update(note_params)
                format.html { redirect_to @note, notice: 'Note was successfully updated.' }
                format.json { render :show, status: :ok,
                    json: {success: true}}
                format.js { render :show, status: :ok,
                    json: {success: true}}
            else
                format.html { render :edit }
                format.json { render status: :unprocessable_entity,
                    json: {success: false, errors: @note.errors}}
                format.js { render status: :unprocessable_entity,
                    json: {success: false, errors: @note.errors}}
            end
        end
    end

    def destroy
        respond_to do |format|
            if current_user == @note.user or current_user.has_role? :admin
                @note.destroy
                format.html { redirect_to notes_url, notice: 'Note was successfully destroyed.' }
                format.json { render json: {success: true}}
            else
                format.html { redirect_to last_path(current_user),
                    notice: 'You do not have permission to perform this action.' }
                format.json { render json: { success: false } }
            end
        end
    end

    respond_to :json
    def data
        if params[:note].empty?
            @notes = Note.limit(search_params["limit"].to_i)
                .offset(search_params["offset"].to_i)
        else
            @notes = Note.where(data_params)
                .limit(search_params["limit"].to_i)
                .offset(search_params["offset"].to_i)
        end

        render :status => 200,
            :json => { :success => true, :data => @reviews }
    end

    def data_params
        params.require(:note).permit(:id, :user_id, :menu_item_id)
    end

    def search_params
        ps = params.permit(:offset, :limit)
        defaults = {"offset" => 0, "limit" => 20}
        defaults.merge(ps)
    end

    def note_params
        params.require(:note).permit(:text, :user_id, :menu_item_id)
    end

    def set_note
        @note = Note.find(params[:id])
    end

    private :data_params
    private :search_params
    private :note_params
    private :set_note
end
