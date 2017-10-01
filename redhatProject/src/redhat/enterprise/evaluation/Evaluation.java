package redhat.enterprise.evaluation;

import redhat.enterprise.Enterprise;

public class Evaluation {
   private String uid;
   private int total_evaluation;
   private int female_welfare;
   private int promotion_chance;
   private int gender_equal;
   private String e_code;

   Enterprise enterprise = new Enterprise();
   
   public String getUid() {
      return uid;
   }
   public void setUid(String uid) {
      this.uid = uid;
   }
   
   public int getTotal_evaluation() {
      return total_evaluation;
   }
   public void setTotal_evaluation(int total_evaluation) {
      this.total_evaluation = total_evaluation;
   }
   public int getFemale_welfare() {
      return female_welfare;
   }
   public void setFemale_welfare(int female_welfare) {
      this.female_welfare = female_welfare;
   }
   public int getPromotion_chance() {
      return promotion_chance;
   }
   public void setPromotion_chance(int promotion_chance) {
      this.promotion_chance = promotion_chance;
   }
   public int getGender_equal() {
      return gender_equal;
   }
   public void setGender_equal(int gender_equal) {
      this.gender_equal = gender_equal;
   }
   /*public String getE_code() {
      return e_code;
   }
   public void setE_code(String e_code) {
      this.e_code = e_code;
   }*/
   
   
   public String getE_code() {
      //return e_code;
      return enterprise.getE_code();
   }
   public void setE_code(String e_code) {
      this.e_code = e_code;
      enterprise.setE_code(this.e_code);
   }

}