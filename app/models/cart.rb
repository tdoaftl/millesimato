class Cart < ApplicationRecord
  belongs_to :user, optional: true  # ゲストカートは user_id が nil
  has_many :cart_items, dependent: :destroy

  before_save :set_expiration

  def expired?
    expires_at.present? && expires_at < Time.current
  end

  def clear_if_expired
    destroy if expired?
  end

  private

  def set_expiration
    self.expires_at = 1.hour.from_now
  end
end
