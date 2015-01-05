require_dependency 'roles_controller'

module AdminInfoReadonly
    module RolesControllerPatch
        def self.included(base)
            base.send(:include, InstanceMethods)
            base.class_eval do 
                before_filter :require_admin, :except => [:index, :show,:edit_admin_info_readonly]
                before_filter :find_role, :only => [:show, :edit, :update, :destroy,:edit_admin_info_readonly]
            end
        end

        module InstanceMethods
            def edit_admin_info_readonly
                                
            end

        end


    end
end

RolesController.send(:include, AdminInfoReadonly::RolesControllerPatch)
