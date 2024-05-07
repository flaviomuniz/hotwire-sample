import consumer from "./consumer";

console.log('employees_channel.js loaded');

consumer.subscriptions.create("EmployeesChannel", {
  connected() {
    // This is called as soon as the subscription has been started successfully.
    console.log("Connected to the employees channel");
  },

  disconnected() {
    // This is called when the subscription has been terminated by the server.
    console.log("Disconnected from the employees channel");
  },

  received() {
    // Called when new data is broadcast from the server to this channel.
    // This is where you would typically update the UI with the new data.
    // You can pass an argument to the received function in the broadcast method, eg: received(data)
    console.log("Received data from the employees channel");
  }
});
