#該程式未解開Section, 採用最新樣板產出!
{<section id="astr340_g01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:1(2016-07-20 15:19:43), PR版次:0001(2016-07-20 15:21:45)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000019
#+ Filename...: astr340_g01
#+ Description: ...
#+ Creator....: 06540(2016-06-30 11:21:37)
#+ Modifier...: 07142 -SD/PR- 07142
 
{</section>}
 
{<section id="astr340_g01.global" readonly="Y" >}
#報表 g01 樣板自動產生(Version:13)
#add-point:填寫註解說明 name="global.memo"

#end add-point
#add-point:填寫註解說明 name="global.memo_customerization"

 
IMPORT os
#add-point:增加匯入項目 name="global.import"

#end add-point
 
SCHEMA ds
 
GLOBALS "../../cfg/top_global.inc"
GLOBALS "../../cfg/top_report.inc"                  #報表使用的global
 
#報表 type 宣告
PRIVATE TYPE sr1_r RECORD
   stbd003 LIKE stbd_t.stbd003, 
   stbe008 LIKE stbe_t.stbe008, 
   l_djname LIKE type_t.chr50, 
   l_js LIKE type_t.chr30, 
   l_steal003 LIKE type_t.chr30, 
   l_ooefl003 LIKE type_t.chr30, 
   l_pmaal003 LIKE type_t.chr30, 
   stbe002 LIKE stbe_t.stbe002, 
   stbe003 LIKE stbe_t.stbe003, 
   stbeseq LIKE stbe_t.stbeseq, 
   stbe014 LIKE stbe_t.stbe014, 
   stbe025 LIKE stbe_t.stbe025, 
   l_meno LIKE type_t.chr30, 
   l_kouway LIKE type_t.chr30, 
   stbe024 LIKE stbe_t.stbe024, 
   stbe005 LIKE stbe_t.stbe005, 
   l_payway LIKE type_t.chr30, 
   stbe011 LIKE stbe_t.stbe011, 
   stbe031 LIKE stbe_t.stbe031, 
   stbe013 LIKE stbe_t.stbe013, 
   stbe026 LIKE stbe_t.stbe026, 
   stbe012 LIKE stbe_t.stbe012, 
   stbe027 LIKE stbe_t.stbe027, 
   stbe004 LIKE stbe_t.stbe004, 
   stbe019 LIKE stbe_t.stbe019, 
   stbe001 LIKE stbe_t.stbe001, 
   stbe018 LIKE stbe_t.stbe018, 
   stbesite LIKE stbe_t.stbesite, 
   l_idnum LIKE type_t.chr30, 
   stbd021 LIKE stbd_t.stbd021, 
   stbd025 LIKE stbd_t.stbd025, 
   stbd026 LIKE stbd_t.stbd026, 
   l_name LIKE type_t.chr30, 
   stbd033 LIKE stbd_t.stbd033, 
   l_amount LIKE type_t.chr30, 
   stbdcnfid LIKE stbd_t.stbdcnfid, 
   stbddocdt LIKE stbd_t.stbddocdt, 
   ooag_t_ooag011 LIKE ooag_t.ooag011, 
   stbd038 LIKE stbd_t.stbd038, 
   stbd006 LIKE stbd_t.stbd006, 
   stbd005 LIKE stbd_t.stbd005, 
   stbd018 LIKE stbd_t.stbd018, 
   stbd015 LIKE stbd_t.stbd015, 
   stbd011 LIKE stbd_t.stbd011, 
   stbd017 LIKE stbd_t.stbd017, 
   stbe017 LIKE stbe_t.stbe017, 
   stbd002 LIKE stbd_t.stbd002, 
   stbddocno LIKE stbd_t.stbddocno, 
   stbdsite LIKE stbd_t.stbdsite, 
   stbdent LIKE stbd_t.stbdent, 
   stbeent LIKE stbe_t.stbeent, 
   stbd046 LIKE stbd_t.stbd046, 
   l_stbd046 LIKE type_t.chr30, 
   l_imaal003 LIKE imaal_t.imaal003, 
   l_stbc043 LIKE stbc_t.stbc043
END RECORD
 
PRIVATE TYPE sr2_r RECORD
   ooff013 LIKE ooff_t.ooff013
END RECORD
 
 
DEFINE tm RECORD
       wc STRING                   #where condition
       END RECORD
DEFINE sr DYNAMIC ARRAY OF sr1_r                   #宣告sr為sr1_t資料結構的動態陣列
DEFINE g_select        STRING
DEFINE g_from          STRING
DEFINE g_where         STRING
DEFINE g_order         STRING
DEFINE g_sql           STRING                         #report_select_prep,REPORT段使用
 
#add-point:自定義環境變數(Global Variable)(客製用) name="global.variable_customerization"

#end add-point
#add-point:自定義環境變數(Global Variable) (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
TYPE sr3_r RECORD         
   #子報表05資料
  stbddocno like stbe_t.stbedocno,
  l_gys    varchar(80),   #供应商
  l_dz     varchar(40),   #店组
  stbe017   like stbe_t.stbe017,
  l_payway  varchar(20),   #结算方式
  stbesite  like stbe_t.stbesite,
  stbe019   like stbe_t.stbe019,
  stbe005   like stbe_t.stbe005,
  l_name    varchar(40),
  stbe012   like stbe_t.stbe012,
  stbe024   like stbe_t.stbe024,
  stbe032   like stbe_t.stbe032,
  stbe025   like stbe_t.stbe025,
  l_ticket   LIKE stbe_t.stbe012,  #显示扣票总金额  #dd by guomy 2015/12/3
  l_noticket LIKE stbe_t.stbe012  #显示不扣票总金额 #dd by guomy 2015/12/3
END RECORD 
#end add-point
 
{</section>}
 
{<section id="astr340_g01.main" readonly="Y" >}
PUBLIC FUNCTION astr340_g01(p_arg1)
DEFINE  p_arg1 STRING                  #tm.wc  where condition
#add-point:init段define (客製用) name="component_name.define_customerization"

#end add-point
#add-point:init段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="component_name.define"

#end add-point
 
   LET tm.wc = p_arg1
 
   #add-point:報表元件參數準備 name="component.arg.prep"
   
   #end add-point
   #報表元件代號
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 
   ##報表元件執行期間是否有錯誤代碼
   LET g_rep_success = 'Y'   
   
   LET g_rep_code = "astr340_g01"
   IF cl_null(tm.wc) THEN LET tm.wc = " 1=1" END IF
 
   #主報表select子句準備
   CALL astr340_g01_sel_prep()
   
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
 
   #將資料存入array
   CALL astr340_g01_ins_data()
   
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
 
   #將資料印出
   CALL astr340_g01_rep_data()
 
END FUNCTION
 
{</section>}
 
{<section id="astr340_g01.sel_prep" readonly="Y" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION astr340_g01_sel_prep()
   #add-point:sel_prep段define (客製用) name="sel_prep.define_customerization"
   
   #end add-point
   #add-point:sel_prep段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="sel_prep.define"
   
   #end add-point
 
   #add-point:sel_prep before name="sel_prep.before"
   
   #end add-point
   
   #add-point:sel_prep g_select name="sel_prep.g_select"
   
   #end add-point
   LET g_select = " SELECT stbd003,stbe008,NULL,NULL,NULL,NULL,NULL,stbe002,stbe003,stbeseq,stbe014, 
       stbe025,NULL,NULL,stbe024,stbe005,NULL,stbe011,stbe031,stbe013,stbe026,stbe012,stbe027,stbe004, 
       stbe019,stbe001,stbe018,stbesite,NULL,stbd021,stbd025,stbd026,NULL,stbd033,NULL,stbdcnfid,stbddocdt, 
       ooag_t.ooag011,stbd038,stbd006,stbd005,stbd018,stbd015,stbd011,stbd017,stbe017,stbd002,stbddocno, 
       stbdsite,stbdent,stbeent,stbd046,NULL,NULL,NULL"
 
   #add-point:sel_prep g_from name="sel_prep.g_from"
   LET g_select = " SELECT stbd003,stbe008,NULL,NULL,NULL,NULL,NULL,stbe002,stbe003,stbeseq,sum(stbe016),stbe025,NULL,NULL, 
       stbe024,stbe005,NULL,stbe011,stbe031,SUM(stbe013),sum(stbe034),SUM(stbe012),SUM(stbe027),stbe004,stbe019,stbe001, 
       stbe018,stbesite,NULL,stbd021,stbd025,stbd026,NULL,stbd033,NULL,stbdcnfid,stbddocdt,null, 
       stbd038,stbd006,stbd005,stbd018,stbd015,stbd011,stbd017,stbe017,stbd002,stbddocno,stbdsite,stbdent, 
       stbeent,stbd046,pmaal004 "  
       
   #end add-point
    LET g_from = " FROM stbd_t,stbe_t,ooag_t"
 
   #add-point:sel_prep g_where name="sel_prep.g_where"
   LET g_from = " FROM stbd_t LEFT JOIN stbe_t ON stbdent=stbeent AND stbddocno =stbedocno AND stbe001<>'3' ",
                " LEFT JOIN ooag_t ON ooag_t.ooag001 = stbd021 AND ooag_t.ooagent = stbdent  " ,
                " LEFT JOIN pmaal_t ON pmaalent =stbdent AND pmaal001 = stbd046 AND pmaal002 = '",g_dlang,"' "    ###增加单头显示付款供应商和备注显示stbd046,pmaal004 2015/12/3 add by guomy --------------               

   #end add-point
    LET g_where = " WHERE " ,tm.wc CLIPPED 
 
   #add-point:sel_prep g_order name="sel_prep.g_order"
      IF g_prog='astr340' THEN
       LET g_where = " WHERE stbd000 = '1'  AND " ,tm.wc CLIPPED
     ELSE
        LET g_where = " WHERE  stbd000 = '1'  AND (stbdstus ='J' or stbdstus ='Y')  AND  " ,tm.wc CLIPPED  
     END IF  
    IF g_errno='N' THEN
       LET g_where = " WHERE stbd000 = '1'  AND " ,tm.wc CLIPPED
    END IF
   
   #end add-point
    LET g_order = " ORDER BY stbddocno"
 
   #add-point:sel_prep.sql.before name="sel_prep.sql.before"

    LET g_order = " group by ", 
                 " stbd003,stbe008,stbe002,stbe003,stbeseq,stbe025,stbe024, 
             stbe005,stbe011,stbe031,stbe004,stbe019,stbe001,stbe018, 
             stbesite,stbd021,stbd025,stbd026,stbd033,stbdcnfid,stbddocdt,ooag_t.ooag011,stbd038, 
             stbd006,stbd005,stbd018,stbd015,stbd011,stbd017,stbe017,stbd002,stbddocno,stbdsite,stbdent,stbeent,stbd046,pmaal004 ",
             " ORDER BY stbddocno,stbdsite,stbe002  "
    
   #end add-point:sel_prep.sql.before
   LET g_where = g_where ,cl_sql_add_filter("stbd_t")   #資料過濾功能
   LET g_sql = g_select CLIPPED ," ",g_from CLIPPED ," ",g_where CLIPPED ," ",g_order CLIPPED
   LET g_sql = cl_sql_add_mask(g_sql)    #遮蔽特定資料, 若寫至add-point也需複製此段 
 
   #add-point:sel_prep.sql.after name="sel_prep.sql.after"
   
   #end add-point
   PREPARE astr340_g01_prepare FROM g_sql
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'prepare:'
      LET g_errparam.code   = STATUS
      LET g_errparam.popup  = TRUE
      CALL cl_err()   
      LET g_rep_success = 'N'    
   END IF
   DECLARE astr340_g01_curs CURSOR FOR astr340_g01_prepare
 
END FUNCTION
 
{</section>}
 
{<section id="astr340_g01.ins_data" readonly="Y" >}
PRIVATE FUNCTION astr340_g01_ins_data()
#主報表record(用於select子句)
   DEFINE sr_s RECORD 
   stbd003 LIKE stbd_t.stbd003, 
   stbe008 LIKE stbe_t.stbe008, 
   l_djname LIKE type_t.chr50, 
   l_js LIKE type_t.chr30, 
   l_steal003 LIKE type_t.chr30, 
   l_ooefl003 LIKE type_t.chr30, 
   l_pmaal003 LIKE type_t.chr30, 
   stbe002 LIKE stbe_t.stbe002, 
   stbe003 LIKE stbe_t.stbe003, 
   stbeseq LIKE stbe_t.stbeseq, 
   stbe014 LIKE stbe_t.stbe014, 
   stbe025 LIKE stbe_t.stbe025, 
   l_meno LIKE type_t.chr30, 
   l_kouway LIKE type_t.chr30, 
   stbe024 LIKE stbe_t.stbe024, 
   stbe005 LIKE stbe_t.stbe005, 
   l_payway LIKE type_t.chr30, 
   stbe011 LIKE stbe_t.stbe011, 
   stbe031 LIKE stbe_t.stbe031, 
   stbe013 LIKE stbe_t.stbe013, 
   stbe026 LIKE stbe_t.stbe026, 
   stbe012 LIKE stbe_t.stbe012, 
   stbe027 LIKE stbe_t.stbe027, 
   stbe004 LIKE stbe_t.stbe004, 
   stbe019 LIKE stbe_t.stbe019, 
   stbe001 LIKE stbe_t.stbe001, 
   stbe018 LIKE stbe_t.stbe018, 
   stbesite LIKE stbe_t.stbesite, 
   l_idnum LIKE type_t.chr30, 
   stbd021 LIKE stbd_t.stbd021, 
   stbd025 LIKE stbd_t.stbd025, 
   stbd026 LIKE stbd_t.stbd026, 
   l_name LIKE type_t.chr30, 
   stbd033 LIKE stbd_t.stbd033, 
   l_amount LIKE type_t.chr30, 
   stbdcnfid LIKE stbd_t.stbdcnfid, 
   stbddocdt LIKE stbd_t.stbddocdt, 
   ooag_t_ooag011 LIKE ooag_t.ooag011, 
   stbd038 LIKE stbd_t.stbd038, 
   stbd006 LIKE stbd_t.stbd006, 
   stbd005 LIKE stbd_t.stbd005, 
   stbd018 LIKE stbd_t.stbd018, 
   stbd015 LIKE stbd_t.stbd015, 
   stbd011 LIKE stbd_t.stbd011, 
   stbd017 LIKE stbd_t.stbd017, 
   stbe017 LIKE stbe_t.stbe017, 
   stbd002 LIKE stbd_t.stbd002, 
   stbddocno LIKE stbd_t.stbddocno, 
   stbdsite LIKE stbd_t.stbdsite, 
   stbdent LIKE stbd_t.stbdent, 
   stbeent LIKE stbe_t.stbeent, 
   stbd046 LIKE stbd_t.stbd046, 
   l_stbd046 LIKE type_t.chr30, 
   l_imaal003 LIKE imaal_t.imaal003, 
   l_stbc043 LIKE stbc_t.stbc043
 END RECORD
   DEFINE l_cnt           LIKE type_t.num10
#add-point:ins_data段define (客製用) name="ins_data.define_customerization"

#end add-point   
#add-point:ins_data段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ins_data.define"
define l_string   string
DEFINE l_stbc043  LIKE stbc_t.stbc043
DEFINE l_imaal003 LIKE imaal_t.imaal003
#end add-point
 
    #add-point:ins_data段before name="ins_data.before"
    
    #end add-point
 
    CALL sr.clear()                                  #rep sr
    LET l_cnt = 1
    FOREACH astr340_g01_curs INTO sr_s.*
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
       let  sr_s.stbd015 =0
       let sr_s.stbe014 =sr_s.stbe014*sr_s.stbe011
#       let sr_s.stbe026 =sr_s.stbe026 * sr_s.stbe027*sr_s.stbe011
 # add  by guomy 2015/7/23  for 销售金额数值错误 
    #  let sr_s.stbe026 =sr_s.stbe014/(1-sr_s.stbe031/100)
      
 
       #let sr_s.stbe013 =(sr_s.stbe013 - sr_s.stbe012)*sr_s.stbe011
        
    select pmaal003 into sr_s.l_pmaal003 from pmaal_t where pmaal001=sr_s.stbd002 and pmaalent=sr_s.stbdent and pmaal002=g_dlang  
    let sr_s.l_pmaal003=sr_s.stbd002,' ',sr_s.l_pmaal003 
#    #店组 ----mark by guomy 2015/10/31--------------start-----------
#     select ooefl003 into sr_s.l_ooefl003 from ooefl_t where ooefl001=sr_s.stbdsite and ooeflent =sr_s.stbdent and ooefl002=g_dlang
#    
    #店组取法人名称 
     SELECT ooefl006 INTO sr_s.l_ooefl003 
      FROM ooef_t,ooefl_t 
     WHERE ooef001=sr_s.stbdsite 
       AND ooefent =sr_s.stbdent
       AND ooefl002 = g_dlang
       AND ooefl001 = ooef017 

      IF NOT cl_null(sr_s.stbd046) THEN  #add by guomy 2015/12/3 
         LET sr_s.l_stbd046 = sr_s.stbd046,'|',sr_s.l_stbd046
      END IF  

##############################add by guomy 2015/10/31----------    


    #结算方式
     select staal003 into sr_s.l_js from staal_t where staal001=sr_s.stbe017 and staalent=sr_s.stbdent and staal002=g_dlang 
  let sr_s.l_js = sr_s.stbe017,'|',sr_s.l_js   
        select gzcbl004 into sr_s.l_steal003 
        from gzcbl_t 
        where  gzcbl001 ='6703'  
        AND  gzcbl002 = sr_s.stbe001  
        AND  gzcbl003 = g_dlang
       
   select ooag011 into sr_s.l_name from ooag_t where ooag007=sr_s.stbd026 and ooagent=sr_s.stbdent
    #结算类型
    SELECT oocql004  into sr_s.l_payway FROM oocql_t WHERE oocqlent=sr_s.stbdent AND oocql001 = '2060' AND oocql002=sr_s.stbe018 AND oocql003=g_dlang
    select ooag011 into sr_s.stbdcnfid  from ooag_t where ooag001=sr_s.stbdcnfid and ooagent=sr_s.stbdent 
    
LET l_string = sr_s.stbd018 USING '--,---,---,---,---,--&.&&'
#LET sr_s.l_amount = s_num_to_chinese(sr_s.stbd018)," (",sr_s.stbe008," ",l_string.trim(),")"
 LET sr_s.l_amount = s_num_to_chinese(sr_s.stbd018)
       #end add-point
 
       #add-point:ins_data段before_arr name="ins_data.before.save"
    #商品编号+名称
     SELECT stbc043 INTO sr_s.l_stbc043 FROM stbc_t,stbe_t 
     WHERE stbcent=sr_s.stbeent  AND stbc004=sr_s.stbe002 AND stbc005=sr_s.stbe003
     SELECT imaal003 INTO sr_s.l_imaal003  FROM imaal_t 
     WHERE imaalent=g_ernterprise AND imaal001=l_stbc043 AND imaal002=g_prog
       #end add-point
 
       #set rep array value
       LET sr[l_cnt].stbd003 = sr_s.stbd003
       LET sr[l_cnt].stbe008 = sr_s.stbe008
       LET sr[l_cnt].l_djname = sr_s.l_djname
       LET sr[l_cnt].l_js = sr_s.l_js
       LET sr[l_cnt].l_steal003 = sr_s.l_steal003
       LET sr[l_cnt].l_ooefl003 = sr_s.l_ooefl003
       LET sr[l_cnt].l_pmaal003 = sr_s.l_pmaal003
       LET sr[l_cnt].stbe002 = sr_s.stbe002
       LET sr[l_cnt].stbe003 = sr_s.stbe003
       LET sr[l_cnt].stbeseq = sr_s.stbeseq
       LET sr[l_cnt].stbe014 = sr_s.stbe014
       LET sr[l_cnt].stbe025 = sr_s.stbe025
       LET sr[l_cnt].l_meno = sr_s.l_meno
       LET sr[l_cnt].l_kouway = sr_s.l_kouway
       LET sr[l_cnt].stbe024 = sr_s.stbe024
       LET sr[l_cnt].stbe005 = sr_s.stbe005
       LET sr[l_cnt].l_payway = sr_s.l_payway
       LET sr[l_cnt].stbe011 = sr_s.stbe011
       LET sr[l_cnt].stbe031 = sr_s.stbe031
       LET sr[l_cnt].stbe013 = sr_s.stbe013
       LET sr[l_cnt].stbe026 = sr_s.stbe026
       LET sr[l_cnt].stbe012 = sr_s.stbe012
       LET sr[l_cnt].stbe027 = sr_s.stbe027
       LET sr[l_cnt].stbe004 = sr_s.stbe004
       LET sr[l_cnt].stbe019 = sr_s.stbe019
       LET sr[l_cnt].stbe001 = sr_s.stbe001
       LET sr[l_cnt].stbe018 = sr_s.stbe018
       LET sr[l_cnt].stbesite = sr_s.stbesite
       LET sr[l_cnt].l_idnum = sr_s.l_idnum
       LET sr[l_cnt].stbd021 = sr_s.stbd021
       LET sr[l_cnt].stbd025 = sr_s.stbd025
       LET sr[l_cnt].stbd026 = sr_s.stbd026
       LET sr[l_cnt].l_name = sr_s.l_name
       LET sr[l_cnt].stbd033 = sr_s.stbd033
       LET sr[l_cnt].l_amount = sr_s.l_amount
       LET sr[l_cnt].stbdcnfid = sr_s.stbdcnfid
       LET sr[l_cnt].stbddocdt = sr_s.stbddocdt
       LET sr[l_cnt].ooag_t_ooag011 = sr_s.ooag_t_ooag011
       LET sr[l_cnt].stbd038 = sr_s.stbd038
       LET sr[l_cnt].stbd006 = sr_s.stbd006
       LET sr[l_cnt].stbd005 = sr_s.stbd005
       LET sr[l_cnt].stbd018 = sr_s.stbd018
       LET sr[l_cnt].stbd015 = sr_s.stbd015
       LET sr[l_cnt].stbd011 = sr_s.stbd011
       LET sr[l_cnt].stbd017 = sr_s.stbd017
       LET sr[l_cnt].stbe017 = sr_s.stbe017
       LET sr[l_cnt].stbd002 = sr_s.stbd002
       LET sr[l_cnt].stbddocno = sr_s.stbddocno
       LET sr[l_cnt].stbdsite = sr_s.stbdsite
       LET sr[l_cnt].stbdent = sr_s.stbdent
       LET sr[l_cnt].stbeent = sr_s.stbeent
       LET sr[l_cnt].stbd046 = sr_s.stbd046
       LET sr[l_cnt].l_stbd046 = sr_s.l_stbd046
       LET sr[l_cnt].l_imaal003 = sr_s.l_imaal003
       LET sr[l_cnt].l_stbc043 = sr_s.l_stbc043
 
 
       #add-point:ins_data段after_arr name="ins_data.after.save"
       
       #end add-point
       LET l_cnt = l_cnt + 1
    END FOREACH
    CALL sr.deleteElement(l_cnt)
 
    #add-point:ins_data段after name="ins_data.after"
    
    #end add-point
END FUNCTION
 
{</section>}
 
{<section id="astr340_g01.rep_data" readonly="Y" >}
PRIVATE FUNCTION astr340_g01_rep_data()
   DEFINE HANDLER         om.SaxDocumentHandler
   DEFINE l_i             INTEGER
 
    #判斷是否有報表資料，若回彈出訊息視窗
    IF sr.getLength() = 0 THEN
       INITIALIZE g_errparam TO NULL
       LET g_errparam.code = "adz-00285"
       LET g_errparam.extend = NULL
       LET g_errparam.popup  = FALSE
       LET g_errparam.replace[1] = ''
       CALL cl_err()  
       RETURN 
    END IF
    WHILE TRUE   
       #add-point:rep_data段印前 name="rep_data.before"
 
       #end add-point     
       LET handler = cl_gr_handler()
       IF handler IS NOT NULL THEN
          START REPORT astr340_g01_rep TO XML HANDLER handler
          FOR l_i = 1 TO sr.getLength()
             OUTPUT TO REPORT astr340_g01_rep(sr[l_i].*)
             #報表中斷列印時，顯示錯誤訊息
             IF fgl_report_getErrorStatus() THEN
                DISPLAY "FGL: STOPPING REPORT msg=\"",fgl_report_getErrorString(),"\""
                EXIT FOR
             END IF                  
          END FOR
          FINISH REPORT astr340_g01_rep
       END IF
       #add-point:rep_data段印完 name="rep_data.after"
       
       #end add-point       
       IF g_rep_flag = TRUE THEN
          LET g_rep_flag = FALSE
          EXIT WHILE
       END IF
    END WHILE
    #add-point:rep_data段離開while印完前 name="rep_data.end.before"
    
    #end add-point
    CALL cl_gr_close_report()
    #add-point:rep_data段離開while印完後 name="rep_data.end.after"
    
    #end add-point    
END FUNCTION
 
{</section>}
 
{<section id="astr340_g01.rep" readonly="Y" >}
PRIVATE REPORT astr340_g01_rep(sr1)
DEFINE sr1 sr1_r
DEFINE sr2 sr2_r
DEFINE l_subrep01_show  LIKE type_t.chr1,
       l_subrep02_show  LIKE type_t.chr1,
       l_subrep03_show  LIKE type_t.chr1,
       l_subrep04_show  LIKE type_t.chr1
DEFINE l_cnt           LIKE type_t.num10
DEFINE l_sub_sql       STRING
#add-point:rep段define  (客製用) name="rep.define_customerization"

#end add-point
#add-point:rep段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="rep.define"
DEFINE l_amount     LIKE pmdt_t.pmdt036 
DEFINE l_amount1     LIKE pmdt_t.pmdt036 
DEFINE l_amount2     LIKE pmdt_t.pmdt036 
DEFINE l_sum1        LIKE pmdt_t.pmdt036
DEFINE l_sum2        LIKE pmdt_t.pmdt036
DEFINE l_sum3        LIKE pmdt_t.pmdt036
DEFINE l_sum4        LIKE pmdt_t.pmdt036
DEFINE l_sum5        LIKE pmdt_t.pmdt036
DEFINE l_sum6        LIKE pmdt_t.pmdt036
DEFINE l_stbesite        LIKE stbe_t.stbesite
DEFINE l_i          INTEGER
DEFINE l_show     LIKE type_t.chr1
DEFINE l_ooefl006  LIKE ooefl_t.ooefl006
DEFINE l_site     varchar(50)
DEFINE sr3 sr3_r                                        
DEFINE l_subrep05_show  LIKE type_t.chr1   
define l_show1      like type_t.chr1
define l_right_width  like type_t.num15_3
DEFINE l_kaipiao      LIKE type_t.num15_3
DEFINE l_staal003     LIKE staal_t.staal003

#####设置固话格子的显示  guomy 2015/10/29----start--------
#DEFINE l_cmd             STRING               
#DEFINE l_body_cnt        LIKE type_t.num5
#DEFINE l_body_cnt_2      LIKE type_t.num5
#DEFINE l_body_tot        LIKE type_t.num5  
#DEFINE l_display_line2   LIKE type_t.chr1
#DEFINE l_display_line3   LIKE type_t.chr1
#DEFINE l_display_line4   LIKE type_t.chr1
#DEFINE l_display_line5   LIKE type_t.chr1
#DEFINE l_display_sum     LIKE type_t.chr1
#DEFINE l_lineno          LIKE type_t.num5
#DEFINE l_pageno          STRING  
#DEFINE l_pagecnt         LIKE type_t.num5  
#DEFINE l_pagetot         LIKE type_t.num5 
#DEFINE l_display_header  LIKE type_t.chr1
#DEFINE l_yy              LIKE type_t.num5 
#DEFINE l_mm              LIKE type_t.num5
#DEFINE l_dd              LIKE type_t.num5
#DEFINE l_sum_str         STRING
#DEFINE l_skip            LIKE type_t.chr1
#####设置固话格子的显示  guomy 2015/10/29----end--------
DEFINE l_ticket   LIKE stbe_t.stbe012  #显示扣票总金额  #dd by guomy 2015/12/3
DEFINE l_noticket LIKE stbe_t.stbe012  #显示不扣票总金额 #dd by guomy 2015/12/3
#add by dengdd 160319(S)
DEFINE l_stbd001  LIKE stbd_t.stbd001
DEFINE l_stbd041  LIKE stbd_t.stbd041
DEFINE l_stbd041_desc LIKE type_t.chr50
#add by dengdd 160319(E)
DEFINE l_stan017    LIKE stan_t.stan017 #add by dengdd 160517
DEFINE l_stan018    LIKE stan_t.stan018 #add by dengdd 160517

#end add-point
 
    #add-point:rep段ORDER_before name="rep.order.before"
    
    #end add-point
    ORDER  BY sr1.stbddocno
    #add-point:rep段ORDER_after name="rep.order.after"
    
    #end add-point
    
    FORMAT
       FIRST PAGE HEADER          
          PRINTX g_user,g_pdate,g_rep_code,g_company,g_ptime,g_user_name,g_date_fmt
          PRINTX tm.*
          PRINTX g_grNumFmt.*
          PRINTX g_rep_wcchp
 
          #讀取beforeGrup子樣板+子報表樣板
        #報表 d01 樣板自動產生(Version:2)
        BEFORE GROUP OF sr1.stbddocno
            #報表 d05 樣板自動產生(Version:6)
            CALL cl_gr_title_clear()  #清除title變數值 
            #add-point:rep.header  #公司資訊(不在公用變數內) name="rep.header"
             SELECT ooefl006 INTO l_ooefl006
             FROM ooefl_t 
             WHERE ooeflent = sr1.stbdent
               AND ooefl001 = (SELECT ooef017 
                                 FROM ooef_t 
                                WHERE ooefent = sr1.stbdent AND ooef001 = sr1.stbdsite) 
               AND ooefl002 = g_dlang
            LET g_grPageHeader.title0101 = l_ooefl006

            #end add-point:rep.header 
            LET g_rep_docno = sr1.stbddocno
            CALL cl_gr_init_pageheader() #表頭資訊
            PRINTX g_grPageHeader.*
            PRINTX g_grPageFooter.*
            #add-point:rep.apr.signstr.before name="rep.apr.signstr.before"
                          
            #end add-point:rep.apr.signstr.before   
            LET g_doc_key = 'stbdent=' ,sr1.stbdent,'{+}stbddocno=' ,sr1.stbddocno         
            CALL cl_gr_init_apr(sr1.stbddocno)
            #add-point:rep.apr.signstr name="rep.apr.signstr"
            SELECT stbd001,stbd041 INTO l_stbd001,l_stbd041 FROM stbd_t WHERE stbdent = g_enterprise AND stbddocno=sr1.stbddocno
            
            SELECT gzcbl004 INTO l_stbd041_desc FROM gzcbl_t 
             WHERE gzcbl001='6013'
               AND gzcbl002 = l_stbd041
               AND gzcbl003 = g_dlang
            #add by dengdd 160319(E)
            
            #add by dengdd 160517(s)--合同生失效日期
            SELECT stan017,stan018 INTO l_stan017,l_stan018 FROM stan_t
             WHERE stanent = g_enterprise AND stan001=l_stbd001
            #add by dengdd 160517(e)

            #end add-point:rep.apr.signstr
            PRINTX g_grSign.*
 
 
 
           #add-point:rep.b_group.stbddocno.before name="rep.b_group.stbddocno.before"
            LET l_i=1   #add BY guomy 2015/11/24 显示合计第一笔资料
            LET l_sum1=0
            LET l_sum2=0
            LET l_sum3=0
            LET l_sum4=0
            LET l_sum5=0
            LET l_sum6=0
            LET l_amount=0
            LET l_amount1=0
            LET l_amount2=0
            LET l_stbesite = sr1.stbesite
           #end add-point:

           #end add-point:
 
           #報表 d03 樣板自動產生(Version:3)
           #add-point:rep.sub01.before name="rep.sub01.before"
           
           #end add-point:rep.sub01.before
 
           #add-point:rep.sub01.sql name="rep.sub01.sql"
           
           #end add-point:rep.sub01.sql
 
           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='6' AND ooff012='2' AND ooff004=0 AND ooffent = '", 
                sr1.stbdent CLIPPED ,"'", " AND  ooff003 = '", sr1.stbddocno CLIPPED ,"'"
 
           #add-point:rep.sub01.afsql name="rep.sub01.afsql"
           
           #end add-point:rep.sub01.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep01_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE astr340_g01_repcur01_cnt_pre FROM l_sub_sql
           EXECUTE astr340_g01_repcur01_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep01_show ="Y"
           END IF
           PRINTX l_subrep01_show
           START REPORT astr340_g01_subrep01
           DECLARE astr340_g01_repcur01 CURSOR FROM g_sql
           FOREACH astr340_g01_repcur01 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "astr340_g01_repcur01:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub01.foreach name="rep.sub01.foreach"
              
              #end add-point:rep.sub01.foreach
              OUTPUT TO REPORT astr340_g01_subrep01(sr2.*)
           END FOREACH
           FINISH REPORT astr340_g01_subrep01
           #add-point:rep.sub01.after name="rep.sub01.after"
           
           #end add-point:rep.sub01.after
 
 
 
           #add-point:rep.b_group.stbddocno.after name="rep.b_group.stbddocno.after"
           
           #end add-point:
 
 
 
 
       ON EVERY ROW
          #add-point:rep.everyrow.before name="rep.everyrow.before"
              LET l_right_width=0  
           IF  sr1.stbd003='1' THEN 
              LET l_show1 ='N'
              LET l_right_width=0              
           ELSE 
              LET l_show1 ='Y'
              LET l_right_width=0.5
           END IF 
              PRINTX l_right_width
              PRINTX l_show1
          #end add-point:rep.everyrow.before
 
          #單身前備註
             #報表 d03 樣板自動產生(Version:3)
           #add-point:rep.sub02.before name="rep.sub02.before"
           
           #end add-point:rep.sub02.before
 
           #add-point:rep.sub02.sql name="rep.sub02.sql"
           
           #end add-point:rep.sub02.sql
 
           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='7' AND ooff012='2' AND ooffent = '", 
                sr1.stbdent CLIPPED ,"'", " AND  ooff003 = '", sr1.stbddocno CLIPPED ,"'"
 
           #add-point:rep.sub02.afsql name="rep.sub02.afsql"
           
           #end add-point:rep.sub02.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep02_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE astr340_g01_repcur02_cnt_pre FROM l_sub_sql
           EXECUTE astr340_g01_repcur02_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep02_show ="Y"
           END IF
           PRINTX l_subrep02_show
           START REPORT astr340_g01_subrep02
           DECLARE astr340_g01_repcur02 CURSOR FROM g_sql
           FOREACH astr340_g01_repcur02 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "astr340_g01_repcur02:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub02.foreach name="rep.sub02.foreach"
              
              #end add-point:rep.sub02.foreach
              OUTPUT TO REPORT astr340_g01_subrep02(sr2.*)
           END FOREACH
           FINISH REPORT astr340_g01_subrep02
           #add-point:rep.sub02.after name="rep.sub02.after"
           
           #end add-point:rep.sub02.after
 
 
 
          #add-point:rep.everyrow.beforerow name="rep.everyrow.beforerow"
          
          #end add-point:rep.everyrow.beforerow
            
          PRINTX sr1.*
 
          #add-point:rep.everyrow.afterrow name="rep.everyrow.afterrow"
          LET l_site=l_stbesite,' 应付小计'          
          PRINTX l_amount,l_amount1,l_amount2,l_site
            
          LET l_show ='N'
          IF  cl_null(sr1.stbe014) THEN
          LET sr1.stbe014 =0
          END IF 
          IF  cl_null(sr1.stbe026) THEN
          LET sr1.stbe026 =0
          END IF
          IF  cl_null(sr1.stbe013) THEN
          LET sr1.stbe013 =0
          END IF
          IF sr1.stbesite<>l_stbesite THEN
             IF  l_i > 1  THEN       
             LET l_show='Y'
             END IF 
             LET l_amount   = sr1.stbe014
             LET l_amount1  = sr1.stbe026
             LET l_amount2  = sr1.stbe013
             LET l_stbesite = sr1.stbesite
          ELSE
             LET l_amount = l_amount + sr1.stbe014
             LET l_amount1 = l_amount1 + sr1.stbe026
             LET l_amount2 = l_amount2 + sr1.stbe013
          END IF
         
          LET l_sum4 = l_sum4 + sr1.stbe014
          LET l_sum5 = l_sum5 + sr1.stbe026
          LET l_sum6 = l_sum6 + sr1.stbe013
          PRINTX l_show
          LET l_i=l_i+1
          #end add-point:rep.everyrow.afterrow
 
          #單身後備註
             #報表 d03 樣板自動產生(Version:3)
           #add-point:rep.sub03.before name="rep.sub03.before"
            LET l_sum1 =l_amount
            LET l_sum2 =l_amount1
            LET l_sum3 =l_amount2
           #end add-point:rep.sub03.before
 
           #add-point:rep.sub03.sql name="rep.sub03.sql"
           
           #end add-point:rep.sub03.sql
 
           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='7' AND ooff012='1' AND ooff003 = '", 
                sr1.stbdent CLIPPED ,"'"
 
           #add-point:rep.sub03.afsql name="rep.sub03.afsql"
           
           #end add-point:rep.sub03.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep03_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE astr340_g01_repcur03_cnt_pre FROM l_sub_sql
           EXECUTE astr340_g01_repcur03_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep03_show ="Y"
           END IF
           PRINTX l_subrep03_show
           START REPORT astr340_g01_subrep03
           DECLARE astr340_g01_repcur03 CURSOR FROM g_sql
           FOREACH astr340_g01_repcur03 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "astr340_g01_repcur03:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub03.foreach name="rep.sub03.foreach"
              
              #end add-point:rep.sub03.foreach
              OUTPUT TO REPORT astr340_g01_subrep03(sr2.*)
           END FOREACH
           FINISH REPORT astr340_g01_subrep03
           #add-point:rep.sub03.after name="rep.sub03.after"
           
           #end add-point:rep.sub03.after
 
 
 
          #add-point:rep.everyrow.after name="rep.everyrow.after"
          
          #end add-point:rep.everyrow.after        
 
          #讀取afterGrup子樣板+子報表樣板
        #報表 d01 樣板自動產生(Version:2)
        AFTER GROUP OF sr1.stbddocno
 
           #add-point:rep.a_group.stbddocno.before name="rep.a_group.stbddocno.before"
          SELECT stbd045 INTO l_kaipiao
            FROM stbd_t
           WHERE stbdent=g_enterprise
             AND stbddocno = sr1.stbddocno
           
          PRINTX l_kaipiao
          PRINTX l_sum1
          PRINTX l_sum2
          PRINTX l_sum3
          PRINTX l_sum4
          PRINTX l_sum5
          PRINTX l_sum6
          
          PRINTX l_stbd001
          PRINTX l_stan017  #add by dengdd 160517
          PRINTX l_stan018  #add by dengdd 160517
       
#       let g_sql=" select stbddocno,'','','','',stbesite,stbe019,stbe005,'',stbe014,stbe024,stbe032,stbe025 ",
#                    " from stbe_t,stbd_t  " ,
#                    " where stbdent =stbeent and stbddocno = stbedocno ",
#                    " and stbdent= '",sr1.stbdent,"'  and stbddocno='",sr1.stbddocno,"'" ,
#                    " and stbe001='3' and stbe024='Y' "                    
         #mark by guomy 2015/12/3-------------------------------------------mark by guomy 2015/12/3--start---
          LET l_ticket = 0
          LET l_noticket = 0       
          LET g_sql=" SELECT SUM(stbe014) ",  #总计扣票金额
                       " FROM stbe_t,stbd_t  " ,
                       " WHERE stbdent =stbeent AND stbddocno = stbedocno ",
                       " AND stbdent= '",sr1.stbdent,"'  AND stbddocno='",sr1.stbddocno,"'" ,
                       " AND stbe001='3' AND stbe024='Y' " ,
                       " AND stbe025='Y' " 
          PREPARE astr340_g01_repcur05_ticket FROM g_sql
          EXECUTE astr340_g01_repcur05_ticket INTO l_ticket
          
          LET g_sql=" SELECT SUM(stbe014) ",  #总计不扣票金额
                       " FROM stbe_t,stbd_t  " ,
                       " WHERE stbdent =stbeent AND stbddocno = stbedocno ",
                       " AND stbdent= '",sr1.stbdent,"'  AND stbddocno='",sr1.stbddocno,"'" ,
                       " AND stbe001='3' AND stbe024='Y' " ,
                       " AND stbe025='N' " 
          PREPARE astr340_g01_repcur05_noticket FROM g_sql
          EXECUTE astr340_g01_repcur05_noticket INTO l_noticket
          PRINTX l_ticket
          PRINTX l_noticket
          
          LET g_sql=" SELECT stbddocno,'','',stbe017,'',stbesite,stbe019,stbe005,'',stbe016,stbe024,stbe032,stbe025,'','' ",
                       " FROM stbe_t,stbd_t  " ,
                       " WHERE stbdent =stbeent AND stbddocno = stbedocno ",
                       " AND stbdent= '",sr1.stbdent,"'  AND stbddocno='",sr1.stbddocno,"'" ,
                       " AND stbe001='3' AND stbe024='Y' " ,
                       " ORDER BY stbesite,stbe025 " 
          #add BY guomy 2015/12/3增加排序按照是否扣票排序 并汇总扣票金额和不扣票金额显示在子单头 ---end ------                                       
          LET l_cnt = 0
          LET l_sub_sql = ""
          LET l_subrep05_show ="N"
          LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
          PREPARE astr340_g01_repcur05_cnt_pre FROM l_sub_sql
          EXECUTE astr340_g01_repcur05_cnt_pre INTO l_cnt
          IF l_cnt > 0 THEN 
            LET l_subrep05_show ="Y"
          END IF
          PRINTX l_subrep05_show                           
          START REPORT astr340_g01_subrep05                 
             DECLARE astr340_g01_repcur05 CURSOR FROM g_sql
             FOREACH astr340_g01_repcur05 INTO sr3.*
             
                LET sr3.l_ticket  = l_ticket
                LET sr3.l_noticket= l_noticket
                
                #供应商
                SELECT pmaal003 INTO sr3.l_gys FROM pmaal_t WHERE pmaal001=sr1.stbd002 AND pmaalent=sr1.stbdent AND pmaal002=g_dlang  
                 LET sr3.l_gys=sr1.stbd002,' ',sr3.l_gys 
                #店组 
                SELECT ooefl003 INTO sr3.l_dz FROM ooefl_t WHERE ooefl001=sr1.stbdsite AND ooeflent =sr1.stbdent AND ooefl002=g_dlang
                #支付方式
                select staal003 into l_staal003 from staal_t where staal001=sr3.stbe017 and staalent=sr1.stbdent and staal002=g_dlang 
                let sr3.stbe017 = sr3.stbe017,'|',l_staal003 
                #扣项名称
                SELECT stael003 INTO sr3.l_name  FROM stael_t WHERE stael001=sr3.stbe005 AND staelent=sr1.stbdent
                 OUTPUT TO REPORT astr340_g01_subrep05(sr3.*)
             END FOREACH  
          
           FINISH REPORT astr340_g01_subrep05 
           #end add-point:
 
           #報表 d03 樣板自動產生(Version:3)
           #add-point:rep.sub04.before name="rep.sub04.before"
           
           #end add-point:rep.sub04.before
 
           #add-point:rep.sub04.sql name="rep.sub04.sql"
           
           #end add-point:rep.sub04.sql
 
           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='6' AND ooff012='1' AND ooff004=0 AND ooffent = '", 
                sr1.stbdent CLIPPED ,"'", " AND  ooff003 = '", sr1.stbddocno CLIPPED ,"'"
 
           #add-point:rep.sub04.afsql name="rep.sub04.afsql"
           
           #end add-point:rep.sub04.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep04_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE astr340_g01_repcur04_cnt_pre FROM l_sub_sql
           EXECUTE astr340_g01_repcur04_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep04_show ="Y"
           END IF
           PRINTX l_subrep04_show
           START REPORT astr340_g01_subrep04
           DECLARE astr340_g01_repcur04 CURSOR FROM g_sql
           FOREACH astr340_g01_repcur04 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "astr340_g01_repcur04:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub04.foreach name="rep.sub04.foreach"
              
              #end add-point:rep.sub04.foreach
              OUTPUT TO REPORT astr340_g01_subrep04(sr2.*)
           END FOREACH
           FINISH REPORT astr340_g01_subrep04
           #add-point:rep.sub04.after name="rep.sub04.after"
           
           #end add-point:rep.sub04.after
 
 
 
           #add-point:rep.a_group.stbddocno.after name="rep.a_group.stbddocno.after"
           
           #end add-point:
 
 
 
       ON LAST ROW
            #add-point:rep.lastrow.before name="rep.lastrow.before"  
                    
            #end add-point :rep.lastrow.before
 
            #add-point:rep.lastrow.after name="rep.lastrow.after"
            
            #end add-point :rep.lastrow.after
END REPORT
 
{</section>}
 
{<section id="astr340_g01.subrep_str" readonly="Y" >}
#讀取子報表樣板
#報表 d02 樣板自動產生(Version:3)
PRIVATE REPORT astr340_g01_subrep01(sr2)
DEFINE  sr2  sr2_r
#add-point:query段define(客製用) name="sub01.define_customerization" 

#end add-point
#add-point:sub01.define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="sub01.define" 

#end add-point:sub01.define
 
    #add-point:sub01.order.before name="sub01.order.before" 
    
    #end add-point:sub01.order.before
 
 
 
    FORMAT
 
 
 
       ON EVERY ROW
            #add-point:sub01.everyrow.before name="sub01.everyrow.before" 
                          
            #end add-point:sub01.everyrow.before
 
            PRINTX sr2.*
 
            #add-point:sub01.everyrow.after name="sub01.everyrow.after" 
            
            #end add-point:sub01.everyrow.after
 
 
END REPORT
 
 
#報表 d02 樣板自動產生(Version:3)
PRIVATE REPORT astr340_g01_subrep02(sr2)
DEFINE  sr2  sr2_r
#add-point:query段define(客製用) name="sub02.define_customerization" 

#end add-point
#add-point:sub02.define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="sub02.define" 

#end add-point:sub02.define
 
    #add-point:sub02.order.before name="sub02.order.before" 
    
    #end add-point:sub02.order.before
 
 
 
    FORMAT
 
 
 
       ON EVERY ROW
            #add-point:sub02.everyrow.before name="sub02.everyrow.before" 
                          
            #end add-point:sub02.everyrow.before
 
            PRINTX sr2.*
 
            #add-point:sub02.everyrow.after name="sub02.everyrow.after" 
            
            #end add-point:sub02.everyrow.after
 
 
END REPORT
 
 
#報表 d02 樣板自動產生(Version:3)
PRIVATE REPORT astr340_g01_subrep03(sr2)
DEFINE  sr2  sr2_r
#add-point:query段define(客製用) name="sub03.define_customerization" 

#end add-point
#add-point:sub03.define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="sub03.define" 

#end add-point:sub03.define
 
    #add-point:sub03.order.before name="sub03.order.before" 
    
    #end add-point:sub03.order.before
 
 
 
    FORMAT
 
 
 
       ON EVERY ROW
            #add-point:sub03.everyrow.before name="sub03.everyrow.before" 
                          
            #end add-point:sub03.everyrow.before
 
            PRINTX sr2.*
 
            #add-point:sub03.everyrow.after name="sub03.everyrow.after" 
            
            #end add-point:sub03.everyrow.after
 
 
END REPORT
 
 
#報表 d02 樣板自動產生(Version:3)
PRIVATE REPORT astr340_g01_subrep04(sr2)
DEFINE  sr2  sr2_r
#add-point:query段define(客製用) name="sub04.define_customerization" 

#end add-point
#add-point:sub04.define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="sub04.define" 

#end add-point:sub04.define
 
    #add-point:sub04.order.before name="sub04.order.before" 
    
    #end add-point:sub04.order.before
 
 
 
    FORMAT
 
 
 
       ON EVERY ROW
            #add-point:sub04.everyrow.before name="sub04.everyrow.before" 
                          
            #end add-point:sub04.everyrow.before
 
            PRINTX sr2.*
 
            #add-point:sub04.everyrow.after name="sub04.everyrow.after" 
            
            #end add-point:sub04.everyrow.after
 
 
END REPORT
 
 
 
 
{</section>}
 
{<section id="astr340_g01.other_function" readonly="Y" >}

 
{</section>}
 
{<section id="astr340_g01.other_report" readonly="Y" >}

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
PRIVATE REPORT astr340_g01_subrep05(sr3)
DEFINE  sr3    sr3_r  
DEFINE  l_rep05_sum LIKE pmdn_t.pmdn047  
  
  ORDER EXTERNAL BY sr3.stbddocno,sr3.stbesite
 
FORMAT
           BEFORE GROUP OF sr3.stbddocno

   let l_rep05_sum =0
   
        ON EVERY ROW
            PRINTX g_grNumFmt.*
            PRINTX sr3.*
       LET l_rep05_sum = l_rep05_sum + sr3.stbe012     
      AFTER GROUP OF sr3.stbddocno       
        PRINTX l_rep05_sum
END REPORT

 
{</section>}
 
