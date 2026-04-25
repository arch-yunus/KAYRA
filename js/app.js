document.addEventListener('DOMContentLoaded', () => {

    /* --- Tab Navigation --- */
    const navItems = document.querySelectorAll('.nav-links li');
    const tabContents = document.querySelectorAll('.tab-content');

    navItems.forEach(item => {
        item.addEventListener('click', () => {
            // Remove active classes
            navItems.forEach(n => n.classList.remove('active'));
            tabContents.forEach(t => t.classList.remove('active'));

            // Add active class to clicked item
            item.classList.add('active');
            
            // Show corresponding tab
            const tabId = item.getAttribute('data-tab');
            document.getElementById(tabId).classList.add('active');
        });
    });

    /* --- Daily Discipline Tracker --- */
    const checkboxes = document.querySelectorAll('#daily-checklist input[type="checkbox"]');
    const progressBar = document.getElementById('daily-progress');
    const percentText = document.getElementById('completion-text');
    const statusDesc = document.getElementById('status-desc');
    const statusCircle = document.querySelector('.status-circle');

    // Load saved state
    const today = new Date().toDateString();
    let savedData = JSON.parse(localStorage.getItem('kayra_daily')) || {};
    
    if(savedData.date !== today) {
        // Reset if it's a new day
        savedData = { date: today, checks: [false, false, false, false] };
        localStorage.setItem('kayra_daily', JSON.stringify(savedData));
    }

    checkboxes.forEach((cb, index) => {
        cb.checked = savedData.checks[index];
        cb.addEventListener('change', updateProgress);
    });

    function updateProgress() {
        let points = 0;
        let checksArr = [];

        checkboxes.forEach((cb, index) => {
            checksArr[index] = cb.checked;
            if(cb.checked) {
                points += parseInt(cb.getAttribute('data-points'));
            }
        });

        // Save state
        savedData.checks = checksArr;
        localStorage.setItem('kayra_daily', JSON.stringify(savedData));

        // Update UI
        progressBar.style.width = points + '%';
        percentText.innerText = points + '%';

        // Update Status
        if(points === 0) {
            statusDesc.innerText = "Derin Gaflet. Kalk ve savaş.";
            statusCircle.style.borderColor = "rgba(255, 255, 255, 0.1)";
            statusCircle.style.color = "rgba(255, 255, 255, 0.5)";
        } else if(points <= 50) {
            statusDesc.innerText = "Hazırlık Evresi. Disiplini artır.";
            statusCircle.style.borderColor = "#ff9800";
            statusCircle.style.color = "#ff9800";
        } else if(points <= 75) {
            statusDesc.innerText = "Yüksek Şuur. Direncini koru.";
            statusCircle.style.borderColor = "#00d4ff";
            statusCircle.style.color = "#00d4ff";
        } else {
            statusDesc.innerText = "MUTLAK ALPEREN. Nizam sağlandı.";
            statusCircle.style.borderColor = "#00e676";
            statusCircle.style.color = "#00e676";
            statusCircle.style.boxShadow = "0 0 20px rgba(0, 230, 118, 0.5)";
        }
    }

    // Init progress on load
    updateProgress();

    /* --- War Chest Logic --- */
    const targetInput = document.getElementById('target-saving');
    const currentInput = document.getElementById('current-saving');
    const savingFill = document.getElementById('saving-fill');
    const updateChestBtn = document.getElementById('update-chest');

    // Load saved chest data
    const savedChest = JSON.parse(localStorage.getItem('kayra_warchest'));
    if(savedChest) {
        targetInput.value = savedChest.target;
        currentInput.value = savedChest.current;
    }

    function updateChest() {
        const target = parseFloat(targetInput.value) || 1;
        const current = parseFloat(currentInput.value) || 0;
        
        let percentage = (current / target) * 100;
        if(percentage > 100) percentage = 100;

        savingFill.style.width = percentage + '%';

        localStorage.setItem('kayra_warchest', JSON.stringify({
            target: target,
            current: current
        }));
    }

    updateChestBtn.addEventListener('click', updateChest);
    
    // Init warchest on load
    setTimeout(updateChest, 500);

});
