(function(global){
    function toChartData(rows) {
        return {
            labels: (rows || []).map(function(r){ return r.label; }),
            datasets: [{
                data: (rows || []).map(function(r){ return r.value; }),
                backgroundColor: ['#ffc107','#0d6efd','#198754','#6610f2','#20c997','#fd7e14']
            }]
        };
    }

    var charts = {
        renderStatus: function(containerId, rows){
            return new Chart(document.getElementById(containerId), {
                type: 'pie',
                data: toChartData(rows),
                options: { plugins: { legend: { position: 'bottom' } } }
            });
        },
        renderMonthly: function(containerId, rows){
            return new Chart(document.getElementById(containerId), {
                type: 'line',
                data: {
                    labels: (rows || []).map(function(r){ return r.label; }),
                    datasets: [{ label:'등록', data: (rows || []).map(function(r){ return r.value; }), borderColor:'#0d6efd', fill:false }]
                },
                options: { plugins: { legend: { display: false } } }
            });
        },
        renderUsers: function(containerId, rows){
            return new Chart(document.getElementById(containerId), {
                type: 'bar',
                data: {
                    labels: (rows || []).map(function(r){ return r.label; }),
                    datasets: [{ label:'등록 수', data: (rows || []).map(function(r){ return r.value; }), backgroundColor: '#20c997' }]
                },
                options: { plugins: { legend: { display: false } } }
            });
        },
        renderResolutionRate: function(containerId, total, completed) {
            var percentage = (total > 0) ? (completed / total * 100) : 0;
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
                    rotation: -90, // Start from the left
                    circumference: 180, // Half circle
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
        }
    };

    global.MnmDashboardCharts = charts;
})(window);


