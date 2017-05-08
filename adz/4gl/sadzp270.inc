

PRIVATE TYPE type_col_relation   RECORD
      old_table_id   LIKE dzea_t.dzea001,
      old_col_id     LIKE dzeb_t.dzeb002,
      old_col_key    LIKE type_t.chr20,
      old_col_name   LIKE dzebl_t.dzebl003,
      relation_no    LIKE type_t.num5,
      new_table_id   LIKE dzea_t.dzea001,
      new_col_id     LIKE dzeb_t.dzeb002,
      new_col_key    LIKE type_t.chr20,
      new_col_name   LIKE dzebl_t.dzebl003
END RECORD


PRIVATE TYPE dzag_type RECORD
      old_table_id       LIKE dzag_t.dzag002,
      old_table_name     LIKE dzeal_t.dzeal003,
      old_table_parent   LIKE dzag_t.dzag004,
      old_table_main     LIKE dzag_t.dzag005,
      new_table_id       LIKE dzag_t.dzag002,
      new_table_name     LIKE dzeal_t.dzeal003,
      new_table_parent   LIKE dzag_t.dzag004,
      new_table_main     LIKE dzag_t.dzag005,
      pair_no            LIKE type_t.num5
END RECORD

PRIVATE TYPE type_para  RECORD

      ms_dgenv             LIKE dzaf_t.dzaf010,      #環境變數DGENV (s:標準/ c:客製)
      ms_erpid             LIKE dzaf_t.dzaf007,      #環境變數ERPID(產品代號)
      ms_erpver            LIKE dzaf_t.dzaf008,      #環境變數ERPVER(產品版本)
      ms_cust              LIKE dzaf_t.dzaf009,      #環境變數CUST (客戶代號)
      g_gen_prog           LIKE dzaa_t.dzaa001,
      g_gen_ver            STRING,
      g_gen_spec_ver       STRING,                   #產生程式的規格版次
      g_gen_code_ver       STRING,
      g_gen_identity       LIKE dzaf_t.dzaf010,
      g_copy_source        LIKE dzaa_t.dzaa001, 　   #複製來源
      g_design_point_ver   STRING,                   #產生程式的設計點版次
      g_source_ver         STRING,                   #來源建構版次
      g_source_spec_ver    STRING,                   #來源規格版次
      g_source_code_ver    STRING,                   #來源代碼版次
      g_source_identity    LIKE dzaf_t.dzaf010,      #來源識別標示
      g_use_table_replace  LIKE type_t.chr1,         #是否啟用表格替換功能
      g_not_copy_appoint   LIKE type_t.chr1,         #是否不複製appoint的內容 
      g_source_type        LIKE dzaf_t.dzaf005       #複製來源類型

END RECORD


DEFINE ga_dzag_type DYNAMIC ARRAY OF dzag_type
