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

    <div class="col-md-6 col-lg-4">
        <div class="card h-100">
            <div class="card-header">민원 처리율</div>
            <div class="card-body d-flex flex-column align-items-center justify-content-center">
                <div style="position: relative; width: 100%; max-width: 220px;">
                    <canvas id="resolutionRateChart" height="110"></canvas>
                    <div style="position: absolute; top: 70%; left: 50%; transform: translate(-50%, -50%); font-size: 1.5rem; font-weight: bold;">
                        <span id="resolutionRateText" class="text-primary">0%</span>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="col-md-6 col-lg-8">
      <div class="card h-100">
        <div class="card-header d-flex align-items-center justify-content-between">
          <span>월별 평균 처리시간(분)</span>
          <select id="avgYearSelect" class="form-select form-select-sm" style="width:auto">
          </select>
        </div>
        <div class="card-body">
          <canvas id="avgResolutionChart" height="220"></canvas>
        </div>
      </div>
  </div>
</div>

<script src="<c:url value='/resources/js/mnm.dashboard.api.js'/>"></script>
<script src="<c:url value='/resources/js/mnm.dashboard.charts.js'/>"></script>
<script src="<c:url value='/resources/js/mnm.dashboard.init.js'/>"></script>

<jsp:include page="/WEB-INF/jsp/include/footer.jsp"/>

