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

        MnmDashboardApi.fetchResolutionRate().done(function(res){
            var total = Number(res.total) || 0;
            var completed = Number(res.completed) || 0;
            var percentage = (total > 0) ? (completed / total * 100) : 0;
            MnmDashboardCharts.renderResolutionRate('resolutionRateChart', total, completed);
            $('#resolutionRateText').text(percentage.toFixed(1) + '%');
        });

        // 월별 평균 처리시간(분) - 연도 선택 및 로딩
        var currentYear = new Date().getFullYear();
        var $year = $('#avgYearSelect');
        if ($year.length) {
            var years = Array.from({ length: 5 }, function(_, i){ return currentYear - i; });
            years.forEach(function(y){ $year.append('<option value="'+ y +'">'+ y +'</option>'); });
            $year.val(String(currentYear));
        }

        var avgChartInstance = null;
        function loadAvgResolution(y){
            MnmDashboardApi.fetchAvgResolutionMinutes(y).done(function(res){
                if (avgChartInstance) { avgChartInstance.destroy(); }
                avgChartInstance = MnmDashboardCharts.renderAvgResolutionMinutes('avgResolutionChart', res.rows || []);
            });
        }

        if ($year.length) {
            $year.on('change', function(){ loadAvgResolution(Number($(this).val())); });
            loadAvgResolution(currentYear);
        }
    });
})();


