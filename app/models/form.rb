class Form < ApplicationRecord
  include Formable
  amoeba do
    enable
  end

  STEPS = ['policy', 'process']

end
