class NotificationFromAdminJob < ApplicationJob
  queue_as :default

  def perform(msg) #performを絶対書く必要がある jobを実行した時にこの中身が実行される
    User.all.each do |user|
      NotificationFromAdminMailer.notify(user, msg).deliver_later
    end
  end
end

# NotificationFromAdminJob.perform_later('やっほー')
# ()のなかにメッセージをいれる