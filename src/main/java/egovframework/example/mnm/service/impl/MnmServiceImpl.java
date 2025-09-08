package egovframework.example.mnm.service.impl;

import egovframework.example.mnm.service.MnmService;
import egovframework.example.mnm.dao.MnmDAO;
import egovframework.example.mnm.vo.MnmVO;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import java.util.List;

@Service
public class MnmServiceImpl implements MnmService {
    private final MnmDAO mnmDAO;

    public MnmServiceImpl(MnmDAO mnmDAO) {
        this.mnmDAO = mnmDAO;
    }

    @Override
    public List<MnmVO> selectMnmList(String title, String status, int offset, int limit) {
        return mnmDAO.selectMnmList(safeLike(title), emptyToNull(status), offset, limit);
    }

    @Override
    public int countMnm(String title, String status) {
        return mnmDAO.countMnm(safeLike(title), emptyToNull(status));
    }

    @Override
    public MnmVO selectMnmById(int mnmId) {
        return mnmDAO.selectMnmById(mnmId);
    }

    @Override
    @Transactional
    public int insertMnm(MnmVO vo) {
        validate(vo, true);
        return mnmDAO.insertMnm(vo);
    }

    @Override
    @Transactional
    public int updateMnm(MnmVO vo) {
        validate(vo, false);
        return mnmDAO.updateMnm(vo);
    }

    @Override
    @Transactional
    public int deleteMnm(int mnmId) {
        return mnmDAO.deleteMnm(mnmId);
    }

    @Override
    public java.util.Map<String, Object> selectResolutionRate() {
        return mnmDAO.selectResolutionRate();
    }

    private void validate(MnmVO vo, boolean isCreate) {
        if (!StringUtils.hasText(vo.getTitle()) || vo.getTitle().length() > 100) {
            throw new IllegalArgumentException("제목은 필수이며 100자 이내여야 합니다.");
        }
        if (!StringUtils.hasText(vo.getContent()) || vo.getContent().length() < 500) {
            throw new IllegalArgumentException("내용은 필수이며 500자 이상이어야 합니다.");
        }
        if (!StringUtils.hasText(vo.getStatus())) {
            vo.setStatus("대기");
        }
    }

    private String safeLike(String input) {
        if (!StringUtils.hasText(input)) return null;
        return "%" + input.trim() + "%";
    }

    private String emptyToNull(String s) {
        return StringUtils.hasText(s) ? s : null;
    }
}


