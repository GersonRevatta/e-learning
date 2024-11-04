require 'rails_helper'

RSpec.describe Api::V1::LessonsController, type: :controller do
  let(:course) { create(:course) }
  let(:professor) { create(:professor) }
  let(:student) { create(:student) }

  describe 'GET #index' do
    let!(:lessons) { create_list(:lesson, 3, course: course) }

    before do
      get :index, params: { course_id: course.id }
    end

    it 'returns status 200 OK' do
      expect(response).to have_http_status(:ok)
    end

    it 'returns all lessons of the course in JSON format' do
      expect(response.content_type).to eq('application/json')
      expect(JSON.parse(response.body).size).to eq(3)
    end
  end

  describe 'GET #show' do
    let(:lesson) { create(:lesson, course: course) }

    before do
      get :show, params: { course_id: course.id, id: lesson.id }
    end

    it 'returns status 200 OK' do
      expect(response).to have_http_status(:ok)
    end

    it 'returns the lesson in JSON format' do
      expect(response.content_type).to eq('application/json')
    end
  end

  describe 'POST #create' do
    context 'when a professor creates a lesson' do
      let(:params) do
        {
          course_id: course.id,
          lesson: {
            name: 'Lesson Name',
            description: 'Lesson Description',
            approval_threshold: 70
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

      it 'creates a new lesson' do
        expect(Lesson.count).to eq(1)
        expect(Lesson.first.name).to eq('Lesson Name')
      end
    end

    context 'when a student tries to create a lesson' do
      let(:params) do
        {
          course_id: course.id,
          lesson: {
            name: 'Lesson Name',
            description: 'Lesson Description',
            approval_threshold: 70
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

      it 'does not create a new lesson' do
        expect(Lesson.count).to eq(0)
      end
    end
  end

  describe 'PATCH #update' do
    let(:lesson) { create(:lesson, course: course, name: 'Old Lesson Name') }

    context 'when a professor updates a lesson' do
      let(:params) do
        {
          course_id: course.id,
          id: lesson.id,
          lesson: { name: 'New Lesson Name' }
        }
      end

      before do
        allow(controller).to receive(:current_user).and_return(professor)
        patch :update, params: params
      end

      it 'returns status 200 OK' do
        expect(response).to have_http_status(:ok)
      end

      it 'updates the lesson name' do
        expect(lesson.reload.name).to eq('New Lesson Name')
      end
    end

    context 'when a student tries to update a lesson' do
      let(:params) do
        {
          course_id: course.id,
          id: lesson.id,
          lesson: { name: 'New Lesson Name' }
        }
      end

      before do
        allow(controller).to receive(:current_user).and_return(student)
        patch :update, params: params
      end

      it 'returns status 403 Forbidden' do
        expect(response).to have_http_status(:forbidden)
      end

      it 'does not update the lesson name' do
        expect(lesson.reload.name).to eq('Old Lesson Name')
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:lesson) { create(:lesson, course: course) }

    context 'when a professor deletes a lesson' do
      before do
        allow(controller).to receive(:current_user).and_return(professor)
        delete :destroy, params: { course_id: course.id, id: lesson.id }
      end

      it 'returns status 204 No Content' do
        expect(response).to have_http_status(:no_content)
      end

      it 'deletes the lesson' do
        expect(Lesson.exists?(lesson.id)).to be_falsey
      end
    end

    context 'when a student tries to delete a lesson' do
      before do
        allow(controller).to receive(:current_user).and_return(student)
        delete :destroy, params: { course_id: course.id, id: lesson.id }
      end

      it 'returns status 403 Forbidden' do
        expect(response).to have_http_status(:forbidden)
      end

      it 'does not delete the lesson' do
        expect(Lesson.exists?(lesson.id)).to be_truthy
      end
    end
  end
end
