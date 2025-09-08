(function(global) {
    const getBaseUrl = () => {
        let base = global.APP_CONTEXT || '/';
        if (base && base.endsWith('/')) { base = base.slice(0, -1); }
        return base;
    };

    const fetchJson = (path, params) => {
        return jQuery.getJSON(getBaseUrl() + path, params);
    };

    const api = {
        fetchStatus: () => fetchJson('/api/charts/status'),
        fetchMonthly: () => fetchJson('/api/charts/monthly'),
        fetchUsers: () => fetchJson('/api/charts/users'),
        fetchResolutionRate: () => fetchJson('/api/charts/resolutionRate'),
        fetchAvgResolutionMinutes: (year) => fetchJson('/api/charts/avgResolutionMinutes', year ? { year } : undefined)
    };

    global.MnmDashboardApi = api;
})(window);


