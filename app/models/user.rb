class User < ApplicationRecord
  after_commit :create_account_key, on: :create,  if: ->(record) { record.persisted? }
  after_initialize :generate_token

  validates_uniqueness_of :email, :phone_number, :key
  validates_presence_of :email, :phone_number, :password, :key
  validates :email, :full_name, length: { maximum: 200 }
  validates :phone_number, length: { maximum: 20 }
  validates :password, :key, :account_key, length: { maximum: 100 }
  validates :metadata, :key, :account_key, length: { maximum: 2000 }

  private

  def create_account_key
    AccessKeyWorker.perform_async(email, key)
  end

  def generate_token
    unless attribute_present?('key')
      self.key = Digest::MD5.hexdigest("#{rand.to_s}#{Time.now.to_i.to_s}")
    end
  end
end
