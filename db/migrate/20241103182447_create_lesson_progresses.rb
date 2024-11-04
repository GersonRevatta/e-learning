class CreateLessonProgresses < ActiveRecord::Migration[5.2]
  def change
    create_table :lesson_progresses do |t|
      t.integer :student_id
      t.integer :lesson_id
      t.boolean :completed, default: false

      t.timestamps
    end
  end
end
