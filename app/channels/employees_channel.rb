# rubocop:disable all

class EmployeesChannel < ApplicationCable::Channel
  # Called when the client subscribes to this channel.
  def subscribed
    stream_from 'employees_channel'
  end

  # Called when the client unsubscribes from this channel.
  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
    # This is where you would remove the user from the list of active subscribers, if necessary.
  end
end
