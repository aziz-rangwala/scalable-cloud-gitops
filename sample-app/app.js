const express = require('express');
const app = express();
const port = process.env.PORT || 3000;

app.get('/', (req, res) => {
  res.json({ message: 'Hello from auto-scaling demo app!' });
});

app.get('/health', (req, res) => {
  res.status(200).send('OK');
});

// Simulate CPU load for HPA testing
app.get('/load', (req, res) => {
  const start = Date.now();
  while (Date.now() - start < 2000) {} // Busy wait for 2 seconds
  res.send('Load test complete');
});

app.listen(port, () => {
  console.log(`App listening at http://localhost:${port}`);
}); 