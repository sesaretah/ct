json.extract! course, :id, :name, :course_type, :course_field, :course_grade, :course_points, :lecturer_id, :course_targets, :course_results, :course_covered, :course_softwares, :problems_period, :garding_mechanism, :created_at, :updated_at
json.url course_url(course, format: :json)
json.image root_url + url_for(course.avatar(:thumb))
