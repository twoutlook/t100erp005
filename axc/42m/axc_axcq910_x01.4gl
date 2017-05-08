#該程式未解開Section, 採用最新樣板產出!
{<section id="axcq910_x01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:1(2015-04-15 10:01:44), PR版次:0001(2015-04-20 09:55:54)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000039
#+ Filename...: axcq910_x01
#+ Description: ...
#+ Creator....: 05016(2015-04-14 11:46:27)
#+ Modifier...: 05016 -SD/PR- 05016
 
{</section>}
 
{<section id="axcq910_x01.global" readonly="Y" >}
#報表 x01 樣板自動產生(Version:8)
#add-point:填寫註解說明 name="global.memo"

#end add-point
#add-point:填寫註解說明 name="global.memo_customerization"

#end add-point
 
IMPORT os
#add-point:增加匯入項目 name="global.import"

#end add-point
 
SCHEMA ds
 
GLOBALS "../../cfg/top_global.inc"
GLOBALS "../../cfg/top_report.inc"                  #報表使用的global
 
#報表 type 宣告
DEFINE tm RECORD
       wc STRING,                  #where condition 
       a1 STRING,                  #temp_table 
       a2 LIKE type_t.num5,         #hide_flag 
       a3 LIKE type_t.chr1,         #xccc002_hide 
       a4 LIKE type_t.chr1          #xccc007_hide
       END RECORD
 
DEFINE g_str           STRING,                      #列印條件回傳值              
       g_sql           STRING  
 
#add-point:自定義環境變數(Global Variable)(客製用) name="global.variable_customerization"

#end add-point
#add-point:自定義環境變數(Global Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_tmp_table     STRING
#end add-point
 
{</section>}
 
{<section id="axcq910_x01.main" readonly="Y" >}
PUBLIC FUNCTION axcq910_x01(p_arg1,p_arg2,p_arg3,p_arg4,p_arg5)
DEFINE  p_arg1 STRING                  #tm.wc  where condition 
DEFINE  p_arg2 STRING                  #tm.a1  temp_table 
DEFINE  p_arg3 LIKE type_t.num5         #tm.a2  hide_flag 
DEFINE  p_arg4 LIKE type_t.chr1         #tm.a3  xccc002_hide 
DEFINE  p_arg5 LIKE type_t.chr1         #tm.a4  xccc007_hide
#add-point:init段define(客製用) name="component.define_customerization"

#end add-point
#add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="component.define"

#end add-point
 
   LET tm.wc = p_arg1
   LET tm.a1 = p_arg2
   LET tm.a2 = p_arg3
   LET tm.a3 = p_arg4
   LET tm.a4 = p_arg5
 
   #add-point:報表元件參數準備 name="component.arg.prep"
   LET g_tmp_table = tm.a1
   #end add-point
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 
   ##報表元件執行期間是否有錯誤代碼
   LET g_rep_success = 'Y'
   
   #報表元件代號      
   LET g_rep_code = "axcq910_x01"
   IF cl_null(tm.wc) THEN LET tm.wc = " 1=1" END IF
 
   #create 暫存檔
   CALL axcq910_x01_create_tmptable()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #報表select欄位準備
   CALL axcq910_x01_sel_prep()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #報表insert的prepare
   CALL axcq910_x01_ins_prep()  
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #將資料存入tmptable
   CALL axcq910_x01_ins_data() 
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #將tmptable資料印出
   CALL axcq910_x01_rep_data()
 
END FUNCTION
 
{</section>}
 
{<section id="axcq910_x01.create_tmptable" readonly="Y" >}
PRIVATE FUNCTION axcq910_x01_create_tmptable()
 
   #清除temptable 陣列
   CALL g_rep_tmpname.clear()
   
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.before name="create_tmp.before"
   
   #end add-point:create_tmp.before
 
   #主報表TEMP TABLE的欄位SQL   
   LET g_sql = "l_xccc002_desc.type_t.chr500,l_xccc006_desc.type_t.chr500,l_xccc007.xccc_t.xccc007,l_xccc008.xccc_t.xccc008,l_xccc280.xccc_t.xccc280,l_xccc280_1.type_t.num20_6,l_xccc280_2.type_t.num20_6,l_xccc280_3.type_t.num20_6,l_xccc280_4.type_t.num20_6,l_xccc280_5.type_t.num20_6,l_xccc280_6.type_t.num20_6,l_xccc280_7.type_t.num20_6,l_xccc280_8.type_t.num20_6,l_xccc280_9.type_t.num20_6,l_xccc280_10.type_t.num20_6,l_xccc280_11.type_t.num20_6,l_xccc280_12.type_t.num20_6,l_xccc280_13.type_t.num20_6,l_xccc280_14.type_t.num20_6,l_xccc280_15.type_t.num20_6,l_xccc280_16.type_t.chr30,l_xccc280_17.type_t.num20_6,l_xccc280_18.type_t.num20_6,l_xccc280_19.type_t.num20_6,l_xccc280_20.type_t.num20_6,l_xccc280_21.type_t.num20_6,l_xccc280_22.type_t.num20_6,l_xccc280_23.type_t.num20_6,l_xccc280_24.type_t.num20_6,l_xccc280_25.type_t.num20_6,l_xccc280_26.type_t.num20_6,l_xccc280_27.type_t.num20_6,l_xccc280_28.type_t.num20_6,l_xccc280_29.type_t.num20_6,l_xccc280_30.type_t.num20_6,l_xccc280_31.type_t.num20_6,l_xccc280_32.type_t.num20_6,l_xccc280_33.type_t.num20_6,l_xccc280_34.type_t.num20_6,l_xccc280_35.type_t.num20_6,l_xccc280_36.type_t.num20_6,l_xccc280_37.type_t.num20_6,l_xccc280_38.type_t.num20_6,l_xccc280_39.type_t.num20_6,l_xccc280_40.type_t.num20_6,l_xccc280_41.type_t.num20_6,l_xccc280_42.type_t.num20_6,l_xccc280_43.type_t.num20_6,l_xccc280_44.type_t.num20_6,l_xccc280_45.type_t.num20_6,l_xccc280_46.type_t.num20_6,l_xccc280_47.type_t.num20_6,l_xccc280_48.type_t.num20_6,l_xccc280_49.type_t.num20_6,l_flag.type_t.chr1,l_comp_desc.type_t.chr80,l_ld_desc.type_t.chr80,l_strdate.type_t.chr80,l_enddate.type_t.chr80,l_xccc003_desc.type_t.chr80,l_xccc001_desc.type_t.chr80" 
   
   #建立TEMP TABLE,主報表序號1 
   IF NOT cl_xg_create_tmptable(g_sql,1) THEN
      LET g_rep_success = 'N'            
   END IF
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.after name="create_tmp.after"
   
   #end add-point:create_tmp.after
END FUNCTION
 
{</section>}
 
{<section id="axcq910_x01.ins_prep" readonly="Y" >}
PRIVATE FUNCTION axcq910_x01_ins_prep()
DEFINE i              INTEGER
DEFINE l_prep_str     STRING
#add-point:ins_prep.define (客製用) name="ins_prep.define_customerization"

#end add-point:ins_prep.define
#add-point:ins_prep.define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ins_prep.define"

#end add-point:ins_prep.define
 
   FOR i = 1 TO g_rep_tmpname.getLength()
      CALL cl_xg_del_data(g_rep_tmpname[i])
      #LET g_sql = g_rep_ins_prep[i]              #透過此lib取得prepare字串 lib精簡
      CASE i
         WHEN 1
         #INSERT INTO PREP
         LET g_sql = " INSERT INTO ",g_rep_db CLIPPED,g_rep_tmpname[1] CLIPPED," VALUES(?,?,?,?,?,?, 
             ?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?, 
             ?,?,?,?,?,?,?,?,?,?,?)"
         PREPARE insert_prep FROM g_sql
         IF STATUS THEN
            LET l_prep_str ="insert_prep",i
            INITIALIZE g_errparam TO NULL
            LET g_errparam.extend = l_prep_str
            LET g_errparam.code   = status
            LET g_errparam.popup  = TRUE
            CALL cl_err()
            CALL cl_xg_drop_tmptable()
            LET g_rep_success = 'N'           
         END IF 
         #add-point:insert_prep段 name="insert_prep"
         
         #end add-point                  
 
 
      END CASE
   END FOR
END FUNCTION
 
{</section>}
 
{<section id="axcq910_x01.sel_prep" readonly="Y" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION axcq910_x01_sel_prep()
DEFINE g_select      STRING
DEFINE g_from        STRING
DEFINE g_where       STRING
#add-point:sel_prep段define(客製用) name="sel_prep.define_customerization"

#end add-point
#add-point:sel_prep段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="sel_prep.define"

#end add-point
 
   #add-point:sel_prep before name="sel_prep.before"
   
   #end add-point
 
   #add-point:sel_prep g_select name="sel_prep.g_select"
 
#   #end add-point
#   LET g_select = " SELECT '','','','','','','','','','','','','','','','','','','','','','','','','', 
#       '','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','', 
#       '','','','',''"
# 
#   #add-point:sel_prep g_from name="sel_prep.g_from"
 
#   #end add-point
#    LET g_from = " FROM xccc_t"
# 
#   #add-point:sel_prep g_where name="sel_prep.g_where"
 
#   #end add-point
#    LET g_where = " WHERE " ,tm.wc CLIPPED
# 
#   #add-point:sel_prep g_order name="sel_prep.g_order"
   
   #end add-point
 
   #add-point:sel_prep.sql.before name="sel_prep.sql.before"
    
#   #end add-point:sel_prep.sql.before
#   LET g_where = g_where ,cl_sql_add_filter("xccc_t")   #資料過濾功能
#   LET g_sql = g_select CLIPPED ," ",g_from CLIPPED ," ",g_where CLIPPED
#   LET g_sql = cl_sql_add_mask(g_sql)    #遮蔽特定資料, 若寫至add-point也需複製此段
# 
#   #add-point:sel_prep.sql.after name="sel_prep.sql.after"
   LET g_sql = " SELECT * FROM ", g_tmp_table CLIPPED
   #end add-point
   PREPARE axcq910_x01_prepare FROM g_sql
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'prepare:'
      LET g_errparam.code   = STATUS
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET g_rep_success = 'N' 
   END IF
   DECLARE axcq910_x01_curs CURSOR FOR axcq910_x01_prepare
 
END FUNCTION
 
{</section>}
 
{<section id="axcq910_x01.ins_data" readonly="Y" >}
PRIVATE FUNCTION axcq910_x01_ins_data()
DEFINE sr RECORD 
   l_xccc002_desc LIKE type_t.chr500, 
   l_xccc006_desc LIKE type_t.chr500, 
   l_xccc007 LIKE xccc_t.xccc007, 
   l_xccc008 LIKE xccc_t.xccc008, 
   l_xccc280 LIKE xccc_t.xccc280, 
   l_xccc280_1 LIKE type_t.num20_6, 
   l_xccc280_2 LIKE type_t.num20_6, 
   l_xccc280_3 LIKE type_t.num20_6, 
   l_xccc280_4 LIKE type_t.num20_6, 
   l_xccc280_5 LIKE type_t.num20_6, 
   l_xccc280_6 LIKE type_t.num20_6, 
   l_xccc280_7 LIKE type_t.num20_6, 
   l_xccc280_8 LIKE type_t.num20_6, 
   l_xccc280_9 LIKE type_t.num20_6, 
   l_xccc280_10 LIKE type_t.num20_6, 
   l_xccc280_11 LIKE type_t.num20_6, 
   l_xccc280_12 LIKE type_t.num20_6, 
   l_xccc280_13 LIKE type_t.num20_6, 
   l_xccc280_14 LIKE type_t.num20_6, 
   l_xccc280_15 LIKE type_t.num20_6, 
   l_xccc280_16 LIKE type_t.chr30, 
   l_xccc280_17 LIKE type_t.num20_6, 
   l_xccc280_18 LIKE type_t.num20_6, 
   l_xccc280_19 LIKE type_t.num20_6, 
   l_xccc280_20 LIKE type_t.num20_6, 
   l_xccc280_21 LIKE type_t.num20_6, 
   l_xccc280_22 LIKE type_t.num20_6, 
   l_xccc280_23 LIKE type_t.num20_6, 
   l_xccc280_24 LIKE type_t.num20_6, 
   l_xccc280_25 LIKE type_t.num20_6, 
   l_xccc280_26 LIKE type_t.num20_6, 
   l_xccc280_27 LIKE type_t.num20_6, 
   l_xccc280_28 LIKE type_t.num20_6, 
   l_xccc280_29 LIKE type_t.num20_6, 
   l_xccc280_30 LIKE type_t.num20_6, 
   l_xccc280_31 LIKE type_t.num20_6, 
   l_xccc280_32 LIKE type_t.num20_6, 
   l_xccc280_33 LIKE type_t.num20_6, 
   l_xccc280_34 LIKE type_t.num20_6, 
   l_xccc280_35 LIKE type_t.num20_6, 
   l_xccc280_36 LIKE type_t.num20_6, 
   l_xccc280_37 LIKE type_t.num20_6, 
   l_xccc280_38 LIKE type_t.num20_6, 
   l_xccc280_39 LIKE type_t.num20_6, 
   l_xccc280_40 LIKE type_t.num20_6, 
   l_xccc280_41 LIKE type_t.num20_6, 
   l_xccc280_42 LIKE type_t.num20_6, 
   l_xccc280_43 LIKE type_t.num20_6, 
   l_xccc280_44 LIKE type_t.num20_6, 
   l_xccc280_45 LIKE type_t.num20_6, 
   l_xccc280_46 LIKE type_t.num20_6, 
   l_xccc280_47 LIKE type_t.num20_6, 
   l_xccc280_48 LIKE type_t.num20_6, 
   l_xccc280_49 LIKE type_t.num20_6, 
   l_flag LIKE type_t.chr1, 
   l_comp_desc LIKE type_t.chr80, 
   l_ld_desc LIKE type_t.chr80, 
   l_strdate LIKE type_t.chr80, 
   l_enddate LIKE type_t.chr80, 
   l_xccc003_desc LIKE type_t.chr80, 
   l_xccc001_desc LIKE type_t.chr80
 END RECORD
#add-point:ins_data段define (客製用) name="ins_data.define_customerization"

#end add-point
#add-point:ins_data段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ins_data.define"
DEFINE l_flag   DYNAMIC ARRAY OF VARCHAR(500)
DEFINE i    LIKE type_t.num5
#end add-point
 
    #add-point:ins_data段before name="ins_data.before"
    
    #end add-point
 
    LET g_rep_success = 'Y'
 
    FOREACH axcq910_x01_curs INTO sr.*                               
       IF STATUS THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.extend = 'foreach:'
          LET g_errparam.code   = STATUS
          LET g_errparam.popup  = TRUE
          CALL cl_err()
          LET g_rep_success = 'N'
          EXIT FOREACH
       END IF
 
       #add-point:ins_data段foreach name="ins_data.foreach"
       
       #end add-point
 
       #add-point:ins_data段before.save name="ins_data.before.save"
       
       #end add-point
 
       #EXECUTE
       EXECUTE insert_prep USING sr.l_xccc002_desc,sr.l_xccc006_desc,sr.l_xccc007,sr.l_xccc008,sr.l_xccc280,sr.l_xccc280_1,sr.l_xccc280_2,sr.l_xccc280_3,sr.l_xccc280_4,sr.l_xccc280_5,sr.l_xccc280_6,sr.l_xccc280_7,sr.l_xccc280_8,sr.l_xccc280_9,sr.l_xccc280_10,sr.l_xccc280_11,sr.l_xccc280_12,sr.l_xccc280_13,sr.l_xccc280_14,sr.l_xccc280_15,sr.l_xccc280_16,sr.l_xccc280_17,sr.l_xccc280_18,sr.l_xccc280_19,sr.l_xccc280_20,sr.l_xccc280_21,sr.l_xccc280_22,sr.l_xccc280_23,sr.l_xccc280_24,sr.l_xccc280_25,sr.l_xccc280_26,sr.l_xccc280_27,sr.l_xccc280_28,sr.l_xccc280_29,sr.l_xccc280_30,sr.l_xccc280_31,sr.l_xccc280_32,sr.l_xccc280_33,sr.l_xccc280_34,sr.l_xccc280_35,sr.l_xccc280_36,sr.l_xccc280_37,sr.l_xccc280_38,sr.l_xccc280_39,sr.l_xccc280_40,sr.l_xccc280_41,sr.l_xccc280_42,sr.l_xccc280_43,sr.l_xccc280_44,sr.l_xccc280_45,sr.l_xccc280_46,sr.l_xccc280_47,sr.l_xccc280_48,sr.l_xccc280_49,sr.l_flag,sr.l_comp_desc,sr.l_ld_desc,sr.l_strdate,sr.l_enddate,sr.l_xccc003_desc,sr.l_xccc001_desc
 
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.extend = "axcq910_x01_execute"
          LET g_errparam.code   = SQLCA.sqlcode
          LET g_errparam.popup  = FALSE
          CALL cl_err()       
          LET g_rep_success = 'N'
          EXIT FOREACH
       END IF
 
       #add-point:ins_data段after_save name="ins_data.after.save"
       
       #end add-point
       
    END FOREACH
    
    #add-point:ins_data段after name="ins_data.after"
    FOR i= 1 TO tm.a2
       LET l_flag[i]  = 'Y'
    END FOR
    IF cl_null(l_flag[1]) THEN LET l_flag[1] = 'N' END IF
    IF cl_null(l_flag[2]) THEN LET l_flag[2] = 'N' END IF
    IF cl_null(l_flag[3]) THEN LET l_flag[3] = 'N' END IF
    IF cl_null(l_flag[4]) THEN LET l_flag[4] = 'N' END IF
    IF cl_null(l_flag[5]) THEN LET l_flag[5] = 'N' END IF
    IF cl_null(l_flag[6]) THEN LET l_flag[6] = 'N' END IF
    IF cl_null(l_flag[7]) THEN LET l_flag[7] = 'N' END IF
    IF cl_null(l_flag[8]) THEN LET l_flag[8] = 'N' END IF
    IF cl_null(l_flag[9]) THEN LET l_flag[9] = 'N' END IF
    IF cl_null(l_flag[10]) THEN LET l_flag[10] = 'N' END IF
    IF cl_null(l_flag[11]) THEN LET l_flag[11] = 'N' END IF
    IF cl_null(l_flag[12]) THEN LET l_flag[12] = 'N' END IF
    IF cl_null(l_flag[13]) THEN LET l_flag[13] = 'N' END IF
    IF cl_null(l_flag[14]) THEN LET l_flag[14] = 'N' END IF
    IF cl_null(l_flag[15]) THEN LET l_flag[15] = 'N' END IF
    IF cl_null(l_flag[16]) THEN LET l_flag[16] = 'N' END IF
    IF cl_null(l_flag[17]) THEN LET l_flag[17] = 'N' END IF
    IF cl_null(l_flag[18]) THEN LET l_flag[18] = 'N' END IF
    IF cl_null(l_flag[19]) THEN LET l_flag[19] = 'N' END IF
    IF cl_null(l_flag[20]) THEN LET l_flag[20] = 'N' END IF
    IF cl_null(l_flag[21]) THEN LET l_flag[21] = 'N' END IF
    IF cl_null(l_flag[22]) THEN LET l_flag[22] = 'N' END IF
    IF cl_null(l_flag[23]) THEN LET l_flag[23] = 'N' END IF
    IF cl_null(l_flag[24]) THEN LET l_flag[24] = 'N' END IF
    IF cl_null(l_flag[25]) THEN LET l_flag[25] = 'N' END IF
    IF cl_null(l_flag[26]) THEN LET l_flag[26] = 'N' END IF
    IF cl_null(l_flag[27]) THEN LET l_flag[27] = 'N' END IF
    IF cl_null(l_flag[28]) THEN LET l_flag[28] = 'N' END IF
    IF cl_null(l_flag[29]) THEN LET l_flag[29] = 'N' END IF
    IF cl_null(l_flag[30]) THEN LET l_flag[30] = 'N' END IF
    IF cl_null(l_flag[31]) THEN LET l_flag[31] = 'N' END IF
    IF cl_null(l_flag[32]) THEN LET l_flag[32] = 'N' END IF
    IF cl_null(l_flag[33]) THEN LET l_flag[33] = 'N' END IF
    IF cl_null(l_flag[34]) THEN LET l_flag[34] = 'N' END IF
    IF cl_null(l_flag[35]) THEN LET l_flag[35] = 'N' END IF
    IF cl_null(l_flag[36]) THEN LET l_flag[36] = 'N' END IF
    IF cl_null(l_flag[37]) THEN LET l_flag[37] = 'N' END IF
    IF cl_null(l_flag[38]) THEN LET l_flag[38] = 'N' END IF
    IF cl_null(l_flag[39]) THEN LET l_flag[39] = 'N' END IF
    IF cl_null(l_flag[40]) THEN LET l_flag[40] = 'N' END IF
    IF cl_null(l_flag[41]) THEN LET l_flag[41] = 'N' END IF
    IF cl_null(l_flag[42]) THEN LET l_flag[42] = 'N' END IF
    IF cl_null(l_flag[43]) THEN LET l_flag[43] = 'N' END IF
    IF cl_null(l_flag[44]) THEN LET l_flag[44] = 'N' END IF
    IF cl_null(l_flag[45]) THEN LET l_flag[45] = 'N' END IF
    IF cl_null(l_flag[46]) THEN LET l_flag[46] = 'N' END IF
    IF cl_null(l_flag[47]) THEN LET l_flag[47] = 'N' END IF
    IF cl_null(l_flag[48]) THEN LET l_flag[48] = 'N' END IF
    IF cl_null(l_flag[49]) THEN LET l_flag[49] = 'N' END IF
    IF cl_null(l_flag[50]) THEN LET l_flag[50] = 'N' END IF
        
    LET g_xgrid.visible_column = NULL
     
    LET g_xgrid.visible_column ="l_flag"
    IF tm.a3 = 'N' THEN LET g_xgrid.visible_column = g_xgrid.visible_column CLIPPED,"|l_xccc007" END IF
    IF tm.a4 = 'N' THEN LET g_xgrid.visible_column = g_xgrid.visible_column CLIPPED,"|l_xccc002_desc" END IF
    IF l_flag[1 ] = 'N' THEN LET g_xgrid.visible_column =g_xgrid.visible_column CLIPPED,"|l_xccc280"  END IF     
    IF l_flag[2 ] = 'N' THEN LET g_xgrid.visible_column =g_xgrid.visible_column CLIPPED,"|l_xccc280_1"  END IF
    IF l_flag[3 ] = 'N' THEN LET g_xgrid.visible_column =g_xgrid.visible_column CLIPPED,"|l_xccc280_2"  END IF
    IF l_flag[4 ] = 'N' THEN LET g_xgrid.visible_column =g_xgrid.visible_column CLIPPED,"|l_xccc280_3"  END IF
    IF l_flag[5 ] = 'N' THEN LET g_xgrid.visible_column =g_xgrid.visible_column CLIPPED,"|l_xccc280_4"  END IF
    IF l_flag[6 ] = 'N' THEN LET g_xgrid.visible_column =g_xgrid.visible_column CLIPPED,"|l_xccc280_5"  END IF
    IF l_flag[7 ] = 'N' THEN LET g_xgrid.visible_column =g_xgrid.visible_column CLIPPED,"|l_xccc280_6"  END IF
    IF l_flag[8 ] = 'N' THEN LET g_xgrid.visible_column =g_xgrid.visible_column CLIPPED,"|l_xccc280_7"  END IF
    IF l_flag[9 ] = 'N' THEN LET g_xgrid.visible_column =g_xgrid.visible_column CLIPPED,"|l_xccc280_8"  END IF
    IF l_flag[10] = 'N' THEN LET g_xgrid.visible_column =g_xgrid.visible_column CLIPPED,"|l_xccc280_9"  END IF
    IF l_flag[11] = 'N' THEN LET g_xgrid.visible_column =g_xgrid.visible_column CLIPPED,"|l_xccc280_10"  END IF
    IF l_flag[12] = 'N' THEN LET g_xgrid.visible_column =g_xgrid.visible_column CLIPPED,"|l_xccc280_11"  END IF
    IF l_flag[13] = 'N' THEN LET g_xgrid.visible_column =g_xgrid.visible_column CLIPPED,"|l_xccc280_12"  END IF
    IF l_flag[14] = 'N' THEN LET g_xgrid.visible_column =g_xgrid.visible_column CLIPPED,"|l_xccc280_13"  END IF
    IF l_flag[15] = 'N' THEN LET g_xgrid.visible_column =g_xgrid.visible_column CLIPPED,"|l_xccc280_14"  END IF
    IF l_flag[16] = 'N' THEN LET g_xgrid.visible_column =g_xgrid.visible_column CLIPPED,"|l_xccc280_15"  END IF
    IF l_flag[17] = 'N' THEN LET g_xgrid.visible_column =g_xgrid.visible_column CLIPPED,"|l_xccc280_16"  END IF
    IF l_flag[18] = 'N' THEN LET g_xgrid.visible_column =g_xgrid.visible_column CLIPPED,"|l_xccc280_17"  END IF
    IF l_flag[19] = 'N' THEN LET g_xgrid.visible_column =g_xgrid.visible_column CLIPPED,"|l_xccc280_18"  END IF
    IF l_flag[20] = 'N' THEN LET g_xgrid.visible_column =g_xgrid.visible_column CLIPPED,"|l_xccc280_19"  END IF
    IF l_flag[21] = 'N' THEN LET g_xgrid.visible_column =g_xgrid.visible_column CLIPPED,"|l_xccc280_20"  END IF
    IF l_flag[22] = 'N' THEN LET g_xgrid.visible_column =g_xgrid.visible_column CLIPPED,"|l_xccc280_21"  END IF
    IF l_flag[23] = 'N' THEN LET g_xgrid.visible_column =g_xgrid.visible_column CLIPPED,"|l_xccc280_22"  END IF
    IF l_flag[24] = 'N' THEN LET g_xgrid.visible_column =g_xgrid.visible_column CLIPPED,"|l_xccc280_23"  END IF
    IF l_flag[25] = 'N' THEN LET g_xgrid.visible_column =g_xgrid.visible_column CLIPPED,"|l_xccc280_24"  END IF
    IF l_flag[26] = 'N' THEN LET g_xgrid.visible_column =g_xgrid.visible_column CLIPPED,"|l_xccc280_25"  END IF
    IF l_flag[27] = 'N' THEN LET g_xgrid.visible_column =g_xgrid.visible_column CLIPPED,"|l_xccc280_26"  END IF
    IF l_flag[28] = 'N' THEN LET g_xgrid.visible_column =g_xgrid.visible_column CLIPPED,"|l_xccc280_27"  END IF
    IF l_flag[29] = 'N' THEN LET g_xgrid.visible_column =g_xgrid.visible_column CLIPPED,"|l_xccc280_28"  END IF
    IF l_flag[30] = 'N' THEN LET g_xgrid.visible_column =g_xgrid.visible_column CLIPPED,"|l_xccc280_29"  END IF
    IF l_flag[31] = 'N' THEN LET g_xgrid.visible_column =g_xgrid.visible_column CLIPPED,"|l_xccc280_30"  END IF
    IF l_flag[32] = 'N' THEN LET g_xgrid.visible_column =g_xgrid.visible_column CLIPPED,"|l_xccc280_31"  END IF
    IF l_flag[33] = 'N' THEN LET g_xgrid.visible_column =g_xgrid.visible_column CLIPPED,"|l_xccc280_32"  END IF
    IF l_flag[34] = 'N' THEN LET g_xgrid.visible_column =g_xgrid.visible_column CLIPPED,"|l_xccc280_33"  END IF
    IF l_flag[35] = 'N' THEN LET g_xgrid.visible_column =g_xgrid.visible_column CLIPPED,"|l_xccc280_34"  END IF
    IF l_flag[36] = 'N' THEN LET g_xgrid.visible_column =g_xgrid.visible_column CLIPPED,"|l_xccc280_35"  END IF
    IF l_flag[37] = 'N' THEN LET g_xgrid.visible_column =g_xgrid.visible_column CLIPPED,"|l_xccc280_36"  END IF
    IF l_flag[38] = 'N' THEN LET g_xgrid.visible_column =g_xgrid.visible_column CLIPPED,"|l_xccc280_37"  END IF
    IF l_flag[39] = 'N' THEN LET g_xgrid.visible_column =g_xgrid.visible_column CLIPPED,"|l_xccc280_38"  END IF
    IF l_flag[40] = 'N' THEN LET g_xgrid.visible_column =g_xgrid.visible_column CLIPPED,"|l_xccc280_39"  END IF
    IF l_flag[41] = 'N' THEN LET g_xgrid.visible_column =g_xgrid.visible_column CLIPPED,"|l_xccc280_40"  END IF
    IF l_flag[42] = 'N' THEN LET g_xgrid.visible_column =g_xgrid.visible_column CLIPPED,"|l_xccc280_41"  END IF
    IF l_flag[43] = 'N' THEN LET g_xgrid.visible_column =g_xgrid.visible_column CLIPPED,"|l_xccc280_42"  END IF
    IF l_flag[44] = 'N' THEN LET g_xgrid.visible_column =g_xgrid.visible_column CLIPPED,"|l_xccc280_43"  END IF
    IF l_flag[45] = 'N' THEN LET g_xgrid.visible_column =g_xgrid.visible_column CLIPPED,"|l_xccc280_44"  END IF
    IF l_flag[46] = 'N' THEN LET g_xgrid.visible_column =g_xgrid.visible_column CLIPPED,"|l_xccc280_45"  END IF
    IF l_flag[47] = 'N' THEN LET g_xgrid.visible_column =g_xgrid.visible_column CLIPPED,"|l_xccc280_46"  END IF
    IF l_flag[48] = 'N' THEN LET g_xgrid.visible_column =g_xgrid.visible_column CLIPPED,"|l_xccc280_47"  END IF
    IF l_flag[49] = 'N' THEN LET g_xgrid.visible_column =g_xgrid.visible_column CLIPPED,"|l_xccc280_48"  END IF
    IF l_flag[50] = 'N' THEN LET g_xgrid.visible_column =g_xgrid.visible_column CLIPPED,"|l_xccc280_49"  END IF    
   

    #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="axcq910_x01.rep_data" readonly="Y" >}
PRIVATE FUNCTION axcq910_x01_rep_data()
#add-point:rep_data.define (客製用) name="rep_data.define_customerization"

#end add-point:rep_data.define
#add-point:rep_data.define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="rep_data.define"

#end add-point:rep_data.define
 
    #add-point:rep_data.before name="rep_data.before"
    
    #end add-point:rep_data.before
    
    CALL cl_xg_view()
    #add-point:rep_data.after name="rep_data.after"
    
    #end add-point:rep_data.after
END FUNCTION
 
{</section>}
 
{<section id="axcq910_x01.other_function" readonly="Y" >}

 
{</section>}
 
