document.addEventListener('DOMContentLoaded', () => {
    const messages = [
        "Hello there!",
        "Greetings from your awesome app!",
        "Welcome aboard!",
        "Hope you're having a great day!",
        "Glad to see you here!",
        "This is a dynamic greeting!"
    ];

    const messageElement = document.getElementById('dynamic-message');
    const greetButton = document.getElementById('greetButton');

    const fetchDataButton = document.getElementById('fetchDataButton');
    const backendDataElement = document.getElementById('backend-data');

    function getRandomMessage() {
        const randomIndex = Math.floor(Math.random() * messages.length);
        return messages[randomIndex];
    }

    messageElement.innerText = getRandomMessage();

    greetButton.addEventListener('click', () => {
        messageElement.innerText = getRandomMessage();
    });

    fetchDataButton.addEventListener('click', async () => {
        const backendUrl = 'http://backend-service:5000/api/data'; 

        try {
            const response = await fetch(backendUrl);

            if (!response.ok) {
                throw new Error(`HTTP error! status: ${response.status}`);
            }

            const data = await response.json();

            backendDataElement.innerText = JSON.stringify(data, null, 2); 
        } catch (error) {
            console.error('Error fetching data from backend:', error);
            backendDataElement.innerText = 'Failed to load data from Backend. Check console for details.';
        }
    });
});
