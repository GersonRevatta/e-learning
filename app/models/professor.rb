class Professor < User
  has_many :courses

  def initialize(attributes = {})
    attributes ||= {}
    super(attributes.merge(role: :professor))
  end
end
