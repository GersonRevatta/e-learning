class CreateEnrollments < ActiveRecord::Migration[5.2]
  def change
    create_table :enrollments do |t|
      t.integer :student_id
      t.integer :course_id
      t.integer :status_enrollment

      t.timestamps
    end
  end
end
