class CourseSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :lessons

  def lessons
    ActiveModelSerializers::SerializableResource.new(
      object.lessons,
      each_serializer: LessonSerializer
    )
  end
end
