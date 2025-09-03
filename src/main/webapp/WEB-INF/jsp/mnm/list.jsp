<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/jsp/include/header.jsp"/>

<div class="card">
  <div class="card-body">
    <form id="searchForm" class="row g-2 align-items-center">
      <div class="col-md-4">
        <input type="text" name="title" class="form-control" placeholder="제목 검색"/>
      </div>
      <div class="col-md-3">
        <select name="status" class="form-select">
          <option value="">전체</option>
          <option value="대기">대기</option>
          <option value="진행">진행</option>
          <option value="완료">완료</option>
        </select>
      </div>
      <div class="col-md-2">
        <button type="submit" class="btn btn-primary w-100">검색</button>
      </div>
      <div class="col-md-3 text-end">
        <button type="button" class="btn btn-success" id="btnNew">신규 등록</button>
      </div>
    </form>
  </div>
</div>

<div class="card mt-3">
  <div class="card-body">
    <div class="table-responsive">
      <table class="table table-hover" id="mnmTable">
        <thead>
          <tr>
            <th>ID</th><th>제목</th><th>상태</th><th>작성자</th><th>등록일</th><th></th>
          </tr>
        </thead>
        <tbody></tbody>
      </table>
    </div>
    <nav>
      <ul class="pagination justify-content-center" id="pager"></ul>
    </nav>
  </div>
  </div>

<!-- Modal -->
<div class="modal fade" id="mnmModal" tabindex="-1" aria-hidden="true">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
      <div class="modal-header"><h5 class="modal-title">민원</h5><button type="button" class="btn-close" data-bs-dismiss="modal"></button></div>
      <div class="modal-body">
        <form id="mnmForm">
          <input type="hidden" name="mnmId"/>
          <div class="mb-3">
            <label class="form-label">제목</label>
            <input type="text" name="title" class="form-control" required maxlength="100"/>
          </div>
          <div class="mb-3">
            <label class="form-label">내용</label>
            <textarea name="content" class="form-control" rows="8" required></textarea>
            <div class="form-text">500자 이상 입력</div>
          </div>
          <div class="mb-3">
            <label class="form-label">상태</label>
            <select name="status" class="form-select">
              <option value="대기">대기</option>
              <option value="진행">진행</option>
              <option value="완료">완료</option>
            </select>
          </div>
          <div class="mb-3">
            <label class="form-label">작성자</label>
            <input type="text" name="regUser" class="form-control" required/>
          </div>
        </form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
        <button type="button" class="btn btn-primary" id="btnSave">저장</button>
      </div>
    </div>
  </div>
</div>

<script>
  $(function(){
    const $tbody = $('#mnmTable tbody');
    const $pager = $('#pager');
    const modal = new bootstrap.Modal(document.getElementById('mnmModal'));

    function fetchList(page) {
      const params = $('#searchForm').serializeArray().reduce((acc, x) => (acc[x.name]=x.value, acc), {page});
      $.getJSON('<c:url value="/api/mnm"/>', params, function(res){
        $tbody.empty();
        res.rows.forEach(function(row){
          const tr = $('<tr/>');
          tr.append(`<td>${row.mnmId}</td><td>${row.title}</td><td>${row.status}</td><td>${row.regUser||''}</td><td>${row.regDate||''}</td>`);
          tr.append(`<td class="text-end"><button class="btn btn-sm btn-outline-primary btn-edit" data-id="${row.mnmId}">수정</button> <button class="btn btn-sm btn-outline-danger btn-del" data-id="${row.mnmId}">삭제</button></td>`);
          $tbody.append(tr);
        });
        renderPager(res.page, Math.ceil(res.total/res.size));
      });
    }

    function renderPager(page, total) {
      $pager.empty();
      for (let p = 1; p <= total; p++) {
        const li = $(`<li class="page-item ${p===page?'active':''}"><a class="page-link" href="#">${p}</a></li>`);
        li.on('click', function(e){ e.preventDefault(); fetchList(p); });
        $pager.append(li);
      }
    }

    $('#searchForm').on('submit', function(e){ e.preventDefault(); fetchList(1); });

    $('#btnNew').on('click', function(){
      $('#mnmForm')[0].reset();
      $('[name=mnmId]').val('');
      modal.show();
    });

    $tbody.on('click', '.btn-edit', function(){
      const id = $(this).data('id');
      $.getJSON(`<c:url value='/api/mnm'/>/${id}`, function(row){
        for (const k in row) { $(`[name=${k}]`).val(row[k]); }
        modal.show();
      });
    });

    $('#btnSave').on('click', function(){
      const data = Object.fromEntries(new FormData(document.getElementById('mnmForm')).entries());
      if (!data.title || data.title.length>100) return alert('제목은 100자 이내 필수입니다.');
      if (!data.content || data.content.length<500) return alert('내용은 500자 이상 필수입니다.');
      const method = data.mnmId ? 'PUT' : 'POST';
      const url = data.mnmId ? `<c:url value='/api/mnm'/>/${data.mnmId}` : `<c:url value='/api/mnm'/>`;
      $.ajax({url, method, contentType:'application/json', data: JSON.stringify(data)})
        .done(function(){ modal.hide(); fetchList(1); })
        .fail(function(xhr){ alert(xhr.responseJSON?.message || '오류가 발생했습니다.'); });
    });

    $tbody.on('click', '.btn-del', function(){
      if (!confirm('삭제하시겠습니까?')) return;
      const id = $(this).data('id');
      $.ajax({url: `<c:url value='/api/mnm'/>/${id}`, method:'DELETE'})
        .done(function(){ fetchList(1); });
    });

    fetchList(1);
  });
</script>

<jsp:include page="/WEB-INF/jsp/include/footer.jsp"/>

