class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :addresses, dependent: :destroy
  has_many :cart_items, dependent: :destroy
  has_many :orders, dependent: :destroy

  def name
    last_name +  first_name
  end

  def name_s
    last_name + "　" + first_name
  end

  def name_kana
    last_name_kana + first_name_kana
  end

  def name_kana_s
    last_name_kana + "　" + first_name_kana
  end

end
