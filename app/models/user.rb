class User < ApplicationRecord
  before_create :set_token
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :boxes

  def to_s
    email
  end

  private

  def set_token
    self.token = ULID.generate
  end
end
