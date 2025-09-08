package egovframework.example.mnm.dao;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import egovframework.example.mnm.vo.MnmVO;
import java.util.List;

@Mapper
public interface MnmDAO {
    List<MnmVO> selectMnmList(@Param("title") String title,
                               @Param("status") String status,
                               @Param("offset") int offset,
                               @Param("limit") int limit);

    int countMnm(@Param("title") String title,
                 @Param("status") String status);

    MnmVO selectMnmById(@Param("mnmId") int mnmId);

    int insertMnm(MnmVO vo);

    int updateMnm(MnmVO vo);

    int deleteMnm(@Param("mnmId") int mnmId);

    // Stats for charts
    List<java.util.Map<String, Object>> countByStatus();
    List<java.util.Map<String, Object>> monthlyCounts(@Param("year") int year);
    List<java.util.Map<String, Object>> countByUser();
    java.util.Map<String, Object> selectResolutionRate();
    List<java.util.Map<String, Object>> monthlyAvgResolutionMinutes(@Param("year") int year);
}


