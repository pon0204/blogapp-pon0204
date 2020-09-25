class CreateProfiles < ActiveRecord::Migration[6.0]
  def change
    create_table :profiles do |t|
      t.references :user, null: false
      t.string :nicklname
      t.text :introduction #長文はtext
      t.integer :gender
      t.date :birthday
      t.boolean :subscribed, default: false#true or false
      t.timestamps
    end
  end
end

#データベースの設定 rails g model Profile カラムを追加していき,rails db:migrate
