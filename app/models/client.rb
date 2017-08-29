class Client < ApplicationRecord
  validates :monthly_revenue, presence: true
  validates :asset_value, presence: true
  validates :due_date, presence: true

  validates :asset_value, numericality: { greater_than_or_equal_to: 500, message: "O valor do título deve ser de pelo menos R$ 500" }

  validates :due_date, :timeliness => {:on_or_after => lambda { Date.current + 10.days }, :type => :date}
end
