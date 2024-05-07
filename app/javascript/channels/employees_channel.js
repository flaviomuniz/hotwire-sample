import consumer from "./consumer"

console.log('employees_channel.js loaded');

consumer.subscriptions.create("EmployeesChannel", {
  connected() {
    console.log("Connected to the employees channel");
  },

  disconnected() {
    console.log("Disconnected from the employees channel");
  },

  received() {
    // Chamado quando há dados disponíveis no canal (recebidos do servidor)
    // received() pode receber argumentos, que são os dados enviados pelo servidor, ex: received(data)
    console.log("Received data from the employees channel");
  }
});
