class QuestionsController < ApplicationController
before_action :get_question, only: [:edit, :update, :destroy]
before_action :get_couch, only: [:update]


  def create
    @question = Question.new(params.require(:question).permit(:user_id, :couch_id,:question))
    get_couch

    respond_to do |format|
      if @question.save
        Message.create(user_id: @c.user_id, message:"Tienes una nueva pregunta para tu couch con id #{@c.id}", object:"question")
        format.html { redirect_to @c, notice: "Tu pregunta fue enviada" }
      else
        format.html { redirect_to @c, alert: "Tu pregunta no fue enviada" }
      end
    end

  end


  def edit

  end


  def update

    respond_to do |format|
      if @question.update(params.require(:question).permit(:answer))
        Message.create(user_id: @question.user_id, message:"Tu pregunta al couch con id #{@question.couch_id} fue respondida", object:"question")
        format.html { redirect_to @c, notice: "La pregunta fue respondida" }
      else
         format.html { redirect_to edit_question_path(@question), alert: "La pregunta no fue respondida" }
      end
    end

  end

  def destroy
    @couch = Couch.find(@question.couch_id)
    if !current_user.id == @question.user_id
      Message.create(user_id:@question.user_id, message:"Tu pregunta al couch con id #{@question.couch_id} fue dada de baja por el dueño del couch", object:"question")
    end
    @question.destroy
    redirect_to @couch, notice:"La pregunta fue eliminada correctamente"
  end

private
  def get_couch
    @c = Couch.find(@question.couch_id)
  end

  def get_question
    @question = Question.find(params[:id])
  end

end
