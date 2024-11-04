class AddPreviusLessonToLessons < ActiveRecord::Migration[5.2]
  def change
    add_reference :lessons, :previous_lesson, foreign_key: { to_table: :lessons }
  end
end
