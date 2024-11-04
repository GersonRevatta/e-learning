class CreateLessons < ActiveRecord::Migration[5.2]
  def change
    create_table :lessons do |t|
      t.string :name
      t.integer :course_id
      t.text :description
      t.boolean :is_public, default: false
      t.integer :approval_threshold, default: 0

      t.timestamps
    end
  end
end
