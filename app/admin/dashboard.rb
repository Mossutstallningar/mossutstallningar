ActiveAdmin.register_page 'Dashboard' do
  config.breadcrumb = false
  menu priority: 0

  content do
    render 'dashboard'
  end
end
