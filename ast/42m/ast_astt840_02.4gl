#該程式已解開Section, 不再透過樣板產出!
{<section id="astt840_02.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0001(2016-11-08 14:32:13), PR版次:0001(2016-11-10 15:43:02)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000002
#+ Filename...: astt840_02
#+ Description: 費用項列印選擇
#+ Creator....: 07142(2016-11-08 14:15:34)
#+ Modifier...: 07142 -SD/PR- 07142
 
{</section>}
 
{<section id="astt840_02.global" >}
#應用 c02c 樣板自動產生(Version:9)
#add-point:填寫註解說明
#Memos
#end add-point
#add-point:填寫註解說明(客製用)

#end add-point
 
IMPORT os
IMPORT FGL lib_cl_dlg
#add-point:增加匯入項目

#end add-point
 
SCHEMA ds
 
GLOBALS "../../cfg/top_global.inc"
 
#add-point:增加匯入變數檔

#end add-point
 
DEFINE g_rec_b               LIKE type_t.num10   
DEFINE g_wc                  STRING
DEFINE g_ref_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_ref_vars            DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE gfrm_curr            ui.Form 
 
 
#add-point:自定義模組變數(Module Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理)
 TYPE type_g_stbe_d        RECORD
       sel LIKE type_t.chr500, 
   stbeseq LIKE stbe_t.stbeseq, 
   stbe001 LIKE stbe_t.stbe001, 
   stbe002 LIKE stbe_t.stbe002, 
   stbe003 LIKE stbe_t.stbe003, 
   stbe004 LIKE stbe_t.stbe004, 
   stbe028 LIKE stbe_t.stbe028, 
   stbe028_desc LIKE type_t.chr500, 
   stbe005 LIKE stbe_t.stbe005, 
   stbe005_desc LIKE type_t.chr500, 
   stbe035 LIKE stbe_t.stbe035, 
   stbe036 LIKE stbe_t.stbe036, 
   stbe036_desc LIKE type_t.chr500, 
   stbe024 LIKE stbe_t.stbe024, 
   stbe025 LIKE stbe_t.stbe025, 
   l_stae003 LIKE type_t.chr10, 
   l_stae003_desc LIKE type_t.chr500, 
   stbe006 LIKE stbe_t.stbe006, 
   stbe007 LIKE stbe_t.stbe007, 
   stbe008 LIKE stbe_t.stbe008, 
   stbe008_desc LIKE type_t.chr500, 
   stbe009 LIKE stbe_t.stbe009, 
   stbe009_desc LIKE type_t.chr500, 
   stbe011 LIKE stbe_t.stbe011, 
   stbe012 LIKE stbe_t.stbe012, 
   stbe013 LIKE stbe_t.stbe013, 
   stbe014 LIKE stbe_t.stbe014, 
   stbe015 LIKE stbe_t.stbe015, 
   stbe016 LIKE stbe_t.stbe016, 
   stbe017 LIKE stbe_t.stbe017, 
   stbe017_desc LIKE type_t.chr500, 
   stbe018 LIKE stbe_t.stbe018, 
   stbesite LIKE stbe_t.stbesite, 
   stbesite_desc LIKE type_t.chr500, 
   stbe020 LIKE stbe_t.stbe020, 
   stbe020_desc LIKE type_t.chr500, 
   stbe019 LIKE stbe_t.stbe019, 
   stbe019_desc LIKE type_t.chr500, 
   stbe032 LIKE stbe_t.stbe032
       END RECORD
DEFINE l_ac                  LIKE type_t.num10
DEFINE g_ac                  LIKE type_t.num10 
DEFINE g_cnt                 LIKE type_t.num10
DEFINE g_detail_idx          LIKE type_t.num5
DEFINE g_detail_cnt         LIKE type_t.num10
DEFINE g_master_idx         LIKE type_t.num10
DEFINE g_error_show          LIKE type_t.num5
DEFINE li_idx    LIKE type_t.num10
DEFINE g_sql                 STRING
DEFINE g_docno               LIKE stbe_t.stbedocno
DEFINE g_stbe_d          DYNAMIC ARRAY OF type_g_stbe_d
DEFINE g_wcc                 STRING 

#end add-point
     
#add-point:自定義客戶專用模組變數(Module Variable)

#end add-point
     
#add-point:傳入參數說明(global.argv)

#end add-point     
 
{</section>}
 
{<section id="astt840_02.input" >}
#+ 資料輸入
PUBLIC FUNCTION astt840_02(--)
   #add-point:construct段變數傳入
   p_docno
   #end add-point
   )
   #add-point:construct段define

   #end add-point
   DEFINE l_ac_t          LIKE type_t.num10       #未取消的ARRAY CNT 
   DEFINE l_allow_insert  LIKE type_t.num5        #可新增否 
   DEFINE l_allow_delete  LIKE type_t.num5        #可刪除否  
   DEFINE l_count         LIKE type_t.num10
   DEFINE l_insert        LIKE type_t.num5
   DEFINE p_cmd           LIKE type_t.chr5
   #add-point:construct段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理)
   DEFINE p_docno         LIKE stbe_t.stbedocno
   DEFINE l_success    LIKE type_t.num5
   DEFINE l_wc         STRING 
   #end add-point
   
   #畫面開啟 (identifier)
   OPEN WINDOW w_astt840_02 WITH FORM cl_ap_formpath("ast","astt840_02")
 
   #瀏覽頁簽資料初始化
   CALL cl_ui_init()
   
   #LET g_qryparam.state = "i"
   
   #LET l_allow_insert = cl_auth_detail_input("insert")
   #LET l_allow_delete = cl_auth_detail_input("delete")
   
   #輸入前處理
   #add-point:單身前置處理
   LET g_wcc = '1=1'
   CALL cl_set_combo_scc('stbe035','6932')
   CALL cl_set_combo_scc('stbe001','6703')    
   LET g_docno = p_docno
   CALL astt840_02_create_tmp() RETURNING l_success
   CALL astt840_02_fill()
   CALL astt840_02_b_fill()
   #end add-point
  
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
    
      #輸入開始
#      CONSTRUCT g_wc ON sel,stbeseq,stbe001,stbe002,stbe003,stbe004,stbe028,stbe005,stbe035,stbe036, 
#          l_stae003,stbe024,stbe025,stbe006,stbe007,stbe008,stbe009,stbe011,stbe012,stbe013,stbe014, 
#          stbe015,stbe016,stbe017,stbe018,stbesite,stbe020,stbe019,stbe032 
#           FROM s_detail1[1].sel,s_detail1[1].stbeseq,s_detail1[1].stbe001,s_detail1[1].stbe002,s_detail1[1].stbe003, 
#               s_detail1[1].stbe004,s_detail1[1].stbe028,s_detail1[1].stbe005,s_detail1[1].stbe035,s_detail1[1].stbe036, 
#               s_detail1[1].l_stae003,s_detail1[1].stbe024,s_detail1[1].stbe025,s_detail1[1].stbe006, 
#               s_detail1[1].stbe007,s_detail1[1].stbe008,s_detail1[1].stbe009,s_detail1[1].stbe011,s_detail1[1].stbe012, 
#               s_detail1[1].stbe013,s_detail1[1].stbe014,s_detail1[1].stbe015,s_detail1[1].stbe016,s_detail1[1].stbe017, 
#               s_detail1[1].stbe018,s_detail1[1].stbesite,s_detail1[1].stbe020,s_detail1[1].stbe019, 
#               s_detail1[1].stbe032 
         
         #自訂ACTION
         #add-point:自訂ACTION

         #end add-point
         
#         BEFORE CONSTRUCT
            #add-point:單頭輸入前處理

            #end add-point
            
#         AFTER CONSTRUCT
            #add-point:單頭輸入後處理

            #end add-point
            
         #單身公用欄位開窗相關處理
         
           
         #單身一般欄位開窗相關處理
           
            
#      END CONSTRUCT
    
      #add-point:自定義construct
      INPUT ARRAY g_stbe_d FROM s_detail1.*
        ATTRIBUTE(COUNT = g_detail_cnt,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS,
                   INSERT ROW = FALSE,
                   DELETE ROW = FALSE, 
                   APPEND ROW = FALSE)
        BEFORE INPUT
           #LET g_current_page = 1
           CALL cl_set_act_visible("filter",FALSE)
         ON CHANGE sel
           IF g_stbe_d[l_ac].sel = 'N' THEN
              UPDATE astt840_02_tmp SET sel = 'N'
              WHERE stbeseq =g_stbe_d[l_ac].stbeseq
           ELSE
              UPDATE astt840_02_tmp SET sel = 'Y'
              WHERE stbeseq =g_stbe_d[l_ac].stbeseq
           END IF         
        BEFORE ROW
           LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
           LET l_ac = g_detail_idx
           DISPLAY g_detail_idx TO FORMONLY.idx
           DISPLAY g_stbe_d.getLength() TO FORMONLY.cnt
           LET g_master_idx = l_ac
           #IF g_stbe_d[l_ac].sel = 'N' THEN
              NEXT FIELD sel
           #else
                 
      END INPUT

      BEFORE DIALOG
#         IF g_stbe_d.getLength() > 0 THEN
#            CALL gfrm_curr.setFieldHidden("formonly.sel", TRUE)
#            #CALL gfrm_curr.setFieldHidden("formonly.statepic", TRUE)
#         ELSE
#            CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)
#            #CALL gfrm_curr.setFieldHidden("formonly.statepic", FALSE)
#         END IF
      #DISPLAY ARRAY g_stbe_d TO s_detail1.* 
      #END DISPLAY
      #end add-point
    
      #公用action
      ON ACTION select_all
         call astt840_02_select_all()
      
      ON ACTION select_no
         call astt840_02_select_no()
         
      ON ACTION accept
         call astt840_02_wc() returning g_wcc
         LET l_wc = "stbddocno = '",g_docno,"'"
         #CALL astr840_g01(l_wc,g_wcc)
         ACCEPT DIALOG
        
      ON ACTION cancel
         LET INT_FLAG = TRUE 
         EXIT DIALOG
 
      ON ACTION close
         LET INT_FLAG = TRUE 
         EXIT DIALOG
 
      ON ACTION exit
         LET INT_FLAG = TRUE 
         EXIT DIALOG
   
      #交談指令共用ACTION
      &include "common_action.4gl" 
         CONTINUE DIALOG 
   END DIALOG
 
   #add-point:畫面關閉前
      
   #end add-point 
   
   #畫面關閉
   CLOSE WINDOW w_astt840_02 
   
   #add-point:construct段after construct 
   DROP TABLE astt840_02_tmp
   RETURN g_wcc
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="astt840_02.other_dialog" readonly="Y" >}

 
{</section>}
 
{<section id="astt840_02.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL s_aooi150_ins (传入参数)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION astt840_02_fill()

 DELETE FROM astt840_02_tmp
 LET g_sql = "SELECT  DISTINCT 'Y',stbeseq,stbe001,stbe002,stbe003,stbe004,stbe028,t1.mhbel003 ,stbe005,t2.stael003 ,stbe035, 
             stbe036,t3.ooefl003 ,stbe024,stbe025,'','',stbe006,stbe007,stbe008,t4.ooail003,stbe009,t5.staal003 ,stbe011,stbe012,stbe013, 
             stbe014,stbe015,stbe016,stbe017,'',stbe018,stbesite,t6.ooefl003 , 
             stbe020, t7.ooefl003 ,stbe019,t8.rtaxl003,stbe032
              FROM stbe_t",   
               " LEFT JOIN mhbel_t t1 ON t1.mhbelent="||g_enterprise||" AND t1.mhbel001=stbe028 AND t1.mhbel002='"||g_dlang||"' ",
               " LEFT JOIN stael_t t2 ON t2.staelent="||g_enterprise||" AND t2.stael001=stbe005 AND t2.stael002='"||g_dlang||"' ",
               " LEFT JOIN ooefl_t t3 ON t3.ooeflent="||g_enterprise||" AND t3.ooefl001=stbe036 AND t3.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooail_t t4 ON t4.ooailent="||g_enterprise||" AND t4.ooail001=stbe008 AND t4.ooail002='"||g_dlang||"' ",
               " LEFT JOIN staal_t t5 ON t5.staalent="||g_enterprise||" AND t5.staal001=stbe017 AND t5.staal002='"||g_dlang||"' ",
               " LEFT JOIN ooefl_t t6 ON t6.ooeflent="||g_enterprise||" AND t6.ooefl001=stbesite AND t6.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooefl_t t7 ON t7.ooeflent="||g_enterprise||" AND t7.ooefl001=stbe020 AND t7.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN rtaxl_t t8 ON t8.rtaxlent="||g_enterprise||" AND t8.rtaxl001=stbe019 AND t8.rtaxl002='"||g_dlang||"' ", 
               " WHERE stbeent=",g_enterprise," AND stbedocno='",g_docno,"' and stbe001 ='3' ",
               " ORDER BY stbeseq "
       LET g_sql="INSERT INTO astt840_02_tmp ",g_sql
           PREPARE astt840_02_ins_tmp FROM g_sql  
           EXECUTE astt840_02_ins_tmp
       IF SQLCA.sqlcode<>0 AND SQLCA.sqlcode<>100 THEN
          INITIALIZE g_errparam TO NULL 
          LET g_errparam.extend = "EXECUTE:astt840_02_ins_tmp" 
          LET g_errparam.code   = SQLCA.sqlcode 
          LET g_errparam.popup  = TRUE 
          CALL cl_err()
       END IF

END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL s_aooi150_ins (传入参数)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION astt840_02_get_ooef019(p_ooef001)
DEFINE p_ooef001   LIKE ooef_t.ooef001
DEFINE r_ooef019   LIKE ooef_t.ooef019
   
   LET r_ooef019 = ''
   
   SELECT ooef019 INTO r_ooef019
     FROM ooef_t
    WHERE ooefent = g_enterprise
      AND ooef001 = p_ooef001

   RETURN r_ooef019
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL s_aooi150_ins (传入参数)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION astt840_02_get_stae003(p_stae001)
   DEFINE p_stae001      LIKE stae_t.stae001
   DEFINE r_stae003      LIKE stae_t.stae003
   DEFINE r_oocql004     LIKE oocql_t.oocql004
   
   LET r_stae003 = ''
   
   SELECT stae003,oocql004 INTO r_stae003,r_oocql004
     FROM stae_t 
          LEFT JOIN oocql_t ON oocqlent = staeent AND oocql001 = '2058' 
                           AND oocql002 = stae003 AND oocql003 = g_dlang
    WHERE staeent = g_enterprise
      AND stae001 = p_stae001
    
   RETURN r_stae003,r_oocql004
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL s_aooi150_ins (传入参数)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION astt840_02_create_tmp()
DEFINE r_success        LIKE type_t.num5

   LET r_success = TRUE
   
   #DROP TABLE astt840_02_tmp
   
   CREATE TEMP TABLE astt840_02_tmp(
   sel  VARCHAR(500), 
   stbeseq  INTEGER, 
   stbe001  VARCHAR(10), 
   stbe002  VARCHAR(20), 
   stbe003  INTEGER, 
   stbe004  DATE, 
   stbe028  VARCHAR(20), 
   stbe028_desc  VARCHAR(500), 
   stbe005  VARCHAR(10), 
   stbe005_desc  VARCHAR(500), 
   stbe035  VARCHAR(10), 
   stbe036  VARCHAR(10), 
   stbe036_desc  VARCHAR(500), 
   stbe024  VARCHAR(1), 
   stbe025  VARCHAR(1), 
   l_stae003  VARCHAR(10), 
   l_stae003_desc  VARCHAR(500), 
   stbe006  DATE, 
   stbe007  DATE, 
   stbe008  VARCHAR(10), 
   stbe008_desc  VARCHAR(500), 
   stbe009  VARCHAR(10), 
   stbe009_desc  VARCHAR(500), 
   stbe011  SMALLINT, 
   stbe012  DECIMAL(20,6), 
   stbe013  DECIMAL(20,6), 
   stbe014  DECIMAL(20,6), 
   stbe015  DECIMAL(20,6), 
   stbe016  DECIMAL(20,6), 
   stbe017  VARCHAR(10), 
   stbe017_desc  VARCHAR(500), 
   stbe018  VARCHAR(10), 
   stbesite  VARCHAR(10), 
   stbesite_desc  VARCHAR(500), 
   stbe020  VARCHAR(10), 
   stbe020_desc  VARCHAR(500), 
   stbe019  VARCHAR(10), 
   stbe019_desc  VARCHAR(500), 
   stbe032  VARCHAR(255))
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'Create Temp Table astt840_02_tmp'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL s_aooi150_ins (传入参数)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION astt840_02_select_all()
   UPDATE astt840_02_tmp SET sel = 'Y'
   CALL astt840_02_b_fill()
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL s_aooi150_ins (传入参数)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION astt840_02_select_no()
   UPDATE astt840_02_tmp SET sel = 'N'
   CALL astt840_02_b_fill()
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL s_aooi150_ins (传入参数)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION astt840_02_b_fill()
  DEFINE l_ooef019  LIKE ooef_t.ooef019     
      let g_sql = "SELECT * FROM astt840_02_tmp "
      LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
      PREPARE astt840_02_pb FROM g_sql
      DECLARE b_fill_cs CURSOR FOR astt840_02_pb          
      LET l_ac = 1                                               
      FOREACH b_fill_cs INTO g_stbe_d[l_ac].*
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:",SQLERRMESSAGE 
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
         LET l_ooef019 = ''
         LET l_ooef019 = astt840_02_get_ooef019(g_stbe_d[l_ac].stbesite) 
         LET g_stbe_d[l_ac].stbe009_desc  = s_desc_get_tax_desc(l_ooef019,g_stbe_d[l_ac].stbe009)
         CALL astt840_02_get_stae003(g_stbe_d[l_ac].stbe005) RETURNING g_stbe_d[l_ac].l_stae003,g_stbe_d[l_ac].l_stae003_desc      
         IF l_ac > g_max_rec THEN
            IF g_error_show = 1 THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = l_ac
               LET g_errparam.code   = 9035 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
            END IF
            EXIT FOREACH
         END IF
         
         LET l_ac = l_ac + 1
      END FOREACH
       let g_ac=l_ac-1
       CALL g_stbe_d.deleteElement(g_stbe_d.getLength()) 
       LET l_ac = g_stbe_d.getLength()
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL s_aooi150_ins (传入参数)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION astt840_02_wc()
DEFINE l_sql   string 
DEFINE l_wc    string
DEFINE l_t     INT
DEFINE l_seq   LIKE stbe_t.stbeseq
let l_sql = " SELECT stbeseq FROM astt840_02_tmp where sel ='Y' order by stbeseq"
    PREPARE astt840_02_pb1 FROM l_sql
    DECLARE b_fill_cs1 CURSOR FOR astt840_02_pb1
    let l_t = 1    
    FOREACH b_fill_cs1 INTO l_seq
       IF NOT cl_null(l_seq)  THEN
          IF l_t =1 THEN        
             let l_wc = " ( stbeseq = ",l_seq," "
          ELSE
             LET l_wc = l_wc CLIPPED," OR stbeseq = ",l_seq," "
          END IF
       END IF 
       let l_t =l_t+1
    END FOREACH 
    IF NOT cl_null(l_wc) THEN 
       LET l_wc =l_wc CLIPPED," ) "
    ELSE
       LET l_wc ="1=2"
    END IF      
    RETURN  l_wc   
END FUNCTION

 
{</section>}
 
