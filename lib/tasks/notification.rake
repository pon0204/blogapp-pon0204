namespace :notification do
  desc '利用者にメールを送付する'

  task :send_emails_from_admin, ['msg'] => :environment do |task, args|
    msg = args['msg']
    if msg.present?
    NotificationFromAdminJob.perform_later(msg)
    else 
      puts '送信できませんでした。メッセージを入力してください'
    end
  end
end

# jobを実行
# redis sidekiq等を実行しておく


# argsとは　arguments 日本語で引数
# rails notification:send_emails_from_admin\[こんにちは\]