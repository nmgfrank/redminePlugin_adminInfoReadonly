require_dependency 'workflows_helper'

module AdminInfoReadonly
    module WorkflowsHelperPatch
        def self.included(base)
            base.send(:include, InstanceMethods)
            base.class_eval do 

            end
        end

        module InstanceMethods
        
          def field_permission_tag_admin_info_readonly(permissions, status, field)
            name = field.is_a?(CustomField) ? field.id.to_s : field
            options = [["", ""], [l(:label_readonly), "readonly"]]
            options << [l(:label_required), "required"] unless field_required?(field)

            select_tag("permissions[#{name}][#{status.id}]", options_for_select(options, permissions[status.id][name]), :disabled=> 'disabled', :readonly=> "readonly")
          end

        end
    end
end


WorkflowsHelper.send(:include, AdminInfoReadonly::WorkflowsHelperPatch)
