package egovframework.example.mnm.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/")
public class MnmController {

    @GetMapping
    public String home() {
        return "redirect:/dashboard";
    }

    @GetMapping("/dashboard")
    public String dashboard(Model model) {
        model.addAttribute("pageTitle", "통계 대시보드");
        return "mnm/dashboard";
    }

    @GetMapping("/mnm")
    public String list(Model model) {
        model.addAttribute("pageTitle", "민원 목록");
        return "mnm/list";
    }
}


