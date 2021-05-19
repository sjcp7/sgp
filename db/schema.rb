# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_05_18_210735) do

  create_table "admins", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "batches", force: :cascade do |t|
    t.integer "course_id", null: false
    t.integer "school_year_id", null: false
    t.integer "school_grade_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "description"
    t.integer "batch_director_id"
    t.index ["batch_director_id"], name: "index_batches_on_batch_director_id"
    t.index ["course_id"], name: "index_batches_on_course_id"
    t.index ["school_grade_id"], name: "index_batches_on_school_grade_id"
    t.index ["school_year_id"], name: "index_batches_on_school_year_id"
  end

  create_table "course_subjects", force: :cascade do |t|
    t.integer "course_id", null: false
    t.integer "subject_id", null: false
    t.integer "school_grade_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["course_id"], name: "index_course_subjects_on_course_id"
    t.index ["school_grade_id"], name: "index_course_subjects_on_school_grade_id"
    t.index ["subject_id"], name: "index_course_subjects_on_subject_id"
  end

  create_table "courses", force: :cascade do |t|
    t.string "description"
    t.string "acronymn"
    t.string "kind"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "enrollments", force: :cascade do |t|
    t.integer "batch_id", null: false
    t.integer "student_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["batch_id"], name: "index_enrollments_on_batch_id"
    t.index ["student_id"], name: "index_enrollments_on_student_id"
  end

  create_table "lectures", force: :cascade do |t|
    t.integer "course_subject_id", null: false
    t.integer "batch_id", null: false
    t.integer "teacher_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["batch_id"], name: "index_lectures_on_batch_id"
    t.index ["course_subject_id"], name: "index_lectures_on_course_subject_id"
    t.index ["teacher_id"], name: "index_lectures_on_teacher_id"
  end

  create_table "requests", force: :cascade do |t|
    t.integer "teacher_id", null: false
    t.integer "test_id", null: false
    t.text "message"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["teacher_id"], name: "index_requests_on_teacher_id"
    t.index ["test_id"], name: "index_requests_on_test_id"
  end

  create_table "school_grades", force: :cascade do |t|
    t.integer "grade"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "school_quarters", force: :cascade do |t|
    t.integer "quarter"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "current"
  end

  create_table "school_years", force: :cascade do |t|
    t.string "year"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "current", default: false
  end

  create_table "student_tests", force: :cascade do |t|
    t.integer "test_id", null: false
    t.integer "student_id", null: false
    t.float "score"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["student_id"], name: "index_student_tests_on_student_id"
    t.index ["test_id"], name: "index_student_tests_on_test_id"
  end

  create_table "students", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "nif"
  end

  create_table "subjects", force: :cascade do |t|
    t.string "description"
    t.string "acronymn"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "teachers", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "tests", force: :cascade do |t|
    t.integer "lecture_id", null: false
    t.float "max_score"
    t.string "kind"
    t.integer "school_quarter_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "locked", default: false
    t.index ["lecture_id"], name: "index_tests_on_lecture_id"
    t.index ["school_quarter_id"], name: "index_tests_on_school_quarter_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "profile_type"
    t.integer "profile_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["profile_type", "profile_id"], name: "index_users_on_profile"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
