class QuestionSerializer < ActiveModel::Serializer
  attributes :content, :question_type, :answers

  def answers
    ActiveModelSerializers::SerializableResource.new(
      object.answers,
      each_serializer: AnswerSerializer
    )
  end
end
