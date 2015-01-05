require_dependency 'workflows_controller'

module AdminInfoReadonly
    module WorkflowsControllerPatch
        def self.included(base)
            base.send(:include, InstanceMethods)
            base.class_eval do 
                before_filter :require_admin, :except => ['edit_admin_info_readonly','permissions_admin_info_readonly']
            end
        end

        module InstanceMethods
            def edit_admin_info_readonly
                @role = Role.find_by_id(params[:role_id]) if params[:role_id]
                @tracker = Tracker.find_by_id(params[:tracker_id]) if params[:tracker_id]


                @used_statuses_only = (params[:used_statuses_only] == '0' ? false : true)
                if @tracker && @used_statuses_only && @tracker.issue_statuses.any?
                  @statuses = @tracker.issue_statuses
                end
                @statuses ||= IssueStatus.sorted.all

                if @tracker && @role && @statuses.any?
                  workflows = WorkflowTransition.where(:role_id => @role.id, :tracker_id => @tracker.id).all
                  @workflows = {}
                  @workflows['always'] = workflows.select {|w| !w.author && !w.assignee}
                  @workflows['author'] = workflows.select {|w| w.author}
                  @workflows['assignee'] = workflows.select {|w| w.assignee}
                end            
                                
            end
            
            
              def permissions_admin_info_readonly
                @role = Role.find_by_id(params[:role_id]) if params[:role_id]
                @tracker = Tracker.find_by_id(params[:tracker_id]) if params[:tracker_id]



                @used_statuses_only = (params[:used_statuses_only] == '0' ? false : true)
                if @tracker && @used_statuses_only && @tracker.issue_statuses.any?
                  @statuses = @tracker.issue_statuses
                end
                @statuses ||= IssueStatus.sorted.all

                if @role && @tracker
                  @fields = (Tracker::CORE_FIELDS_ALL - @tracker.disabled_core_fields).map {|field| [field, l("field_"+field.sub(/_id$/, ''))]}
                  @custom_fields = @tracker.custom_fields

                  @permissions = WorkflowPermission.where(:tracker_id => @tracker.id, :role_id => @role.id).all.inject({}) do |h, w|
                    h[w.old_status_id] ||= {}
                    h[w.old_status_id][w.field_name] = w.rule
                    h
                  end
                  @statuses.each {|status| @permissions[status.id] ||= {}}
                end
              end

        end


    end
end

WorkflowsController.send(:include, AdminInfoReadonly::WorkflowsControllerPatch)
