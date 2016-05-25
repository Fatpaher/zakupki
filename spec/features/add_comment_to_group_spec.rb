require 'rails_helper'

describe 'User visit group show page' do
  let(:group) { create :group, :enabled }

  context 'unregistered' do
    it "can't leave comment" do
      visit group_path(group)
      expect(page).not_to have_content 'Прокомментировать'
    end
  end

  context 'sign-in' do
    let(:user) { create :user }

    before do
      login_as user
    end

    it 'can leave comment' do
      comment_body = 'Some comment'
      visit group_path(group)
      fill_in 'comment[body]', with: comment_body
      click_on 'Прокомментировать'

      expect(page).to have_content comment_body
    end
  end
end
