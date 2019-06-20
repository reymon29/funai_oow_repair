class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :notes
  has_many :repairs
  has_many :shippings
  has_many :orders
  has_many :user_onlines
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :dept, presence: true, exclusion: { in: %w(Warranty TC CC) }
  validates :location, presence: true, exclusion: { in: %w(OH CA PH) }
  validates :email, presence: true, uniqueness: true, format: { with: /[a-zA-Z0-9_.+-]+@(?:(?:[a-zA-Z0-9-]+\.)?[a-zA-Z]+\.)?(funaicorp|funaiservice|hgs)\.(com)$/, multiline: true, message: " domain is not a valid partner at this time." }
  before_validation :normalize_name, on: [ :create, :update ]
  after_destroy :destroy_online_sign_out

  private

  def normalize_name
    self.first_name = first_name.nil? ? first_name : first_name.titleize
    self.last_name = last_name.nil? ? last_name : last_name.titleize
  end

  def self.destroy_online_sign_out
    online = UserOnline.find_by(user: current_user)
    if online.nil?
    else
      online.destroy
    end
  end

end
