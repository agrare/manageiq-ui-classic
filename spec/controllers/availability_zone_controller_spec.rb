describe AvailabilityZoneController do
  describe "#show" do
    before do
      EvmSpecHelper.create_guid_miq_server_zone
      @zone = FactoryBot.create(:availability_zone)
      login_as FactoryBot.create(:user_admin)
    end

    subject do
      get :show, :params => {:id => @zone.id}
    end

    context "render listnav partial" do
      render_views

      it do
        is_expected.to have_http_status 200
        is_expected.to render_template(:partial => "layouts/listnav/_availability_zone")
      end
    end
  end

  describe "#show display=timeline" do
    before do
      EvmSpecHelper.create_guid_miq_server_zone
      @zone = FactoryBot.create(:availability_zone)
      login_as FactoryBot.create(:user_admin)
    end

    subject do
      get :show, :params => {:id => @zone.id, :display => 'timeline'}
    end

    context "render listnav partial" do
      render_views

      it do
        is_expected.to have_http_status 200
        is_expected.to render_template(:partial => "layouts/listnav/_availability_zone")
      end
    end
  end

  include_examples '#download_summary_pdf', :availability_zone
end
