(function waitForDeps() {
    if (!window.jQuery || !window.Chart || !window.MnmDashboardApi || !window.MnmDashboardCharts) {
        setTimeout(waitForDeps, 50);
        return;
    }
    jQuery(function($) {
        const $spinner = $('#globalSpinner');
        if ($spinner.length) {
            $spinner.show();
        }

        MnmDashboardApi.fetchStatus().done(res => {
            const rows = res.rows || [];
            const total = rows.reduce((a, b) => a + (Number(b.value) || 0), 0);
            MnmDashboardCharts.renderStatus('statusChart', rows);
            $('#statusTotal').text(`총 ${total}건`);
        }).always(() => { if ($spinner.length) { $spinner.hide(); } });

        MnmDashboardApi.fetchMonthly().done(res => {
            MnmDashboardCharts.renderMonthly('monthlyChart', res.rows || []);
        });

        MnmDashboardApi.fetchUsers().done(res => {
            MnmDashboardCharts.renderUsers('userChart', res.rows || []);
        });

        MnmDashboardApi.fetchResolutionRate().done(res => {
            const total = Number(res.total) || 0;
            const completed = Number(res.completed) || 0;
            const percentage = (total > 0) ? (completed / total * 100) : 0;
            MnmDashboardCharts.renderResolutionRate('resolutionRateChart', total, completed);
            $('#resolutionRateText').text(`${percentage.toFixed(1)}%`);
        });

        // 월별 평균 처리시간(분) - 연도 선택 및 로딩
        const currentYear = new Date().getFullYear();
        const $year = $('#avgYearSelect');
        if ($year.length) {
            const years = Array.from({ length: 5 }, (_, i) => currentYear - i);
            years.forEach(y => $year.append(`<option value="${y}">${y}</option>`));
            $year.val(String(currentYear));
        }

        let avgChartInstance = null;
        const loadAvgResolution = (y) => {
            MnmDashboardApi.fetchAvgResolutionMinutes(y).done(res => {
                if (avgChartInstance) { avgChartInstance.destroy(); }
                avgChartInstance = MnmDashboardCharts.renderAvgResolutionMinutes('avgResolutionChart', res.rows || []);
            });
        };

        if ($year.length) {
            $year.on('change', () => loadAvgResolution(Number($year.val())));
            loadAvgResolution(currentYear);
        }
    });
})();


