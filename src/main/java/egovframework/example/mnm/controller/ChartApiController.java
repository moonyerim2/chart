package egovframework.example.mnm.controller;

import egovframework.example.mnm.dao.MnmDAO;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.time.LocalDate;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api/charts")
public class ChartApiController {
    private final MnmDAO mnmDAO;

    public ChartApiController(MnmDAO mnmDAO) {
        this.mnmDAO = mnmDAO;
    }

    @GetMapping("/status")
    public Map<String, Object> statusChart() {
        List<Map<String, Object>> rows = mnmDAO.countByStatus();
        return wrap(rows);
    }

    @GetMapping("/monthly")
    public Map<String, Object> monthlyChart(@RequestParam(required = false) Integer year) {
        int y = (year == null) ? LocalDate.now().getYear() : year;
        List<Map<String, Object>> rows = mnmDAO.monthlyCounts(y);
        return wrap(rows);
    }

    @GetMapping("/users")
    public Map<String, Object> usersChart() {
        List<Map<String, Object>> rows = mnmDAO.countByUser();
        return wrap(rows);
    }

    @GetMapping("/resolutionRate")
    public Map<String, Object> resolutionRateChart() {
        Map<String, Object> data = mnmDAO.selectResolutionRate();
        return data; // Directly return the map for resolution rate
    }

    @GetMapping("/avgResolutionMinutes")
    public Map<String, Object> avgResolutionMinutes(@RequestParam(required = false) Integer year) {
        int y = (year == null) ? LocalDate.now().getYear() : year;
        List<Map<String, Object>> rows = mnmDAO.monthlyAvgResolutionMinutes(y);
        return wrap(rows);
    }

    @GetMapping("/ping")
    public Map<String, String> ping() {
        return java.util.Map.of("ok", "true");
    }

    private Map<String, Object> wrap(List<Map<String, Object>> rows) {
        Map<String, Object> res = new HashMap<>();
        res.put("rows", rows);
        return res;
    }
}


