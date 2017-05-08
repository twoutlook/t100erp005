#比對檔案清單
TYPE T_DIFF_PROG_LIST  DYNAMIC ARRAY OF RECORD
                  prog      LIKE dzaf_t.dzaf001, #在AFTER_SYNC的情況下是行業程式本身, 其他情況是指標準程式.
                  prog_name LIKE gzzal_t.gzzal003,
                  cons_type LIKE dzaf_t.dzaf005,
                  auth      CHAR(1) 
                  END RECORD

#指定檔案比對程式資訊
TYPE T_FILE_INFO RECORD
                 left_4gl   STRING,
                 right_4gl  STRING,
                 left_4fd   STRING,
                 right_4fd  STRING,
                 left_orig  STRING,
                 right_orig STRING
                 END RECORD

#diff來源
CONSTANT cs_after_cus_patch  = "AFTER_CUS_PATCH"  #客戶Patch並merge後:由adzp050單支觸發,可以進階合併追版.
CONSTANT cs_after_ind_patch  = "AFTER_IND_PATCH"  #行業Patch並同步後:由adzp050單支觸發,可以進階合併追版.
CONSTANT cs_select_ver       = "SELECT_VER"       #作廢:不同版次比較:改成adzq993自行產生兩個不同版本的4gl,然後變成cs_file_diff再傳入.
CONSTANT cs_only_query       = "ONLY_QUERY"       #行業Patch前/客戶Patch前:多支,只能查看.
CONSTANT cs_before_imp       = "BEFORE_IMP"       #過單匯入前/設計資料匯入前:單支,只能查看.
CONSTANT cs_before_ind_patch = "BEFORE_IND_PATCH" #當比對情境為'行業Patch前', 則adzq991會自動轉成'BEFORE_IND_PATCH'.
CONSTANT cs_file_diff        = "FILE_DIFF"        #指定檔案比較:adzq992呼叫使用
