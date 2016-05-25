require 'rails_helper'

describe 'User visit purchase show page' do
  let(:other_user) { create :user }
  let(:purchase) { create :purchase, :opened, owner_id: other_user.id }

  context 'unregistered' do
    it "can't leave comment" do
      visit purchase_path(purchase)

      expect(page).not_to have_content 'Прокомментировать'
    end
  end

  context 'sign-in' do
    let(:user) { create :user }
    before do
      login_as user
    end

    it 'can leave comment' do
      comment_body = 'some comment'
      visit purchase_path(purchase)
      fill_in 'comment[body]', with: comment_body
      click_on 'Прокомментировать'
      expect(page).to have_content(comment_body)
    end
  end
end
