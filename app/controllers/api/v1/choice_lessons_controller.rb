# frozen_string_literal: true
module Api
  module V1
    class ChoiceLessonsController < ApplicationController
      before_action :set_lesson, only: [:take]
      before_action :set_student, only: [:take]
      before_action :assign_previous_lesson_if_missing, only: [:take]
      before_action :check_previous_lesson_completion, only: [:take]

      def take
        lesson_progress = LessonProgress.find_or_initialize_by(student_id: @student&.id, lesson_id: @lesson&.id)
        lesson_progress.status_progress = :in_progress
    
        if lesson_progress.save
          render json: @lesson, serializer: LessonSerializer
        else
          render json: { error: 'No se pudo tomar la lección' }, status: :unprocessable_entity
        end
      end
    
      private
    
      def set_lesson
        @lesson = Lesson.find_by(id: params[:id])
        render json: { error: 'Lección no encontrada' }, status: :not_found unless @lesson
      end
    
      def set_student
        @student = Student.find_by(id: params[:student_id])
        return render json: { error: 'Estudiante no encontrado' }, status: :not_found unless @student
      end

   
      def assign_previous_lesson_if_missing
        if @lesson.previous_lesson_id.nil?
          last_lesson = Lesson.where(course_id: @lesson.course_id).order(:created_at).where.not(id: @lesson.id).last
          @lesson.update(previous_lesson_id: last_lesson.id) if last_lesson
        end
      end

      def check_previous_lesson_completion
        if @lesson.previous_lesson_id
          previous_progress = LessonProgress.find_by(student_id: @student.id, lesson_id: @lesson.previous_lesson_id)
          
          unless previous_progress&.finish?
            render json: { error: 'Debes completar la lección anterior antes de tomar esta.' }, status: :forbidden
          end
        end
      end

    end
  end
end
