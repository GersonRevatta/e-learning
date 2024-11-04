class CreateQuestions < ActiveRecord::Migration[5.2]
  def change
    create_table :questions do |t|
      t.text :content
      t.integer :question_type
      t.integer :lesson_id
      t.integer :score, default: 0

      t.timestamps
    end
  end
end
