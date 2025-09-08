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
        }
    };

    global.MnmDashboardCharts = charts;
})(window);


