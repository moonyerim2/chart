package egovframework.example.mnm.controller;

import egovframework.example.mnm.service.MnmService;
import egovframework.example.mnm.vo.MnmVO;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api/mnm")
public class MnmApiController {
    private final MnmService mnmService;

    public MnmApiController(MnmService mnmService) {
        this.mnmService = mnmService;
    }

    @GetMapping
    public Map<String, Object> list(@RequestParam(required = false) String title,
                                    @RequestParam(required = false) String status,
                                    @RequestParam(defaultValue = "1") int page,
                                    @RequestParam(defaultValue = "10") int size) {
        int offset = (page - 1) * size;
        List<MnmVO> rows = mnmService.selectMnmList(title, status, offset, size);
        int total = mnmService.countMnm(title, status);
        Map<String, Object> res = new HashMap<>();
        res.put("rows", rows);
        res.put("total", total);
        res.put("page", page);
        res.put("size", size);
        return res;
    }

    @GetMapping("/{id}")
    public MnmVO detail(@PathVariable("id") int id) {
        return mnmService.selectMnmById(id);
    }

    @PostMapping
    public Map<String, Object> create(@RequestBody MnmVO vo) {
        int affected = mnmService.insertMnm(vo);
        return Map.of("affected", affected, "id", vo.getMnmId());
    }

    @PutMapping("/{id}")
    public Map<String, Object> update(@PathVariable("id") int id, @RequestBody MnmVO vo) {
        vo.setMnmId(id);
        int affected = mnmService.updateMnm(vo);
        return Map.of("affected", affected);
    }

    @DeleteMapping("/{id}")
    public Map<String, Object> delete(@PathVariable("id") int id) {
        int affected = mnmService.deleteMnm(id);
        return Map.of("affected", affected);
    }
}


