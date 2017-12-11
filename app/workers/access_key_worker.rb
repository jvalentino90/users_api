class AccessKeyWorker
  include Sidekiq::Worker
  sidekiq_options :retry => 1

  def perform(email, key)
    key = AccessKey.get_token(email, key)
    raise Exceptions::AccessKeyNotGenerated if key.nil?
    User.find_by!(email: email).update(account_key: key)
  rescue ActiveRecord::RecordNotFound
    loggger.info "couldn't find user with email #{email}"
  end
end