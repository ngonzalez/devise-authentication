class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :database_authenticatable, :token_authenticatable

  validates :first_name, :last_name, presence: true

  acts_as_paranoid

  has_paper_trail

  before_save do |user|
    user.alias_name = ('A'..'Z').to_a.shuffle.take(3).join if user.alias_name.blank?
    user.alias_name = user.alias_name.upcase.strip.gsub(/[^a-z]/i, '')[0..2]
  end
end
