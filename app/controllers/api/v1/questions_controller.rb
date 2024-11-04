# frozen_string_literal: true

module Api
  module V1
    class QuestionsController < ApplicationController
      before_action :set_course
      before_action :set_lesson
      before_action :set_question, only: [:show, :update, :destroy]
      before_action :authorize_professor!, only: [:create, :update, :destroy]

      def index
        @questions = @lesson.questions
        render json: @questions
      end

      def show
        render json: @question
      end

      def new
        @question = @lesson.questions.build
        render json: @question
      end
    
      def create
        @question = @lesson.questions.build(question_params)
        if @question.save
          render json: @question, status: :created
        else
          render json: { errors: @question.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def update
        if @question.update(question_params)
          render json: @question
        else
          render json: { errors: @question.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def destroy
        @question.destroy
        head :no_content
      end

      private

      def set_course
        @course = Course.find(params[:course_id])
      end

      def set_lesson
        @lesson = @course.lessons.find(params[:lesson_id])
      end

      def set_question
        @question = @lesson.questions.find(params[:id])
      end

      def question_params
        params.require(:question).permit(:content, :question_type, :score)
      end

      def authorize_professor!
        render json: { error: 'Unauthorized' }, status: :forbidden unless current_user&.professor?
      end

      def current_user
        @user ||= User.find(params[:professor_id]) if params[:professor_id].present?
      end
    end
  end
end
