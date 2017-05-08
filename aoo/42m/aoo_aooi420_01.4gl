#該程式未解開Section, 採用最新樣板產出!
{<section id="aooi420_01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0008(2016-09-26 14:27:56), PR版次:0008(2017-02-10 14:30:31)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000300
#+ Filename...: aooi420_01
#+ Description: 行事曆產生
#+ Creator....: 01258(2013-08-16 10:53:55)
#+ Modifier...: 02294 -SD/PR- 08734
 
{</section>}
 
{<section id="aooi420_01.global" >}
#應用 c01b 樣板自動產生(Version:10)
#add-point:填寫註解說明 name="global.memo"
#160318-00005#32  2016/03/27 By 07900    重复错误信息修改
#160919-00054#1   2016/09/19 By dorislai 修正「行事曆參照表號」為空，造成資料產生失敗的問題
#160914-00032#2   2016/09/26 By lixiang  整批產生行事曆時，原先只可產生一年，現在改成可一次產生多年 
#161124-00048#13  2016/12/14 By 08734    星号整批调整
#170207-00018#3   2017/02/10 By 08734    ROWNUM整批调整
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
 
#單頭 type 宣告
PRIVATE type type_g_oogc_m        RECORD
       oogc001 LIKE oogc_t.oogc001, 
   oogc001_desc LIKE type_t.chr80, 
   oogc002 LIKE oogc_t.oogc002, 
   oogc015 LIKE oogc_t.oogc015, 
   eyear LIKE type_t.num5, 
   bdate LIKE type_t.dat, 
   edate LIKE type_t.dat, 
   oogc004 LIKE oogc_t.oogc004, 
   oogc004_desc LIKE type_t.chr80, 
   oogc009 LIKE oogc_t.oogc009, 
   type LIKE type_t.chr500, 
   season LIKE type_t.chr500, 
   week LIKE type_t.chr500, 
   mw1b LIKE type_t.num5, 
   mw1e LIKE type_t.num5, 
   mw2b LIKE type_t.num5, 
   mw2e LIKE type_t.num5, 
   mw3b LIKE type_t.num5, 
   mw3e LIKE type_t.num5, 
   mw4b LIKE type_t.num5, 
   mw4e LIKE type_t.num5, 
   mw5b LIKE type_t.num5, 
   mw5e LIKE type_t.num5
       END RECORD
	   
#add-point:自定義模組變數(Module Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_oogc_m_t        type_g_oogc_m


#end add-point
 
DEFINE g_oogc_m        type_g_oogc_m
 
   DEFINE g_oogc001_t LIKE oogc_t.oogc001
DEFINE g_oogc002_t LIKE oogc_t.oogc002
DEFINE g_oogc015_t LIKE oogc_t.oogc015
 
 
DEFINE g_ref_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明(global.argv) name="global.argv"

#end add-point
 
{</section>}
 
{<section id="aooi420_01.input" >}
#+ 資料輸入
PUBLIC FUNCTION aooi420_01(--)
   #add-point:input段變數傳入 name="input.get_var"
p_argv1,p_oogc001,p_oogc002,p_oogc015
   #end add-point
   )
   #add-point:input段define name="input.define_customerization"
   
   #end add-point
   DEFINE l_ac_t          LIKE type_t.num10       #未取消的ARRAY CNT 
   DEFINE l_allow_insert  LIKE type_t.num5        #可新增否 
   DEFINE l_allow_delete  LIKE type_t.num5        #可刪除否  
   DEFINE l_count         LIKE type_t.num10
   DEFINE l_insert        LIKE type_t.num5
   DEFINE p_cmd           LIKE type_t.chr5
   #add-point:input段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="input.define"
   DEFINE l_date_first          LIKE type_t.dat
   DEFINE l_date_last           LIKE type_t.dat
   DEFINE l_year                  LIKE type_t.chr10
   DEFINE l_n             LIKE type_t.num5
   DEFINE l_sql           STRING
   DEFINE l_sql1          STRING
   DEFINE l_success       LIKE type_t.chr1
   DEFINE p_oogc001       LIKE oogc_t.oogc001
   DEFINE p_oogc002       LIKE oogc_t.oogc002
   DEFINE p_oogc015		  LIKE oogc_t.oogc015
   #DEFINE l_oogc   RECORD LIKE oogc_t.*  #161124-00048#13  2016/12/14 By 08734 mark
   #161124-00048#13  2016/12/14 By 08734 add(S)
   DEFINE l_oogc RECORD  #行事曆檔
       oogcent LIKE oogc_t.oogcent, #企业编号
       oogcstus LIKE oogc_t.oogcstus, #状态码
       oogc001 LIKE oogc_t.oogc001, #行事历参照表号
       oogc002 LIKE oogc_t.oogc002, #行事历类别
       oogc003 LIKE oogc_t.oogc003, #日期
       oogc004 LIKE oogc_t.oogc004, #休假类型
       oogc005 LIKE oogc_t.oogc005, #原因说明
       oogc006 LIKE oogc_t.oogc006, #期别
       oogc007 LIKE oogc_t.oogc007, #季别
       oogc008 LIKE oogc_t.oogc008, #周别
       oogc009 LIKE oogc_t.oogc009, #上班时数
       oogc010 LIKE oogc_t.oogc010, #分类一
       oogc011 LIKE oogc_t.oogc011, #分类二
       oogc012 LIKE oogc_t.oogc012, #分类三
       oogc013 LIKE oogc_t.oogc013, #分类四
       oogc014 LIKE oogc_t.oogc014, #分类五
       oogc015 LIKE oogc_t.oogc015, #年度
       oogcownid LIKE oogc_t.oogcownid, #资料所有者
       oogcowndp LIKE oogc_t.oogcowndp, #资料所有部门
       oogccrtid LIKE oogc_t.oogccrtid, #资料录入者
       oogccrtdp LIKE oogc_t.oogccrtdp, #资料录入部门
       oogccrtdt LIKE oogc_t.oogccrtdt, #资料创建日
       oogcmodid LIKE oogc_t.oogcmodid, #资料更改者
       oogcmoddt LIKE oogc_t.oogcmoddt, #最近更改日
       oogc016 LIKE oogc_t.oogc016, #月份
       oogc017 LIKE oogc_t.oogc017 #月周
END RECORD
#161124-00048#13  2016/12/14 By 08734 add(E)
   DEFINE l_yy          LIKE type_t.num5
   DEFINE l_mm         LIKE type_t.num5
   DEFINE l_dd           LIKE type_t.num5
   DEFINE l_i             LIKE type_t.num5
   DEFINE i             LIKE type_t.num5
   DEFINE b_date          LIKE type_t.dat 
   DEFINE b_date1         LIKE type_t.dat
   DEFINE b_date2         LIKE type_t.dat
   DEFINE f_date          LIKE type_t.dat 
   DEFINE l_date  ARRAY[12] OF LIKE type_t.dat,          
          l_date2 ARRAY[12] OF LIKE type_t.dat 
   DEFINE l_ss            LIKE type_t.num5
   DEFINE l_week          LIKE type_t.num5
   DEFINE l_days          LIKE type_t.num5
   DEFINE l_month         LIKE type_t.num5
   #DEFINE l_oogb   RECORD LIKE oogb_t.*  #161124-00048#13  2016/12/14 By 08734 mark
   #161124-00048#13  2016/12/14 By 08734 add(S)
   DEFINE l_oogb RECORD  #行事曆假日當
       oogbent LIKE oogb_t.oogbent, #企业编号
       oogb001 LIKE oogb_t.oogb001, #行事历参照表号
       oogb002 LIKE oogb_t.oogb002, #日期
       oogb003 LIKE oogb_t.oogb003, #休假类型
       oogb004 LIKE oogb_t.oogb004, #原因说明
       oogb005 LIKE oogb_t.oogb005, #分类一
       oogb006 LIKE oogb_t.oogb006, #分类二
       oogb007 LIKE oogb_t.oogb007, #分类三
       oogb008 LIKE oogb_t.oogb008, #分类四
       oogb009 LIKE oogb_t.oogb009, #分类五
       oogbstus LIKE oogb_t.oogbstus, #状态码
       oogbownid LIKE oogb_t.oogbownid, #资料所有者
       oogbowndp LIKE oogb_t.oogbowndp, #资料所有部门
       oogbcrtid LIKE oogb_t.oogbcrtid, #资料录入者
       oogbcrtdp LIKE oogb_t.oogbcrtdp, #资料录入部门
       oogbcrtdt LIKE oogb_t.oogbcrtdt, #资料创建日
       oogbmodid LIKE oogb_t.oogbmodid, #资料更改者
       oogbmoddt LIKE oogb_t.oogbmoddt, #最近更改日
       oogb010 LIKE oogb_t.oogb010 #年度
END RECORD
#161124-00048#13  2016/12/14 By 08734 add(E)
   DEFINE p_argv1         LIKE type_t.chr1
   DEFINE l_ask           LIKE type_t.chr1
   DEFINE l_crtdt         LIKE oogc_t.oogccrtdt
   DEFINE l_mw_days       LIKE type_t.num5
   DEFINE l_mw            LIKE type_t.num5
   DEFINE l_mw1e_t        LIKE type_t.num5
   DEFINE l_mw2e_t        LIKE type_t.num5   
   DEFINE l_mw3e_t        LIKE type_t.num5
   DEFINE l_mw4e_t        LIKE type_t.num5     
   
   #160914-00032#2---s
   DEFINE l_year2         LIKE oogc_t.oogc015
   DEFINE l_bmonth        LIKE type_t.num5     #当前日期范围的起始月份
   DEFINE l_bday          LIKE type_t.num5     #当前日期范围的起始日
   DEFINE l_emonth        LIKE type_t.num5     #当前日期范围的截止月份
   DEFINE l_eday          LIKE type_t.num5     #当前日期范围的截止日
   DEFINE l_bdate         LIKE oogc_t.oogc003
   DEFINE l_edate         LIKE oogc_t.oogc003
   DEFINE l_flag          LIKE type_t.num5
   DEFINE l_delete        LIKE type_t.chr1
   #160914-00032#2---e
   #end add-point
   
   #畫面開啟 (identifier)
   OPEN WINDOW w_aooi420_01 WITH FORM cl_ap_formpath("aoo","aooi420_01")
 
   #瀏覽頁簽資料初始化
   CALL cl_ui_init()
   
   LET g_qryparam.state = "i"
   LET p_cmd = 'a'
   
   #輸入前處理
   #add-point:單頭前置處理 name="input.pre_input"
   WHENEVER ERROR CONTINUE
   #CALL cl_set_comp_entry("oogc001,oogc002,oogc015",TRUE)  #mark by lixh 20150907
   CALL cl_set_comp_entry("oogc002,oogc015",TRUE)     #add by lixh 20150907
   IF p_argv1 = '2' THEN
      CALL cl_set_comp_entry("oogc001,oogc002,oogc015",FALSE)
   END IF
   CALL cl_set_combo_scc('oogc002','25')
   LET g_oogc_m.oogc001 = p_oogc001
   LET g_oogc_m.oogc002 = p_oogc002
   LET g_oogc_m.oogc015 = p_oogc015
   LET g_oogc_m.season = 'Y'
   LET g_oogc_m.week = 'Y'
   LET g_oogc_m.type = '1'
   #170207-00018#3  2017/02/10  By 08734 mark(S)
   #SELECT oocq002 INTO g_oogc_m.oogc004 FROM oocq_t
   # WHERE oocq001 = 6 AND oocqent = g_enterprise 
   #   AND oocq014 = 'Y' AND ROWNUM = 1 ORDER BY oocq002
   #170207-00018#3  2017/02/10  By 08734 mark(E)
   #170207-00018#3  2017/02/10  By 08734 add(S)
   SELECT A.oocq002 INTO g_oogc_m.oogc004 FROM  (SELECT oocq002  FROM oocq_t
    WHERE oocq001 = 6 AND oocqent = g_enterprise 
      AND oocq014 = 'Y' ORDER BY oocq002) A
   WHERE ROWNUM = 1
   #170207-00018#3  2017/02/10  By 08734 add(E)
   CALL cl_set_comp_entry("mw1e,mw2e,mw3e,mw4e,mw5e",FALSE)
   CREATE TEMP TABLE aooi420_01_tmp(
             oogcent_tmp     varchar(5),
             oogc001_tmp     varchar(10),
             oogc015_tmp     decimal(5,0),
             oogc002_tmp     varchar(10),
             oogc003_tmp     date, 
             oogc004_tmp     varchar(10),
             oogc005_tmp     varchar(80),
             oogc006_tmp     decimal(5,0),
             oogc007_tmp     decimal(5,0),
             oogc008_tmp     decimal(5,0),
             oogc009_tmp     decimal(15,3),
             oogc010_tmp     varchar(10),
             oogc011_tmp     varchar(10),
             oogc012_tmp     varchar(10),
             oogc013_tmp     varchar(10),
             oogc014_tmp     varchar(10),
             oogcstus_tmp    varchar(10),
             oogcownid_tmp   varchar(10),
             oogcowndp_tmp   varchar(10),
             oogccrtid_tmp   varchar(10),
             oogccrtdp_tmp   varchar(10),
             oogccrtdt_tmp   date,
             oogcmodid_tmp   varchar(10),
             oogcmoddt_tmp   date)
   #end add-point
  
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      #輸入開始
      INPUT BY NAME g_oogc_m.oogc001,g_oogc_m.oogc002,g_oogc_m.oogc015,g_oogc_m.eyear,g_oogc_m.bdate, 
          g_oogc_m.edate,g_oogc_m.oogc004,g_oogc_m.oogc009,g_oogc_m.type,g_oogc_m.season,g_oogc_m.week, 
          g_oogc_m.mw1b,g_oogc_m.mw1e,g_oogc_m.mw2b,g_oogc_m.mw2e,g_oogc_m.mw3b,g_oogc_m.mw3e,g_oogc_m.mw4b, 
          g_oogc_m.mw4e,g_oogc_m.mw5b,g_oogc_m.mw5e ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂ACTION
         #add-point:單頭前置處理 name="input.action"
         
         #end add-point
         
         #自訂ACTION(master_input)
         
         
         BEFORE INPUT
            #add-point:單頭輸入前處理 name="input.before_input"
            #160919-00054#1-s-add
            IF cl_null(g_oogc_m.oogc001) THEN
               SELECT ooef008 INTO g_oogc_m.oogc001 FROM ooef_t
                WHERE ooefent = g_enterprise AND ooef001 = g_site   
            END IF
            #160919-00054#1-e-add
            IF cl_null(g_oogc_m.oogc015) THEN
               LET g_oogc_m.oogc015 = YEAR(g_today) + 1
            END IF
            LET g_oogc_m.bdate = MDY(1,1,g_oogc_m.oogc015)
            LET g_oogc_m.edate = MDY(12,31,g_oogc_m.oogc015)
            DISPLAY BY NAME g_oogc_m.bdate,g_oogc_m.edate
            LET g_oogc_m.mw1b = 1
            LET g_oogc_m.mw1e = ''
            LET g_oogc_m.mw2b = ''
            LET g_oogc_m.mw2e = ''
            LET g_oogc_m.mw3b = ''
            LET g_oogc_m.mw3e = ''
            LET g_oogc_m.mw4b = ''
            LET g_oogc_m.mw4e = ''
            LET g_oogc_m.mw5b = ''
            LET g_oogc_m.mw5e = ''
            CALL cl_set_comp_entry("mw1e,mw2e,mw3e,mw4e,mw5e",FALSE)
            
            LET g_oogc_m.eyear = g_oogc_m.oogc015 #160914-00032#2
            DISPLAY BY NAME g_oogc_m.eyear  #160914-00032#2
            #end add-point
          
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD oogc001
            
            #add-point:AFTER FIELD oogc001 name="input.a.oogc001"
            #此段落由子樣板a05產生
            IF NOT cl_null(g_oogc_m.oogc001) THEN 
               LET l_n = 0
                SELECT COUNT(*) INTO l_n FROM ooal_t
                 WHERE ooalent = g_enterprise
                   AND ooal002 = g_oogc_m.oogc001
                   AND ooal001 = 4
                IF l_n = 0 THEN
                   INITIALIZE g_errparam TO NULL
                   LET g_errparam.code = 'agl-00007'
                   LET g_errparam.extend = g_oogc_m.oogc001
                   LET g_errparam.popup = TRUE
                   CALL cl_err()

                   LET g_oogc_m.oogc001 = ''
                   DISPLAY BY NAME g_oogc_m.oogc001
                   NEXT FIELD CURRENT
                END IF
                
                LET l_n = 0
                SELECT COUNT(*) INTO l_n FROM ooal_t
                 WHERE ooalent = g_enterprise
                   AND ooal002 = g_oogc_m.oogc001
                   AND ooal001 = 4
                   AND ooalstus='Y'
                IF l_n = 0 THEN
                   INITIALIZE g_errparam TO NULL
                   LET g_errparam.code = 'sub-01302' #aoo-00124 #160318-00005#32 by 07900 --mod  
                   LET g_errparam.extend = g_oogc_m.oogc001
                   #160318-00005#31  By 07900 --add-str
                   LET g_errparam.replace[1] ='aooi074'
                   LET g_errparam.replace[2] = cl_get_progname("aooi074",g_lang,"2")
                   LET g_errparam.exeprog ='aooi074'
                   #160318-00005#31  By 07900 --add-end
                   LET g_errparam.popup = TRUE
                   CALL cl_err()

                   LET g_oogc_m.oogc001 = ''
                   DISPLAY BY NAME g_oogc_m.oogc001
                   NEXT FIELD CURRENT
                END IF
            END IF


            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_oogc_m.oogc001
            CALL ap_ref_array2(g_ref_fields,"SELECT ooall004 FROM ooall_t WHERE ooallent="||g_enterprise||" AND ooall002=? AND ooall003='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_oogc_m.oogc001_desc = g_rtn_fields[1]
            DISPLAY BY NAME g_oogc_m.oogc001_desc

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD oogc001
            #add-point:BEFORE FIELD oogc001 name="input.b.oogc001"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE oogc001
            #add-point:ON CHANGE oogc001 name="input.g.oogc001"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD oogc002
            #add-point:BEFORE FIELD oogc002 name="input.b.oogc002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD oogc002
            
            #add-point:AFTER FIELD oogc002 name="input.a.oogc002"
            #此段落由子樣板a05產生


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE oogc002
            #add-point:ON CHANGE oogc002 name="input.g.oogc002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD oogc015
            #add-point:BEFORE FIELD oogc015 name="input.b.oogc015"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD oogc015
            
            #add-point:AFTER FIELD oogc015 name="input.a.oogc015"
            #此段落由子樣板a05產生
            IF NOT cl_null(g_oogc_m.oogc015) THEN 
               #160914-00032#2---s
               IF NOT cl_null(g_oogc_m.eyear) THEN 
                  IF g_oogc_m.oogc015 > g_oogc_m.eyear THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'acr-00064'
                     LET g_errparam.extend = g_oogc_m.oogc015
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     NEXT FIELD CURRENT 
                  END IF
               END IF
               #160914-00032#2---e
               LET g_oogc_m.bdate = MDY(1,1,g_oogc_m.oogc015)
               LET g_oogc_m.edate = MDY(12,31,g_oogc_m.oogc015)
               DISPLAY BY NAME g_oogc_m.bdate,g_oogc_m.edate
            END IF



            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE oogc015
            #add-point:ON CHANGE oogc015 name="input.g.oogc015"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD eyear
            #add-point:BEFORE FIELD eyear name="input.b.eyear"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD eyear
            
            #add-point:AFTER FIELD eyear name="input.a.eyear"
            #160914-00032#2---s
            IF NOT cl_null(g_oogc_m.eyear) THEN 
               IF NOT cl_null(g_oogc_m.oogc015) THEN 
                  IF g_oogc_m.eyear < g_oogc_m.oogc015 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'agl-00373'
                     LET g_errparam.extend = g_oogc_m.eyear
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     NEXT FIELD CURRENT 
                  END IF
               END IF
            END IF
            #160914-00032#2---e
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE eyear
            #add-point:ON CHANGE eyear name="input.g.eyear"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bdate
            #add-point:BEFORE FIELD bdate name="input.b.bdate"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bdate
            
            #add-point:AFTER FIELD bdate name="input.a.bdate"
            IF NOT cl_null(g_oogc_m.bdate) AND NOT cl_null(g_oogc_m.edate) THEN
               LET g_oogc_m.edate = s_date_get_date(g_oogc_m.bdate,12,-1)
               DISPLAY BY NAME g_oogc_m.edate
               IF p_argv1 = '1' THEN
                  LET g_oogc_m.oogc015 = YEAR(g_oogc_m.bdate)
               ELSE
                  IF YEAR(g_oogc_m.bdate) != g_oogc_m.oogc015 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'aoo-00198'
                     LET g_errparam.extend = YEAR(g_oogc_m.bdate)
                     LET g_errparam.popup = FALSE
                     CALL cl_err()

                     NEXT FIELD CURRENT
                  END IF
               END IF
               DISPLAY BY NAME g_oogc_m.edate
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bdate
            #add-point:ON CHANGE bdate name="input.g.bdate"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD edate
            #add-point:BEFORE FIELD edate name="input.b.edate"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD edate
            
            #add-point:AFTER FIELD edate name="input.a.edate"
            IF NOT cl_null(g_oogc_m.bdate) AND NOT cl_null(g_oogc_m.edate) THEN
                IF g_oogc_m.bdate > g_oogc_m.edate THEN
                    INITIALIZE g_errparam TO NULL
                    LET g_errparam.code = 'sub-00095'
                    LET g_errparam.extend = g_oogc_m.edate
                    LET g_errparam.popup = TRUE
                    CALL cl_err()

                    NEXT FIELD edate
                END IF
             END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE edate
            #add-point:ON CHANGE edate name="input.g.edate"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD oogc004
            
            #add-point:AFTER FIELD oogc004 name="input.a.oogc004"
            IF NOT cl_null(g_oogc_m.oogc004) THEN
               LET l_n = 0
               SELECT COUNT(*) INTO l_n FROM oocq_t
                WHERE oocqent =  g_enterprise
                  AND oocq001 = 6
                  AND oocq002 = g_oogc_m.oogc004
                  AND oocq014 = 'Y'
               IF l_n = 0 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'aoo-00081'
                  LET g_errparam.extend = g_oogc_m.oogc004
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  NEXT FIELD CURRENT
               END IF 
               
               LET l_n = 0
               SELECT COUNT(*) INTO l_n FROM oocq_t
                WHERE oocqent =  g_enterprise
                  AND oocq001 = 6
                  AND oocq002 = g_oogc_m.oogc004
                  AND oocqstus= 'Y'
                  AND oocq014 = 'Y'
               IF l_n = 0 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'aoo-00082'
                  LET g_errparam.extend = g_oogc_m.oogc004
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  NEXT FIELD CURRENT
               END IF
            END IF


            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_oogc_m.oogc004
            CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent="||g_enterprise||" AND oocql001='6' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_oogc_m.oogc004_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_oogc_m.oogc004_desc

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD oogc004
            #add-point:BEFORE FIELD oogc004 name="input.b.oogc004"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE oogc004
            #add-point:ON CHANGE oogc004 name="input.g.oogc004"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD oogc009
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_oogc_m.oogc009,"0.00","1","","","azz-00079",1) THEN
               NEXT FIELD oogc009
            END IF 
 
 
 
            #add-point:AFTER FIELD oogc009 name="input.a.oogc009"
            IF NOT cl_null(g_oogc_m.oogc009) THEN 
            END IF 

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD oogc009
            #add-point:BEFORE FIELD oogc009 name="input.b.oogc009"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE oogc009
            #add-point:ON CHANGE oogc009 name="input.g.oogc009"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD type
            #add-point:BEFORE FIELD type name="input.b.type"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD type
            
            #add-point:AFTER FIELD type name="input.a.type"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE type
            #add-point:ON CHANGE type name="input.g.type"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD season
            #add-point:BEFORE FIELD season name="input.b.season"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD season
            
            #add-point:AFTER FIELD season name="input.a.season"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE season
            #add-point:ON CHANGE season name="input.g.season"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD week
            #add-point:BEFORE FIELD week name="input.b.week"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD week
            
            #add-point:AFTER FIELD week name="input.a.week"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE week
            #add-point:ON CHANGE week name="input.g.week"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mw1b
            #add-point:BEFORE FIELD mw1b name="input.b.mw1b"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mw1b
            
            #add-point:AFTER FIELD mw1b name="input.a.mw1b"
         
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mw1b
            #add-point:ON CHANGE mw1b name="input.g.mw1b"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mw1e
            #add-point:BEFORE FIELD mw1e name="input.b.mw1e"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mw1e
            
            #add-point:AFTER FIELD mw1e name="input.a.mw1e"
            IF NOT cl_null(g_oogc_m.mw1e) THEN
               IF g_oogc_m.mw1e < g_oogc_m.mw1b THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'aoo-00257'
                  LET g_errparam.extend = g_oogc_m.mw1e
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_oogc_m.mw1e = ''
                  NEXT FIELD CURRENT
               END IF
               IF NOT aooi420_01_days_outside(g_oogc_m.mw1e) THEN
                  LET g_oogc_m.mw1e = ''
                  NEXT FIELD CURRENT
               END IF
               
               IF g_oogc_m.mw1e != l_mw1e_t AND l_mw1e_t != 0 THEN
                  LET g_oogc_m.mw2b = ""
                  LET g_oogc_m.mw2e = "" 
                  DISPLAY BY NAME g_oogc_m.mw2b,g_oogc_m.mw2e
                  CALL cl_set_comp_entry("mw2e",FALSE)
                  CALL aooi420_01_no_entry()
               END IF
               IF g_oogc_m.mw1e != 31 THEN
                  LET g_oogc_m.mw2b = g_oogc_m.mw1e + 1
                  DISPLAY BY NAME g_oogc_m.mw2b
                  CALL cl_set_comp_entry("mw2e",TRUE)
               END IF
               LET l_mw1e_t = g_oogc_m.mw1e
            END IF
            CALL aooi420_01_no_entry()
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mw1e
            #add-point:ON CHANGE mw1e name="input.g.mw1e"
 
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mw2b
            #add-point:BEFORE FIELD mw2b name="input.b.mw2b"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mw2b
            
            #add-point:AFTER FIELD mw2b name="input.a.mw2b"
 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mw2b
            #add-point:ON CHANGE mw2b name="input.g.mw2b"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mw2e
            #add-point:BEFORE FIELD mw2e name="input.b.mw2e"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mw2e
            
            #add-point:AFTER FIELD mw2e name="input.a.mw2e"
            IF NOT cl_null(g_oogc_m.mw2e) THEN
               IF g_oogc_m.mw2e < g_oogc_m.mw2b THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'aoo-00257'
                  LET g_errparam.extend = g_oogc_m.mw2e
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_oogc_m.mw2e = ''
                  NEXT FIELD CURRENT
               END IF
               IF NOT aooi420_01_days_outside(g_oogc_m.mw2e) THEN
                  LET g_oogc_m.mw2e = ''
                  NEXT FIELD CURRENT
               END IF

               IF g_oogc_m.mw2e != l_mw2e_t AND l_mw2e_t != 0 THEN
                  LET g_oogc_m.mw3b = ""
                  LET g_oogc_m.mw3e = "" 
                  DISPLAY BY NAME g_oogc_m.mw3b,g_oogc_m.mw3e
                  CALL cl_set_comp_entry("mw3e",FALSE)
                  CALL aooi420_01_no_entry()
               END IF
               IF g_oogc_m.mw2e != 31 THEN
                  LET g_oogc_m.mw3b = g_oogc_m.mw2e + 1
                  DISPLAY BY NAME g_oogc_m.mw3b
                  CALL cl_set_comp_entry("mw3e",TRUE)
               END IF
               LET l_mw2e_t = g_oogc_m.mw2e
            END IF
            CALL aooi420_01_no_entry()
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mw2e
            #add-point:ON CHANGE mw2e name="input.g.mw2e"
 
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mw3b
            #add-point:BEFORE FIELD mw3b name="input.b.mw3b"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mw3b
            
            #add-point:AFTER FIELD mw3b name="input.a.mw3b"
 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mw3b
            #add-point:ON CHANGE mw3b name="input.g.mw3b"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mw3e
            #add-point:BEFORE FIELD mw3e name="input.b.mw3e"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mw3e
            
            #add-point:AFTER FIELD mw3e name="input.a.mw3e"
            IF NOT cl_null(g_oogc_m.mw3e) THEN
               IF g_oogc_m.mw3e < g_oogc_m.mw3b THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'aoo-00257'
                  LET g_errparam.extend = g_oogc_m.mw3e
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_oogc_m.mw3e = ''
                  NEXT FIELD CURRENT
               END IF
               IF NOT aooi420_01_days_outside(g_oogc_m.mw3e) THEN
                  LET g_oogc_m.mw3e = ''
                  NEXT FIELD CURRENT
               END IF

               IF g_oogc_m.mw3e != l_mw3e_t AND l_mw3e_t != 0 THEN
                  LET g_oogc_m.mw4b = ""
                  LET g_oogc_m.mw4e = "" 
                  DISPLAY BY NAME g_oogc_m.mw4b,g_oogc_m.mw4e
                  CALL cl_set_comp_entry("mw4e",FALSE)
                  CALL aooi420_01_no_entry()
               END IF
               IF g_oogc_m.mw3e != 31 THEN
                  LET g_oogc_m.mw4b = g_oogc_m.mw3e + 1
                  DISPLAY BY NAME g_oogc_m.mw4b
                  CALL cl_set_comp_entry("mw4e",TRUE)
               END IF
               LET l_mw3e_t = g_oogc_m.mw3e
            END IF
            CALL aooi420_01_no_entry()
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mw3e
            #add-point:ON CHANGE mw3e name="input.g.mw3e"
 
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mw4b
            #add-point:BEFORE FIELD mw4b name="input.b.mw4b"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mw4b
            
            #add-point:AFTER FIELD mw4b name="input.a.mw4b"
 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mw4b
            #add-point:ON CHANGE mw4b name="input.g.mw4b"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mw4e
            #add-point:BEFORE FIELD mw4e name="input.b.mw4e"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mw4e
            
            #add-point:AFTER FIELD mw4e name="input.a.mw4e"
            IF NOT cl_null(g_oogc_m.mw4e) THEN
               IF g_oogc_m.mw4e < g_oogc_m.mw4b THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'aoo-00257'
                  LET g_errparam.extend = g_oogc_m.mw4e
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_oogc_m.mw4e = ''
                  NEXT FIELD CURRENT
               END IF
               IF NOT aooi420_01_days_outside(g_oogc_m.mw4e) THEN
                  LET g_oogc_m.mw4e = ''
                  NEXT FIELD CURRENT
               END IF
               
               IF g_oogc_m.mw4e != l_mw4e_t AND l_mw4e_t != 0 THEN
                  LET g_oogc_m.mw5b = ""
                  LET g_oogc_m.mw5e = "" 
                  DISPLAY BY NAME g_oogc_m.mw5b,g_oogc_m.mw5e
                  CALL cl_set_comp_entry("mw5e",FALSE)
                  CALL aooi420_01_no_entry()
               END IF
               IF g_oogc_m.mw4e != 31 THEN
                  LET g_oogc_m.mw5b = g_oogc_m.mw4e + 1
                  DISPLAY BY NAME g_oogc_m.mw5b
                  CALL cl_set_comp_entry("mw5e",TRUE)
               END IF
               LET l_mw4e_t = g_oogc_m.mw4e
            END IF
            CALL aooi420_01_no_entry()
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mw4e
            #add-point:ON CHANGE mw4e name="input.g.mw4e"
 
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mw5b
            #add-point:BEFORE FIELD mw5b name="input.b.mw5b"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mw5b
            
            #add-point:AFTER FIELD mw5b name="input.a.mw5b"
 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mw5b
            #add-point:ON CHANGE mw5b name="input.g.mw5b"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mw5e
            #add-point:BEFORE FIELD mw5e name="input.b.mw5e"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mw5e
            
            #add-point:AFTER FIELD mw5e name="input.a.mw5e"
            IF NOT cl_null(g_oogc_m.mw5e) THEN
               IF g_oogc_m.mw5e < g_oogc_m.mw5b THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'aoo-00257'
                  LET g_errparam.extend = g_oogc_m.mw5e
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_oogc_m.mw5e = ''
                  NEXT FIELD CURRENT
               END IF
               IF NOT aooi420_01_days_outside(g_oogc_m.mw5e) THEN
                  NEXT FIELD CURRENT
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mw5e
            #add-point:ON CHANGE mw5e name="input.g.mw5e"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.oogc001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD oogc001
            #add-point:ON ACTION controlp INFIELD oogc001 name="input.c.oogc001"
#此段落由子樣板a07產生            
            #開窗i段
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_oogc_m.oogc001             #給予default值

            #給予arg
            LET g_qryparam.where = " ooal001 = 4"
            CALL q_ooal002() #呼叫開窗
            INITIALIZE g_qryparam.where TO null
            LET g_oogc_m.oogc001 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_oogc_m.oogc001 TO oogc001              #顯示到畫面上

            NEXT FIELD oogc001                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.oogc002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD oogc002
            #add-point:ON ACTION controlp INFIELD oogc002 name="input.c.oogc002"
            
            #END add-point
 
 
         #Ctrlp:input.c.oogc015
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD oogc015
            #add-point:ON ACTION controlp INFIELD oogc015 name="input.c.oogc015"
            
            #END add-point
 
 
         #Ctrlp:input.c.eyear
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD eyear
            #add-point:ON ACTION controlp INFIELD eyear name="input.c.eyear"
            
            #END add-point
 
 
         #Ctrlp:input.c.bdate
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bdate
            #add-point:ON ACTION controlp INFIELD bdate name="input.c.bdate"
            
            #END add-point
 
 
         #Ctrlp:input.c.edate
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD edate
            #add-point:ON ACTION controlp INFIELD edate name="input.c.edate"
            
            #END add-point
 
 
         #Ctrlp:input.c.oogc004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD oogc004
            #add-point:ON ACTION controlp INFIELD oogc004 name="input.c.oogc004"
#此段落由子樣板a07產生            
            #開窗i段
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_oogc_m.oogc004             #給予default值

            #給予arg
            LET g_qryparam.arg1 = 6 #應用分類
            LET g_qryparam.where = " oocq014 = 'Y'"
            CALL q_oocq002()                                #呼叫開窗
            INITIALIZE g_qryparam.where TO NULL
            LET g_oogc_m.oogc004 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_oogc_m.oogc004 TO oogc004              #顯示到畫面上

            NEXT FIELD oogc004                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.oogc009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD oogc009
            #add-point:ON ACTION controlp INFIELD oogc009 name="input.c.oogc009"
            
            #END add-point
 
 
         #Ctrlp:input.c.type
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD type
            #add-point:ON ACTION controlp INFIELD type name="input.c.type"
            
            #END add-point
 
 
         #Ctrlp:input.c.season
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD season
            #add-point:ON ACTION controlp INFIELD season name="input.c.season"
            
            #END add-point
 
 
         #Ctrlp:input.c.week
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD week
            #add-point:ON ACTION controlp INFIELD week name="input.c.week"
            
            #END add-point
 
 
         #Ctrlp:input.c.mw1b
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mw1b
            #add-point:ON ACTION controlp INFIELD mw1b name="input.c.mw1b"
            
            #END add-point
 
 
         #Ctrlp:input.c.mw1e
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mw1e
            #add-point:ON ACTION controlp INFIELD mw1e name="input.c.mw1e"
            
            #END add-point
 
 
         #Ctrlp:input.c.mw2b
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mw2b
            #add-point:ON ACTION controlp INFIELD mw2b name="input.c.mw2b"
            
            #END add-point
 
 
         #Ctrlp:input.c.mw2e
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mw2e
            #add-point:ON ACTION controlp INFIELD mw2e name="input.c.mw2e"
            
            #END add-point
 
 
         #Ctrlp:input.c.mw3b
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mw3b
            #add-point:ON ACTION controlp INFIELD mw3b name="input.c.mw3b"
            
            #END add-point
 
 
         #Ctrlp:input.c.mw3e
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mw3e
            #add-point:ON ACTION controlp INFIELD mw3e name="input.c.mw3e"
            
            #END add-point
 
 
         #Ctrlp:input.c.mw4b
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mw4b
            #add-point:ON ACTION controlp INFIELD mw4b name="input.c.mw4b"
            
            #END add-point
 
 
         #Ctrlp:input.c.mw4e
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mw4e
            #add-point:ON ACTION controlp INFIELD mw4e name="input.c.mw4e"
            
            #END add-point
 
 
         #Ctrlp:input.c.mw5b
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mw5b
            #add-point:ON ACTION controlp INFIELD mw5b name="input.c.mw5b"
            
            #END add-point
 
 
         #Ctrlp:input.c.mw5e
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mw5e
            #add-point:ON ACTION controlp INFIELD mw5e name="input.c.mw5e"
            
            #END add-point
 
 
 #欄位開窗
 
         AFTER INPUT
            #add-point:單頭輸入後處理 name="input.after_input"
            
            #end add-point
            
      END INPUT
    
      #add-point:自定義input name="input.more_input"
      
      #end add-point
    
      #公用action
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
 
   #add-point:畫面關閉前 name="input.before_close"
   
   #end add-point
   
   #畫面關閉
   CLOSE WINDOW w_aooi420_01 
   
   #add-point:input段after input name="input.post_input"
   IF NOT INT_FLAG THEN
      #160914-00032#2---s
      IF cl_null(g_oogc_m.eyear) THEN 
         LET g_oogc_m.eyear = g_oogc_m.oogc015
      END IF
      
      LET l_flag = FALSE      #是否询问过  #160914-00032#2
      LET l_delete = 'Y'      #160914-00032#2
      
      CALL s_transaction_begin()   #160914-00032#2
      
      FOR l_year2 = g_oogc_m.oogc015 TO g_oogc_m.eyear
         LET l_bmonth = MONTH(g_oogc_m.bdate) #当前日期范围的起始月份
         LET l_bday = DAY(g_oogc_m.bdate)     #当前日期范围的起始日
         LET l_emonth = MONTH(g_oogc_m.edate) #当前日期范围的截止月份
         LET l_eday = DAY(g_oogc_m.edate)     #当前日期范围的截止日
         
         LET l_bdate = MDY(l_bmonth,l_bday,l_year2)
         IF YEAR(g_oogc_m.edate) - YEAR(g_oogc_m.bdate) = 1 THEN  #截止日期是下一年份
            LET l_edate = MDY(l_emonth,l_eday,l_year2+1)
         ELSE
            LET l_edate = MDY(l_emonth,l_eday,l_year2)
         END IF
      #160914-00032#2---e
         
         #CALL s_transaction_begin()   #160914-00032#2
         LET l_crtdt = cl_get_current()
         LET l_sql = "SELECT ",g_enterprise,",'",g_oogc_m.oogc001 CLIPPED,"',TO_NUMBER(SUBSTR(TO_CHAR(ooga001,'YYYY-MM-DD'),1,4)),",
                     "       '",g_oogc_m.oogc002 CLIPPED,"',ooga001,ooga004,ooga005,ooga006,ooga007,ooga008,'Y',",
                     "       '",g_user,"','",g_dept,"','",g_user,"','",g_dept,"',TO_DATE('",l_crtdt,"','YYYY-MM-DD HH24:MI:SS')",
                     "  FROM ooga_t",
                     #" WHERE ooga001 BETWEEN '",g_oogc_m.bdate CLIPPED,"' AND '",g_oogc_m.edate CLIPPED,"'",  #160914-00032#2
                     " WHERE ooga001 BETWEEN '",l_bdate CLIPPED,"' AND '",l_edate CLIPPED,"'",  #160914-00032#2                     
                     "   AND oogaent = ",g_enterprise
         LET l_n = 0
         SELECT COUNT(*) INTO l_n FROM oogc_t WHERE oogc001 = g_oogc_m.oogc001
            AND oogcent = g_enterprise AND oogc002 = g_oogc_m.oogc002
            #AND oogc003 BETWEEN g_oogc_m.bdate AND g_oogc_m.edate  #160914-00032#2
            AND oogc003 BETWEEN l_bdate AND l_edate  #160914-00032#2
            
         LET l_ask = 'Y'      #代表默認沒有已存在的資料  
         IF l_n > 0 THEN     #判斷是否有資料,再詢問是否刪除已存在的oogc_t資料
            #160914-00032#2--s
            #询问过就不再询问
            IF l_flag THEN
               IF l_delete = 'Y' THEN
                  DELETE FROM oogc_t WHERE oogcent = g_enterprise AND oogc001 = g_oogc_m.oogc001
                                       AND oogc002 = g_oogc_m.oogc002 
                                       AND oogc003 BETWEEN l_bdate AND l_edate  
                  IF SQLCA.SQLCODE OR l_success = 'N' THEN
                     LET l_success = 'N'
                  ELSE
                     LET l_success = 'Y'
                  END IF
               ELSE
                  LET l_ask = 'N'
                  LET l_sql = l_sql," AND  NOT EXISTS(SELECT oogc003 FROM oogc_t WHERE oogcent = ",g_enterprise,
                     "                AND oogc001 = '",g_oogc_m.oogc001 CLIPPED,"'",
                     "                AND oogc003 BETWEEN '",l_bdate CLIPPED,"' AND '",l_edate CLIPPED,"'",   
                     "                AND oogc002 = '",g_oogc_m.oogc002 CLIPPED,"' AND oogc003 = ooga001) "
               END IF
            ELSE
            #160914-00032#2--e
               IF NOT cl_ask_confirm('aoo-00191') THEN
                  LET l_ask = 'N'
                  LET l_sql = l_sql," AND  NOT EXISTS(SELECT oogc003 FROM oogc_t WHERE oogcent = ",g_enterprise,
                     "                AND oogc001 = '",g_oogc_m.oogc001 CLIPPED,"'",
                     #"                AND oogc003 BETWEEN '",g_oogc_m.bdate CLIPPED,"' AND '",g_oogc_m.edate CLIPPED,"'",   #160914-00032#2
                     "                AND oogc003 BETWEEN '",l_bdate CLIPPED,"' AND '",l_edate CLIPPED,"'",   #160914-00032#2
                     "                AND oogc002 = '",g_oogc_m.oogc002 CLIPPED,"' AND oogc003 = ooga001) "
               ELSE
                  DELETE FROM oogc_t WHERE oogcent = g_enterprise AND oogc001 = g_oogc_m.oogc001
                                       AND oogc002 = g_oogc_m.oogc002 
                                       #AND oogc003 BETWEEN g_oogc_m.bdate AND g_oogc_m.edate  #160914-00032#2
                                       AND oogc003 BETWEEN l_bdate AND l_edate  #160914-00032#2
                  IF SQLCA.SQLCODE OR l_success = 'N' THEN
                     LET l_success = 'N'
                  ELSE
                     LET l_success = 'Y'
                  END IF
               END IF 
               LET l_flag = TRUE     #160914-00032#2
               LET l_delete = l_ask  #160914-00032#2 #是否删除
            END IF   #160914-00032#2
         END IF      
         
         IF l_ask = 'Y' THEN
            LET l_sql1 = "INSERT INTO oogc_t(oogcent,oogc001,oogc015,oogc002,oogc003,oogc010,oogc011,oogc012,oogc013,",
                                            "oogc014,oogcstus,oogcownid,oogcowndp,oogccrtid,oogccrtdp,oogccrtdt) "
         ELSE
            LET l_sql1 = "INSERT INTO aooi420_01_tmp(oogcent_tmp,oogc001_tmp,oogc015_tmp,oogc002_tmp,oogc003_tmp,oogc010_tmp,",
                                                   "oogc011_tmp,oogc012_tmp,oogc013_tmp,oogc014_tmp,oogcstus_tmp,oogcownid_tmp,",
                                                   "oogcowndp_tmp,oogccrtid_tmp,oogccrtdp_tmp,oogccrtdt_tmp) "
         END IF
         LET l_sql = l_sql1,l_sql
         PREPARE aooi420_01_pre1 FROM l_sql
         EXECUTE aooi420_01_pre1
         IF SQLCA.SQLCODE OR l_success = 'N' THEN
            LET l_success = 'N'
         ELSE
            LET l_success = 'Y'
         END IF
      
       #將行事曆假日檔的資料更新至oogc_t
         IF l_ask = 'Y' THEN
            LET l_sql = "UPDATE oogc_t SET (oogc004,oogc005,oogc010,oogc011,oogc012,oogc013,oogc014) ",
                        "= ((SELECT oogb003,oogb004,oogb005,oogb006,oogb007,oogb008,oogb009 FROM oogb_t", 
                        " WHERE oogbent = ",g_enterprise," AND oogbent = oogcent AND oogb001 = oogc001 AND oogb002 = oogc003 AND oogb010 = oogc015))",
                        " WHERE oogcent = ",g_enterprise," AND oogc001 = '",g_oogc_m.oogc001,"'", 
                        "   AND oogc002 = '",g_oogc_m.oogc002,"'", 
                        #"   AND oogc003 BETWEEN '",g_oogc_m.bdate,"' AND '",g_oogc_m.edate,"'",  #160914-00032#2
                        "   AND oogc003 BETWEEN '",l_bdate,"' AND '",l_edate,"'",  #160914-00032#2
                        #"   AND EXISTS (SELECT * FROM oogb_t where oogb001 = oogc001 AND  oogb002 = oogc003 AND oogbent = ",g_enterprise,  #161124-00048#13  2016/12/14 By 08734 mark
                        "   AND EXISTS (SELECT oogbent,oogb001,oogb002,oogb003,oogb004,oogb005,oogb006,oogb007,oogb008,oogb009,oogbstus,",  #161124-00048#13  2016/12/14 By 08734 add
                        " oogbownid,oogbowndp,oogbcrtid,oogbcrtdp,oogbcrtdt,oogbmodid,oogbmoddt,oogb010 FROM oogb_t where oogb001 = oogc001 AND  oogb002 = oogc003 AND oogbent = ",g_enterprise,
                        "                  AND oogbent = oogcent AND oogb010 = oogc015)"
         ELSE
            LET l_sql = "UPDATE aooi420_01_tmp SET (oogc004_tmp,oogc005_tmp,oogc010_tmp,oogc011_tmp,oogc012_tmp,oogc013_tmp,oogc014_tmp) ",
                        "= ((SELECT oogb003,oogb004,oogb005,oogb006,oogb007,oogb008,oogb009 FROM oogb_t", 
                        " WHERE oogbent = ",g_enterprise," AND oogbent = oogcent_tmp AND oogb001 = oogc001_tmp AND oogb002 = oogc003_tmp AND oogb010 = oogc015_tmp))",
                        #" WHERE EXISTS (SELECT * FROM oogb_t where oogb001 = oogc001_tmp AND  oogb002 = oogc003_tmp AND oogbent = ",g_enterprise,  #161124-00048#13  2016/12/14 By 08734 mark
                        " WHERE EXISTS (SELECT oogbent,oogb001,oogb002,oogb003,oogb004,oogb005,oogb006,oogb007,oogb008,oogb009,oogbstus,",  #161124-00048#13  2016/12/14 By 08734 add
                        " oogbownid,oogbowndp,oogbcrtid,oogbcrtdp,oogbcrtdt,oogbmodid,oogbmoddt,oogb010 FROM oogb_t where oogb001 = oogc001_tmp AND  oogb002 = oogc003_tmp AND oogbent = ",g_enterprise,
                        "                  AND oogbent = oogcent_tmp AND oogb010 = oogc015_tmp)"
         END IF
         PREPARE oogb_pre FROM l_sql
         EXECUTE oogb_pre
         IF SQLCA.SQLCODE OR l_success = 'N' THEN
             LET l_success = 'N'
          ELSE
             LET l_success = 'Y'
         END IF
        
#         LET l_sql = "SELECT * FROM oogb_t WHERE oogbent = '",g_enterprise,"'",
#                     "   AND oogb001 = '",g_oogc_m.oogc001 CLIPPED,"' AND oogbstus = 'Y'",
#                     "   AND oogb002 BETWEEN '",g_oogc_m.bdate,"' AND '",g_oogc_m.edate,"'"
#         PREPARE oogb_pre_1 FROM l_sql
#         DECLARE oogb_cur_1 CURSOR FOR oogb_pre_1
#         FOREACH oogb_cur_1 INTO l_oogb.*
#            IF SQLCA.SQLCODE OR l_success = 'N' THEN
#               LET l_success = 'N'
#               EXIT FOREACH
#            ELSE
#               LET l_success = 'Y'
#            END IF
#            UPDATE oogc_t SET oogc004 = l_oogb.oogb003,oogc005 = l_oogb.oogb004,oogc010 = l_oogb.oogb005,
#                              oogc011 = l_oogb.oogb006,oogc012 = l_oogb.oogb007,oogc013 = l_oogb.oogb008,
#                              oogc014 = l_oogb.oogb009
#                        WHERE oogcent = g_enterprise
#                          AND oogc001 = g_oogc_m.oogc001  
#                          AND oogc002 = g_oogc_m.oogc002
#                          AND oogc003 = l_oogb.oogb002
#                          AND oogc015 = l_oogb.oogb010                       
#            IF SQLCA.SQLCODE OR l_success = 'N' THEN
#               LET l_success = 'N'
#               EXIT FOREACH
#            ELSE
#               LET l_success = 'Y'
#            END IF                  
#            
#         END FOREACH
                           
          
        #將非行事曆假日檔的日期更新                  
         IF l_ask = 'Y' THEN
            UPDATE oogc_t SET oogc004 = g_oogc_m.oogc004,
                              oogc009 = g_oogc_m.oogc009
                        WHERE oogcent = g_enterprise
                          AND oogc001 = g_oogc_m.oogc001
                          AND oogc002 = g_oogc_m.oogc002
                          #AND oogc003 BETWEEN g_oogc_m.bdate AND g_oogc_m.edate   #160914-00032#2
                          AND oogc003 BETWEEN l_bdate AND l_edate   #160914-00032#2
                          #AND NOT EXISTS(SELECT * FROM oogb_t WHERE oogbent = oogcent  #161124-00048#13  2016/12/14 By 08734 mark
                          AND NOT EXISTS(SELECT oogbent,oogb001,oogb002,oogb003,oogb004,oogb005,oogb006,oogb007,oogb008,oogb009,oogbstus,  #161124-00048#13  2016/12/14 By 08734 add
                         oogbownid,oogbowndp,oogbcrtid,oogbcrtdp,oogbcrtdt,oogbmodid,oogbmoddt,oogb010 FROM oogb_t WHERE oogbent = oogcent
                                            AND oogb001 = oogc001
                                            AND oogb002 = oogc003
                                            AND oogb010 = oogc015)
         ELSE
            UPDATE aooi420_01_tmp SET oogc004_tmp = g_oogc_m.oogc004,
                                      oogc009_tmp = g_oogc_m.oogc009
                                #WHERE NOT EXISTS(SELECT * FROM oogb_t WHERE oogbent = oogcent_tmp  #161124-00048#13  2016/12/14 By 08734 mark
                                WHERE NOT EXISTS(SELECT oogbent,oogb001,oogb002,oogb003,oogb004,oogb005,oogb006,oogb007,oogb008,oogb009,oogbstus,  #161124-00048#13  2016/12/14 By 08734 add
                         oogbownid,oogbowndp,oogbcrtid,oogbcrtdp,oogbcrtdt,oogbmodid,oogbmoddt,oogb010 FROM oogb_t WHERE oogbent = oogcent_tmp
                                                    AND oogb001 = oogc001_tmp
                                                    AND oogb002 = oogc003_tmp
                                                    AND oogb010 = oogc015_tmp)            
         END IF
         
         IF l_ask = 'N' THEN    #如果用戶選擇的是不刪除已存在的數據,就將臨時表裏處理好的數據一次性INSERT INTO 到oogc_t中
            INSERT INTO oogc_t (oogcent,oogc001,oogc015,oogc002,oogc003,oogc004,
                                oogc005,oogc006,oogc007,oogc008,oogc009,oogc010,
                                oogc011,oogc012,oogc013,oogc014,oogcstus,oogcownid,
                                oogcowndp,oogccrtid,oogccrtdp,oogccrtdt)
            SELECT oogcent_tmp,oogc001_tmp,oogc015_tmp,oogc002_tmp,oogc003_tmp,oogc004_tmp,
                   oogc005_tmp,oogc006_tmp,oogc007_tmp,oogc008_tmp,oogc009_tmp,oogc010_tmp,
                   oogc011_tmp,oogc012_tmp,oogc013_tmp,oogc014_tmp,oogcstus_tmp,oogcownid_tmp,
                   oogcowndp_tmp,oogccrtid_tmp,oogccrtdp_tmp,oogccrtdt_tmp
             FROM aooi420_01_tmp
         END IF
         IF SQLCA.SQLCODE OR l_success = 'N' THEN
            LET l_success = 'N'
         ELSE
            LET l_success = 'Y'
         END IF
         
         #LET l_sql = "SELECT * FROM oogc_t WHERE oogcent = '",g_enterprise CLIPPED,"'",  #161124-00048#13  2016/12/14 By 08734 mark
         LET l_sql = "SELECT oogcent,oogcstus,oogc001,oogc002,oogc003,oogc004,oogc005,oogc006,oogc007,oogc008,oogc009,oogc010,oogc011,oogc012,oogc013,",  #161124-00048#13  2016/12/14 By 08734 add
                     " oogc014,oogc015,oogcownid,oogcowndp,oogccrtid,oogccrtdp,oogccrtdt,oogcmodid,oogcmoddt,oogc016,oogc017 FROM oogc_t WHERE oogcent = '",g_enterprise CLIPPED,"'",
                     "   AND oogc001 = '",g_oogc_m.oogc001 CLIPPED,"'",
                     "   AND oogc002 = '",g_oogc_m.oogc002 CLIPPED,"'",
                     #"   AND oogc003 BETWEEN '",g_oogc_m.bdate CLIPPED,"' AND '",g_oogc_m.edate CLIPPED,"'"  #160914-00032#2
                     "   AND oogc003 BETWEEN '",l_bdate CLIPPED,"' AND '",l_edate CLIPPED,"'"  #160914-00032#2
         PREPARE aooi420_01_pre3 FROM l_sql
         DECLARE aooi420_01_cur3 CURSOR FOR aooi420_01_pre3
         
         #LET b_date = g_oogc_m.bdate  #160914-00032#2
         #LET f_date = g_oogc_m.edate  #160914-00032#2
         LET b_date = l_bdate  #160914-00032#2
         LET f_date = l_edate  #160914-00032#2
         FOREACH aooi420_01_cur3 INTO l_oogc.*
            IF SQLCA.SQLCODE OR l_success = 'N' THEN
               LET l_success = 'N'
               EXIT FOREACH
            END IF
            IF g_oogc_m.season = 'Y' THEN
               LET b_date1 = MDY(1,1,YEAR(l_oogc.oogc003))
            ELSE
               #LET b_date1 = g_oogc_m.bdate  #160914-00032#2
               LET b_date1 = l_bdate  #160914-00032#2
            END IF
            
            FOR i= 1 TO 12
                LET l_date[i] = s_date_get_date(b_date1,i,0)
                LET l_date2[i] = l_date[i] -1
            END FOR
        
            #第一季度
            IF l_oogc.oogc003 <= l_date2[3] THEN
               LET l_ss = 1
            END IF 
            #第二季度
            IF l_oogc.oogc003 <= l_date2[6] AND l_oogc.oogc003 >= l_date[3] THEN
               LET l_ss = 2      	    
            END IF
            #第三季度
            IF l_oogc.oogc003 <= l_date2[9] AND l_oogc.oogc003 >= l_date[6] THEN
               LET l_ss = 3	        
            END IF
            #第四季度
            IF l_oogc.oogc003 <= l_date2[12] AND l_oogc.oogc003 >= l_date[9] THEN
               LET l_ss = 4
            END IF
            #計算週期
            IF g_oogc_m.week = 'Y' THEN
               LET b_date2 = MDY(1,1,YEAR(l_oogc.oogc003))
            ELSE
               #LET b_date2 = g_oogc_m.bdate    #160914-00032#2
               LET b_date2 = l_bdate  #160914-00032#2
            END IF
            LET l_days = l_oogc.oogc003 - b_date2
            IF l_days=0 THEN LET l_days=1 END IF
            LET l_week = 0
            LET l_mm = 0
            FOR l_i = 1 TO l_days
                IF WEEKDAY(b_date + l_i) = 0 THEN
                   LET l_week = l_week +1
                END IF
                IF l_week = 0 THEN 
                   LET l_week = l_week +1
                END IF 
            END FOR 
            
             #週期種類1.月
            IF g_oogc_m.type = '1' THEN
               #第一季度
               IF l_oogc.oogc003 <= l_date2[3] THEN
                  IF l_oogc.oogc003 <= l_date2[1] THEN
                     LET l_mm = 1
                  END IF
                  IF l_oogc.oogc003 >= l_date[1] AND l_oogc.oogc003 <= l_date2[2] THEN
                     LET l_mm = 2
                  END IF
	              IF l_oogc.oogc003 >= l_date[2] AND l_oogc.oogc003 <= l_date2[3] THEN
                     LET l_mm = 3
                  END IF
               END IF 
               #第二季度
               IF l_oogc.oogc003 <= l_date2[6] AND l_oogc.oogc003 >= l_date[3]THEN
         	       IF l_oogc.oogc003 >= l_date[3] AND l_oogc.oogc003 <= l_date2[4] THEN
                     LET l_mm = 4
                  END IF
       	       IF l_oogc.oogc003 >= l_date[4] AND l_oogc.oogc003 <= l_date2[5] THEN
                     LET l_mm = 5
                  END IF
	              IF l_oogc.oogc003 >= l_date[5] AND l_oogc.oogc003 <= l_date2[6] THEN
                     LET l_mm = 6
                  END IF
               END IF
               #第三季度
               IF l_oogc.oogc003 <= l_date2[9] AND l_oogc.oogc003 >= l_date[6]THEN
	              IF l_oogc.oogc003 >= l_date[6] AND l_oogc.oogc003 <= l_date2[7] THEN
                     LET l_mm = 7
                  END IF
	              IF l_oogc.oogc003 >= l_date[7] AND l_oogc.oogc003 <= l_date2[8] THEN
                     LET l_mm = 8
                  END IF
	              IF l_oogc.oogc003 >= l_date[8] AND l_oogc.oogc003 <= l_date2[9] THEN
                     LET l_mm = 9
                  END IF
               END IF
               #第四季度
               IF l_oogc.oogc003 <= l_date2[12] AND l_oogc.oogc003 >= l_date[9]THEN
	              IF l_oogc.oogc003 >= l_date[9] AND l_oogc.oogc003 <= l_date2[10] THEN
                     LET l_mm = 10
                  END IF
	              IF l_oogc.oogc003 >= l_date[10] AND l_oogc.oogc003 <= l_date2[11] THEN
                     LET l_mm = 11
                  END IF
	              IF l_oogc.oogc003 >= l_date[11] AND l_oogc.oogc003 <= l_date2[12] THEN
                     LET l_mm = 12
                  END IF
               END IF
            END IF
            #周奇種類 2.週
            IF g_oogc_m.type = '2' THEN
               #第一季度
               IF l_oogc.oogc003 <= b_date +83 THEN
                  IF l_oogc.oogc003 <= b_date +27 THEN
                     LET l_mm = 1
                  END IF 
	              IF l_oogc.oogc003 <= b_date +55 AND l_oogc.oogc003 >= b_date +28 THEN
	                 LET l_mm = 2
                  END IF
	              IF l_oogc.oogc003 <= b_date +83 AND l_oogc.oogc003 >= b_date +56 THEN
	                 LET l_mm = 3
                  END IF
               END IF 
               #第二季度
               IF l_oogc.oogc003 <= b_date +167 AND l_oogc.oogc003 >= b_date+84 THEN
                  IF l_oogc.oogc003 <= b_date +111 AND l_oogc.oogc003 >= b_date + 84 THEN
	                 LET l_mm = 4
                  END IF 
	              IF l_oogc.oogc003 <= b_date +139 AND l_oogc.oogc003 >= b_date +112 THEN
	                 LET l_mm = 5
                  END IF
	              IF l_oogc.oogc003 <= b_date +167 AND l_oogc.oogc003 >= b_date +140 THEN
  	                 LET l_mm = 6
                  END IF
                END IF 
                #第三季度
                IF l_oogc.oogc003 <= b_date +251 AND l_oogc.oogc003 >= b_date+168 THEN
                   IF l_oogc.oogc003 <= b_date + 195 AND l_oogc.oogc003 >= b_date + 168 THEN
	                 LET l_mm = 7
                   END IF 
	               IF l_oogc.oogc003 <= b_date + 223 AND l_oogc.oogc003 >= b_date + 196 THEN
	                  LET l_mm = 8
                   END IF
	               IF l_oogc.oogc003 <= b_date + 251 AND l_oogc.oogc003 >= b_date + 224 THEN
	                  LET l_mm = 9
                   END IF
                END IF 
                #第四季度
                IF l_oogc.oogc003 <= f_date AND l_oogc.oogc003 >= b_date+252 THEN
                   IF l_oogc.oogc003 <= b_date + 279 AND l_oogc.oogc003 >= b_date + 252 THEN
	                  LET l_mm = 10
                   END IF 
	               IF l_oogc.oogc003 <= b_date + 307 AND l_oogc.oogc003 >= b_date + 280 THEN
	                  LET l_mm = 11
                   END IF
	               IF l_oogc.oogc003 <= b_date + 335 AND l_oogc.oogc003 >= b_date + 308 THEN
	                  LET l_mm = 12
                   END IF
	               IF l_oogc.oogc003 <= f_date   AND l_oogc.oogc003 >= b_date + 336 THEN
	                  LET l_mm = 13
                   END IF
                END IF
            END IF
#            #週期種類 3.445
#            IF g_oogc_m.type = '3' THEN
#               #第一季度
#               IF l_oogc.oogc003 <= b_date +90 THEN
#                  IF l_oogc.oogc003 <= b_date +27 THEN
#                     LET l_mm = 1
#                  END IF 
#                  IF l_oogc.oogc003 <= b_date +55 AND l_oogc.oogc003 >= b_date +28 THEN
#                     LET l_mm = 2
#                  END IF
#                  IF l_oogc.oogc003 <= b_date +90 AND l_oogc.oogc003 >= b_date +56 THEN
#                     LET l_mm = 3
#                  END IF
#               END IF 
#               #第二季度
#               IF l_oogc.oogc003 <= b_date +181 AND l_oogc.oogc003 >= b_date+91 THEN
#                  IF l_oogc.oogc003 <= b_date +118 AND l_oogc.oogc003 >= b_date + 91 THEN
#                     LET l_mm = 4
#                  END IF 
#                  IF l_oogc.oogc003 <= b_date +146 AND l_oogc.oogc003 >= b_date +119 THEN
#                     LET l_mm = 5
#                  END IF
#                  IF l_oogc.oogc003 <= b_date +181 AND l_oogc.oogc003 >= b_date +147 THEN
#                     LET l_mm = 6
#                  END IF
#               END IF 
#               #第三季度
#               IF l_oogc.oogc003 <= b_date +272 AND l_oogc.oogc003 >= b_date+182 THEN
#                  IF l_oogc.oogc003 <= b_date + 209 AND l_oogc.oogc003 >= b_date + 182 THEN
#                     LET l_mm = 7
#                  END IF 
#                  IF l_oogc.oogc003 <= b_date + 237 AND l_oogc.oogc003 >= b_date + 210 THEN
#                     LET l_mm = 8
#                  END IF
#                  IF l_oogc.oogc003 <= b_date + 272 AND l_oogc.oogc003 >= b_date + 238 THEN
#                     LET l_mm = 9
#                  END IF
#               END IF 
#               #第四季度
#               IF l_oogc.oogc003 <= f_date AND l_oogc.oogc003 >= b_date+273 THEN
#                  IF l_oogc.oogc003 <= b_date + 300 AND l_oogc.oogc003 >= b_date + 273 THEN
#                     LET l_mm = 10
#                  END IF 
#                  IF l_oogc.oogc003 <= b_date + 328 AND l_oogc.oogc003 >= b_date + 301 THEN
#                     LET l_mm = 11
#                  END IF
#                  IF l_oogc.oogc003 <= f_date   AND l_oogc.oogc003 >= b_date + 329 THEN
#                     LET l_mm = 12
#                  END IF
#               END IF
#            END IF
            
            LET l_month = MONTH(l_oogc.oogc003)
            
           #月週計算-str------
            LET l_mw_days = DAY(l_oogc.oogc003)
            IF cl_null(g_oogc_m.mw1e) THEN LET g_oogc_m.mw1e = 31 END IF
            IF NOT cl_null(g_oogc_m.mw2b) AND cl_null(g_oogc_m.mw2e) THEN LET g_oogc_m.mw2e = 31 END IF
            IF NOT cl_null(g_oogc_m.mw3b) AND cl_null(g_oogc_m.mw3e) THEN LET g_oogc_m.mw3e = 31 END IF
            IF NOT cl_null(g_oogc_m.mw4b) AND cl_null(g_oogc_m.mw4e) THEN LET g_oogc_m.mw4e = 31 END IF
            IF NOT cl_null(g_oogc_m.mw5b) AND cl_null(g_oogc_m.mw5e) THEN LET g_oogc_m.mw5e = 31 END IF
            IF l_mw_days >= g_oogc_m.mw1b AND l_mw_days <= g_oogc_m.mw1e THEN 
               LET l_mw = 1
            END IF
            IF l_mw_days >= g_oogc_m.mw2b AND l_mw_days <= g_oogc_m.mw2e THEN 
               LET l_mw = 2
            END IF
            IF l_mw_days >= g_oogc_m.mw3b AND l_mw_days <= g_oogc_m.mw3e THEN 
               LET l_mw = 3
            END IF
            IF l_mw_days >= g_oogc_m.mw4b AND l_mw_days <= g_oogc_m.mw4e THEN 
               LET l_mw = 4
            END IF
            IF l_mw_days >= g_oogc_m.mw5b AND l_mw_days <= g_oogc_m.mw5e THEN 
               LET l_mw = 5
            END IF
           #月週計算-end------
            UPDATE oogc_t SET oogc006 = l_mm,
                              oogc007 = l_ss,
                              oogc008 = l_week,
                              oogc016 = l_month,
                              oogc017 = l_mw           #月週計算  
                        WHERE oogc001 = g_oogc_m.oogc001
                          AND oogc002 = g_oogc_m.oogc002
                          AND oogc003 = l_oogc.oogc003
                          AND oogc015 = l_oogc.oogc015
                          AND oogcent = g_enterprise
             IF SQLCA.SQLCODE OR l_success = 'N' THEN
                LET l_success = 'N'
                EXIT FOREACH
             ELSE
                LET l_success = 'Y'
             END IF
         END FOREACH
         #DROP TABLE aooi420_01_tmp    #160914-00032#2
         DELETE FROM aooi420_01_tmp    #160914-00032#2
         #CALL s_transaction_end(l_success,'1')   #160914-00032#2
      END FOR  #160914-00032#2
      DROP TABLE aooi420_01_tmp    #160914-00032#2
      CALL s_transaction_end(l_success,'1')   #160914-00032#2
   END IF
   
   LET INT_FLAG = FALSE
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="aooi420_01.other_dialog" readonly="Y" >}

 
{</section>}
 
{<section id="aooi420_01.other_function" readonly="Y" >}

PRIVATE FUNCTION aooi420_01_days_outside(p_days)
DEFINE p_days  LIKE  type_t.num5
   IF p_days > 31 OR p_days < 1 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'aoo-00256'
      LET g_errparam.extend = p_days
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN FALSE
   END IF
   RETURN TRUE
END FUNCTION

PRIVATE FUNCTION aooi420_01_no_entry()
            IF cl_null(g_oogc_m.mw1e) OR g_oogc_m.mw1e = 31 THEN
               LET g_oogc_m.mw2b = ""
               LET g_oogc_m.mw2e = "" 
               DISPLAY BY NAME g_oogc_m.mw2b,g_oogc_m.mw2e
               CALL cl_set_comp_entry("mw2e",FALSE)
            END IF
            IF cl_null(g_oogc_m.mw2e) OR g_oogc_m.mw2e = 31 THEN
               LET g_oogc_m.mw3b = ""
               LET g_oogc_m.mw3e = "" 
               DISPLAY BY NAME g_oogc_m.mw3b,g_oogc_m.mw3e
               CALL cl_set_comp_entry("mw3e",FALSE)
            END IF

            IF cl_null(g_oogc_m.mw3e) OR g_oogc_m.mw3e = 31 THEN
               LET g_oogc_m.mw4b = ""
               LET g_oogc_m.mw4e = "" 
               DISPLAY BY NAME g_oogc_m.mw4b,g_oogc_m.mw4e
               CALL cl_set_comp_entry("mw4e",FALSE)
            END IF

            IF cl_null(g_oogc_m.mw4e) OR g_oogc_m.mw4e = 31 THEN
               LET g_oogc_m.mw5b = ""
               LET g_oogc_m.mw5e = "" 
               DISPLAY BY NAME g_oogc_m.mw5b,g_oogc_m.mw5e
               CALL cl_set_comp_entry("mw5e",FALSE)
            END IF

END FUNCTION

 
{</section>}
 
