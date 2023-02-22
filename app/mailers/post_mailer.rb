class PostMailer < ApplicationMailer
   def post_mail(picture, user)
    @picture = picture
    @current_user = user
    mail to: @current_user.email, subject: "お問い合わせの確認メール"
  end
end
