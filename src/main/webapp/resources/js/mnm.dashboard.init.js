(function waitForDeps(){
    if (!window.jQuery || !window.Chart || !window.MnmDashboardApi || !window.MnmDashboardCharts) { setTimeout(waitForDeps, 50); return; }
    jQuery(function($) {
        var $spinner = $('#globalSpinner');
        if ($spinner.length) { $spinner.show(); }

        MnmDashboardApi.fetchStatus().done(function(res){
            var rows = res.rows || [];
            var total = rows.reduce(function(a,b){ return a + (Number(b.value)||0); }, 0);
            MnmDashboardCharts.renderStatus('statusChart', rows);
            $('#statusTotal').text('총 ' + total + '건');
        }).always(function(){ if ($spinner.length) { $spinner.hide(); } });

        MnmDashboardApi.fetchMonthly().done(function(res){
            MnmDashboardCharts.renderMonthly('monthlyChart', res.rows || []);
        });

        MnmDashboardApi.fetchUsers().done(function(res){
            MnmDashboardCharts.renderUsers('userChart', res.rows || []);
        });
    });
})();


