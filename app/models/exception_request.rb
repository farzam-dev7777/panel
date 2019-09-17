class ExceptionRequest < ApplicationRecord

  #serialize :matter_types, Array

  self.per_page = 10
  belongs_to :user

  LOB_LIST = ["Canadian P&C", "Capital Markets", "Corporate", "Technology & Operations", "US P&C", "Wealth Management"]
  REQUEST_TYPE = {
    "EXCEPTION": "Exception",
    "ADD_TO_LAW_FIRM_PANEL": "Add to Law Firm Panel"
  }
  LAW_FIRM_CATEGORIES = {
    "PANEL": "Panel",
    "NON_PANEL": "Non Panel"
  }

  MATTER_TYPES = ["MATTER_TYPE_1", "MATTER_TYPE_2", "MATTER_TYPE_3"]
  MINORITY_OWNED_TYPE = ["Yes", "No"]
  WOMEN_OWNED_TYPE = ["Yes", "No"]

  validates_presence_of :requested_by

  belongs_to :law_firm
end
