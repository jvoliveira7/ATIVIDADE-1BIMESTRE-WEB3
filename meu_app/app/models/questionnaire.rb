class Questionnaire < ApplicationRecord
  belongs_to :user
  has_many :questions
  has_many :attempts
end
