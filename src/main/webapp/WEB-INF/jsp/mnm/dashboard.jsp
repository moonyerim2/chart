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
        // Static placeholder data for initial skeleton
        new Chart(document.getElementById('statusChart'), {
            type: 'pie',
            data: { labels: ['대기','진행','완료'], datasets: [{ data: [5,3,7], backgroundColor: ['#ffc107','#0d6efd','#198754'] }] },
            options: { plugins: { legend: { position: 'bottom' } } }
        });
        $('#statusTotal').text('총 15건');

        new Chart(document.getElementById('monthlyChart'), {
            type: 'line',
            data: { labels: ['1','2','3','4','5','6'], datasets: [{ label:'등록', data: [1,2,3,4,3,5], borderColor:'#0d6efd', fill:false }] },
            options: { plugins: { legend: { display: false } } }
        });

        new Chart(document.getElementById('userChart'), {
            type: 'bar',
            data: { labels: ['user1','user2','user3'], datasets: [{ label:'등록 수', data: [3,5,2], backgroundColor: '#20c997' }] },
            options: { plugins: { legend: { display: false } } }
        });
        $spinner.hide();
    });
</script>

<jsp:include page="/WEB-INF/jsp/include/footer.jsp"/>

