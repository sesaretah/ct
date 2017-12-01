#json.extract! question, :id, :title, :content, :user_id, :created_at, :updated_at
#json.url question_url(question, format: :json)
#json.answers question.answers
#json.image root_url + url_for(question.avatar(:thumb))



    json.title question.title
    json.id question.id
    json.content question.content
    json.image  root_url + url_for(question.user.profile.avatar(:thumb))
    json.answers do
        json.array!(question.answers) do |answer|
            json.content answer.content
            json.image root_url + url_for(answer.user.profile.avatar(:thumb))
            json.user_id answer.user_id
        end
      end
