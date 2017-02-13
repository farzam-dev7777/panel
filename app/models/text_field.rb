class TextField < FormField
  validates :max,
            :min,
            absence: { message: "can't be specified on text field" }

  def as
    :string
  end

  def add_validation_errors(value); end
end