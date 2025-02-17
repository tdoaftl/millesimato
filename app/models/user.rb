class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :clothings
  has_many :purchases  
  has_one :information, dependent: :destroy
  has_many :favorites



  validates :nickname,          presence: true
  validates :birthday,          presence: true


   # デフォルトのロールを設定（新しいユーザーには `user` がデフォルト）
   after_initialize :set_default_role, if: :new_record?

   # ロールの列挙
   enum role: { user: 'user', admin: 'admin' }
 
   private
 
   # ロールのデフォルト値を設定
   def set_default_role
     self.role ||= :user
   end
end
