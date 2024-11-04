class AddStatusToLessonProgress < ActiveRecord::Migration[5.2]
  def change
    add_column :lesson_progresses, :status_progress, :integer
  end
end
