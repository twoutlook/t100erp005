#該程式未解開Section, 採用最新樣板產出!
{<section id="artm901_01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0003(2015-07-01 17:01:08), PR版次:0003(2016-08-03 17:08:40)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000039
#+ Filename...: artm901_01
#+ Description: 產生每日預算結果
#+ Creator....: 01752(2015-07-01 16:07:12)
#+ Modifier...: 01752 -SD/PR- 08742
 
{</section>}
 
{<section id="artm901_01.global" >}
#應用 c01c 樣板自動產生(Version:10)
#add-point:填寫註解說明 name="global.memo"
#Memos
#160727-00019#16 2016/08/03 By 08742   系统中定义的临时表名称超过15码在执行时会出错,所以需要将系统中定义的临时表长度超过15码的全部改掉	 	
#                                      Mod   artm901_rtcd_temp -->artm901_tmp01
#                                      Mod   artm901_01_temp1 -->artm901_tmp02
#end add-point
#add-point:填寫註解說明(客製用) name="global.memo_customerization"

#end add-point
 
IMPORT os
IMPORT FGL lib_cl_dlg
#add-point:增加匯入項目 name="global.import"

#end add-point
 
SCHEMA ds
 
GLOBALS "../../cfg/top_global.inc"
 
#add-point:增加匯入變數檔 name="global.inc" name="global.inc"

#end add-point
 
DEFINE g_rec_b               LIKE type_t.num10
DEFINE g_wc                  STRING
DEFINE g_ref_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_ref_vars            DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
 
 
#add-point:自定義模組變數(Module Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
TYPE type_parameter RECORD
        l_del            LIKE type_t.chr1
                    END RECORD
DEFINE g_master  type_parameter

TYPE type_g_rtcd    RECORD
         rtcdent       LIKE rtcd_t.rtcdent,
         rtcdsite      LIKE rtcd_t.rtcdsite,
         rtcd001       LIKE rtcd_t.rtcd001,
         rtcd002       LIKE rtcd_t.rtcd002,
         rtcd003       LIKE rtcd_t.rtcd003,
         rtcd004       LIKE rtcd_t.rtcd004,
         rtcd005       LIKE rtcd_t.rtcd005,
         rtcd006       LIKE rtcd_t.rtcd006,
         rtcd007       LIKE rtcd_t.rtcd007,
         rtcd008       LIKE rtcd_t.rtcd008,
         rtcd009       LIKE rtcd_t.rtcd009,
         rtcd010       LIKE rtcd_t.rtcd010,
         rtcd011       LIKE rtcd_t.rtcd011,
         rtcd012       LIKE rtcd_t.rtcd012,
         rtcd013       LIKE rtcd_t.rtcd013,
         rtcd014       LIKE rtcd_t.rtcd014,
         rtcd015       LIKE rtcd_t.rtcd015,
         rtcd016       LIKE rtcd_t.rtcd016,
         rtcd017       LIKE rtcd_t.rtcd017,
         rtcd018       LIKE rtcd_t.rtcd018,
         rtcd019       LIKE rtcd_t.rtcd019,
         rtcd020       LIKE rtcd_t.rtcd020,
         rtcd021       LIKE rtcd_t.rtcd021,
         rtcd022       LIKE rtcd_t.rtcd022,
         rtcd023       LIKE rtcd_t.rtcd023,
         rtcd024       LIKE rtcd_t.rtcd024,
         rtcd025       LIKE rtcd_t.rtcd025,
         rtcd026       LIKE rtcd_t.rtcd026,
         rtcd027       LIKE rtcd_t.rtcd027,
         rtcd028       LIKE rtcd_t.rtcd028,
         rtcd029       LIKE rtcd_t.rtcd029,
         rtcd030       LIKE rtcd_t.rtcd030,
         rtcd031       LIKE rtcd_t.rtcd031,
         rtcd032       LIKE rtcd_t.rtcd032,
         rtcd033       LIKE rtcd_t.rtcd033,  
         rtcd034       LIKE rtcd_t.rtcd034,
         rtcd035       LIKE rtcd_t.rtcd035,
         rtcd036       LIKE rtcd_t.rtcd036,
         rtcd037       LIKE rtcd_t.rtcd037
                 END RECORD
DEFINE g_rtcd            type_g_rtcd
DEFINE g_rtcd3           type_g_rtcd
DEFINE g_rtcd5           type_g_rtcd
DEFINE g_datetime        DATETIME YEAR TO SECOND
DEFINE g_total_budget    LIKE rtcb_t.rtcb005
DEFINE g_days            LIKE type_t.num5
#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明(global.argv) name="global.argv"

#end add-point  
 
{</section>}
 
{<section id="artm901_01.input" >}
#+ 資料輸入
PUBLIC FUNCTION artm901_01(--)
   #add-point:construct段變數傳入 name="construct.get_var"
   
   #end add-point
   )
   #add-point:construct段define name="construct.define_customerization"
   
   #end add-point
   DEFINE l_ac_t          LIKE type_t.num10       #未取消的ARRAY CNT 
   DEFINE l_allow_insert  LIKE type_t.num5        #可新增否 
   DEFINE l_allow_delete  LIKE type_t.num5        #可刪除否  
   DEFINE l_count         LIKE type_t.num10
   DEFINE l_insert        LIKE type_t.num5
   #add-point:construct段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="construct.define"
   DEFINE r_success       LIKE type_t.num5
   #end add-point
 
   #畫面開啟 (identifier)
   OPEN WINDOW w_artm901_01 WITH FORM cl_ap_formpath("art","artm901_01")
 
   #瀏覽頁簽資料初始化
   CALL cl_ui_init()
   
   LET g_qryparam.state = "i"
   
   #輸入前處理
   #add-point:單頭前置處理 name="construct.pre_construct"
   LET r_success = TRUE
   #end add-point
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      #輸入開始
      CONSTRUCT BY NAME g_wc ON rtcbsite,rtcc001 
      
            #add-point:自定義action name="construct.action"
            ON ACTION controlp INFIELD rtcbsite
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.where = s_aooi500_q_where(g_prog,'rtcbsite',g_site,'c')
               CALL q_ooef001_24()
               DISPLAY g_qryparam.return1 TO rtcbsite  #顯示到畫面上
               NEXT FIELD rtcbsite                     #返回原欄位
            ON ACTION controlp INFIELD rtcc001
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_rtcc001()
               DISPLAY g_qryparam.return1 TO rtcc001   #顯示到畫面上
               NEXT FIELD rtcc001                      #返回原欄位
            #end add-point
      
         BEFORE CONSTRUCT
            #add-point:單頭輸入前處理 name="construct.before_construct"
            
            #end add-point
            
         AFTER CONSTRUCT
            #add-point:單頭輸入後處理 name="construct.after_construct"
            
            #end add-point
            
         
 
         
       
      END CONSTRUCT
 
      #add-point:自定義construct name="construct.more_construct"
      INPUT BY NAME g_master.l_del
         BEFORE INPUT         
          
      END INPUT
      
      BEFORE DIALOG
         LET g_master.l_del = 'N'
         DISPLAY BY NAME g_master.l_del    
      #end add-point
      
      ON ACTION accept
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
 
   #add-point:畫面關閉前 name="construct.before_close"
   IF NOT INT_FLAG THEN
      DELETE FROM artm901_tmp01                #160727-00019#16 Mod   artm901_rtcd_temp -->artm901_tmp01
      DELETE FROM artm901_tmp02                #160727-00019#16 Mod   artm901_01_temp1 -->artm901_tmp02
      CALL cl_err_collect_init()
      IF NOT artm901_01_process() THEN
         LET r_success = FALSE      
      END IF      
      CALL cl_err_collect_show()
   END IF
   #end add-point 
   
   #畫面關閉
   CLOSE WINDOW w_artm901_01 
   
   #add-point:construct段after construct name="construct.post_construct"
   RETURN r_success
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="artm901_01.other_dialog" readonly="Y" >}

 
{</section>}
 
{<section id="artm901_01.other_function" readonly="Y" >}

PRIVATE FUNCTION artm901_01_process()
   DEFINE r_success       LIKE type_t.num5
   DEFINE l_where         STRING
   DEFINE l_str           STRING
   DEFINE l_wc            STRING
   DEFINE l_wc1           STRING          
   DEFINE l_sql           STRING   
   DEFINE l_num           LIKE type_t.num5
   DEFINE l_num2          LIKE type_t.num5
   DEFINE l_length        LIKE type_t.num5  
   DEFINE l_rtcc001       LIKE rtcc_t.rtcc001
   DEFINE l_chr           LIKE type_t.chr20
   DEFINE l_year          LIKE type_t.num5
   DEFINE l_month         LIKE type_t.num5
   DEFINE l_rtcbsite      LIKE rtcb_t.rtcbsite
   DEFINE l_rtcb001       LIKE rtcb_t.rtcb001
   DEFINE l_rtcb002       LIKE rtcb_t.rtcb002
   DEFINE l_rtcb003       LIKE rtcb_t.rtcb003
   DEFINE l_rtcb    RECORD
            rtcb004       LIKE rtcb_t.rtcb004,
            rtca003       LIKE rtca_t.rtca003,
            rtcb005       LIKE rtcb_t.rtcb005,
            rtcb006       LIKE rtcb_t.rtcb006,
            rtcb007       LIKE rtcb_t.rtcb007,
            rtcb008       LIKE rtcb_t.rtcb008,
            rtcb009       LIKE rtcb_t.rtcb009,
            rtcb010       LIKE rtcb_t.rtcb010,
            rtcb011       LIKE rtcb_t.rtcb011,
            rtcb012       LIKE rtcb_t.rtcb012,
            rtcb013       LIKE rtcb_t.rtcb013,
            rtcb014       LIKE rtcb_t.rtcb014,
            rtcb015       LIKE rtcb_t.rtcb015,
            rtcb016       LIKE rtcb_t.rtcb016            
                    END RECORD          
   LET r_success = TRUE
   
   LET l_where = s_aooi500_sql_where(g_prog,'rtcbsite')
   LET l_wc = ''
   LET l_wc1 = ''
   
   #解析stfasite的construct出來到l_wc
   LET l_str = g_wc
   LET l_num = l_str.getIndexOf("rtcc001",1)
   IF l_num > 0 THEN
      LET l_num2 = l_str.getIndexOf("and",l_num)
      IF l_num2 > 0 THEN
         LET l_wc = l_str.subString(l_num,l_num2-2)
      ELSE
         LET l_wc = l_str.subString(l_num,l_str.getLength())
      END IF
      IF l_wc = "rtcc001 like '%'" THEN
         LET l_wc = " 1=1"
      END IF

      IF l_num = 1 THEN
         IF l_num2 = 0 THEN
            LET l_wc1 = ''
         ELSE
            LET l_wc1 = l_str.subString(l_num2+4,l_str.getLength())
         END IF
      ELSE
         IF l_num2 = 0 THEN
            LET l_wc1 = l_str.subString(1,l_num-5)
         ELSE
            LET l_wc1 = l_str.subString(1,l_num-5)
            LET l_wc1 = l_wc1 CLIPPED," ",l_str.subString(l_num2,l_str.getLength())
         END IF
      END IF
      IF cl_null(l_wc1) THEN LET l_wc1 = " 1=1" END IF
   ELSE
      LET l_wc = " 1=1"
      LET l_wc1 = g_wc
   END IF
   
   
   
   LET l_sql = " SELECT UNIQUE rtcc001 FROM rtcc_t",
                " WHERE rtccent = ",g_enterprise,
                "   AND ",l_wc
                
   PREPARE artm901_01_rtcc001_prep FROM l_sql
   DECLARE artm901_01_rtcc001_cs CURSOR FOR artm901_01_rtcc001_prep

   LET g_datetime = cl_get_current()
   
   #計算的年度,期別
   FOREACH artm901_01_rtcc001_cs INTO l_rtcc001
      LET l_chr = l_rtcc001
      LET l_str = l_chr
      LET l_length = l_str.getLength()
           
      LET l_year  = l_chr[1,l_length-2]
      LET l_month = l_chr[l_length-1,l_length]
      
      INSERT INTO artm901_tmp02(rtcc001,year1,month1)            #160727-00019#16 Mod   artm901_01_temp1 -->artm901_tmp02
             VALUES(l_rtcc001,l_year,l_month)
      IF SQLCA.sqlcode != 0 THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'insert artm901_tmp02'            #160727-00019#16 Mod   artm901_01_temp1 -->artm901_tmp02
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success
      END IF
   END FOREACH
          
   LET l_sql = " SELECT UNIQUE rtcbsite,rtcb001,rtcb002,rtcb003",
               "   FROM rtcb_t",
               "  WHERE rtcbent = ",g_enterprise,
               "    AND EXISTS (SELECT 1 FROM artm901_tmp02 ",           #160727-00019#16 Mod   artm901_01_temp1 -->artm901_tmp02
               "                 WHERE rtcb001 = year1 )",
               "    AND ",l_wc1,
               "    AND ",l_where,
               "    AND rtcbstus = 'Y'",
               " ORDER BY rtcbsite,rtcb001"
   
   PREPARE artm901_01_rtcb_prep1 FROM l_sql
   DECLARE artm901_01_rtcb_cs1 CURSOR WITH HOLD FOR artm901_01_rtcb_prep1
                 
   LET l_sql = " SELECT rtcb004,rtca003,rtcb005,rtcb006,rtcb007,rtcb008,rtcb009, ",
               "        rtcb010,rtcb011,rtcb012,rtcb013,rtcb014,rtcb015,rtcb016  ",
               "   FROM rtcb_t,rtca_t ",
               "  WHERE rtcbent = rtcaent ",
               "    AND rtcb004 = rtca001 ",
               "    AND rtcbent = ",g_enterprise,  #160324-00011#1 Add By Ken 160331
               "    AND rtcbstus = 'Y' ",  
               "    AND rtcbsite = ? ",
               "    AND rtcb001 = ? ",
               "    AND rtcb002 = ? ",
               "    AND rtcb003 = ? "               
   PREPARE artm901_01_rtcb_prep2 FROM l_sql
   DECLARE artm901_01_rtcb_cs2 CURSOR WITH HOLD FOR artm901_01_rtcb_prep2
                 
   LET l_sql = " SELECT rtcc001,year1,month1 ",
               "   FROM artm901_tmp02",                #160727-00019#16 Mod   artm901_01_temp1 -->artm901_tmp02
               "  WHERE year1 = ? "
               
   PREPARE artm901_01_temp1_prep1 FROM l_sql
   DECLARE artm901_01_temp1_cs1 CURSOR WITH HOLD FOR artm901_01_temp1_prep1
 
   #找出arti902有設定的組織資料 和 artm901的資料搭配產生rtcd_t
   FOREACH artm901_01_rtcb_cs1 INTO l_rtcbsite,l_rtcb001,l_rtcb002,l_rtcb003
      INITIALIZE g_rtcd.* TO NULL
      INITIALIZE g_rtcd3.* TO NULL
      INITIALIZE g_rtcd5.* TO NULL
      
      LET g_rtcd.rtcdent  = g_enterprise
      LET g_rtcd.rtcdsite = l_rtcbsite
      LET g_rtcd.rtcd002  = l_rtcb002
      LET g_rtcd.rtcd003  = l_rtcb003     
      
      FOREACH artm901_01_temp1_cs1 USING l_rtcb001 INTO l_rtcc001,l_year,l_month
         LET g_rtcd.rtcd001 = l_rtcc001
         IF NOT artm901_01_ins_rtcd_temp_rowtype_1to3() THEN
            LET r_success = FALSE
            RETURN r_success
         END IF
         
         LET g_rtcd5.rtcd007 = 0
         LET g_rtcd5.rtcd008 = 0
         LET g_rtcd5.rtcd009 = 0
         LET g_rtcd5.rtcd010 = 0
         LET g_rtcd5.rtcd011 = 0
         LET g_rtcd5.rtcd012 = 0
         LET g_rtcd5.rtcd013 = 0
         LET g_rtcd5.rtcd014 = 0
         LET g_rtcd5.rtcd015 = 0
         LET g_rtcd5.rtcd016 = 0
         LET g_rtcd5.rtcd017 = 0
         LET g_rtcd5.rtcd018 = 0
         LET g_rtcd5.rtcd019 = 0
         LET g_rtcd5.rtcd020 = 0
         LET g_rtcd5.rtcd021 = 0
         LET g_rtcd5.rtcd022 = 0
         LET g_rtcd5.rtcd023 = 0
         LET g_rtcd5.rtcd024 = 0
         LET g_rtcd5.rtcd025 = 0
         LET g_rtcd5.rtcd026 = 0
         LET g_rtcd5.rtcd027 = 0
         LET g_rtcd5.rtcd028 = 0
         LET g_rtcd5.rtcd029 = 0
         LET g_rtcd5.rtcd030 = 0
         LET g_rtcd5.rtcd031 = 0
         LET g_rtcd5.rtcd032 = 0
         LET g_rtcd5.rtcd033 = 0
         LET g_rtcd5.rtcd034 = 0
         LET g_rtcd5.rtcd035 = 0
         LET g_rtcd5.rtcd036 = 0
         LET g_rtcd5.rtcd037 = 0
          
         FOREACH artm901_01_rtcb_cs2 USING l_rtcbsite,l_rtcb001,l_rtcb002,l_rtcb003 INTO l_rtcb.*
            LET g_rtcd.rtcd005 = l_rtcb.rtcb004
            LET g_rtcd.rtcd006 = l_rtcb.rtca003            
            CASE l_month
               WHEN 1  LET g_total_budget = l_rtcb.rtcb005
               WHEN 2  LET g_total_budget = l_rtcb.rtcb006
               WHEN 3  LET g_total_budget = l_rtcb.rtcb007
               WHEN 4  LET g_total_budget = l_rtcb.rtcb008
               WHEN 5  LET g_total_budget = l_rtcb.rtcb009
               WHEN 6  LET g_total_budget = l_rtcb.rtcb010
               WHEN 7  LET g_total_budget = l_rtcb.rtcb011
               WHEN 8  LET g_total_budget = l_rtcb.rtcb012
               WHEN 9  LET g_total_budget = l_rtcb.rtcb013
               WHEN 10 LET g_total_budget = l_rtcb.rtcb014
               WHEN 11 LET g_total_budget = l_rtcb.rtcb015
               WHEN 12 LET g_total_budget = l_rtcb.rtcb016             
            END CASE            
            LET g_days = s_date_get_max_day(l_year,l_month)            
            IF NOT artm901_01_ins_rtcd_temp_rowtype_4() THEN
               LET r_success = FALSE
               RETURN r_success
            END IF
         END FOREACH 
         
         IF NOT artm901_01_ins_rtcd_temp_rowtype_5() THEN
            LET r_success = FALSE
            RETURN r_success
         END IF
         
         IF NOT artm901_01_ins_rtcd_temp_rowtype_6() THEN
            LET r_success = FALSE
            RETURN r_success
         END IF
         
      END FOREACH     
   
   END FOREACH
   
   IF NOT artm901_01_ins_rtcd() THEN
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   
   RETURN r_success
END FUNCTION

PUBLIC FUNCTION artm901_01_create_temp()
   DEFINE r_success         LIKE type_t.num5

   WHENEVER ERROR CONTINUE

   LET r_success = TRUE

   IF NOT artm901_01_drop_temp() THEN
      LET r_success = FALSE
      RETURN r_success
   END IF

   CREATE TEMP TABLE artm901_tmp01(           #160727-00019#16 Mod   artm901_rtcd_temp -->artm901_tmp01
      rtcdent         SMALLINT,
      rtcdsite        VARCHAR(10),
      rtcd001         INTEGER,
      rtcd002         VARCHAR(10),
      rtcd003         VARCHAR(10),
      rtcd004         VARCHAR(10),
      rtcd005         VARCHAR(10),
      rtcd006         VARCHAR(10),
      rtcd007         VARCHAR(500),
      rtcd008         VARCHAR(500),
      rtcd009         VARCHAR(500),
      rtcd010         VARCHAR(500),
      rtcd011         VARCHAR(500),
      rtcd012         VARCHAR(500),
      rtcd013         VARCHAR(500),
      rtcd014         VARCHAR(500),
      rtcd015         VARCHAR(500),
      rtcd016         VARCHAR(500),
      rtcd017         VARCHAR(500),
      rtcd018         VARCHAR(500),
      rtcd019         VARCHAR(500),
      rtcd020         VARCHAR(500),
      rtcd021         VARCHAR(500),
      rtcd022         VARCHAR(500),
      rtcd023         VARCHAR(500),
      rtcd024         VARCHAR(500),
      rtcd025         VARCHAR(500),
      rtcd026         VARCHAR(500),
      rtcd027         VARCHAR(500),
      rtcd028         VARCHAR(500),
      rtcd029         VARCHAR(500),
      rtcd030         VARCHAR(500),
      rtcd031         VARCHAR(500),
      rtcd032         VARCHAR(500),
      rtcd033         VARCHAR(500),  
      rtcd034         VARCHAR(500),
      rtcd035         VARCHAR(500),
      rtcd036         VARCHAR(500),
      rtcd037         VARCHAR(500),
      rtcdownid       VARCHAR(20),
      rtcdowndp       VARCHAR(10),
      rtcdcrtid       VARCHAR(20),
      rtcdcrtdp       VARCHAR(10),
      rtcdcrtdt       DATETIME YEAR TO SECOND,
      rtcdmodid       VARCHAR(20),
      rtcdmoddt       DATETIME YEAR TO SECOND,
      rtcdstus        VARCHAR(10)
      )       

   IF SQLCA.sqlcode != 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'create artm901_tmp01'          #160727-00019#16 Mod   artm901_rtcd_temp -->artm901_tmp01
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   CREATE TEMP TABLE artm901_tmp02(                #160727-00019#16 Mod   artm901_01_temp1 -->artm901_tmp02
     rtcc001            INTEGER,
     year1              SMALLINT,
     month1             SMALLINT
     )       

   IF SQLCA.sqlcode != 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'create artm901_tmp02'           #160727-00019#16 Mod   artm901_01_temp1 -->artm901_tmp02
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   RETURN r_success
END FUNCTION

PUBLIC FUNCTION artm901_01_drop_temp()
   DEFINE r_success          LIKE type_t.num5

   WHENEVER ERROR CONTINUE

   LET r_success = TRUE

   DROP TABLE artm901_tmp01            #160727-00019#16 Mod   artm901_rtcd_temp -->artm901_tmp01

   IF NOT (SQLCA.sqlcode = 0 OR SQLCA.sqlcode = -206) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'drop artm901_tmp01'        #160727-00019#16 Mod   artm901_rtcd_temp -->artm901_tmp01
      LET g_errparam.popup = TRUE
      CALL cl_err()

      LET r_success = FALSE
      RETURN r_success
   END IF
   
   DROP TABLE artm901_tmp02          #160727-00019#16 Mod   artm901_01_temp1 -->artm901_tmp02

   IF NOT (SQLCA.sqlcode = 0 OR SQLCA.sqlcode = -206) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'drop artm901_tmp02'           #160727-00019#16 Mod   artm901_01_temp1 -->artm901_tmp02
      LET g_errparam.popup = TRUE
      CALL cl_err()

      LET r_success = FALSE
      RETURN r_success
   END IF
  
   RETURN r_success
END FUNCTION

PRIVATE FUNCTION artm901_01_ins_rtcd_temp_rowtype_1to3()
   DEFINE r_success     LIKE type_t.num5
   DEFINE l_sql         STRING
   
   LET r_success = TRUE
   LET g_rtcd.rtcd005 = ' '
   LET g_rtcd.rtcd006 = ' '
   
   LET l_sql = " SELECT rtcc003,rtcc004,rtcc005,rtcc006,rtcc007,",
               "        rtcc008,rtcc009,rtcc010,rtcc011,rtcc012,",
               "        rtcc013,rtcc014,rtcc015,rtcc016,rtcc017,",
               "        rtcc018,rtcc019,rtcc020,rtcc021,rtcc022,",
               "        rtcc023,rtcc024,rtcc025,rtcc026,rtcc027,",
               "        rtcc028,rtcc029,rtcc030,rtcc031,rtcc032,",  
               "        rtcc033 ",               
               "   FROM rtcc_t",
               "  WHERE rtccent = ",g_enterprise,
               "    AND rtcc001 = ? ",
               "    AND rtcc002 = ? "
   PREPARE artm901_search_rtcc_prep FROM l_sql
   
   #行狀態1.星期
   LET g_rtcd.rtcd004 = '1' 

   EXECUTE artm901_search_rtcc_prep USING g_rtcd.rtcd001,g_rtcd.rtcd004
      INTO g_rtcd.rtcd007,g_rtcd.rtcd008,g_rtcd.rtcd009,g_rtcd.rtcd010,g_rtcd.rtcd011,
           g_rtcd.rtcd012,g_rtcd.rtcd013,g_rtcd.rtcd014,g_rtcd.rtcd015,g_rtcd.rtcd016,
           g_rtcd.rtcd017,g_rtcd.rtcd018,g_rtcd.rtcd019,g_rtcd.rtcd020,g_rtcd.rtcd021,
           g_rtcd.rtcd022,g_rtcd.rtcd023,g_rtcd.rtcd024,g_rtcd.rtcd025,g_rtcd.rtcd026,
           g_rtcd.rtcd027,g_rtcd.rtcd028,g_rtcd.rtcd029,g_rtcd.rtcd030,g_rtcd.rtcd031,
           g_rtcd.rtcd032,g_rtcd.rtcd033,g_rtcd.rtcd034,g_rtcd.rtcd035,g_rtcd.rtcd036,
           g_rtcd.rtcd037   
   
   IF NOT artm901_01_ins_rtcd_temp() THEN
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   #行狀態2.節日類型
   LET g_rtcd.rtcd004 = '2'
   
   EXECUTE artm901_search_rtcc_prep USING g_rtcd.rtcd001,g_rtcd.rtcd004
      INTO g_rtcd.rtcd007,g_rtcd.rtcd008,g_rtcd.rtcd009,g_rtcd.rtcd010,g_rtcd.rtcd011,
           g_rtcd.rtcd012,g_rtcd.rtcd013,g_rtcd.rtcd014,g_rtcd.rtcd015,g_rtcd.rtcd016,
           g_rtcd.rtcd017,g_rtcd.rtcd018,g_rtcd.rtcd019,g_rtcd.rtcd020,g_rtcd.rtcd021,
           g_rtcd.rtcd022,g_rtcd.rtcd023,g_rtcd.rtcd024,g_rtcd.rtcd025,g_rtcd.rtcd026,
           g_rtcd.rtcd027,g_rtcd.rtcd028,g_rtcd.rtcd029,g_rtcd.rtcd030,g_rtcd.rtcd031,
           g_rtcd.rtcd032,g_rtcd.rtcd033,g_rtcd.rtcd034,g_rtcd.rtcd035,g_rtcd.rtcd036,
           g_rtcd.rtcd037   
   
   IF NOT artm901_01_ins_rtcd_temp() THEN
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   #行狀態3.預算係數
   LET g_rtcd.rtcd004 = '3'
   
   EXECUTE artm901_search_rtcc_prep USING g_rtcd.rtcd001,g_rtcd.rtcd004
      INTO g_rtcd.rtcd007,g_rtcd.rtcd008,g_rtcd.rtcd009,g_rtcd.rtcd010,g_rtcd.rtcd011,
           g_rtcd.rtcd012,g_rtcd.rtcd013,g_rtcd.rtcd014,g_rtcd.rtcd015,g_rtcd.rtcd016,
           g_rtcd.rtcd017,g_rtcd.rtcd018,g_rtcd.rtcd019,g_rtcd.rtcd020,g_rtcd.rtcd021,
           g_rtcd.rtcd022,g_rtcd.rtcd023,g_rtcd.rtcd024,g_rtcd.rtcd025,g_rtcd.rtcd026,
           g_rtcd.rtcd027,g_rtcd.rtcd028,g_rtcd.rtcd029,g_rtcd.rtcd030,g_rtcd.rtcd031,
           g_rtcd.rtcd032,g_rtcd.rtcd033,g_rtcd.rtcd034,g_rtcd.rtcd035,g_rtcd.rtcd036,
           g_rtcd.rtcd037   
   
   IF NOT artm901_01_ins_rtcd_temp() THEN
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   LET g_rtcd3.* = g_rtcd.*
   
   RETURN r_success
END FUNCTION

PRIVATE FUNCTION artm901_01_ins_rtcd_temp()
   DEFINE r_success     LIKE type_t.num5
   
   LET r_success = TRUE
   
   INSERT INTO artm901_tmp01( rtcdent,   rtcdsite,  rtcd001,   rtcd002,   rtcd003,                 #160727-00019#16 Mod   artm901_rtcd_temp -->artm901_tmp01
                              rtcd004,   rtcd005,   rtcd006,   rtcd007,   rtcd008,
                              rtcd009,   rtcd010,   rtcd011,   rtcd012,   rtcd013,
                              rtcd014,   rtcd015,   rtcd016,   rtcd017,   rtcd018,
                              rtcd019,   rtcd020,   rtcd021,   rtcd022,   rtcd023,
                              rtcd024,   rtcd025,   rtcd026,   rtcd027,   rtcd028,
                              rtcd029,   rtcd030,   rtcd031,   rtcd032,   rtcd033,  
                              rtcd034,   rtcd035,   rtcd036,   rtcd037,   
                              rtcdownid, rtcdowndp, rtcdcrtid, rtcdcrtdp, rtcdcrtdt,
                              rtcdmodid, rtcdmoddt, rtcdstus )
          VALUES(  g_rtcd.rtcdent,   g_rtcd.rtcdsite,  g_rtcd.rtcd001,   g_rtcd.rtcd002,   g_rtcd.rtcd003,
                   g_rtcd.rtcd004,   g_rtcd.rtcd005,   g_rtcd.rtcd006,   g_rtcd.rtcd007,   g_rtcd.rtcd008,
                   g_rtcd.rtcd009,   g_rtcd.rtcd010,   g_rtcd.rtcd011,   g_rtcd.rtcd012,   g_rtcd.rtcd013,
                   g_rtcd.rtcd014,   g_rtcd.rtcd015,   g_rtcd.rtcd016,   g_rtcd.rtcd017,   g_rtcd.rtcd018,
                   g_rtcd.rtcd019,   g_rtcd.rtcd020,   g_rtcd.rtcd021,   g_rtcd.rtcd022,   g_rtcd.rtcd023,
                   g_rtcd.rtcd024,   g_rtcd.rtcd025,   g_rtcd.rtcd026,   g_rtcd.rtcd027,   g_rtcd.rtcd028,
                   g_rtcd.rtcd029,   g_rtcd.rtcd030,   g_rtcd.rtcd031,   g_rtcd.rtcd032,   g_rtcd.rtcd033,  
                   g_rtcd.rtcd034,   g_rtcd.rtcd035,   g_rtcd.rtcd036,   g_rtcd.rtcd037,   
                   g_user, g_dept, g_user, g_dept, g_datetime, '', '', 'Y' )
                   
   IF SQLCA.sqlcode != 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'ins artm901_tmp01'                 #160727-00019#16 Mod   artm901_rtcd_temp -->artm901_tmp01
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF            
   
   RETURN r_success
END FUNCTION

PRIVATE FUNCTION artm901_01_ins_rtcd_temp_rowtype_4()
   DEFINE r_success   LIKE type_t.num5
   DEFINE l_i         LIKE type_t.num5
   DEFINE l_budget    LIKE rtcb_t.rtcb005
   
   LET r_success = TRUE
   
   LET l_budget = g_total_budget / g_days   
   LET l_budget = s_num_round('3',l_budget,0)  #取位
   
   LET g_rtcd.rtcd004 = '4'   
   FOR l_i = 1 TO g_days
      IF l_i != g_days THEN
         CASE l_i 
            WHEN 1  LET g_rtcd.rtcd007 = l_budget * g_rtcd3.rtcd007 USING "##,###,##&"                    
            WHEN 2  LET g_rtcd.rtcd008 = l_budget * g_rtcd3.rtcd008 USING "##,###,##&"
            WHEN 3  LET g_rtcd.rtcd009 = l_budget * g_rtcd3.rtcd009 USING "##,###,##&"
            WHEN 4  LET g_rtcd.rtcd010 = l_budget * g_rtcd3.rtcd010 USING "##,###,##&" 
            WHEN 5  LET g_rtcd.rtcd011 = l_budget * g_rtcd3.rtcd011 USING "##,###,##&"
            WHEN 6  LET g_rtcd.rtcd012 = l_budget * g_rtcd3.rtcd012 USING "##,###,##&"
            WHEN 7  LET g_rtcd.rtcd013 = l_budget * g_rtcd3.rtcd013 USING "##,###,##&"
            WHEN 8  LET g_rtcd.rtcd014 = l_budget * g_rtcd3.rtcd014 USING "##,###,##&"
            WHEN 9  LET g_rtcd.rtcd015 = l_budget * g_rtcd3.rtcd015 USING "##,###,##&"
            WHEN 10 LET g_rtcd.rtcd016 = l_budget * g_rtcd3.rtcd016 USING "##,###,##&"
            WHEN 11 LET g_rtcd.rtcd017 = l_budget * g_rtcd3.rtcd017 USING "##,###,##&"
            WHEN 12 LET g_rtcd.rtcd018 = l_budget * g_rtcd3.rtcd018 USING "##,###,##&"
            WHEN 13 LET g_rtcd.rtcd019 = l_budget * g_rtcd3.rtcd019 USING "##,###,##&"
            WHEN 14 LET g_rtcd.rtcd020 = l_budget * g_rtcd3.rtcd020 USING "##,###,##&" 
            WHEN 15 LET g_rtcd.rtcd021 = l_budget * g_rtcd3.rtcd021 USING "##,###,##&"
            WHEN 16 LET g_rtcd.rtcd022 = l_budget * g_rtcd3.rtcd022 USING "##,###,##&"
            WHEN 17 LET g_rtcd.rtcd023 = l_budget * g_rtcd3.rtcd023 USING "##,###,##&"
            WHEN 18 LET g_rtcd.rtcd024 = l_budget * g_rtcd3.rtcd024 USING "##,###,##&"
            WHEN 19 LET g_rtcd.rtcd025 = l_budget * g_rtcd3.rtcd025 USING "##,###,##&"
            WHEN 20 LET g_rtcd.rtcd026 = l_budget * g_rtcd3.rtcd026 USING "##,###,##&"
            WHEN 21 LET g_rtcd.rtcd027 = l_budget * g_rtcd3.rtcd027 USING "##,###,##&"
            WHEN 22 LET g_rtcd.rtcd028 = l_budget * g_rtcd3.rtcd028 USING "##,###,##&"
            WHEN 23 LET g_rtcd.rtcd029 = l_budget * g_rtcd3.rtcd029 USING "##,###,##&"
            WHEN 24 LET g_rtcd.rtcd030 = l_budget * g_rtcd3.rtcd030 USING "##,###,##&" 
            WHEN 25 LET g_rtcd.rtcd031 = l_budget * g_rtcd3.rtcd031 USING "##,###,##&"
            WHEN 26 LET g_rtcd.rtcd032 = l_budget * g_rtcd3.rtcd032 USING "##,###,##&"
            WHEN 27 LET g_rtcd.rtcd033 = l_budget * g_rtcd3.rtcd033 USING "##,###,##&"
            WHEN 28 LET g_rtcd.rtcd034 = l_budget * g_rtcd3.rtcd034 USING "##,###,##&"
            WHEN 29 LET g_rtcd.rtcd035 = l_budget * g_rtcd3.rtcd035 USING "##,###,##&"
            WHEN 30 LET g_rtcd.rtcd036 = l_budget * g_rtcd3.rtcd036 USING "##,###,##&"
         END CASE
      ELSE
         CASE l_i
            WHEN 28 LET g_rtcd.rtcd034 = (g_total_budget - (l_budget * 27)) * g_rtcd3.rtcd034 USING "##,###,##&"
            WHEN 29 LET g_rtcd.rtcd035 = (g_total_budget - (l_budget * 28)) * g_rtcd3.rtcd035 USING "##,###,##&"
            WHEN 30 LET g_rtcd.rtcd036 = (g_total_budget - (l_budget * 29)) * g_rtcd3.rtcd036 USING "##,###,##&"
            WHEN 31 LET g_rtcd.rtcd037 = (g_total_budget - (l_budget * 30)) * g_rtcd3.rtcd037 USING "##,###,##&"
         END CASE
      END IF
   END FOR
   
   IF NOT artm901_01_ins_rtcd_temp() THEN
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   #寫入累計資料後續可使用
   LET g_rtcd5.rtcd007 = g_rtcd5.rtcd007 + g_rtcd.rtcd007 
   LET g_rtcd5.rtcd008 = g_rtcd5.rtcd008 + g_rtcd.rtcd008
   LET g_rtcd5.rtcd009 = g_rtcd5.rtcd009 + g_rtcd.rtcd009
   LET g_rtcd5.rtcd010 = g_rtcd5.rtcd010 + g_rtcd.rtcd010
   LET g_rtcd5.rtcd011 = g_rtcd5.rtcd011 + g_rtcd.rtcd011
   LET g_rtcd5.rtcd012 = g_rtcd5.rtcd012 + g_rtcd.rtcd012
   LET g_rtcd5.rtcd013 = g_rtcd5.rtcd013 + g_rtcd.rtcd013
   LET g_rtcd5.rtcd014 = g_rtcd5.rtcd014 + g_rtcd.rtcd014
   LET g_rtcd5.rtcd015 = g_rtcd5.rtcd015 + g_rtcd.rtcd015
   LET g_rtcd5.rtcd016 = g_rtcd5.rtcd016 + g_rtcd.rtcd016
   LET g_rtcd5.rtcd017 = g_rtcd5.rtcd017 + g_rtcd.rtcd017
   LET g_rtcd5.rtcd018 = g_rtcd5.rtcd018 + g_rtcd.rtcd018
   LET g_rtcd5.rtcd019 = g_rtcd5.rtcd019 + g_rtcd.rtcd019
   LET g_rtcd5.rtcd020 = g_rtcd5.rtcd020 + g_rtcd.rtcd020
   LET g_rtcd5.rtcd021 = g_rtcd5.rtcd021 + g_rtcd.rtcd021
   LET g_rtcd5.rtcd022 = g_rtcd5.rtcd022 + g_rtcd.rtcd022
   LET g_rtcd5.rtcd023 = g_rtcd5.rtcd023 + g_rtcd.rtcd023
   LET g_rtcd5.rtcd024 = g_rtcd5.rtcd024 + g_rtcd.rtcd024
   LET g_rtcd5.rtcd025 = g_rtcd5.rtcd025 + g_rtcd.rtcd025
   LET g_rtcd5.rtcd026 = g_rtcd5.rtcd026 + g_rtcd.rtcd026
   LET g_rtcd5.rtcd027 = g_rtcd5.rtcd027 + g_rtcd.rtcd027
   LET g_rtcd5.rtcd028 = g_rtcd5.rtcd028 + g_rtcd.rtcd028
   LET g_rtcd5.rtcd029 = g_rtcd5.rtcd029 + g_rtcd.rtcd029
   LET g_rtcd5.rtcd030 = g_rtcd5.rtcd030 + g_rtcd.rtcd030
   LET g_rtcd5.rtcd031 = g_rtcd5.rtcd031 + g_rtcd.rtcd031
   LET g_rtcd5.rtcd032 = g_rtcd5.rtcd032 + g_rtcd.rtcd032
   LET g_rtcd5.rtcd033 = g_rtcd5.rtcd033 + g_rtcd.rtcd033
   LET g_rtcd5.rtcd034 = g_rtcd5.rtcd034 + g_rtcd.rtcd034
   LET g_rtcd5.rtcd035 = g_rtcd5.rtcd035 + g_rtcd.rtcd035
   LET g_rtcd5.rtcd036 = g_rtcd5.rtcd036 + g_rtcd.rtcd036          
   LET g_rtcd5.rtcd037 = g_rtcd5.rtcd037 + g_rtcd.rtcd037    

   RETURN r_success

END FUNCTION

PRIVATE FUNCTION artm901_01_ins_rtcd_temp_rowtype_5()
   DEFINE r_success      LIKE type_t.num5
   
   LET r_success = TRUE
   
   LET g_rtcd.rtcd004 = '5'
   LET g_rtcd.rtcd005 = ' '
   LET g_rtcd.rtcd006 = ' '
   LET g_rtcd.rtcd007 = g_rtcd5.rtcd007 
   LET g_rtcd.rtcd008 = g_rtcd5.rtcd008 + g_rtcd.rtcd007
   LET g_rtcd.rtcd009 = g_rtcd5.rtcd009 + g_rtcd.rtcd008
   LET g_rtcd.rtcd010 = g_rtcd5.rtcd010 + g_rtcd.rtcd009
   LET g_rtcd.rtcd011 = g_rtcd5.rtcd011 + g_rtcd.rtcd010
   LET g_rtcd.rtcd012 = g_rtcd5.rtcd012 + g_rtcd.rtcd011
   LET g_rtcd.rtcd013 = g_rtcd5.rtcd013 + g_rtcd.rtcd012
   LET g_rtcd.rtcd014 = g_rtcd5.rtcd014 + g_rtcd.rtcd013
   LET g_rtcd.rtcd015 = g_rtcd5.rtcd015 + g_rtcd.rtcd014
   LET g_rtcd.rtcd016 = g_rtcd5.rtcd016 + g_rtcd.rtcd015
   LET g_rtcd.rtcd017 = g_rtcd5.rtcd017 + g_rtcd.rtcd016
   LET g_rtcd.rtcd018 = g_rtcd5.rtcd018 + g_rtcd.rtcd017
   LET g_rtcd.rtcd019 = g_rtcd5.rtcd019 + g_rtcd.rtcd018
   LET g_rtcd.rtcd020 = g_rtcd5.rtcd020 + g_rtcd.rtcd019
   LET g_rtcd.rtcd021 = g_rtcd5.rtcd021 + g_rtcd.rtcd020
   LET g_rtcd.rtcd022 = g_rtcd5.rtcd022 + g_rtcd.rtcd021
   LET g_rtcd.rtcd023 = g_rtcd5.rtcd023 + g_rtcd.rtcd022
   LET g_rtcd.rtcd024 = g_rtcd5.rtcd024 + g_rtcd.rtcd023
   LET g_rtcd.rtcd025 = g_rtcd5.rtcd025 + g_rtcd.rtcd024
   LET g_rtcd.rtcd026 = g_rtcd5.rtcd026 + g_rtcd.rtcd025
   LET g_rtcd.rtcd027 = g_rtcd5.rtcd027 + g_rtcd.rtcd026
   LET g_rtcd.rtcd028 = g_rtcd5.rtcd028 + g_rtcd.rtcd027
   LET g_rtcd.rtcd029 = g_rtcd5.rtcd029 + g_rtcd.rtcd028
   LET g_rtcd.rtcd030 = g_rtcd5.rtcd030 + g_rtcd.rtcd029
   LET g_rtcd.rtcd031 = g_rtcd5.rtcd031 + g_rtcd.rtcd030
   LET g_rtcd.rtcd032 = g_rtcd5.rtcd032 + g_rtcd.rtcd031
   LET g_rtcd.rtcd033 = g_rtcd5.rtcd033 + g_rtcd.rtcd032
   LET g_rtcd.rtcd034 = g_rtcd5.rtcd034 + g_rtcd.rtcd033
   LET g_rtcd.rtcd035 = g_rtcd5.rtcd035 + g_rtcd.rtcd034
   LET g_rtcd.rtcd036 = g_rtcd5.rtcd036 + g_rtcd.rtcd035          
   LET g_rtcd.rtcd037 = g_rtcd5.rtcd037 + g_rtcd.rtcd036 
   
   IF NOT artm901_01_ins_rtcd_temp() THEN
      LET r_success = FALSE
      RETURN r_success
   END IF

   LET g_rtcd5.* = g_rtcd.*
  
   RETURN r_success   
   
END FUNCTION

PRIVATE FUNCTION artm901_01_ins_rtcd_temp_rowtype_6()
   DEFINE r_success      LIKE type_t.num5
   DEFINE l_total        LIKE rtcb_t.rtcb005
   
   LET r_success = TRUE
   CASE g_days 
      WHEN '28' LET l_total = g_rtcd.rtcd034
      WHEN '29' LET l_total = g_rtcd.rtcd035
      WHEN '30' LET l_total = g_rtcd.rtcd036
      WHEN '31' LET l_total = g_rtcd.rtcd037
   END CASE
   
   LET g_rtcd.rtcd004 = '6'
   LET g_rtcd.rtcd005 = ' '
   LET g_rtcd.rtcd006 = ' '
   LET g_rtcd.rtcd007 = g_rtcd5.rtcd007 / l_total * 100 USING "##&.&&%"
   LET g_rtcd.rtcd008 = g_rtcd5.rtcd008 / l_total * 100 USING "##&.&&%"
   LET g_rtcd.rtcd009 = g_rtcd5.rtcd009 / l_total * 100 USING "##&.&&%"
   LET g_rtcd.rtcd010 = g_rtcd5.rtcd010 / l_total * 100 USING "##&.&&%"
   LET g_rtcd.rtcd011 = g_rtcd5.rtcd011 / l_total * 100 USING "##&.&&%"
   LET g_rtcd.rtcd012 = g_rtcd5.rtcd012 / l_total * 100 USING "##&.&&%"
   LET g_rtcd.rtcd013 = g_rtcd5.rtcd013 / l_total * 100 USING "##&.&&%"
   LET g_rtcd.rtcd014 = g_rtcd5.rtcd014 / l_total * 100 USING "##&.&&%"
   LET g_rtcd.rtcd015 = g_rtcd5.rtcd015 / l_total * 100 USING "##&.&&%"
   LET g_rtcd.rtcd016 = g_rtcd5.rtcd016 / l_total * 100 USING "##&.&&%"
   LET g_rtcd.rtcd017 = g_rtcd5.rtcd017 / l_total * 100 USING "##&.&&%"
   LET g_rtcd.rtcd018 = g_rtcd5.rtcd018 / l_total * 100 USING "##&.&&%"
   LET g_rtcd.rtcd019 = g_rtcd5.rtcd019 / l_total * 100 USING "##&.&&%"
   LET g_rtcd.rtcd020 = g_rtcd5.rtcd020 / l_total * 100 USING "##&.&&%"
   LET g_rtcd.rtcd021 = g_rtcd5.rtcd021 / l_total * 100 USING "##&.&&%"
   LET g_rtcd.rtcd022 = g_rtcd5.rtcd022 / l_total * 100 USING "##&.&&%"
   LET g_rtcd.rtcd023 = g_rtcd5.rtcd023 / l_total * 100 USING "##&.&&%"
   LET g_rtcd.rtcd024 = g_rtcd5.rtcd024 / l_total * 100 USING "##&.&&%"
   LET g_rtcd.rtcd025 = g_rtcd5.rtcd025 / l_total * 100 USING "##&.&&%"
   LET g_rtcd.rtcd026 = g_rtcd5.rtcd026 / l_total * 100 USING "##&.&&%"
   LET g_rtcd.rtcd027 = g_rtcd5.rtcd027 / l_total * 100 USING "##&.&&%"
   LET g_rtcd.rtcd028 = g_rtcd5.rtcd028 / l_total * 100 USING "##&.&&%"
   LET g_rtcd.rtcd029 = g_rtcd5.rtcd029 / l_total * 100 USING "##&.&&%"
   LET g_rtcd.rtcd030 = g_rtcd5.rtcd030 / l_total * 100 USING "##&.&&%"
   LET g_rtcd.rtcd031 = g_rtcd5.rtcd031 / l_total * 100 USING "##&.&&%"
   LET g_rtcd.rtcd032 = g_rtcd5.rtcd032 / l_total * 100 USING "##&.&&%"
   LET g_rtcd.rtcd033 = g_rtcd5.rtcd033 / l_total * 100 USING "##&.&&%"
   LET g_rtcd.rtcd034 = g_rtcd5.rtcd034 / l_total * 100 USING "##&.&&%"
   LET g_rtcd.rtcd035 = g_rtcd5.rtcd035 / l_total * 100 USING "##&.&&%"
   LET g_rtcd.rtcd036 = g_rtcd5.rtcd036 / l_total * 100 USING "##&.&&%"            
   LET g_rtcd.rtcd037 = g_rtcd5.rtcd037 / l_total * 100 USING "##&.&&%"
   
   IF NOT artm901_01_ins_rtcd_temp() THEN
      LET r_success = FALSE
      RETURN r_success
   END IF

   RETURN r_success   
   
END FUNCTION

PRIVATE FUNCTION artm901_01_ins_rtcd()
   DEFINE r_success           LIKE type_t.num5
   DEFINE l_rtcdsite          LIKE rtcd_t.rtcdsite
   DEFINE l_rtcd001           LIKE rtcd_t.rtcd001
   DEFINE l_sql               STRING

   LET r_success = TRUE

   #rtcd_t已產生預算資料 
   DECLARE artm901_01_rtcd_cs1 CURSOR FOR
    SELECT DISTINCT a.rtcdsite,a.rtcd001
      FROM artm901_tmp01 a                        #160727-00019#16 Mod   artm901_rtcd_temp -->artm901_tmp01
     WHERE EXISTS (SELECT 1 FROM rtcd_t b
                    WHERE b.rtcdent  = a.rtcdent
                      AND b.rtcdsite = a.rtcdsite
                      AND b.rtcd001  = a.rtcd001 )
                      
                      
   IF g_master.l_del = 'Y' THEN   
      FOREACH artm901_01_rtcd_cs1 INTO l_rtcdsite,l_rtcd001
         INITIALIZE g_errparam TO NULL
         LET g_errparam.replace[1] = l_rtcdsite
         LET g_errparam.replace[2] = l_rtcd001
         LET g_errparam.code = 'art-00665'
         LET g_errparam.popup = TRUE
         CALL cl_err()
      END FOREACH
      
      LET l_sql = "DELETE FROM rtcd_t a ",
                  " WHERE EXISTS (SELECT 1 FROM artm901_tmp01 b ",               #160727-00019#16 Mod   artm901_rtcd_temp -->artm901_tmp01
                  "         WHERE a.rtcdent  = b.rtcdent ",
                  "           AND a.rtcdsite = b.rtcdsite",
                  "           AND a.rtcd001  = b.rtcd001 )",
                  "       AND rtcdent = ",g_enterprise   #160324-00011#1 Add By Ken 160331
      PREPARE artm901_01_del_rtcd_prep1 FROM l_sql
      EXECUTE artm901_01_del_rtcd_prep1
      
      INSERT INTO rtcd_t ( rtcdent, rtcdsite, rtcd001, rtcd002, rtcd003,
                           rtcd004, rtcd005,  rtcd006, rtcd007, rtcd008,
                           rtcd009, rtcd010,  rtcd011, rtcd012, rtcd013,
                           rtcd014, rtcd015,  rtcd016, rtcd017, rtcd018,
                           rtcd019, rtcd020,  rtcd021, rtcd022, rtcd023,
                           rtcd024, rtcd025,  rtcd026, rtcd027, rtcd028,
                           rtcd029, rtcd030,  rtcd031, rtcd032, rtcd033,  
                           rtcd034, rtcd035,  rtcd036, rtcd037,
                           rtcdownid, rtcdowndp, rtcdcrtid, rtcdcrtdp, rtcdcrtdt,
                           rtcdmodid, rtcdmoddt, rtcdstus)
       SELECT rtcdent, rtcdsite, rtcd001, rtcd002, rtcd003,
              rtcd004, rtcd005,  rtcd006, rtcd007, rtcd008,
              rtcd009, rtcd010,  rtcd011, rtcd012, rtcd013,
              rtcd014, rtcd015,  rtcd016, rtcd017, rtcd018,
              rtcd019, rtcd020,  rtcd021, rtcd022, rtcd023,
              rtcd024, rtcd025,  rtcd026, rtcd027, rtcd028,
              rtcd029, rtcd030,  rtcd031, rtcd032, rtcd033,  
              rtcd034, rtcd035,  rtcd036, rtcd037,
              rtcdownid, rtcdowndp, rtcdcrtid, rtcdcrtdp, rtcdcrtdt,
              rtcdmodid, rtcdmoddt, rtcdstus 
        FROM artm901_tmp01                 #160727-00019#16 Mod   artm901_rtcd_temp -->artm901_tmp01
 
      IF SQLCA.SQLcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "ins rtcd_t"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success
      END IF
      
   ELSE
      FOREACH artm901_01_rtcd_cs1 INTO l_rtcdsite,l_rtcd001
         INITIALIZE g_errparam TO NULL
         LET g_errparam.replace[1] = l_rtcdsite
         LET g_errparam.replace[2] = l_rtcd001
         LET g_errparam.code = 'art-00666'
         LET g_errparam.popup = TRUE
         CALL cl_err()
      END FOREACH
      
      INSERT INTO rtcd_t ( rtcdent, rtcdsite, rtcd001, rtcd002, rtcd003,
                           rtcd004, rtcd005, rtcd006, rtcd007, rtcd008,
                           rtcd009, rtcd010, rtcd011, rtcd012, rtcd013,
                           rtcd014, rtcd015, rtcd016, rtcd017, rtcd018,
                           rtcd019, rtcd020, rtcd021, rtcd022, rtcd023,
                           rtcd024, rtcd025, rtcd026, rtcd027, rtcd028,
                           rtcd029, rtcd030, rtcd031, rtcd032, rtcd033,  
                           rtcd034, rtcd035, rtcd036, rtcd037,
                           rtcdownid, rtcdowndp, rtcdcrtid, rtcdcrtdp, rtcdcrtdt,
                           rtcdmodid, rtcdmoddt, rtcdstus)
       SELECT a.rtcdent, a.rtcdsite, a.rtcd001, a.rtcd002, a.rtcd003,
              a.rtcd004, a.rtcd005,  a.rtcd006, a.rtcd007, a.rtcd008,
              a.rtcd009, a.rtcd010,  a.rtcd011, a.rtcd012, a.rtcd013,
              a.rtcd014, a.rtcd015,  a.rtcd016, a.rtcd017, a.rtcd018,
              a.rtcd019, a.rtcd020,  a.rtcd021, a.rtcd022, a.rtcd023,
              a.rtcd024, a.rtcd025,  a.rtcd026, a.rtcd027, a.rtcd028,
              a.rtcd029, a.rtcd030,  a.rtcd031, a.rtcd032, a.rtcd033,  
              a.rtcd034, a.rtcd035,  a.rtcd036, a.rtcd037,
              a.rtcdownid, a.rtcdowndp, a.rtcdcrtid, a.rtcdcrtdp, a.rtcdcrtdt,
              a.rtcdmodid, a.rtcdmoddt, a.rtcdstus 
        FROM artm901_tmp01 a                    #160727-00019#16 Mod   artm901_rtcd_temp -->artm901_tmp01
       WHERE NOT EXISTS (SELECT 1 FROM rtcd_t b
                          WHERE b.rtcdent  = a.rtcdent
                            AND b.rtcdsite = a.rtcdsite
                            AND b.rtcd001 =  a.rtcd001#)                           
                            AND b.rtcd002 =  a.rtcd002 #ken(S)
                            AND b.rtcd003 =  a.rtcd003
                            AND b.rtcd004 =  a.rtcd004
                            AND b.rtcd005 =  a.rtcd005)


      IF SQLCA.SQLcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "ins rtcd_t"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success
      END IF
      
   END IF
   
   RETURN r_success
END FUNCTION

 
{</section>}
 
