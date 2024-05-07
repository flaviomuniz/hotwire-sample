# rubocop:disable all

class EmployeesChannel < ApplicationCable::Channel
  def subscribed
    stream_from 'employees_channel'
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end