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

    // دالة لاختيار رسالة عشوائية
    function getRandomMessage() {
        const randomIndex = Math.floor(Math.random() * messages.length);
        return messages[randomIndex];
    }

    // تعيين رسالة أولية عند تحميل الصفحة
    messageElement.innerText = getRandomMessage();

    // إضافة مستمع للحدث عند الضغط على الزرار
    greetButton.addEventListener('click', () => {
        messageElement.innerText = getRandomMessage();
    });
});
