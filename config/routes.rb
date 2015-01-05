# Plugin's routes
# See: http://guides.rubyonrails.org/routing.html

match '/roles/:id/edit_admin_info_readonly', :to => 'roles#edit_admin_info_readonly', :via => [:get, :post]

match '/workflows/edit_admin_info_readonly', :to => 'workflows#edit_admin_info_readonly', :via => [:get, :post]

match '/workflows/permissions_admin_info_readonly', :to => 'workflows#permissions_admin_info_readonly', :via => [:get, :post]

match '/groups_admin_info_readonly', :to => 'groups#index_admin_info_readonly', :via => [:get, :post]

match '/groups/:id/edit_admin_info_readonly', :to => 'groups#edit_admin_info_readonly', :via => [:get, :post]

match '/custom_fields_admin_info_readonly', :to => 'custom_fields#index_admin_info_readonly', :via => [:get, :post]


match '/custom_fields/:id/modify_edit_admin_info_readonly', :to => 'custom_fields#modify_edit_admin_info_readonly', :via => [:get, :post]
