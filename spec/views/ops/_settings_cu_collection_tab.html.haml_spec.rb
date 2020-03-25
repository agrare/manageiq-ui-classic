describe "ops/_settings_cu_collection_tab.html.haml" do
  let(:cluster) { FactoryBot.create(:ems_cluster) }
  let(:ems) { FactoryBot.create(:ext_management_system) }

  let(:host_1) { FactoryBot.create(:host, :ems_cluster => cluster) }
  let(:host_2) { FactoryBot.create(:host, :ems_cluster => cluster) }
  let(:host_3) { FactoryBot.create(:host, :ext_management_system => ems) }

  before do
    assign(:sb, :active_tab => "settings_cu_collection")

    MiqRegion.seed
    allow(host_1).to receive(:perf_capture_enabled?).and_return(true)
    allow(host_2).to receive(:perf_capture_enabled?).and_return(false)
    allow(host_3).to receive(:perf_capture_enabled?).and_return(true)


    @host = FactoryBot.create(:host, :name => 'Host Name')
    FactoryBot.create(:storage, :name => 'Name', :id => 1, :hosts => [@host])
    @datastore = [{:id       => 1,
                   :name     => 'Datastore',
                   :location => 'Location',
                   :capture  => false}]
    @datastore_tree = TreeBuilderDatastores.new(:datastore_tree, {}, true, :root => @datastore)
    @cluster_tree = TreeBuilderClusters.new(:cluster_tree, {}, true)
  end

  it "Check All checkbox have unique id for Clusters trees" do
    # setting up simple data to show Check All checkbox on screen
    assign(:edit, :new => {
             :all_clusters => false,
             :clusters     => [{:name => "Some Cluster", :id => "Some Id", :capture => true}]
           })
    render
    expect(response).to have_selector("input#cl_toggle")
  end

  it "Check All checkbox have unique id for Storage trees" do
    # setting up simple data to show Check All checkbox on screen
    assign(:edit, :new => {
             :all_storages => false,
             :storages     => [{:name => "Some Storage", :id => "Some Id", :capture => true}]
           })
    render
    expect(response).to have_selector("input#ds_toggle")
  end

  it "Displays note if there are no Clusters" do
    @cluster_tree = nil
    assign(:edit, :new => {:all_clusters => false})
    render
    expect(response).to have_selector("div.note b", :text => "Note: No Clusters available.")
  end

  it "Displays note if there are no Datastores" do
    @datastore_tree = nil
    assign(:edit, :new => {:all_storages => false})
    render
    expect(response).to have_selector("div.note b", :text => "Note: No Datastores available.")
  end
end
