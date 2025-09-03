<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/jsp/include/header.jsp"/>

<div class="row g-4">
    <div class="col-12">
        <div class="card">
            <div class="card-body d-flex align-items-center justify-content-between">
                <h5 class="card-title mb-0">통계 대시보드</h5>
                <div id="globalSpinner" class="spinner-border text-primary" role="status">
                    <span class="visually-hidden">Loading...</span>
                </div>
            </div>
        </div>
    </div>

    <div class="col-md-6 col-lg-4">
        <div class="card h-100">
            <div class="card-header">상태별 민원 현황</div>
            <div class="card-body">
                <canvas id="statusChart" height="220"></canvas>
                <div class="text-center mt-2"><span id="statusTotal" class="badge bg-secondary"></span></div>
            </div>
        </div>
    </div>

    <div class="col-md-6 col-lg-4">
        <div class="card h-100">
            <div class="card-header">월별 등록 건수</div>
            <div class="card-body">
                <canvas id="monthlyChart" height="220"></canvas>
            </div>
        </div>
    </div>

    <div class="col-md-12 col-lg-4">
        <div class="card h-100">
            <div class="card-header">사용자별 등록 수</div>
            <div class="card-body">
                <canvas id="userChart" height="220"></canvas>
            </div>
        </div>
    </div>
</div>

<script>
    $(function() {
        const $spinner = $('#globalSpinner');
        $spinner.show();

        function toChartData(rows) {
            return {
                labels: rows.map(r => r.label),
                datasets: [{ data: rows.map(r => r.value), backgroundColor: ['#ffc107','#0d6efd','#198754','#6610f2','#20c997','#fd7e14'] }]
            };
        }

        $.getJSON('<c:url value="/api/charts/status"/>', function(res){
            const total = res.rows.reduce((a,b)=>a + (Number(b.value)||0), 0);
            new Chart(document.getElementById('statusChart'), {
                type: 'pie', data: toChartData(res.rows), options: { plugins: { legend: { position: 'bottom' } } }
            });
            $('#statusTotal').text(`총 ${total}건`);
        }).always(()=> $spinner.hide());

        $.getJSON('<c:url value="/api/charts/monthly"/>', function(res){
            new Chart(document.getElementById('monthlyChart'), {
                type: 'line', data: { labels: res.rows.map(r=>r.label), datasets: [{ label:'등록', data: res.rows.map(r=>r.value), borderColor:'#0d6efd', fill:false }] },
                options: { plugins: { legend: { display: false } } }
            });
        });

        $.getJSON('<c:url value="/api/charts/users"/>', function(res){
            new Chart(document.getElementById('userChart'), {
                type: 'bar', data: { labels: res.rows.map(r=>r.label), datasets: [{ label:'등록 수', data: res.rows.map(r=>r.value), backgroundColor: '#20c997' }] },
                options: { plugins: { legend: { display: false } } }
            });
        });
    });
</script>

<jsp:include page="/WEB-INF/jsp/include/footer.jsp"/>

