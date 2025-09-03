package egovframework.example.mnm.vo;

import java.time.LocalDateTime;

public class MnmVO {
    private Integer mnmId;
    private String title;
    private String content;
    private String status;
    private String regUser;
    private LocalDateTime regDate;
    private LocalDateTime updDate;

    public Integer getMnmId() {
        return mnmId;
    }

    public void setMnmId(Integer mnmId) {
        this.mnmId = mnmId;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getRegUser() {
        return regUser;
    }

    public void setRegUser(String regUser) {
        this.regUser = regUser;
    }

    public LocalDateTime getRegDate() {
        return regDate;
    }

    public void setRegDate(LocalDateTime regDate) {
        this.regDate = regDate;
    }

    public LocalDateTime getUpdDate() {
        return updDate;
    }

    public void setUpdDate(LocalDateTime updDate) {
        this.updDate = updDate;
    }
}


