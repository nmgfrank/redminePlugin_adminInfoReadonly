require 'redmine'

require_dependency 'admin_info_readonly/roles_controller_patch'
require_dependency 'admin_info_readonly/groups_controller_patch'
require_dependency 'admin_info_readonly/workflows_helper_patch'
require_dependency 'admin_info_readonly/workflows_controller_patch'
require_dependency 'admin_info_readonly/custom_fields_controller_patch'



Redmine::Plugin.register :admin_info_readonly do
  name 'Admin Info Readonly plugin'
  author 'nmgfrank'
  description 'It makes us to view some info which can only be view by administrator. 1. It shows the permissions of roles when we add \'_admin_info_readonly\' to the end of uri;  2. It shows the workflows of trackers and roles when we add \'_admin_info_readonly\' to the end of uri; 3. It shows the readonly groups info when we visit http://xxxx/groups/readonly/index_admin_info_readonly '
  version '0.0.1'
  url 'http://nmgfrankblog.sinaapp.com'
  author_url 'http://nmgfrankblog.sinaapp.com'
end
