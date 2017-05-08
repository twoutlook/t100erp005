#+ Version..: T100-ERP-1.00.00 Build-00001
#+
#+ Filename.: azzp112.4gl
#+ Buildtype: p01樣板自動產
#+ Memo.....: 
#+            

IMPORT os
SCHEMA ds
         
GLOBALS "../../cfg/top_global.inc"

DEFINE gs_lang STRING 
MAIN

   DEFINE ls_temp1 STRING
   DEFINE ls_temp2 STRING
   DEFINE ls_str   STRING   

   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log

   LET g_bgjob = "Y"
   #依模組進行系統初始化設定(系統設定)
   CALL cl_ap_init("azz","")
 
   IF azzp112_chk_lang(g_argv[1]) THEN   
      CALL azzp112_get_gzzd(g_argv[1])      
   ELSE 
      
      DISPLAY "Error: 參數不足"
      DISPLAY "Example: r.r azzp112 語言別"
      #離開作業
   END IF 

   CALL cl_ap_exitprogram("0")
   
END MAIN

############################################################
#+ @code
#+ 函式目的 取得gzzd
#+ @param  
############################################################
PRIVATE FUNCTION azzp112_get_gzzd(pc_gzzy001)
   DEFINE pc_gzzy001  LIKE gzzy_t.gzzy001  #語言別
   DEFINE lc_gzzd001  LIKE gzzd_t.gzzd001  #
   DEFINE lc_gzzd005  LIKE gzzd_t.gzzd005  #轉換標籤文字
   DEFINE lc_gzzd006  LIKE gzzd_t.gzzd006  #轉換註解
   DEFINE li_cnt      LIKE type_t.num5  
   DEFINE li_cnt1     LIKE type_t.num5  
   DEFINE li_sum      LIKE type_t.num10 
   DEFINE ld_gzzd  DYNAMIC ARRAY OF RECORD
          gzzd001  LIKE gzzd_t.gzzd001,
          gzzd003  LIKE gzzd_t.gzzd003,
          lchr_value  LIKE type_t.chr300
      END RECORD
    

   LET li_cnt1 = 0 
   LET li_cnt = 0 
   LET li_sum = 0
   CALL ld_gzzd.clear()
   
   #中文
   IF pc_gzzy001 = "zh_TW" THEN 

     DECLARE azzp112_curs CURSOR FOR 
        SELECT gzzd005,gzzd006 FROM gzzd_t
          WHERE gzzd002 = pc_gzzy001
        FOREACH azzp112_curs INTO ld_gzzd[1].lchr_value,ld_gzzd[2].lchr_value 

           LET li_cnt = azzp112_ins_upd_gzoz(ld_gzzd,pc_gzzy001,NULL)
           LET li_sum = li_sum + li_cnt
           LET li_cnt1 = li_cnt1 + 1 
      END FOREACH 
   ELSE
     #其他語言別
     DECLARE azzp112_curs2 CURSOR FOR 
        SELECT gzzd001,gzzd003,gzzd005 from gzzd_t
          WHERE gzzd002 = pc_gzzy001
          
      FOREACH azzp112_curs2  INTO  ld_gzzd[1].gzzd001,ld_gzzd[1].gzzd003,lc_gzzd005  
             SELECT  gzzd005,gzzd006 INTO  ld_gzzd[1].lchr_value,ld_gzzd[2].lchr_value
                FROM  gzzd_t 
                WHERE  gzzd001 = ld_gzzd[1].gzzd001
                AND  gzzd002 = 'zh_TW'
                AND  gzzd003 = ld_gzzd[1].gzzd003 
                   
               LET li_cnt = azzp112_ins_upd_gzoz(ld_gzzd,pc_gzzy001,lc_gzzd005)
               LET li_sum = li_sum + li_cnt  
         LET li_cnt1 = li_cnt1 + 1       
      END FOREACH 
   END  IF 

   DISPLAY "總筆數:",li_cnt1 ,"更新筆數:",li_sum  
END FUNCTION 


############################################################
#+ @code
#+ 函式目的 檢核參數
#+ @param  
############################################################
PRIVATE FUNCTION azzp112_chk_lang(pc_gzzy001)
   DEFINE pc_gzzy001 LIKE gzzy_t.gzzy001 
   DEFINE ls_sql STRING 
   DEFINE li_cnt LIKE type_t.num5

   LET ls_sql = " SELECT COUNT(*) FROM gzzy_t WHERE gzzy001 = ?"
   PREPARE azzp112_chk_pre FROM ls_sql
   EXECUTE azzp112_chk_pre USING pc_gzzy001 INTO li_cnt  
   FREE azzp112_chk_pre

   IF li_cnt > 0 THEN 
      RETURN TRUE 
   END IF 
   RETURN FALSE 
END FUNCTION 


############################################################
#+ @code
#+ 函式目的 insert or update 字典檔
#+ @param  
############################################################
PRIVATE FUNCTION azzp112_ins_upd_gzoz(ld_gzzd,pc_gzzy001,pc_gzzd005)
    DEFINE pc_gzzy001 LIKE gzzy_t.gzzy001
    DEFINE pc_gzzd005 LIKE gzzd_t.gzzd005
    DEFINE li LIKE type_t.num5
    DEFINE li_cnt LIKE type_t.num5
    DEFINE li_sum LIKE type_t.num5 
    DEFINE ld_gzzd  DYNAMIC ARRAY OF RECORD
        gzzd001     LIKE gzzd_t.gzzd001,
        gzzd003     LIKE gzzd_t.gzzd003,
        lchr_value  LIKE type_t.chr300
        #gzzd006  LIKE gzzd_t.gzzd006
    END RECORD

    LET li_cnt = 0
    FOR li = 1 TO ld_gzzd.getLength()
       LET li_cnt =  cl_dic_chk(ld_gzzd[li].lchr_value,pc_gzzy001,pc_gzzd005)  
       LET li_sum = li_sum + li_cnt
    END FOR 
    RETURN li_sum
END FUNCTION 
