# frozen_string_literal: true

module Api
  module V1
    class LessonsController < ApplicationController
      before_action :set_course
      before_action :set_lesson, only: %i[show update destroy]
      before_action :authorize_professor!, only: %i[create update destroy]

      def index
        @lessons = @course.lessons
        render json: @lessons, each_serializer: LessonSerializer
      end

      def show
        render json: @lesson, serializer: LessonSerializer
      end

      def create
        @lesson = @course.lessons.build(lesson_params)

        if @lesson.save
          render json: @lesson, status: :created, serializer: LessonSerializer
        else
          render json: { errors: @lesson.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def update
        if @lesson.update(lesson_params)
          render json: @lesson, serializer: LessonSerializer
        else
          render json: { errors: @lesson.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def destroy
        @lesson.destroy
        head :no_content
      end

      private

      def set_course
        @course = Course.find(params[:course_id])
      end

      def set_lesson
        @lesson = @course.lessons.find(params[:id])
      end

      def lesson_params
        params.require(:lesson).permit(:name, :description, :approval_threshold)
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
