# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::QuestionsController, type: :controller do
  let(:course) { create(:course) }
  let(:lesson) { create(:lesson, course: course) }
  let(:professor) { create(:professor) }
  let(:student) { create(:student) }

  describe 'GET #index' do
    let!(:questions) { create_list(:question, 3, lesson: lesson) }

    before do
      get :index, params: { course_id: course.id, lesson_id: lesson.id }
    end

    it 'returns status 200 OK' do
      expect(response).to have_http_status(:ok)
    end

    it 'returns all questions of the lesson in JSON format' do
      expect(response.content_type).to eq('application/json')
      expect(JSON.parse(response.body).size).to eq(3)
    end
  end

  describe 'GET #show' do
    let(:question) { create(:question, lesson: lesson) }

    before do
      get :show, params: { course_id: course.id, lesson_id: lesson.id, id: question.id }
    end

    it 'returns status 200 OK' do
      expect(response).to have_http_status(:ok)
    end

    it 'returns the question in JSON format' do
      expect(response.content_type).to eq('application/json')
    end
  end

  describe 'POST #create' do
    context 'when a professor creates a question' do
      let(:params) do
        {
          course_id: course.id,
          lesson_id: lesson.id,
          question: {
            content: 'What is Rails?',
            question_type: 'single_choice'
          }
        }
      end

      before do
        allow(controller).to receive(:current_user).and_return(professor)
        post :create, params: params
      end

      it 'returns status 201 Created' do
        expect(response).to have_http_status(:created)
      end

      it 'creates a new question' do
        expect(Question.count).to eq(1)
        expect(Question.first.content).to eq('What is Rails?')
      end
    end

    context 'when a student tries to create a question' do
      let(:params) do
        {
          course_id: course.id,
          lesson_id: lesson.id,
          question: {
            content: 'What is Rails?',
            question_type: 'single_choice'
          }
        }
      end

      before do
        allow(controller).to receive(:current_user).and_return(student)
        post :create, params: params
      end

      it 'returns status 403 Forbidden' do
        expect(response).to have_http_status(:forbidden)
      end

      it 'does not create a new question' do
        expect(Question.count).to eq(0)
      end
    end
  end

  describe 'PATCH #update' do
    let(:question) { create(:question, lesson: lesson, content: 'Old Content') }

    context 'when a professor updates a question' do
      let(:params) do
        {
          course_id: course.id,
          lesson_id: lesson.id,
          id: question.id,
          question: { content: 'Updated Content' }
        }
      end

      before do
        allow(controller).to receive(:current_user).and_return(professor)
        patch :update, params: params
      end

      it 'returns status 200 OK' do
        expect(response).to have_http_status(:ok)
      end

      it 'updates the question content' do
        expect(question.reload.content).to eq('Updated Content')
      end
    end

    context 'when a student tries to update a question' do
      let(:params) do
        {
          course_id: course.id,
          lesson_id: lesson.id,
          id: question.id,
          question: { content: 'Updated Content' }
        }
      end

      before do
        allow(controller).to receive(:current_user).and_return(student)
        patch :update, params: params
      end

      it 'returns status 403 Forbidden' do
        expect(response).to have_http_status(:forbidden)
      end

      it 'does not update the question content' do
        expect(question.reload.content).to eq('Old Content')
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:question) { create(:question, lesson: lesson) }

    context 'when a professor deletes a question' do
      before do
        allow(controller).to receive(:current_user).and_return(professor)
        delete :destroy, params: { course_id: course.id, lesson_id: lesson.id, id: question.id }
      end

      it 'returns status 204 No Content' do
        expect(response).to have_http_status(:no_content)
      end

      it 'deletes the question' do
        expect(Question.exists?(question.id)).to be_falsey
      end
    end

    context 'when a student tries to delete a question' do
      before do
        allow(controller).to receive(:current_user).and_return(student)
        delete :destroy, params: { course_id: course.id, lesson_id: lesson.id, id: question.id }
      end

      it 'returns status 403 Forbidden' do
        expect(response).to have_http_status(:forbidden)
      end

      it 'does not delete the question' do
        expect(Question.exists?(question.id)).to be_truthy
      end
    end
  end
end
