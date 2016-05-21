require 'rails_helper'

RSpec.describe GroupsController, type: :controller do
  let!(:user) { create(:user) }
  let!(:group) { create(:group) }

  describe 'POST#toggle_group' do
    context 'when user have already joined the group' do
      before do
        user.join_group(group)
        login_with user
      end

      context 'with parameter join' do
        it 'does nothing' do
          count = user.groups.count
          post :toggle_group, { id: group.id, toggle_group: 'join' }
          expect(response).to redirect_to group_path(group)
          expect(user.groups.reload.count).to eq(count)
        end
      end

      context 'with parameter leave' do
        it 'deletes group from users groups' do
          post :toggle_group, { id: group.id, toggle_group: 'leave' }
          expect(response).to redirect_to group_path(group)
          expect(user.groups).not_to include(group)
        end
      end
    end

    context 'when user has not yet joined the group' do
      before { login_with user }

      context 'with parameter join' do
        it 'adds group to user\'s groups' do
          post :toggle_group, { id: group.id, toggle_group: 'join' }
          expect(response).to redirect_to group_path(group)
          expect(user.groups).to include(group)
        end
      end

      context 'with parameter leave' do
        it 'deletes group from users groups' do
          post :toggle_group, { id: group.id, toggle_group: 'leave' }
          expect(response).to redirect_to group_path(group)
          expect(user.groups).not_to include(group)
        end
      end
    end
  end

  describe 'GET#show' do
      it 'renders show template' do
        group = create :group

        get :show, id: group

        expect(response).to render_template(:show)
      end
    end

  describe 'DELETE#destroy' do
      it 'redirects to login' do
        group = create :group

        delete :destroy, id: group

        expect(response).to redirect_to(new_user_session_path)
      end
    end
      
end
