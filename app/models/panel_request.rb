class PanelRequest < ApplicationRecord

  #serialize :matter_types, Array

  self.per_page = 10
  belongs_to :user
  belongs_to :law_firm
  accepts_nested_attributes_for :law_firm


  LOB_LIST = ["Canadian P&C / Services bancaires Particuliers et entreprises - Canada","Capital Markets / Marché des capitaux","Corporate / Services d'entreprise","Technology & Operations / Technologie et opérations (T&O)","US P&C / Services bancaires Particuliers et entreprises - É.-U.","Wealth Management / Gestion de patrimonie"]
  REQUEST_TYPE = {
    "EXCEPTION": "Exception",
    "ADD_TO_LAW_FIRM_PANEL": "Add to Law Firm Panel"
  }
  LAW_FIRM_CATEGORIES = {
    "PANEL": "Panel",
    "NON_PANEL": "Non Panel"
  }

  MATTER_TYPES = [
    "Contractual Transactions (non-lending) / Traduction contractuelle (autre que des prêt",
    "Corporate Governance / Gouvernance d'entreprise",
    "Employment (non-action) / Recrutement (aucune intervention)",
    "General Customer Inquiries / Questions générales de clients",
    "Lending and Financing (inc. secured transactions and workouts) / Financement de prê",
    "transactions garanties et les redressements)",
    "Litigation / Litiges",
    "Mergers & Acquisitions / Fusions et acquisitions",
    "New Products / Nouveaux produits",
    "Real Estate (non-lending) / Immobilier (autres que des prêts)",
    "Regulatory / Réglementation",
    "Tax / Fiscalité",
    "Trademarks / Marques",
    "Wills & Estates / Testaments/successions"
  ]
  MINORITY_OWNED_TYPE = ["Yes", "No"]
  WOMEN_OWNED_TYPE = ["Yes", "No"]

 
  validates_presence_of :requested_by, :submitted_by_email, :line_of_business, :lob_contact_name, :minority_owned, :women_owned


  def matter_types
    JSON.parse(self.read_attribute(:matter_types) || '{}').reject(&:blank?)
  end

end
