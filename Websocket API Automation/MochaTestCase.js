const WebSocket = require('ws');
const assert = require('assert');
const fs = require('fs');

// Create a write stream to the log file
const logStream = fs.createWriteStream('test_report.log', { flags: 'a' });

// Redirect console output to the log file
console.log = function (message) {
  logStream.write(message + '\n');
  process.stdout.write(message + '\n');
};

describe('WebSocket Testing', function () {
  let socket;

  before(function (done) {       
    // Initialize WebSocket connection before tests
    const socketUrl = 'wss://ws.derivws.com/websockets/v3?app_id=36544';
    socket = new WebSocket(socketUrl);

    socket.on('open', () => {
      console.log('WebSocket connection opened');
      done();
    });
  });

  it('should send and receive a message', function (done) {
    this.timeout(5000); // 5000 milliseconds

    const eventData = { states_list: 'id' };
    
    // Event handler for receiving messages from the WebSocket
    socket.on('message', (data) => {
        const receivedData = JSON.parse(data);
      console.log('Received message from WebSocket:');
      console.log( JSON.stringify(receivedData));
      done();
    });

    // Send an event to the WebSocket
    socket.send(JSON.stringify(eventData));
  });

  after(function (done) {
    // Close the WebSocket connection after tests
    socket.on('close', (code, reason) => {
      console.log('WebSocket connection closed:', code, reason);
      done();
    });

    socket.close();
  });
});
