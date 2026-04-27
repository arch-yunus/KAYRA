document.addEventListener('DOMContentLoaded', () => {
    const checklist = document.getElementById('daily-checklist');
    const progressBar = document.getElementById('daily-progress');
    const completionText = document.getElementById('completion-text');
    const statusDesc = document.getElementById('status-desc');
    const updateChestBtn = document.getElementById('update-chest');
    const navLinks = document.querySelectorAll('.nav-links li');
    const tabContents = document.querySelectorAll('.tab-content');

    const ranks = [
        "Gafil (Uykuda)",
        "Nefs-i Emmare",
        "Nefs-i Levvame",
        "Fütüvvet Yolcusu",
        "Alperen (Gazi-Derviş)"
    ];

    // Tab Navigation
    navLinks.forEach(link => {
        link.addEventListener('click', () => {
            const target = link.dataset.tab;
            
            navLinks.forEach(l => l.classList.remove('active'));
            link.classList.add('active');
            
            tabContents.forEach(content => {
                content.classList.remove('active');
                if (content.id === target) content.classList.add('active');
            });
        });
    });

    // Load State
    const loadState = () => {
        const saved = JSON.parse(localStorage.getItem('kayra_state') || '{}');
        checklist.querySelectorAll('input[type="checkbox"]').forEach(cb => {
            if (saved[cb.id]) cb.checked = true;
        });
        
        const warchest = JSON.parse(localStorage.getItem('kayra_warchest') || '{"target": 10000, "current": 0}');
        document.getElementById('target-saving').value = warchest.target;
        document.getElementById('current-saving').value = warchest.current;
        
        updateProgress();
        updateWarChestVisuals();
    };

    // Save State
    const saveState = () => {
        const state = {};
        checklist.querySelectorAll('input[type="checkbox"]').forEach(cb => {
            state[cb.id] = cb.checked;
        });
        localStorage.setItem('kayra_state', JSON.stringify(state));
    };

    const updateProgress = () => {
        const checkboxes = checklist.querySelectorAll('input[type="checkbox"]');
        let totalPoints = 0;
        let earnedPoints = 0;

        checkboxes.forEach(cb => {
            const points = parseInt(cb.dataset.points);
            totalPoints += points;
            if (cb.checked) earnedPoints += points;
        });

        const percentage = Math.round((earnedPoints / totalPoints) * 100) || 0;
        progressBar.style.width = `${percentage}%`;
        completionText.innerText = `${percentage}%`;

        // Update Rank
        let rankIndex = Math.floor(percentage / 21);
        if (rankIndex >= ranks.length) rankIndex = ranks.length - 1;
        statusDesc.innerHTML = `Makam: <strong>${ranks[rankIndex]}</strong>`;
        
        saveState();
    };

    const updateWarChestVisuals = () => {
        const target = parseFloat(document.getElementById('target-saving').value) || 1;
        const current = parseFloat(document.getElementById('current-saving').value) || 0;
        const fill = document.getElementById('saving-fill');
        
        const percentage = Math.min(Math.round((current / target) * 100), 100);
        fill.style.width = `${percentage}%`;
        
        localStorage.setItem('kayra_warchest', JSON.stringify({target, current}));
    };

    // Events
    checklist.addEventListener('change', updateProgress);
    
    updateChestBtn.addEventListener('click', () => {
        updateWarChestVisuals();
        alert("Lojistik sandığı güncellendi. Bereketli olsun!");
    });

    // Initial Load
    loadState();
});
