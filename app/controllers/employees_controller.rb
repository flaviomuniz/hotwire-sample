# rubocop:disable all

class EmployeesController < ApplicationController
  include Pagy::Backend

  def index
    @q = Employee.ransack(params[:q])
    @pagy, @employees = pagy(@q.result.includes(:language), items: 20)
  end

  def show
    employee_find_by_id
  end

  def edit
    employee_find_by_id
  end

  def update
    employee_find_by_id

    if @employee.update(employee_params)
      # Broadcasting updates via Turbo Streams
      Turbo::StreamsChannel.broadcast_replace_to 'employees_channel',
                                                target: "employee-#{params[:id]}",
                                                partial: 'employees/employee',
                                                locals: {
                                                  employee: @employee,
                                                  employee_highlight: true
                                                }
      # Turbo::StreamsChannel: is an ActionCable channel that allows updating parts of the page without reloading the entire page.
      # broadcast_replace_to: is a method that sends a message to a Turbo Streams broadcast channel to replace the content of an HTML element on the page.
      # target: is the CSS selector of the HTML element that will be replaced; it can be classes, id, data-attributes, etc.
      # partial: is the name of the file that will be rendered.
      # locals: are like React's Props; they are variables that can be passed to the view.

      flash.now[:success] = 'Employee was successfully updated.'

      # Appending notification to the 'notifications' DOM element
      Turbo::StreamsChannel.broadcast_append_to 'employees_channel',
                                                target: 'notifications',
                                                content: render_to_string(Noty::NotyComponent.new(flash: flash.to_h))
      # Example for updating a broadcast using ViewComponent instead of a Partial.
      # content: render_to_string(Noty::NotyComponent.new(flash: flash.to_h))
      # render_to_string: is a method that renders the ViewComponent and returns the generated HTML.

    else
      render :edit
    end
  end

  private

  def employee_find_by_id
    @employee = Employee.find(params[:id])
  end

  def employee_params
    params.require(:employee).permit(:name, :status, :email, :language_id)
    # Ensured all relevant parameters are permitted for updates
  end
end
