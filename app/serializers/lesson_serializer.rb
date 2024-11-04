class LessonSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :questions, :is_public

  def questions
    ActiveModelSerializers::SerializableResource.new(
      object.questions,
      each_serializer: QuestionSerializer
    )
  end
end
