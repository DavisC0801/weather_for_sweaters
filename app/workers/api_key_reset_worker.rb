class APIKeyResetWorker
  include Sidekiq::Worker
  sidekiq_options retry: false

  def perform
    User.all.each do |user|
      user.update(api_key: SecureRandom.hex(14))
    end
  end
end
