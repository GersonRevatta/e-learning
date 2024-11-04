class CreateStudentAnswers < ActiveRecord::Migration[5.2]
  def change
    create_table :student_answers do |t|
      t.integer :student_id
      t.integer :question_id
      t.text :response
      t.boolean :correct

      t.timestamps
    end
  end
end
