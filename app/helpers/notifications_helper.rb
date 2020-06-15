module NotificationsHelper
    
    def unchecked_notifications
        @notifications = current_user.reverses_of_notification.where(checked: false)
    end
end
