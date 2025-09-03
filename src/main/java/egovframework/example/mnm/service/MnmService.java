package egovframework.example.mnm.service;

import egovframework.example.mnm.vo.MnmVO;
import java.util.List;

public interface MnmService {
    List<MnmVO> selectMnmList(String title, String status, int offset, int limit);
    int countMnm(String title, String status);
    MnmVO selectMnmById(int mnmId);
    int insertMnm(MnmVO vo);
    int updateMnm(MnmVO vo);
    int deleteMnm(int mnmId);
}


