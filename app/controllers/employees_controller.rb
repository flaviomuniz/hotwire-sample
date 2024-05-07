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
      Turbo::StreamsChannel.broadcast_replace_to 'employees_channel',
                                                  target: "employee-#{params[:id]}",
                                                  partial: 'employees/employee',
                                                  locals: {
                                                    employee: @employee,
                                                    employee_highlight: true
                                                  }

      # Turbo::StreamsChannel: é um canal de transmissão via ActionCable que permite atualizar partes da página sem recarregar a página inteira.
      # broadcast_replace_to: é um método que envia uma mensagem para um canal de transmissão Turbo Streams para substituir o conteúdo de um elemento HTML na página.
      # target: é o seletor CSS do elemento HTML que será substituído, pode ser classes, id, data-attributes, etc.
      # partial: é o nome do arquivo que será renderizado.
      # locals: é como as Props do react, são variáveis que podem ser passadas para a view.

      flash.now[:success] = 'Employee was successfully updated.'
      Turbo::StreamsChannel.broadcast_append_to 'employees_channel',
                                                target: 'notifications',
                                                content: render_to_string(Noty::NotyComponent.new(flash: flash.to_h))

      # Exemplo para atualizar uma transmissão usando ViewComponent ao invés de uma Partial.
      # content: render_to_string(Noty::NotyComponent.new(flash: flash.to_h))
      # render_to_string: é um método que renderiza o ViewComponent e retorna o HTML gerado.

    else
      render :edit
    end

  end

  private

  def employee_find_by_id
    @employee = Employee.find(params[:id])
  end

  def employee_params
    params.require(:employee).permit(:name)
  end

end