class ApplicationController < ActionController::Base
  before_action :set_locale

  def current_user
    ActiveDecorator::Decorator.instance.decorate(super) if super.present?
    super
  end

  def default_url_options
  {locale: I18n.locale } 
  end
  private
  def set_locale #設定言語を決める
    I18n.locale = params[:locale] || I18n.default_locale
  end
end


# /articles/1 => params[:id]
# /articles?id=1 => params[:id]
# /articles?user_status=now => params[:user_status]
# nowの値がstring型でゲットできる