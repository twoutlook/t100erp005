#該程式未解開Section, 採用最新樣板產出!
{<section id="aapr130_x01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:7(2017-01-24 17:40:10), PR版次:0007(2017-01-25 10:41:38)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000074
#+ Filename...: aapr130_x01
#+ Description: ...
#+ Creator....: 05016(2014-12-10 15:37:16)
#+ Modifier...: 06821 -SD/PR- 06821
 
{</section>}
 
{<section id="aapr130_x01.global" readonly="Y" >}
#報表 x01 樣板自動產生(Version:8)
#add-point:填寫註解說明 name="global.memo"

#end add-point
#add-point:填寫註解說明 name="global.memo_customerization"

#end add-point
 
IMPORT os
#add-point:增加匯入項目 name="global.import"
#150902-00001#3   20150904 By apo      增加採購單號/項次/發票號碼
#150924-00012#1   20151001 By Jessy    增加一欄應收帳款單號在單身的最後一欄位,XG報表輸出亦須增加列印
#151019-00009#1   20151021 By Jessy    增加暫估單號顯示,XG報表輸出亦須增加列印
#151028-00011#3   20151102 By RayHuang 修正XG畫面欄位與aapq130相同
#151102-00008#1   20151104 By Jessy    1.增加子件特性,成本分群,增加費用科目欄位,XG報表輸出亦須增加列印 2.增加條件: 己立暫估未立帳款
#151013-00019#9   20151109 By Jessy    調整aapq130 XG列印入庫未稅金額&差異金額與畫面欄位金額不一致
#160414-00018#11  20160513 By albireo  效能調整
#170123-00045#1   20170125 By 06821    SQL中撈取資料時使用 rownum 語法撰寫方式調整
#end add-point
 
SCHEMA ds
 
GLOBALS "../../cfg/top_global.inc"
GLOBALS "../../cfg/top_report.inc"                  #報表使用的global
 
#報表 type 宣告
DEFINE tm RECORD
       wc STRING,                  #where condition 
       a1 LIKE type_t.chr80,         #apcald 
       a2 LIKE type_t.chr80,         #apcacomp 
       a3 LIKE type_t.chr80,         #apcb007 
       a4 LIKE type_t.chr1          #g_aapq130_arg
       END RECORD
 
DEFINE g_str           STRING,                      #列印條件回傳值              
       g_sql           STRING  
 
#add-point:自定義環境變數(Global Variable)(客製用) name="global.variable_customerization"

#end add-point
#add-point:自定義環境變數(Global Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"

#end add-point
 
{</section>}
 
{<section id="aapr130_x01.main" readonly="Y" >}
PUBLIC FUNCTION aapr130_x01(p_arg1,p_arg2,p_arg3,p_arg4,p_arg5)
DEFINE  p_arg1 STRING                  #tm.wc  where condition 
DEFINE  p_arg2 LIKE type_t.chr80         #tm.a1  apcald 
DEFINE  p_arg3 LIKE type_t.chr80         #tm.a2  apcacomp 
DEFINE  p_arg4 LIKE type_t.chr80         #tm.a3  apcb007 
DEFINE  p_arg5 LIKE type_t.chr1         #tm.a4  g_aapq130_arg
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
   
   #end add-point
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 
   ##報表元件執行期間是否有錯誤代碼
   LET g_rep_success = 'Y'
   
   #報表元件代號      
   LET g_rep_code = "aapr130_x01"
   IF cl_null(tm.wc) THEN LET tm.wc = " 1=1" END IF
 
   #create 暫存檔
   CALL aapr130_x01_create_tmptable()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #報表select欄位準備
   CALL aapr130_x01_sel_prep()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #報表insert的prepare
   CALL aapr130_x01_ins_prep()  
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #將資料存入tmptable
   CALL aapr130_x01_ins_data() 
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #將tmptable資料印出
   CALL aapr130_x01_rep_data()
 
END FUNCTION
 
{</section>}
 
{<section id="aapr130_x01.create_tmptable" readonly="Y" >}
PRIVATE FUNCTION aapr130_x01_create_tmptable()
 
   #清除temptable 陣列
   CALL g_rep_tmpname.clear()
   
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.before name="create_tmp.before"
   
   #end add-point:create_tmp.before
 
   #主報表TEMP TABLE的欄位SQL   
   LET g_sql = "pmdtsite.pmdt_t.pmdtsite,pmds007.pmds_t.pmds007,pmds007_desc.type_t.chr100,pmds001.pmds_t.pmds001,l_pmds000.type_t.chr500,pmdtdocno.pmdt_t.pmdtdocno,pmdtseq.pmdt_t.pmdtseq,pmdt006.pmdt_t.pmdt006,pmdt006_desc.type_t.chr500,pmdt006_desc_1.type_t.chr100,l_pmdt005_desc.type_t.chr500,l_imag011.imag_t.imag011,l_imag011_desc.type_t.chr500,l_apcb021.apcb_t.apcb021,l_apcb021_desc.type_t.chr500,pmdt001.pmdt_t.pmdt001,pmdt002.pmdt_t.pmdt002,pmdt050.pmdt_t.pmdt050,pmds002.pmds_t.pmds002,l_pmds002_desc.type_t.chr500,pmds003.pmds_t.pmds003,l_pmds003_desc.type_t.chr500,pmdt016.pmdt_t.pmdt016,l_pmdt016_desc.type_t.chr500,pmdt024.pmdt_t.pmdt024,apcb007.apcb_t.apcb007,pmdt056.pmdt_t.pmdt056,pmdt066.pmdt_t.pmdt066,pmdt069.pmdt_t.pmdt069,l_diffqty.type_t.num20_6,pmds037.pmds_t.pmds037,pmds038.pmds_t.pmds038,pmdt046.pmdt_t.pmdt046,pmdt037.pmdt_t.pmdt037,pmdt036.pmdt_t.pmdt036,l_pmdt038_3.type_t.num20_6,l_pmdt047_3.type_t.num20_6,l_pmdt039_3.type_t.num20_6,pmdt038.pmdt_t.pmdt038,pmdt047.pmdt_t.pmdt047,pmdt039.pmdt_t.pmdt039,l_sumapcb103.type_t.num20_6,l_sumapcb104.type_t.num20_6,l_sumapcb105.type_t.num20_6,l_sfapcb103.type_t.num20_6,l_sfapcb104.type_t.num20_6,l_sfapcb105.type_t.num20_6,l_apcb113.type_t.num20_6,l_apcb114.type_t.num20_6,l_apcb115.type_t.num20_6,l_dapcb103.type_t.num20_6,l_dapcb104.type_t.num20_6,l_dapcb105.type_t.num20_6,pmdt0382.pmdt_t.pmdt038,pmdt0472.pmdt_t.pmdt047,pmdt0392.pmdt_t.pmdt039,l_apcadocno.apca_t.apcadocno,l_apca2.apca_t.apcadocno" 
   
   #建立TEMP TABLE,主報表序號1 
   IF NOT cl_xg_create_tmptable(g_sql,1) THEN
      LET g_rep_success = 'N'            
   END IF
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.after name="create_tmp.after"
   
   #end add-point:create_tmp.after
END FUNCTION
 
{</section>}
 
{<section id="aapr130_x01.ins_prep" readonly="Y" >}
PRIVATE FUNCTION aapr130_x01_ins_prep()
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
             ?,?,?,?,?,?,?,?)"
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
 
{<section id="aapr130_x01.sel_prep" readonly="Y" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION aapr130_x01_sel_prep()
DEFINE g_select      STRING
DEFINE g_from        STRING
DEFINE g_where       STRING
#add-point:sel_prep段define(客製用) name="sel_prep.define_customerization"

#end add-point
#add-point:sel_prep段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="sel_prep.define"
 DEFINE l_field         DYNAMIC ARRAY OF RECORD
                           f11       LIKE type_t.chr100,
                           f21       LIKE type_t.chr100,
                           f31       LIKE type_t.chr100,  #151028-00011#3 add
                           f32       LIKE type_t.chr100,  #151028-00011#3 add
                           f33       LIKE type_t.chr100,  #151028-00011#3 add
                           f34       LIKE type_t.chr100   #151028-00011#3 add  
                          END RECORD
DEFINE l_ld_type        LIKE type_t.chr1
DEFINE l_pmds000_str1   STRING   #150702-00001#1 add
#end add-point
 
   #add-point:sel_prep before name="sel_prep.before"
   
   #end add-point
 
   #add-point:sel_prep g_select name="sel_prep.g_select"
 
#   #end add-point
#   LET g_select = " SELECT pmdtsite,pmds007,'',pmds001,'',pmdtdocno,pmdtseq,pmdt006,'','','','','','', 
#       '',pmdt001,pmdt002,pmdt050,pmds002,'',pmds003,'',pmdt016,'',pmdt024,'',pmdt056,pmdt066,pmdt069, 
#       '',pmds037,pmds038,pmdt046,pmdt037,pmdt036,'','','',pmdt038,'',pmdt039,'','','','','','','','', 
#       '','','','','','','','',''"
# 
#   #add-point:sel_prep g_from name="sel_prep.g_from"
 
#   #end add-point
#    LET g_from = " FROM pmds_t,pmdt_t"
# 
#   #add-point:sel_prep g_where name="sel_prep.g_where"
 
#   #end add-point
#    LET g_where = " WHERE " ,tm.wc CLIPPED
# 
#   #add-point:sel_prep g_order name="sel_prep.g_order"
   
   #end add-point
 
   #add-point:sel_prep.sql.before name="sel_prep.sql.before"
 
#   #end add-point:sel_prep.sql.before
#   LET g_where = g_where ,cl_sql_add_filter("pmds_t")   #資料過濾功能
#   LET g_sql = g_select CLIPPED ," ",g_from CLIPPED ," ",g_where CLIPPED
#   LET g_sql = cl_sql_add_mask(g_sql)    #遮蔽特定資料, 若寫至add-point也需複製此段
# 
#   #add-point:sel_prep.sql.after name="sel_prep.sql.after"
   #160414-00018#11 -----s
   LET g_sql = "SELECT gzcb004 FROM gzcb_t ",
               " WHERE gzcb001 = '2060' ",
               "   AND gzcb002 = ? "
   PREPARE pmds000_chk_pre FROM g_sql
   #160414-00018#11 -----e
   
   CALL s_fin_get_ld_type(tm.a1) RETURNING l_ld_type
   LET l_field[1].f11 = "pmdt056"   LET l_field[2].f11 = "pmdt057"   LET l_field[3].f11 = "pmdt058"   #請款數量   
   LET l_field[1].f21 = "pmdt066"   LET l_field[2].f21 = "pmdt067"   LET l_field[3].f21 = "pmdt068"   #暫估數量  
   #151028-00011#3---s
   LET l_field[1].f31 = "pmdt0562"   LET l_field[2].f31 = "pmdt0562"   LET l_field[3].f31 = "pmdt0562"   #立帳數  
   LET l_field[1].f32 = "sumapcb103" LET l_field[2].f32 = "sumapcb103" LET l_field[3].f32 = "sumapcb103"   #立帳原幣未稅
   LET l_field[1].f33 = "sumapcb104" LET l_field[2].f33 = "sumapcb104" LET l_field[3].f33 = "sumapcb104"   #立帳原幣稅
   LET l_field[1].f34 = "sumapcb105" LET l_field[2].f34 = "sumapcb105" LET l_field[3].f34 = "sumapcb105"   #立帳原幣含稅
   #第4個放aapq130
   LET l_field[4].f11 = "pmdt069" LET l_field[4].f21 = '0'
   LET l_field[4].f31 = "apba010" LET l_field[4].f32 = 'apba103'
   LET l_field[4].f33 = "apba104" LET l_field[4].f34 = 'apba105'
   #151028-00011#3---e
   
   #150702-00001#1-----s
   LET l_pmds000_str1 = s_aap_get_acc_str('2060',"(gzcb003 = 'Y' OR gzcb005 = '2')")
   LET l_pmds000_str1 = s_fin_get_wc_str(l_pmds000_str1)
   #150702-00001#1-----e
   #151028-00011#3---Mark start
  #LET g_sql = "SELECT    pmdtsite,pmds007,'',pmds000,pmdtdocno,pmdtseq,pmdt006,'','',pmdt001,pmdt024, ",                   #150902-00001#3 mark
#   LET g_sql = "SELECT    pmdtsite,pmds007,'',pmds000,pmdtdocno,pmdtseq,pmdt006,'','',pmdt001,pmdt002,pmdt050,pmdt024, ",   #150902-00001#3
#               "       apcb007,pmdt066,pmdt069,pmds037,pmds038,pmdt046,pmdt037,pmdt036,pmdt038,0,pmdt039, ",
#               "       pmdt0382,0,pmdt0392,'','' ",                                                                         #150924-00012#1 add apcadocno   #151019-00009#1 add apca2
#               "  FROM (",
#              #"       SELECT pmdtsite,pmds007,pmds000,pmdtdocno,pmdtseq,pmdt006,pmdt001,pmdt024, ",                   #150902-00001#3 mark
#               "       SELECT pmdtsite,pmds007,pmds000,pmdtdocno,pmdtseq,pmdt006,pmdt001,pmdt002,pmdt050,pmdt024, ",   #150902-00001#3
#               "              COALESCE(pmdt024,0) - COALESCE(",l_field[l_ld_type].f11,",0) apcb007, ",
#               "            ",l_field[l_ld_type].f21," pmdt066, ",
#               "              pmdt069,pmds037,pmds038,pmdt046,pmdt037,pmdt036,pmdt038,pmdt039, ",
#               "              pmdt038*pmds038 pmdt0382,pmdt039*pmds038 pmdt0392 ",
#               "         FROM pmds_t,pmdt_t LEFT OUTER JOIN pmdl_t ON pmdlent = pmdtent AND pmdldocno = pmdt001 ",
#               "        WHERE pmdsent = pmdtent AND pmdt084 ='Y' AND pmdsent = '",g_enterprise,"' ",
#               "          AND pmdsdocno = pmdtdocno ",
#               #"          AND pmds000 IN ('3','4','5','6','7','10','11','12','13','14','15','22','24','25','26','20') ", #150702-00001#1 mark  #150629-00038#1 add 20~26       #pmds000:SCC-2060
#               "          AND pmds000 IN ",l_pmds000_str1 CLIPPED,   #150702-00001#1 add
#               "          AND pmdsstus = 'S' ",                         #只抓入庫/且過帳
#               "          AND pmdsent= '",g_enterprise,"' ",
#               "          AND " ,tm.wc CLIPPED,") "
   #151028-00011#3---Mark 
   
   #151028-00011---add start
   LET g_sql = 
       "SELECT pmdtsite,pmds007,",
              "(SELECT ts07.pmaal004 FROM pmaal_t ts07 WHERE pmaalent = ",g_enterprise," AND ts07.pmaal001 = pmds007 AND ts07.pmaal002 = '",g_dlang,"'),",     #160414-00018#11  add
              "pmds001,pmds000,pmdtdocno,pmdtseq,pmdt006,",
              "(SELECT tt06.imaal003 FROM imaal_t tt06 WHERE tt06.imaalent = ",g_enterprise," AND tt06.imaal001 = pmdt006 AND tt06.imaal002 = '",g_dlang,"'),",#160414-00018#11  add
              "(SELECT tt062.imaal004 FROM imaal_t tt062 WHERE tt062.imaalent = ",g_enterprise," AND tt062.imaal001 = pmdt006 AND tt062.imaal002 = '",g_dlang,"'),",#160414-00018#11  add
              "pmdt005,",#151102-00008#1 add pmdt005
              "(SELECT imag011 FROM imag_t WHERE imagent = ",g_enterprise," AND imagsite = '",tm.a2,"' AND imag001 = pmdt006) ,",#160414-00018#11  add
              "'',",
              #170123-00045#1 --s mark
              #" (SELECT apcb021 FROM apca_t LEFT OUTER JOIN apcb_t ON apcbent = apcaent AND apcbld = apcald AND apcbdocno = apcadocno AND apcb023 <> 'Y'",  #160414-00018#11  add
              # " WHERE apcaent = ",g_enterprise," AND apcald = '",tm.a1,"' AND apcastus <> 'X'", #160414-00018#11  add
              #   " AND apcb002 = pmdtdocno AND apcb003 = pmdtseq AND rownum = 1), ",    #160414-00018#11  add
              #" (SELECT glacl004 FROM glacl_t,glaa_t WHERE glaclent = pmdtent AND glacl001 = glaa004 ",   #160414-00018#11  add
              #   " AND glacl002 = ((SELECT apcb021 FROM apca_t LEFT OUTER JOIN apcb_t ON apcbent = apcaent AND apcbld = apcald AND apcbdocno = apcadocno AND apcb023 <> 'Y'",  #160414-00018#11  add
              # " WHERE apcaent = ",g_enterprise," AND apcald = '",tm.a1,"' AND apcastus <> 'X'",    #160414-00018#11  add
              #   " AND apcb002 = pmdtdocno AND apcb003 = pmdtseq AND rownum = 1)) ",       #160414-00018#11  add
              #   " AND glacl003 = '",g_dlang,"' AND glaald = '",tm.a1,"' AND glaaent = glaclent),",    #160414-00018#11  add
              #170123-00045#1 --e mark
              "'','', ", #170123-00045#1 add
             "pmdt001,pmdt002,pmdt050, ",   
              "CASE WHEN pmdl002 IS NOT NULL THEN pmdl002 ELSE pmds002 END pmds002,",       
             " CASE WHEN pmdl002 IS NOT NULL THEN (SELECT ooag011 FROM ooag_t WHERE ooagent = ",g_enterprise," AND ooag001 = pmdl002) ",   #160414-00018#11  add
                  " ELSE (SELECT ooag011 FROM ooag_t WHERE ooagent = ",g_enterprise," AND ooag001 = pmds002) END, ",   #160414-00018#11  add
              "CASE WHEN pmdl003 IS NOT NULL THEN pmdl003 ELSE pmds003 END pmds003,",    #無採購單者改取入庫部門
             " CASE WHEN pmdl003 IS NOT NULL THEN (SELECT ooefl003 FROM ooefl_t WHERE ooeflent = ",g_enterprise," AND ooefl001 = pmdl003 AND ooefl002 = '",g_dlang,"') ",  #160414-00018#11  add
                  " ELSE (SELECT ooefl003 FROM ooefl_t WHERE ooeflent = ",g_enterprise," AND ooefl001 = pmds003 AND ooefl002 = '",g_dlang,"') END,",   #160414-00018#11  add
              "pmdt016,",
             " (SELECT inayl003 FROM inay_t LEFT OUTER JOIN inayl_t ON inayent = inaylent AND inay001 = inayl001 AND inayl002 = '",g_dlang,"' ",   #160414-00018#11  add
               "   WHERE inayent = ",g_enterprise," AND inay001 = pmdt016), ",   #160414-00018#11  add
              "pmdt024,apcb007,pmdt0562,(pmdt066-apcfminus),pmdt069,0,pmds037,pmds038,pmdt046,",       
              "pmdt037,pmdt036,pmdt038,pmdt047,pmdt039,pmdt038,0,pmdt039,sumapcb103,sumapcb104,sumapcb105,",                                     
              "sfapcb103,sfapcb104,sfapcb105,apcb113,apcb114,apcb115,0,0,0,pmdt0382,0,pmdt0392,",
###160414-00018#11 -----s
               #170123-00045#1 --s mark
               #" (SELECT apcadocno FROM apca_t,apcb_t ",
               #  " WHERE apcaent = ",g_enterprise," AND apcbent = apcaent AND apcbld = apcald AND apcbdocno = apcadocno ",
               #    " AND apcald = '",tm.a1,"' AND apca001 NOT IN('01','02','03','04') ",
               #    " AND apcb002 = pmdtdocno AND apcb003 = pmdtseq AND rownum = 1 ",
               #    " AND apcastus <> 'X'), ",
               #" (SELECT apcadocno FROM apca_t,apcb_t ",
               #  " WHERE apcaent = ",g_enterprise," AND apcbent = apcaent AND apcbld = apcald AND apcbdocno = apcadocno ",
               #    " AND apcald = '",tm.a1,"' AND apca001 IN ('01','02','03','04') ",
               #    " AND apcb002 = pmdtdocno AND apcb003 = pmdtseq AND rownum = 1 ",
               #    " AND apcastus <> 'X') ",
               #170123-00045#1 --e mark
               "'','' ", #170123-00045#1 add
              #"'',''",
###160414-00018#11 -----e
               "  FROM (",
                     " SELECT pmdtsite,pmds007,pmds000,pmdtdocno,pmdtseq,pmdt006,pmdt005,pmdt001,pmdt002,pmdt050,pmdt024, ",    #151102-00008#1 add pmdt005
                            " pmdl002,pmdl003,pmds002,pmds003,pmdt016,", 
                            " COALESCE(pmdt024,0) - COALESCE(",l_field[l_ld_type].f11,",0) apcb007,",
                          " ",l_field[l_ld_type].f21," pmdt066,",
                            " pmdt069,pmds037,pmds038,pmdt046,pmdt037,pmdt036,pmdt038,pmdt039,",
                            " pmdt038*pmds038 pmdt0382,pmdt039*pmds038 pmdt0392,pmdtent,",     
                            " pmds001,",
                            " COALESCE(",l_field[l_ld_type].f31,",0) pmdt0562,COALESCE(apcfminus,0) apcfminus,",   
                            " pmdt047,COALESCE(",l_field[l_ld_type].f32,",0) sumapcb103,",
                            " COALESCE(",l_field[l_ld_type].f33,",0) sumapcb104,",
                            " COALESCE(",l_field[l_ld_type].f34,",0) sumapcb105,",                                 
                            " (COALESCE(sfapcb103a,0)-COALESCE(sfapcb103b,0)) sfapcb103,", 
                            " (COALESCE(sfapcb104a,0)-COALESCE(sfapcb104b,0)) sfapcb104,", 
                            " (COALESCE(sfapcb105a,0)-COALESCE(sfapcb105b,0)) sfapcb105, ",
                            " COALESCE(apcb113,0) apcb113,COALESCE(apcb114,0) apcb114,COALESCE(apcb115,0) apcb115 ",
                       " FROM pmds_t,pmdt_t LEFT OUTER JOIN pmdl_t ON pmdlent = pmdtent AND pmdldocno = pmdt001 ",
               #立帳數量/金額取得
                       " LEFT OUTER JOIN( ",
                          " SELECT apcbent,apcb002,apcb003,SUM(apcb007) pmdt0562, ",
                                 " SUM(apcb103) sumapcb103,SUM(apcb104) sumapcb104,SUM(apcb105) sumapcb105,",
                                 " SUM(apcb113) apcb113,SUM(apcb114) apcb114,SUM(apcb115) apcb115 ",
                            " FROM apcb_t,apca_t ",
                           " WHERE apcbent = apcaent ",
                             " AND apcbld  = apcald  ",
                             " AND apcbdocno = apcadocno ",
                             " AND apca001 IN ('13','17','22') ",
                             " AND apcastus <> 'X' ",
                           " GROUP BY apcbent,apcb002,apcb003 ",
                                      " ) ON apcbent = pmdtent AND apcb002 = pmdtdocno AND apcb003 = pmdtseq ",
               #已沖暫估量/金額取得
                       " LEFT OUTER JOIN( ",
                          " SELECT apcbent,apcb002,apcb003,0 apcfminus1, ",                                        
                                 " sum(apcf103) sfapcb103b,sum(apcf104) sfapcb104b,sum(apcf105) sfapcb105b ",
                            " FROM apca_t a,apcf_t,apca_t b,apcb_t ",
                           " WHERE a.apcald = apcfld AND a.apcaent = apcfent AND a.apcadocno = apcfdocno ",
                             " AND a.apcastus = 'Y' ",
                             " AND b.apcadocno = apcf008 ",
                             " AND apcbseq = apcf009 ",
                             " AND b.apcald = apcfld ",
                             " AND b.apcaent = apcfent ",
                             " AND b.apcaent = apcbent ",
                             " AND b.apcald = apcbld ",
                             " AND b.apcadocno = apcbdocno ",
                             " AND b.apcastus = 'Y' ",
                             " AND b.apca001 IN ('01','02','03','04') ",
                           " GROUP BY apcb002,apcb003,apcbent ",
                                        " ) s2 ON s2.apcbent = pmdtent AND s2.apcb002 = pmdtdocno AND s2.apcb003 = pmdtseq ",
               #暫估金額取得
                       " LEFT OUTER JOIN( ",
                           " SELECT apcbent,apcb002,apcb003,SUM(apcb103) sfapcb103a,SUM(apcb104) sfapcb104a,SUM(apcb105) sfapcb105a ",
                             " FROM apcb_t,apca_t ",
                            " WHERE apcaent = apcbent AND apcald = apcbld AND apcadocno = apcbdocno ",
                              " AND apcastus = 'Y' AND apca001 IN('01','02','03','04') ",
                            " GROUP BY apcbent,apcb002,apcb003 ",               
                                      " ) s3 ON s3.apcbent = pmdtent AND s3.apcb002 = pmdtdocno AND s3.apcb003 = pmdtseq ",
               #aapq140的立帳數量立帳金額
                       " LEFT OUTER JOIN( ",
                           " SELECT apbaent,apba005,apba006,",
                                  " SUM(apba010) apba010,SUM(apba103) apba103,SUM(apba104) apba104,SUM(apba105) apba105 ",
                             " FROM apba_t,apbb_t " ,
                            " WHERE apbaent = apbbent ",
                              " AND apbbstus = 'Y' ",
                              " AND apbadocno = apbbdocno ",
                            " GROUP BY apbaent,apba005,apba006 ",
                                      " ) s4 ON s4.apbaent = pmdtent AND s4.apba005 = pmdtdocno AND s4.apba006 = pmdtseq ",
               #暫估數量
                       " LEFT OUTER JOIN( ",
                           " SELECT apcbent,apcb002,apcb003,SUM(apcb007) apcfminus ",
                             " FROM apcb_t,apca_t ",
                            " WHERE apcaent = apcbent AND apcald = apcbld AND apcadocno = apcbdocno ",
                              " AND apcastus = 'Y' AND apca001 NOT IN('01','02','03','04') ",
                              " AND apcb023 = 'Y'  AND apcald = '",tm.a1,"'",
                            " GROUP BY apcbent,apcb002,apcb003 ",               
                                      " ) s5 ON s5.apcbent = pmdtent AND s5.apcb002 = pmdtdocno AND s5.apcb003 = pmdtseq ",
                      " WHERE pmdsent = pmdtent AND pmdt084 ='Y' AND pmdsent = '",g_enterprise,"' ", 
                        " AND pmdsdocno = pmdtdocno ",
                        " AND pmds000 IN ",l_pmds000_str1 CLIPPED,   
                        " AND pmdsstus = 'S' ",                         
                        " AND pmdsent= '",g_enterprise,"' ",
                        " AND " ,tm.wc CLIPPED,") "
   #151028-00011#3---add end
   CASE tm.a3
      #未匹配
      WHEN '1' LET g_sql = g_sql," WHERE apcb007 <> 0 "
      #已匹配
      WHEN '2' LET g_sql = g_sql," WHERE apcb007 = 0 "
      #全部
      WHEN '3' LET g_sql = g_sql," WHERE 1 = 1 "
      #已立暫估未立帳款
      WHEN '4' LET g_sql = g_sql," WHERE apcb007 <> 0 AND (pmdt066 - apcfminus) > 0 "    #151102-00008#1
   END CASE         
   
#   LET g_sql = g_sql , " ORDER BY pmdtseq "   #151028-00011#3 Mark
   
   #151028-00011#3---s
   IF tm.a4 = '1' THEN
      LET g_sql = g_sql CLIPPED,
                  " AND EXISTS(SELECT 1 FROM ooef_t WHERE ooefent = pmdtent AND ooef001 = pmdtsite AND ooef017 = '",tm.a2,"') "
   END IF
   LET g_sql = g_sql," AND pmdtsite IS NOT NULL ",
                     " ORDER BY pmds000,pmdtdocno,pmdtseq "
   #151028-00011#3---e
   #end add-point
   PREPARE aapr130_x01_prepare FROM g_sql
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'prepare:'
      LET g_errparam.code   = STATUS
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET g_rep_success = 'N' 
   END IF
   DECLARE aapr130_x01_curs CURSOR FOR aapr130_x01_prepare
 
END FUNCTION
 
{</section>}
 
{<section id="aapr130_x01.ins_data" readonly="Y" >}
PRIVATE FUNCTION aapr130_x01_ins_data()
DEFINE sr RECORD 
   pmdtsite LIKE pmdt_t.pmdtsite, 
   pmds007 LIKE pmds_t.pmds007, 
   pmds007_desc LIKE type_t.chr100, 
   pmds001 LIKE pmds_t.pmds001, 
   l_pmds000 LIKE type_t.chr500, 
   pmdtdocno LIKE pmdt_t.pmdtdocno, 
   pmdtseq LIKE pmdt_t.pmdtseq, 
   pmdt006 LIKE pmdt_t.pmdt006, 
   pmdt006_desc LIKE type_t.chr500, 
   pmdt006_desc_1 LIKE type_t.chr100, 
   l_pmdt005_desc LIKE type_t.chr500, 
   l_imag011 LIKE imag_t.imag011, 
   l_imag011_desc LIKE type_t.chr500, 
   l_apcb021 LIKE apcb_t.apcb021, 
   l_apcb021_desc LIKE type_t.chr500, 
   pmdt001 LIKE pmdt_t.pmdt001, 
   pmdt002 LIKE pmdt_t.pmdt002, 
   pmdt050 LIKE pmdt_t.pmdt050, 
   pmds002 LIKE pmds_t.pmds002, 
   l_pmds002_desc LIKE type_t.chr500, 
   pmds003 LIKE pmds_t.pmds003, 
   l_pmds003_desc LIKE type_t.chr500, 
   pmdt016 LIKE pmdt_t.pmdt016, 
   l_pmdt016_desc LIKE type_t.chr500, 
   pmdt024 LIKE pmdt_t.pmdt024, 
   apcb007 LIKE apcb_t.apcb007, 
   pmdt056 LIKE pmdt_t.pmdt056, 
   pmdt066 LIKE pmdt_t.pmdt066, 
   pmdt069 LIKE pmdt_t.pmdt069, 
   l_diffqty LIKE type_t.num20_6, 
   pmds037 LIKE pmds_t.pmds037, 
   pmds038 LIKE pmds_t.pmds038, 
   pmdt046 LIKE pmdt_t.pmdt046, 
   pmdt037 LIKE pmdt_t.pmdt037, 
   pmdt036 LIKE pmdt_t.pmdt036, 
   l_pmdt038_3 LIKE type_t.num20_6, 
   l_pmdt047_3 LIKE type_t.num20_6, 
   l_pmdt039_3 LIKE type_t.num20_6, 
   pmdt038 LIKE pmdt_t.pmdt038, 
   pmdt047 LIKE pmdt_t.pmdt047, 
   pmdt039 LIKE pmdt_t.pmdt039, 
   l_sumapcb103 LIKE type_t.num20_6, 
   l_sumapcb104 LIKE type_t.num20_6, 
   l_sumapcb105 LIKE type_t.num20_6, 
   l_sfapcb103 LIKE type_t.num20_6, 
   l_sfapcb104 LIKE type_t.num20_6, 
   l_sfapcb105 LIKE type_t.num20_6, 
   l_apcb113 LIKE type_t.num20_6, 
   l_apcb114 LIKE type_t.num20_6, 
   l_apcb115 LIKE type_t.num20_6, 
   l_dapcb103 LIKE type_t.num20_6, 
   l_dapcb104 LIKE type_t.num20_6, 
   l_dapcb105 LIKE type_t.num20_6, 
   pmdt0382 LIKE pmdt_t.pmdt038, 
   pmdt0472 LIKE pmdt_t.pmdt047, 
   pmdt0392 LIKE pmdt_t.pmdt039, 
   l_apcadocno LIKE apca_t.apcadocno, 
   l_apca2 LIKE apca_t.apcadocno
 END RECORD
#add-point:ins_data段define (客製用) name="ins_data.define_customerization"

#end add-point
#add-point:ins_data段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ins_data.define"
DEFINE l_glaa001       LIKE glaa_t.glaa001
DEFINE l_nouse         LIKE type_t.num20_6
DEFINE l_pmdtcomp      LIKE apca_t.apcacomp    #入庫單據點所屬法人
DEFINE l_pmdtld        LIKE apca_t.apcald      #入庫單據點帳套  
DEFINE l_pmdwdocno     LIKE pmdw_t.pmdwdocno   #150902-00001#3
DEFINE l_ld_type       LIKE type_t.chr1        #151028-00011#3
DEFINE l_pmds000_desc  LIKE type_t.chr500      #151028-00011#3
DEFINE l_sql           STRING                  #170123-00045#1 add
#end add-point
 
    #add-point:ins_data段before name="ins_data.before"
    #取得帳套類型
    CALL s_ld_sel_glaa(tm.a1,'glaa001') RETURNING g_sub_success,l_glaa001
    CALL s_fin_get_ld_type(tm.a1)       RETURNING l_ld_type
    
    #170123-00045#1 --s add
    LET l_sql = " SELECT apcb021 FROM apca_t ",
                "   LEFT OUTER JOIN apcb_t ON apcbent = apcaent AND apcbld = apcald AND apcbdocno = apcadocno AND apcb023 <> 'Y' ",
                "  WHERE apcaent = ",g_enterprise," AND apcald = '",tm.a1,"' AND apcastus <> 'X' ",
                "    AND apcb002 = ? AND apcb003 = ? "
    PREPARE aapr130_x01_apcb021p FROM l_sql
    DECLARE aapr130_x01_apcb021c SCROLL CURSOR FOR aapr130_x01_apcb021p      
    
    LET l_sql = " SELECT glacl004 FROM glacl_t,glaa_t WHERE glaclent = ",g_enterprise,"  AND glaclent = glaaent AND glacl001 = glaa004 ",  
                "    AND glacl002 = (SELECT apcb021 FROM apca_t LEFT OUTER JOIN apcb_t ON apcbent = apcaent AND apcbld = apcald AND apcbdocno = apcadocno AND apcb023 <> 'Y'", 
                "                     WHERE apcaent = ",g_enterprise," AND apcald = '",tm.a1,"' AND apcastus <> 'X' AND apcb002 = ? AND apcb003 = ? ) ",     
                "    AND glacl003 = '",g_dlang,"' AND glaald = '",tm.a1,"' "    
    PREPARE aapr130_x01_apcb021dp FROM l_sql
    DECLARE aapr130_x01_apcb021dc SCROLL CURSOR FOR aapr130_x01_apcb021dp    
    
    LET l_sql = " SELECT apcadocno FROM apca_t,apcb_t ",
                "  WHERE apcaent = ",g_enterprise," AND apcbent = apcaent AND apcbld = apcald AND apcbdocno = apcadocno ",
                "    AND apcald = '",tm.a1,"' AND apca001 NOT IN('01','02','03','04') ",
                "    AND apcb002 = ? AND apcb003 = ? AND apcastus <> 'X' "
    PREPARE aapr130_x01_docno1p FROM l_sql
    DECLARE aapr130_x01_docno1c SCROLL CURSOR FOR aapr130_x01_docno1p       
    
    LET l_sql = " SELECT apcadocno FROM apca_t,apcb_t ",
                "  WHERE apcaent = ",g_enterprise," AND apcbent = apcaent AND apcbld = apcald AND apcbdocno = apcadocno ",
                "    AND apcald = '",tm.a1,"' AND apca001 IN ('01','02','03','04') ",
                "    AND apcb002 = ? AND apcb003 = ? AND apcastus <> 'X' "
    PREPARE aapr130_x01_docno2p FROM l_sql
    DECLARE aapr130_x01_docno2c SCROLL CURSOR FOR aapr130_x01_docno2p       
    #170123-00045#1 --e add 
    #end add-point
 
    LET g_rep_success = 'Y'
 
    FOREACH aapr130_x01_curs INTO sr.*                               
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
       #151028-00011#3---s
       #入庫單所屬法人/帳套與帳務中心所屬法人/帳套不同者剔除  tm.a1--> 帳套 tm.a2-->法人
#       CALL s_fin_orga_get_comp_ld(sr.pmdtsite) RETURNING g_sub_success,g_errno,l_pmdtcomp,l_pmdtld
#       IF l_pmdtcomp <> tm.a2 OR l_pmdtld <> tm.a1 THEN
#          CONTINUE FOREACH
#       END IF
       #MARK原因---同aapq130
       #1.所屬法人必須依照單頭顯示法人抓取改到主sql與單頭單號中
       #2.不需比較帳別,因其可以設定為帳務中心底下法人的非主帳套
       #EX.
       #帳務中心X
       #    -A法人
       #          -A1帳(主帳套)
       #          -A2帳
       #    -B法人
       #          -B1
       #    -C法人
       #          -C1
       # 若aapq130設定  帳務中心X   A2帳    A法人
       # 此時會因為不為主帳套資料被篩掉
       
       #170123-00045#1 --s add
       #費用科目
       LET sr.l_apcb021 = ''
       OPEN aapr130_x01_apcb021c USING sr.pmdtdocno,sr.pmdtseq
       FETCH FIRST aapr130_x01_apcb021c INTO sr.l_apcb021
       CLOSE aapr130_x01_apcb021c      
       
       #科目說明
       LET sr.l_apcb021_desc = ''
       OPEN aapr130_x01_apcb021dc USING sr.pmdtdocno,sr.pmdtseq
       FETCH FIRST aapr130_x01_apcb021dc INTO sr.l_apcb021_desc
       CLOSE aapr130_x01_apcb021dc      
       
       #應付帳款單號
       LET sr.l_apcadocno = ''
       OPEN aapr130_x01_docno1c USING sr.pmdtdocno,sr.pmdtseq
       FETCH FIRST aapr130_x01_docno1c INTO sr.l_apcadocno
       CLOSE aapr130_x01_docno1c      
       
       #帳款單號
       LET sr.l_apca2 = ''
       OPEN aapr130_x01_docno2c USING sr.pmdtdocno,sr.pmdtseq
       FETCH FIRST aapr130_x01_docno2c INTO sr.l_apca2
       CLOSE aapr130_x01_docno2c         
       #170123-00045#1 --e add        
       
       #aapq140不用這些欄位所以給0,避免後續計算錯誤
       #立帳數量,暫估數量,暫估金額,立帳本幣額 = 0
       IF l_ld_type = '4' THEN
          LET sr.l_sfapcb103 = 0
          LET sr.l_sfapcb104 = 0
          LET sr.l_sfapcb105 = 0  
          LET sr.l_apcb113   = 0
          LET sr.l_apcb114   = 0
          LET sr.l_apcb115   = 0
          LET sr.pmdt056     = 0
          LET sr.pmdt066     = 0
       END IF

       #SA提醒前端可能把尾差攤到單身去,因此要讓計算一致
       #所以當計價數量=未匹配數量時
       #要把入庫金額帶入未匹配金額
       IF sr.pmdt024 = sr.apcb007 THEN    
          LET sr.l_pmdt038_3 =  sr.pmdt038 
          LET sr.l_pmdt047_3 =  sr.pmdt047
          LET sr.l_pmdt039_3 =  sr.pmdt039
       END IF
       #151028-00011#3---e
       
       #計價數量 <> 未匹配數量才重計金額
       IF sr.pmdt024 <> sr.apcb007 THEN
          #金額 = 數量 * 單價
          LET sr.pmdt038 = sr.apcb007 * sr.pmdt036
          CALL s_tax_count(tm.a2,sr.pmdt046,sr.pmdt038,sr.apcb007,sr.pmds037,sr.pmds038)
               RETURNING sr.pmdt038,l_nouse,sr.pmdt039,
                         sr.pmdt0382,l_nouse,sr.pmdt0392
       END IF
            
       #本幣未稅金額取位
       IF cl_null(sr.pmdt0382) THEN LET sr.pmdt0382 = 0 END IF
       IF NOT cl_null(tm.a1) AND NOT cl_null(l_glaa001)THEN
          CALL s_curr_round_ld('1',tm.a1,l_glaa001,sr.pmdt0382,2) RETURNING g_sub_success,g_errno,sr.pmdt0382
       END IF
       #本幣含稅金額取位
       IF cl_null(sr.pmdt0392) THEN LET sr.pmdt0392 = 0 END IF
       IF NOT cl_null(tm.a1) AND NOT cl_null(l_glaa001)THEN
          CALL s_curr_round_ld('1',tm.a1,l_glaa001,sr.pmdt0392,2) RETURNING g_sub_success,g_errno,sr.pmdt0392
       END IF
       LET sr.pmdt047 = sr.pmdt039 - sr.pmdt038
       LET sr.pmdt0472 = sr.pmdt0392 - sr.pmdt0382
       #入庫單性質為7:倉退單者,數量及金額以負數呈現
       #IF sr.l_pmds000 = '7' OR sr.l_pmds000 MATCHES '1[459]' THEN   #albireo 150630 add 19
       #IF s_aap_pmds000_chk('3',sr.l_pmds000) THEN                   #160414-00018#11 mark
       IF aapr130_x01_pmds000_chk('3',sr.l_pmds000) THEN                    #160414-00018#11        
          LET sr.pmdt024 = sr.pmdt024 * -1
          LET sr.apcb007 = sr.apcb007 * -1
          LET sr.pmdt066 = sr.pmdt066 * -1
          LET sr.pmdt069 = sr.pmdt069 * -1
          LET sr.pmdt038 = sr.pmdt038 * -1
          LET sr.pmdt047 = sr.pmdt047 * -1
          LET sr.pmdt039 = sr.pmdt039 * -1
          LET sr.pmdt0382 = sr.pmdt0382 * -1
          LET sr.pmdt0472 = sr.pmdt0472 * -1
          LET sr.pmdt0392 = sr.pmdt0392 * -1
          #151028-00011#3---s
          LET sr.pmdt056    =  sr.pmdt056 * -1
          LET sr.pmdt038    = sr.pmdt038 * -1
          LET sr.pmdt047    = sr.pmdt047 * -1
          LET sr.pmdt039    = sr.pmdt039 * -1 
          LET sr.l_sumapcb103 = sr.l_sumapcb103 * -1
          LET sr.l_sumapcb104= sr.l_sumapcb104 * -1
          LET sr.l_sumapcb105 = sr.l_sumapcb105 * -1   
          LET sr.l_sfapcb103 = sr.l_sfapcb103 * -1
          LET sr.l_sfapcb104= sr.l_sfapcb104 * -1
          LET sr.l_sfapcb105 = sr.l_sfapcb105 * -1  
          LET sr.l_apcb113 = sr.l_apcb113 * -1
          LET sr.l_apcb114= sr.l_apcb114 * -1
          LET sr.l_apcb115 = sr.l_apcb115 * -1          
          #151028-00011#3---e
       END IF 
       
       ##160414-00018#11 mark-----s
       #LET sr.pmds007_desc = s_desc_get_trading_partner_abbr_desc(sr.pmds007)
       ##料號/品名/規格
       #IF NOT cl_null(sr.pmdt006) THEN
       #   CALL s_desc_get_item_desc(sr.pmdt006)RETURNING sr.pmdt006_desc,sr.pmdt006_desc_1
       #END IF           
       ##160414-00018#11 mark-----e
       #151028-00011#3---s
       #差異數量
       LET sr.l_diffqty = sr.pmdt024 - sr.apcb007 - sr.pmdt056 - sr.pmdt066
       #差異金額
       #入库金额－未批配金额－正常立账金额－暂估立账金额 
       LET sr.l_dapcb103 = sr.l_pmdt038_3 - sr.pmdt038 - sr.l_sumapcb103 - sr.l_sfapcb103  #151013-00019#9 調整為入库金额－未批配金额
       LET sr.l_dapcb104 = sr.l_pmdt047_3 - sr.pmdt047 - sr.l_sumapcb104 - sr.l_sfapcb104  #151013-00019#9 調整為入库金额－未批配金额
       LET sr.l_dapcb105 = sr.l_pmdt039_3 - sr.pmdt039 - sr.l_sumapcb105 - sr.l_sfapcb105  #151013-00019#9 調整為入库金额－未批配金额                                
       #151028-00011#3---e
       
       
       #albireo 150827----s
       IF cl_null(sr.apcb007   )THEN LET sr.apcb007    = 0 END IF
       IF cl_null(sr.pmdt066   )THEN LET sr.pmdt066    = 0 END IF
       IF cl_null(sr.pmdt069   )THEN LET sr.pmdt069    = 0 END IF
       IF cl_null(sr.pmds037   )THEN LET sr.pmds037    = 0 END IF
       IF cl_null(sr.pmds038   )THEN LET sr.pmds038    = 0 END IF
       IF cl_null(sr.pmdt046   )THEN LET sr.pmdt046    = 0 END IF
       IF cl_null(sr.pmdt037   )THEN LET sr.pmdt037    = 0 END IF
       IF cl_null(sr.pmdt036   )THEN LET sr.pmdt036    = 0 END IF
       IF cl_null(sr.pmdt038   )THEN LET sr.pmdt038    = 0 END IF
       IF cl_null(sr.pmdt047 )THEN LET sr.pmdt047  = 0 END IF
       IF cl_null(sr.pmdt039   )THEN LET sr.pmdt039    = 0 END IF
       IF cl_null(sr.pmdt0382)THEN LET sr.pmdt0382 = 0 END IF
       IF cl_null(sr.pmdt0472)THEN LET sr.pmdt0472 = 0 END IF
       IF cl_null(sr.pmdt0392)THEN LET sr.pmdt0392 = 0 END IF
       #albireo 150827-----e
       LET sr.pmdt037 = sr.pmdt037 / 100  #151013-00019#9 
       #150902-00001#3--s
       #入庫情形取pmdw
       #IF s_aap_pmds000_chk('2',sr.l_pmds000) THEN                         #160414-00018#11 mark
       IF aapr130_x01_pmds000_chk('2',sr.l_pmds000) THEN                    #160414-00018#11  
          IF sr.l_pmds000 MATCHES '[34]' OR sr.l_pmds000 = '20' THEN
             LET l_pmdwdocno = sr.pmdtdocno
          ELSE
             SELECT pmds006 INTO l_pmdwdocno
               FROM pmds_t
              WHERE pmdsent = g_enterprise
                AND pmdsdocno = sr.pmdtdocno
          END IF         
          LET sr.pmdt050 = ''
          SELECT pmdw010 INTO sr.pmdt050
            FROM pmdw_t
           WHERE pmdwent = g_enterprise
             AND pmdwdocno = l_pmdwdocno
       END IF
       #150902-00001#3--e  
       
       #160414-00018#11 mark-----s
       ##150924-00012#1-----s
       ##應付單號
       #SELECT DISTINCT apcadocno INTO sr.l_apcadocno
       #  FROM apca_t,apcb_t 
       # WHERE apcaent = g_enterprise AND apcbent = apcaent AND apcbld = apcald AND apcbdocno = apcadocno
       # AND apcald = tm.a1 AND apca001 NOT IN('01','02','03','04')
       # AND apcb002 = sr.pmdtdocno AND apcb003 = sr.pmdtseq AND rownum = 1
       # AND apcastus <> 'X' #151019-00009#1 排除作廢單
       ##150924-00012#1-----e 
       #160414-00018#11 mark-----e

       #160414-00018#11 mark-----s
       ##151019-00009#1-----s
       ##暫估單號
       #SELECT apcadocno INTO sr.l_apca2
       #  FROM apca_t,apcb_t 
       # WHERE apcaent = g_enterprise AND apcbent = apcaent AND apcbld = apcald AND apcbdocno = apcadocno
       # AND apcald = tm.a1 AND apca001 IN('01','02','03','04')
       # AND apcb002 = sr.pmdtdocno AND apcb003 = sr.pmdtseq AND rownum = 1
       # AND apcastus <> 'X'
       ##151019-00009#1-----e
       #160414-00018#11 mark-----e
       
       #151102-00008#1---s
       #子件特性
       IF NOT cl_null(sr.l_pmdt005_desc) THEN 
          LET sr.l_pmdt005_desc = sr.l_pmdt005_desc,":",s_desc_gzcbl004_desc('2055',sr.l_pmdt005_desc)   
       END IF
       #160414-00018#11 mark-----s
       ##費用科目
       #LET sr.l_apcb021 = ''
       #LET sr.l_apcb021_desc = ''
       #SELECT apcb021 INTO sr.l_apcb021 FROM apca_t 
       #  LEFT OUTER JOIN apcb_t ON apcbent = apcaent AND apcbld = apcald AND apcbdocno = apcadocno AND apcb023 <> 'Y'
       #  LEFT OUTER JOIN pmdt_t ON apcbent = pmdtent AND apcb002 = pmdtdocno AND apcb003 = pmdtseq
       # WHERE apcaent = g_enterprise AND apcald = tm.a1 AND apcastus <> 'X'
       #   AND apcb002 = sr.pmdtdocno AND apcb003 = sr.pmdtseq AND rownum = 1
       #LET sr.l_apcb021_desc = s_desc_get_account_desc(tm.a1,sr.l_apcb021)
       #160414-00018#11  mark-----e
       
       #160414-00018#11 mark-----s
       ##成本分群
       #SELECT imag011 INTO sr.l_imag011 FROM imag_t WHERE imagent = g_enterprise
       #  AND imagsite = tm.a2
       #  AND imag001 = sr.pmdt006
       #160414-00018#11 mark-----e
       
       LET sr.l_imag011_desc = s_desc_get_acc_desc('206',sr.l_imag011)
       
       #151102-00008#1---e
       
       #end add-point
 
       #add-point:ins_data段before.save name="ins_data.before.save"
       #151028-00011#3---s 說明欄位
       #160414-00018#11 mark-----s
       ##人員
       #CALL s_desc_get_person_desc(sr.pmds002)     RETURNING sr.l_pmds002_desc
       ##部門
       #CALL s_desc_get_department_desc(sr.pmds003) RETURNING sr.l_pmds003_desc
       ##倉庫
       #LET sr.l_pmdt016_desc = s_desc_get_stock_desc(sr.pmdtsite,sr.pmdt016)
       #160414-00018#11 mark-----e
       #入庫性質
       LET l_pmds000_desc = ''
       CALL s_desc_gzcbl004_desc('2060',sr.l_pmds000) RETURNING l_pmds000_desc
       IF NOT cl_null(sr.l_pmds000) AND NOT cl_null(l_pmds000_desc) THEN
          LET sr.l_pmds000 = sr.l_pmds000,":",l_pmds000_desc
       END IF
       #151028-00011#3---e
       #end add-point
 
       #EXECUTE
       EXECUTE insert_prep USING sr.pmdtsite,sr.pmds007,sr.pmds007_desc,sr.pmds001,sr.l_pmds000,sr.pmdtdocno,sr.pmdtseq,sr.pmdt006,sr.pmdt006_desc,sr.pmdt006_desc_1,sr.l_pmdt005_desc,sr.l_imag011,sr.l_imag011_desc,sr.l_apcb021,sr.l_apcb021_desc,sr.pmdt001,sr.pmdt002,sr.pmdt050,sr.pmds002,sr.l_pmds002_desc,sr.pmds003,sr.l_pmds003_desc,sr.pmdt016,sr.l_pmdt016_desc,sr.pmdt024,sr.apcb007,sr.pmdt056,sr.pmdt066,sr.pmdt069,sr.l_diffqty,sr.pmds037,sr.pmds038,sr.pmdt046,sr.pmdt037,sr.pmdt036,sr.l_pmdt038_3,sr.l_pmdt047_3,sr.l_pmdt039_3,sr.pmdt038,sr.pmdt047,sr.pmdt039,sr.l_sumapcb103,sr.l_sumapcb104,sr.l_sumapcb105,sr.l_sfapcb103,sr.l_sfapcb104,sr.l_sfapcb105,sr.l_apcb113,sr.l_apcb114,sr.l_apcb115,sr.l_dapcb103,sr.l_dapcb104,sr.l_dapcb105,sr.pmdt0382,sr.pmdt0472,sr.pmdt0392,sr.l_apcadocno,sr.l_apca2
 
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.extend = "aapr130_x01_execute"
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
    
    #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="aapr130_x01.rep_data" readonly="Y" >}
PRIVATE FUNCTION aapr130_x01_rep_data()
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
 
{<section id="aapr130_x01.other_function" readonly="Y" >}

PRIVATE FUNCTION aapr130_x01_pmds000_chk(p_type,p_pmds000)
   DEFINE p_type    STRING
   DEFINE p_pmds000 LIKE pmds_t.pmds000
   DEFINE r_success LIKE type_t.num5
   DEFINE l_sql     STRING
   DEFINE l_gzcb004 LIKE gzcb_t.gzcb004

   WHENEVER ERROR CONTINUE

   LET r_success = FALSE

   EXECUTE pmds000_chk_pre USING p_pmds000 INTO l_gzcb004

   CASE
      WHEN p_type = '2'   #入
         IF l_gzcb004 = '1' THEN LET r_success = TRUE END IF
      WHEN p_type = '3'   #退
         IF l_gzcb004 = '-1' THEN LET r_success = TRUE END IF
   END CASE

   RETURN r_success
END FUNCTION

 
{</section>}
 
