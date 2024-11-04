require 'rails_helper'

RSpec.describe Api::V1::CoursesController, type: :controller do
  describe 'POST #create' do
    let(:professor) { create(:professor) }
    let(:student) { create(:student) }

    context 'when professor creates a course' do
      let(:params) do
        {
          professor_id: professor.id,
          course: {
            name: 'Course Name',
            description: 'Course Description'
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

      it 'returns the created course in JSON format' do
        expect(response.content_type).to eq('application/json')
      end

      it 'creates a new course' do
        expect(Course.count).to eq(1)
        expect(Course.first.name).to eq('Course Name')
      end
    end

    context 'when student tries to create a course' do
      let(:params) do
        {
          professor_id: student.id,
          course: {
            name: 'Course Name',
            description: 'Course Description'
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

      it 'does not create a new course' do
        expect(Course.count).to eq(0)
      end
    end
  end

  describe 'PATCH #update' do
    let(:professor) { create(:professor) }
    let(:student) { create(:student) }
    let(:course) { create(:course, name: 'Old Course Name', professor: professor) }

    context 'when professor updates a course' do
      let(:params) { { id: course.id, course: { name: 'New Course Name' } } }

      before do
        allow(controller).to receive(:current_user).and_return(professor)
        patch :update, params: params
      end

      it 'returns status 200 OK' do
        expect(response).to have_http_status(:ok)
      end

      it 'updates the course name' do
        expect(course.reload.name).to eq('New Course Name')
      end
    end

    context 'when student tries to update a course' do
      let(:params) { { id: course.id, course: { name: 'New Course Name' } } }

      before do
        allow(controller).to receive(:current_user).and_return(student)
        patch :update, params: params
      end

      it 'returns status 403 Forbidden' do
        expect(response).to have_http_status(:forbidden)
      end

      it 'does not update the course name' do
        expect(course.reload.name).to eq('Old Course Name')
      end
    end
  end

  describe 'DELETE #destroy' do
    let(:professor) { create(:professor) }
    let(:student) { create(:student) }
    let!(:course) { create(:course, professor: professor) }

    context 'when professor deletes a course' do
      before do
        allow(controller).to receive(:current_user).and_return(professor)
        delete :destroy, params: { id: course.id }
      end

      it 'returns status 204 No Content' do
        expect(response).to have_http_status(:no_content)
      end

      it 'deletes the course' do
        expect(Course.exists?(course.id)).to be_falsey
      end
    end

    context 'when student tries to delete a course' do
      before do
        allow(controller).to receive(:current_user).and_return(student)
        delete :destroy, params: { id: course.id }
      end

      it 'returns status 403 Forbidden' do
        expect(response).to have_http_status(:forbidden)
      end

      it 'does not delete the course' do
        expect(Course.exists?(course.id)).to be_truthy
      end
    end
  end
end
