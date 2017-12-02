class LogisticsMailer < ApplicationMailer
  default from: '"WAYO" <system@wayocraft.com>'

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.logistics_mailer.order_info_mail.subject
  #
  def order_info_mail(attachment_file)
    attachments["order_info_#{Time.now.yesterday.strftime('%Y%m%d')}.csv"] = attachment_file
    mail(subject: "注文情報のお知らせ_#{Time.now.yesterday.strftime('%Y%m%d')}",
         to: Settings.tom.email,
         cc: Settings.wayo.email)
  end
end
