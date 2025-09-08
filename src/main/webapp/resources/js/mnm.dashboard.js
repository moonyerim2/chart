(function waitForDeps(){
    if (!window.jQuery || !window.Chart) { setTimeout(waitForDeps, 50); return; }
    jQuery(function($) {
        const $spinner = $('#globalSpinner');
        if ($spinner.length) { $spinner.show(); }

        function toChartData(rows) {
            return {
                labels: rows.map(function(r){ return r.label; }),
                datasets: [{
                    data: rows.map(function(r){ return r.value; }),
                    backgroundColor: ['#ffc107','#0d6efd','#198754','#6610f2','#20c997','#fd7e14']
                }]
            };
        }

        var base = (window.APP_CONTEXT || '/');
        if (base && base.charAt(base.length-1) === '/') { base = base.slice(0, -1); }

        $.getJSON(base + '/api/charts/status', function(res){
            var total = (res.rows || []).reduce(function(a,b){ return a + (Number(b.value)||0); }, 0);
            new Chart(document.getElementById('statusChart'), {
                type: 'pie',
                data: toChartData(res.rows || []),
                options: { plugins: { legend: { position: 'bottom' } } }
            });
            $('#statusTotal').text('총 ' + total + '건');
        }).always(function(){ if ($spinner.length) { $spinner.hide(); } });

        $.getJSON(base + '/api/charts/monthly', function(res){
            new Chart(document.getElementById('monthlyChart'), {
                type: 'line',
                data: {
                    labels: (res.rows || []).map(function(r){ return r.label; }),
                    datasets: [{ label:'등록', data: (res.rows || []).map(function(r){ return r.value; }), borderColor:'#0d6efd', fill:false }]
                },
                options: { plugins: { legend: { display: false } } }
            });
        });

        $.getJSON(base + '/api/charts/users', function(res){
            new Chart(document.getElementById('userChart'), {
                type: 'bar',
                data: {
                    labels: (res.rows || []).map(function(r){ return r.label; }),
                    datasets: [{ label:'등록 수', data: (res.rows || []).map(function(r){ return r.value; }), backgroundColor: '#20c997' }]
                },
                options: { plugins: { legend: { display: false } } }
            });
        });
    });
})();


