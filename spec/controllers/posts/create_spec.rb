# frozen_string_literal: true

describe PostsController do
  describe "POST :create" do
    subject do
      login
      post :create, params: { post: post_params }
    end


    context "only content" do
      let(:post_params) do
        {
          content: "new post"
        }
      end

      it "creates a new post" do
        expect do
          subject
        end.to change { Post.count }.by(1)

        expect(response).to have_http_status(:ok)
      end
    end
  end
end
