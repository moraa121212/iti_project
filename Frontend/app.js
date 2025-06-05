function changeMessage() {
    const messageElement = document.getElementById('message');
    if (messageElement.innerText === 'Welcome to your Frontend App!') {
        messageElement.innerText = 'You clicked the button!';
    } else {
        messageElement.innerText = 'Welcome to your Frontend App!';
    }
}
