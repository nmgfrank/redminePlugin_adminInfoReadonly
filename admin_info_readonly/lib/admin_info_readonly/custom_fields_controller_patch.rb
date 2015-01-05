require_dependency 'custom_fields_controller'


module AdminInfoReadonly
    module CustomFieldsControllerPatch
        def self.included(base)
            base.send(:include, InstanceMethods)
            base.class_eval do 
                before_filter :require_admin, :except => [:index_admin_info_readonly,:modify_edit_admin_info_readonly]
                
            end
        end

        module InstanceMethods
            def index_admin_info_readonly
                @custom_fields_by_type = CustomField.all.group_by {|f| f.class.name }
                @tab = params[:tab] || 'IssueCustomField'
            end  
            
            def modify_edit_admin_info_readonly
                find_custom_field
                extension_infos = CustomFieldsExtension.where(["custom_field_id = ?",params[:id]])
                
                @users = User.order("lastname").select {|u| u.active? }
                
                @extension_info = extension_infos.blank? ? nil : extension_infos[0]
               
            end            
            
            
                     
        end
    end
end

CustomFieldsController.send(:include, AdminInfoReadonly::CustomFieldsControllerPatch)
