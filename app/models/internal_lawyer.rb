class InternalLawyer < User

  default_scope { where(role: 'internal_lawyers') }

  has_many :matter_intakes, foreign_key: 'lawyer_id'

end