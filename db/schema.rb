# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20_241_104_030_719) do
  create_table 'answers', force: :cascade do |t|
    t.text 'text'
    t.boolean 'is_correct'
    t.integer 'question_id'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'courses', force: :cascade do |t|
    t.string 'name'
    t.text 'description'
    t.integer 'professor_id'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'enrollments', force: :cascade do |t|
    t.integer 'student_id'
    t.integer 'course_id'
    t.integer 'status_enrollment'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'lesson_progresses', force: :cascade do |t|
    t.integer 'student_id'
    t.integer 'lesson_id'
    t.boolean 'completed', default: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.integer 'status_progress'
  end

  create_table 'lessons', force: :cascade do |t|
    t.string 'name'
    t.integer 'course_id'
    t.text 'description'
    t.boolean 'is_public', default: false
    t.integer 'approval_threshold', default: 0
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.integer 'previous_lesson_id'
    t.index ['previous_lesson_id'], name: 'index_lessons_on_previous_lesson_id'
  end

  create_table 'questions', force: :cascade do |t|
    t.text 'content'
    t.integer 'question_type'
    t.integer 'lesson_id'
    t.integer 'score', default: 0
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'student_answers', force: :cascade do |t|
    t.integer 'student_id'
    t.integer 'question_id'
    t.text 'response'
    t.boolean 'correct'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'users', force: :cascade do |t|
    t.string 'name'
    t.string 'email'
    t.integer 'role'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end
end
