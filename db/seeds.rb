# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

SchoolGrade.destroy_all
school_grade_list = [{ grade: 10 }, { grade: 11 }, { grade: 12 }, { grade: 13 } ]
school_grades = SchoolGrade.create(school_grade_list)

SchoolYear.destroy_all
school_year_list = [{ year: '2020' }, { year: '2020/2021', current: true }]
school_years = SchoolYear.create(school_year_list)

SchoolQuarter.destroy_all
school_quarter_list = [{ quarter: 1, current: true }, { quarter: 2 }, { quarter: 3}]
school_quarters = SchoolQuarter.create(school_quarter_list)

Subject.destroy_all
subject_list = [
  { description: 'Matemática', acronymn: 'MAT' }, { description: 'Técnicas e Linguagens de Programação', acronymn: 'TLP' }
]
subjects = Subject.create(subject_list)

Course.destroy_all
course_list = [
  { description: 'Informática', acronymn: 'INFO', kind: 'Técnico' }, 
  { description: 'Ciências Físicas e Biológicas', acronymn: 'CFB', kind: 'PUNIV' }
]
courses = Course.create(course_list)

CourseSubject.destroy_all
course_subject_list = [
  { course: courses.first, subject: subjects.first, school_grade: school_grades.first },
  { course: courses.first, subject: subjects.last, school_grade: school_grades.first },
  { course: courses.first, subject: subjects.last, school_grade: school_grades.second},
  { course: courses.last, subject: subjects.first, school_grade: school_grades.first },
  { course: courses.first, subject: subjects.first, school_grade: school_grades.second },
]
course_subjects = CourseSubject.create(course_subject_list)

Batch.destroy_all
batch_list = [
  { course: courses.first, school_year: school_years.first, school_grade: school_grades.first },
  { course: courses.first, school_year: school_years.last, school_grade: school_grades.first },
  { course: courses.first, school_year: school_years.last, school_grade: school_grades.second },
  { course: courses.last, school_year: school_years.last, school_grade: school_grades.first },
  { course: courses.last, school_year: school_years.last, school_grade: school_grades.second },
]
batches = Batch.create(batch_list)

Student.destroy_all
student_list = [
  { first_name: 'Mauro', last_name: 'Nassony' }, { first_name: 'Vambert', last_name: 'Capita' },
  { first_name: 'Samuel', last_name: 'Pedro' }, { first_name: 'Helmer', last_name: 'Ricardo' },
  { first_name: 'Cristina', last_name: 'Cunha' },
]
students = Student.create(student_list)

Enrollment.destroy_all
enrollment_list = [
  { batch: Batch.find_by(school_year: school_years.first), student: Student.find_by(first_name: 'Mauro') },
  { 
    batch: Batch.find_by(
      school_year: school_years.last, school_grade: school_grades.first, course: courses.first
    ),
    student: Student.find_by(first_name: 'Vambert') 
  },
  { 
    batch: Batch.find_by(
      school_year: school_years.last, school_grade: school_grades.second, course: courses.first
    ),
    student: Student.find_by(first_name: 'Samuel') 
  },
  { 
    batch: Batch.find_by(
      school_year: school_years.last, school_grade: school_grades.first, course: courses.last
    ),
    student: Student.find_by(first_name: 'Helmer') 
  },
  { 
    batch: Batch.find_by(
      school_year: school_years.last, school_grade: school_grades.second, course: courses.last
    ),
    student: Student.find_by(first_name: 'Cristina') 
  }
]
enrollments = Enrollment.create(enrollment_list)

Teacher.destroy_all
teacher_list = [
  { first_name: 'Cedrick', last_name: 'Mansoni' },
  { first_name: 'Nelson', last_name: 'Cachinda' }
]
teachers = Teacher.create(teacher_list)

User.destroy_all
user_list = teachers.map do |teacher|
  { email: "#{teacher.first_name}.#{teacher.last_name}@email.com", password: 'password', profile: teacher }
end
users = User.create(user_list)

Lecture.destroy_all
lecture_list = [
  { course_subject: course_subjects.first, batch: batches.first, teacher: teachers.last }, 
  { course_subject: course_subjects.second, batch: batches.first, teacher: teachers.first },
  { course_subject: course_subjects.first, batch: batches.second, teacher: teachers.last },
  { course_subject: course_subjects.first, batch: batches.second, teacher: teachers.first },
  { course_subject: course_subjects.last, batch: batches[2], teacher: teachers.first },
  { course_subject: course_subjects.first, batch: batches[3], teacher: teachers.last },
  { course_subject: course_subjects.first, batch: batches.last, teacher: teachers.last }
]
lectures = Lecture.create(lecture_list)


