require_dependency 'groups_controller'

module AdminInfoReadonly
    module GroupsControllerPatch
        def self.included(base)
            base.send(:include, InstanceMethods)
            base.class_eval do 
                before_filter :require_admin, :except => [:index_admin_info_readonly,:edit_admin_info_readonly]
            
                before_filter :find_group, :except => [:index, :new, :create, :index_admin_info_readonly]
                accept_api_auth :index_admin_info_readonly
        
            end
        end

        module InstanceMethods
              def index_admin_info_readonly
                @groups = Group.sorted.all
              end  
              
              def edit_admin_info_readonly
                
              end
              
                        
        end
    end
end

GroupsController.send(:include, AdminInfoReadonly::GroupsControllerPatch)
