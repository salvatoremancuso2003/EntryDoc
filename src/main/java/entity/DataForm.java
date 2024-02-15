package entity;

import java.io.Serializable;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import java.util.Date;
import javax.persistence.Table;

@Entity
@Table(name="Dati")
public class DataForm implements Serializable {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    
    private Long id;

    private String inpu1;

    private String input2;

    private String input3;

    private String input4;

    private String input5;

    private String input6;

    private String input7;

    @Temporal(TemporalType.DATE)
    private Date dob;

    private String input8;

    private String input9;

    public DataForm() {
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getInpu1() {
        return inpu1;
    }

    public void setInpu1(String inpu1) {
        this.inpu1 = inpu1;
    }

    public String getInput2() {
        return input2;
    }

    public void setInput2(String input2) {
        this.input2 = input2;
    }

    public String getInput3() {
        return input3;
    }

    public void setInput3(String input3) {
        this.input3 = input3;
    }

    public String getInput4() {
        return input4;
    }

    public void setInput4(String input4) {
        this.input4 = input4;
    }

    public String getInput5() {
        return input5;
    }

    public void setInput5(String input5) {
        this.input5 = input5;
    }

    public String getInput6() {
        return input6;
    }

    public void setInput6(String input6) {
        this.input6 = input6;
    }

    public String getInput7() {
        return input7;
    }

    public void setInput7(String input7) {
        this.input7 = input7;
    }

    public Date getDob() {
        return dob;
    }

    public void setDob(Date dob) {
        this.dob = dob;
    }

    public String getInput8() {
        return input8;
    }

    public void setInput8(String input8) {
        this.input8 = input8;
    }

    public String getInput9() {
        return input9;
    }

    public void setInput9(String input9) {
        this.input9 = input9;
    }

}
