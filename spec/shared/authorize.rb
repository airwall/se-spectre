shared_examples "unauthenticated" do
  context "unauthenticated user" do
    it "redirect to sign in path" do
      redirect
      expect(response).to redirect_to(new_user_session_path)
    end
  end
end
