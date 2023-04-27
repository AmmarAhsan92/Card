class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :tasks

  validates :email, presence: true, uniqueness: true, format: { with: /\A[^@\s]+@([^@.\s]+\.)+[^@.\s]+\z/ }
  validate :verify_email_domain

  enum role: { admin: 0, team_mate: 1 }

  scope :id_ordered_desc, -> { order(id: :desc) }

  before_save :update_username, if: :blank_username

  def verify_email_domain
    if %w[gmail.com hotmail.com yahoo.com].include?(email.split('@').last)
      errors.add(:email, 'cannot have the gmail, hotmail, or yahoo domain')
    end
  end

  def update_username
    self.first_name = email.slice(0..1).upcase
  end

  def blank_username
    first_name.blank?
  end
end
