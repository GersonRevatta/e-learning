# frozen_string_literal: true

module Api
  module V1
    class CoursesController < ApplicationController

      before_action :set_course, only: [:show, :update, :destroy]
      before_action :authorize_professor!, only: [:create, :update, :destroy]

      def index
        @courses = Course.all
        render json: @courses, each_serializer: CourseSerializer
      end

      def show
        render json: @course, serializer: CourseSerializer
      end

      def create
        @course = current_user.courses.build(course_params)

        if @course.save
          render json: @course, status: :created, serializer: CourseSerializer
        else
          render json: { errors: @course.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def update
        if @course.update(course_params)
          render json: @course, serializer: CourseSerializer
        else
          render json: { errors: @course.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def destroy
        @course.destroy
        head :no_content
      end

      private

      def set_course
        @course = Course.find(params[:id])
      end

      def course_params
        params.require(:course).permit(:name, :description, :professor_id)
      end

      def authorize_professor!
        render json: { error: 'Unauthorized' }, status: :forbidden unless current_user&.professor?
      end

      def current_user
        @user ||= User.find(params[:professor_id])
      end
    end
  end
end
