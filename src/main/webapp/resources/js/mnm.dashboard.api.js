(function(global){
    function getBaseUrl(){
        var base = (global.APP_CONTEXT || '/');
        if (base && base.charAt(base.length-1) === '/') { base = base.slice(0, -1); }
        return base;
    }

    function fetchJson(path){
        return jQuery.getJSON(getBaseUrl() + path);
    }

    var api = {
        fetchStatus: function(){ return fetchJson('/api/charts/status'); },
        fetchMonthly: function(){ return fetchJson('/api/charts/monthly'); },
        fetchUsers: function(){ return fetchJson('/api/charts/users'); },
        fetchResolutionRate: function(){ return fetchJson('/api/charts/resolutionRate'); }
    };

    global.MnmDashboardApi = api;
})(window);


