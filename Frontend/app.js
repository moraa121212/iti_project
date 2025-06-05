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

    // العناصر الجديدة للـBackend
    const fetchDataButton = document.getElementById('fetchDataButton');
    const backendDataElement = document.getElementById('backend-data');

    // دالة لاختيار رسالة عشوائية (زي ما هي)
    function getRandomMessage() {
        const randomIndex = Math.floor(Math.random() * messages.length);
        return messages[randomIndex];
    }

    // تعيين رسالة أولية عند تحميل الصفحة
    messageElement.innerText = getRandomMessage();

    // إضافة مستمع للحدث عند الضغط على زرار "Generate New Greeting"
    greetButton.addEventListener('click', () => {
        messageElement.innerText = getRandomMessage();
    });

    // --- الوظيفة الجديدة للتواصل مع الـBackend ---
    fetchDataButton.addEventListener('click', async () => {
        // الـURL بتاع الـBackend بتاعنا.
        // بما إننا بنجرب محليًا، هنفترض إن الـBackend شغال على 'http://localhost:5000'.
        // لو الـFrontend والـBackend هيشتغلوا في Docker containers مختلفة،
        // العنوان ده هيتغير لحاجة زي اسم الـService بتاع الـBackend جوه Kubernetes.
        const backendUrl = 'http://localhost:5000/api/data'; 

        try {
            // بنستخدم 'fetch' لإرسال طلب HTTP من نوع GET للـBackend
            const response = await fetch(backendUrl);

            // بنتحقق لو الاستجابة كانت ناجحة (HTTP status 200-299)
            if (!response.ok) {
                throw new Error(`HTTP error! status: ${response.status}`);
            }

            // بنحول الاستجابة لـJSON
            const data = await response.json();

            // بنعرض البيانات اللي جات من الـBackend في عنصر الـ'pre'
            backendDataElement.innerText = JSON.stringify(data, null, 2); 
            // 'null, 2' بتخلي الـJSON يتنسق بشكل مقروء (مع مسافات بادئة)
        } catch (error) {
            // بنمسك أي أخطاء ممكن تحصل (زي مشكلة في الاتصال بالـBackend)
            console.error('Error fetching data from backend:', error);
            backendDataElement.innerText = 'Failed to load data from Backend. Check console for details.';
        }
    });
});
