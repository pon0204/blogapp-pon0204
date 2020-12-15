require 'rails_helper'

RSpec.describe 'Article', type: :system do
  let!(:user) {create(:user)}
  let!(:articles) {create_list(:article, 3, user: user)}

  it '記事一覧が表示される' do
    visit root_path    #visitでブラウザを開く capybaraの機能 
    articles.each do |article|
      expect(page).to have_css('.card_title' ,text: article.title) #そのサイトにarticleのタイトルの文字が存在しているか
    end
  end

  it '記事詳細を表示できる' do
    visit root_path
    article = articles.first
    click_on article.title
    expect(page).to have_css('.article_title' ,text: article.title) #そのサイトにarticleのタイトルの文字が存在しているか
    expect(page).to have_css('.article_content', text: article.content.to_plain_text)
  end
end