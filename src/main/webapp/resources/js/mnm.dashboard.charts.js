(function(global) {
    const toChartData = (rows) => ({
        labels: (rows || []).map(r => r.label),
        datasets: [{
            data: (rows || []).map(r => r.value),
            backgroundColor: ['#ffc107', '#0d6efd', '#198754', '#6610f2', '#20c997', '#fd7e14']
        }]
    });

    const charts = {
        renderStatus: (containerId, rows) => new Chart(document.getElementById(containerId), {
            type: 'pie',
            data: toChartData(rows),
            options: { plugins: { legend: { position: 'bottom' } } }
        }),
        renderMonthly: (containerId, rows) => new Chart(document.getElementById(containerId), {
            type: 'line',
            data: {
                labels: (rows || []).map(r => r.label),
                datasets: [{ label: '등록', data: (rows || []).map(r => r.value), borderColor: '#0d6efd', fill: false }]
            },
            options: { plugins: { legend: { display: false } } }
        }),
        renderUsers: (containerId, rows) => new Chart(document.getElementById(containerId), {
            type: 'bar',
            data: {
                labels: (rows || []).map(r => r.label),
                datasets: [{ label: '등록 수', data: (rows || []).map(r => r.value), backgroundColor: '#20c997' }]
            },
            options: { plugins: { legend: { display: false } } }
        }),
        renderResolutionRate: (containerId, total, completed) => {
            const percentage = (total > 0) ? (completed / total * 100) : 0;
            return new Chart(document.getElementById(containerId), {
                type: 'doughnut',
                data: {
                    labels: ['완료', '미완료'],
                    datasets: [{
                        data: [percentage, 100 - percentage],
                        backgroundColor: ['#198754', '#dee2e6'], // Green for completed, light grey for remaining
                        borderWidth: 0
                    }]
                },
                options: {
                    rotation: -90,
                    circumference: 180,
                    cutout: '80%',
                    plugins: {
                        tooltip: { enabled: false },
                        legend: { display: false }
                    },
                    elements: {
                        arc: {
                            borderRadius: 5,
                            borderAlign: 'inner'
                        }
                    }
                }
            });
        },
        renderAvgResolutionMinutes: (containerId, rows) => new Chart(document.getElementById(containerId), {
            type: 'bar',
            data: {
                labels: (rows || []).map(r => r.label),
                datasets: [{
                    label: '평균 처리시간(분)',
                    data: (rows || []).map(r => Number(r.value) || 0),
                    backgroundColor: '#6610f2'
                }]
            },
            options: { plugins: { legend: { display: false } } }
        })
    };

    global.MnmDashboardCharts = charts;
})(window);


