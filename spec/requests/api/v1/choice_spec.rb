require 'rails_helper'

RSpec.describe Api::V1::ChoiceLessonsController, type: :controller do
  let(:student) { create(:student) }
  let(:course) { create(:course) }
  let(:lesson) { create(:lesson, course: course) }
  let(:previous_lesson) { create(:lesson, course: course) }

  describe 'POST #take' do
    context 'when both lesson and student exist' do
      it 'creates or updates a lesson_progress record with status in_progress' do
        post :take, params: { id: lesson.id, student_id: student.id }

        lesson_progress = LessonProgress.find_by(student_id: student.id, lesson_id: lesson.id)
        expect(lesson_progress).not_to be_nil
        expect(lesson_progress.status_progress).to eq('in_progress')
      end

      it 'renders the lesson as JSON' do
        post :take, params: { id: lesson.id, student_id: student.id }

        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)).to include("id" => lesson.id)
      end
    end

    context 'when lesson does not exist' do
      it 'returns a not_found status with an error message' do
        post :take, params: { id: -1, student_id: student.id }

        expect(response).to have_http_status(:not_found)
        expect(JSON.parse(response.body)['error']).to eq('Lección no encontrada')
      end
    end

    context 'when student does not exist' do
      it 'returns a not_found status with an error message' do
        post :take, params: { id: lesson.id, student_id: -1 }

        expect(response).to have_http_status(:not_found)
        expect(JSON.parse(response.body)['error']).to eq('Estudiante no encontrado')
      end
    end

    context 'when lesson_progress cannot be saved' do
      before do
        allow_any_instance_of(LessonProgress).to receive(:save).and_return(false)
      end

      it 'returns an unprocessable_entity status with an error message' do
        post :take, params: { id: lesson.id, student_id: student.id }

        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)['error']).to eq('No se pudo tomar la lección')
      end
    end

    context 'when lesson has no previous_lesson_id assigned' do
      let(:lesson_without_previous) { create(:lesson, course: course, previous_lesson_id: nil) }

      it 'automatically assigns previous_lesson_id if a previous lesson exists' do
        previous_lesson
        post :take, params: { id: lesson_without_previous.id, student_id: student.id }

        lesson_without_previous.reload
        expect(lesson_without_previous.previous_lesson_id).to eq(previous_lesson.id)
      end
    end

    context 'when previous lesson is not completed' do
      let(:lesson_with_previous) { create(:lesson, course: course, previous_lesson_id: previous_lesson.id) }

      it 'returns forbidden status with an error message' do
        create(:lesson_progress, student: student, lesson: previous_lesson, status_progress: :in_progress)

        post :take, params: { id: lesson_with_previous.id, student_id: student.id }

        expect(response).to have_http_status(:forbidden)
        expect(JSON.parse(response.body)['error']).to eq('Debes completar la lección anterior antes de tomar esta.')
      end
    end

    context 'when previous lesson is completed' do
      let(:lesson_with_previous) { create(:lesson, course: course, previous_lesson_id: previous_lesson.id) }

      it 'allows taking the current lesson if previous lesson is completed' do
        create(:lesson_progress, student: student, lesson: previous_lesson, status_progress: :finish)

        post :take, params: { id: lesson_with_previous.id, student_id: student.id }

        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)).to include("id" => lesson_with_previous.id)
      end
    end
  end
end
