#該程式未解開Section, 採用最新樣板產出!
{<section id="anmt840_01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0002(2014-11-11 14:04:01), PR版次:0002(2016-12-01 09:27:39)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000033
#+ Filename...: anmt840_01
#+ Description: 整批導入
#+ Creator....: 00810(2014-11-11 11:37:35)
#+ Modifier...: 00810 -SD/PR- 02481
 
{</section>}
 
{<section id="anmt840_01.global" >}
#應用 c01b 樣板自動產生(Version:10)
#add-point:填寫註解說明 name="global.memo"
#161128-00061#3   2016/12/01 by 02481    标准程式定义采用宣告模式,弃用.*写法
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
PRIVATE type type_g_nmdg_m        RECORD
       format LIKE type_t.chr500, 
   mold LIKE type_t.chr2, 
   way LIKE type_t.chr500
       END RECORD
	   
#add-point:自定義模組變數(Module Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE l_success       LIKE type_t.num5
#end add-point
 
DEFINE g_nmdg_m        type_g_nmdg_m
 
   
 
DEFINE g_ref_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明(global.argv) name="global.argv"

#end add-point
 
{</section>}
 
{<section id="anmt840_01.input" >}
#+ 資料輸入
PUBLIC FUNCTION anmt840_01(--)
   #add-point:input段變數傳入 name="input.get_var"
   
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
   DEFINE ls_str          STRING
   DEFINE l_chr           LIKE type_t.chr1   
   DEFINE l_chr1          LIKE type_t.chr1   
   DEFINE l_num           LIKE type_t.num5
   #end add-point
   
   #畫面開啟 (identifier)
   OPEN WINDOW w_anmt840_01 WITH FORM cl_ap_formpath("anm","anmt840_01")
 
   #瀏覽頁簽資料初始化
   CALL cl_ui_init()
   
   LET g_qryparam.state = "i"
   LET p_cmd = 'a'
   
   #輸入前處理
   #add-point:單頭前置處理 name="input.pre_input"
   LET g_nmdg_m.format = ''
   LET g_nmdg_m.mold = ''
   LET g_nmdg_m.way = ''
   #end add-point
  
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      #輸入開始
      INPUT BY NAME g_nmdg_m.format,g_nmdg_m.mold,g_nmdg_m.way ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂ACTION
         #add-point:單頭前置處理 name="input.action"
         
         #end add-point
         
         #自訂ACTION(master_input)
         
         
         BEFORE INPUT
            #add-point:單頭輸入前處理 name="input.before_input"
            CALL cl_set_combo_scc('format','8915')
            #end add-point
          
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD format
            #add-point:BEFORE FIELD format name="input.b.format"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD format
            
            #add-point:AFTER FIELD format name="input.a.format"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE format
            #add-point:ON CHANGE format name="input.g.format"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mold
            #add-point:BEFORE FIELD mold name="input.b.mold"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mold
            
            #add-point:AFTER FIELD mold name="input.a.mold"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mold
            #add-point:ON CHANGE mold name="input.g.mold"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD way
            #add-point:BEFORE FIELD way name="input.b.way"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD way
            
            #add-point:AFTER FIELD way name="input.a.way"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE way
            #add-point:ON CHANGE way name="input.g.way"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.format
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD format
            #add-point:ON ACTION controlp INFIELD format name="input.c.format"
            
            #END add-point
 
 
         #Ctrlp:input.c.mold
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mold
            #add-point:ON ACTION controlp INFIELD mold name="input.c.mold"
            
            #END add-point
 
 
         #Ctrlp:input.c.way
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD way
            #add-point:ON ACTION controlp INFIELD way name="input.c.way"
            
            #END add-point
 
 
 #欄位開窗
 
         AFTER INPUT
            #add-point:單頭輸入後處理 name="input.after_input"
            
            #end add-point
            
      END INPUT
    
      #add-point:自定義input name="input.more_input"
      ON ACTION browser
         CALL cl_client_browse_file() RETURNING g_nmdg_m.way
         LET ls_str = g_nmdg_m.way
         #抓取目录斜杆
         LET l_num =ls_str.getIndexOf(':',1)                                    #抓取：后的字符位置
         LET l_chr = ls_str.substring(l_num+1,l_num+1)                        #截取冒号后的字符 
         LET l_chr1 = ls_str.substring(ls_str.getLength(),ls_str.getLength())    #判断是否为根目录
         LET g_nmdg_m.way = g_nmdg_m.way
         DISPLAY BY NAME g_nmdg_m.way
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
   CLOSE WINDOW w_anmt840_01 
   
   #add-point:input段after input name="input.post_input"
   CALL anmt840_01_ins_excel(g_nmdg_m.way) RETURNING l_success
   RETURN l_success
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="anmt840_01.other_dialog" readonly="Y" >}

 
{</section>}
 
{<section id="anmt840_01.other_function" readonly="Y" >}

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
PRIVATE FUNCTION anmt840_01_ins_excel(p_excelname)
DEFINE p_excelname LIKE type_t.chr1000  #excel档名
DEFINE r_success   LIKE type_t.num5
DEFINE l_excelname STRING               #excel档名
DEFINE l_count     LIKE type_t.num10
DEFINE li_i        LIKE type_t.num10
DEFINE li_j        LIKE type_t.num10
DEFINE xlApp,iRes,iRow    LIKE type_t.num5
#161128-00061#3-----modify--begin----------
#DEFINE l_nmdg      RECORD LIKE nmdg_t.*
DEFINE l_nmdg RECORD  #銀行對帳交易明細檔
       nmdgent LIKE nmdg_t.nmdgent, #企業編碼
       nmdgsite LIKE nmdg_t.nmdgsite, #資金中心
       nmdgcomf LIKE nmdg_t.nmdgcomf, #法人
       nmdg001 LIKE nmdg_t.nmdg001, #銀行交易帳戶
       nmdg002 LIKE nmdg_t.nmdg002, #企業流水號
       nmdg003 LIKE nmdg_t.nmdg003, #交易日期
       nmdg004 LIKE nmdg_t.nmdg004, #交易時間
       nmdg005 LIKE nmdg_t.nmdg005, #對方帳號
       nmdg006 LIKE nmdg_t.nmdg006, #對方帳戶名
       nmdg007 LIKE nmdg_t.nmdg007, #對方開戶行名
       nmdg008 LIKE nmdg_t.nmdg008, #借貸別
       nmdg009 LIKE nmdg_t.nmdg009, #交易金額
       nmdg010 LIKE nmdg_t.nmdg010, #交易餘額
       nmdg011 LIKE nmdg_t.nmdg011, #用途
       nmdg012 LIKE nmdg_t.nmdg012, #附言
       nmdg013 LIKE nmdg_t.nmdg013, #銀行單據號
       nmdg014 LIKE nmdg_t.nmdg014, #ERP單據號
       nmdg015 LIKE nmdg_t.nmdg015, #交易對象編號
       nmdg016 LIKE nmdg_t.nmdg016, #交易對象識別碼
       nmdg017 LIKE nmdg_t.nmdg017, #對帳碼
       nmdg018 LIKE nmdg_t.nmdg018, #帳戶編碼
       nmdg019 LIKE nmdg_t.nmdg019  #對帳流水號
       END RECORD
#161128-00061#3-----modify--end------------
DEFINE l_today     LIKE type_t.dat       #zll g_today 没有了
DEFINE l_n         LIKE type_t.num5

   WHENEVER ERROR CONTINUE
   LET r_success = TRUE

   LET l_today= cl_get_current()
   LET l_count = LENGTH(p_excelname CLIPPED)
   #转换路径分隔符
   FOR li_i = 1 TO l_count
       IF p_excelname[li_i,li_i] ="/" THEN
          LET l_excelname = l_excelname CLIPPED,'\\'
       ELSE
          LET l_excelname = l_excelname CLIPPED,p_excelname[li_i,li_i]
       END IF
   END FOR

   CALL ui.interface.frontCall('WinCOM','CreateInstance',
                               ['Excel.Application'],[xlApp])
   IF xlApp <> -1 THEN
      CALL ui.interface.frontCall('WinCOM','CallMethod',
                                  [xlApp,'WorkBooks.Open',l_excelname],[iRes])
      IF iRes <> -1 THEN
         CALL ui.interface.frontCall('WinCOM','GetProperty',
              [xlApp,'ActiveSheet.UsedRange.Rows.Count'],[iRow])
         IF iRow > 1 THEN
            FOR li_i = 2 TO iRow
                INITIALIZE l_nmdg.* TO NULL
                CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',1).Value'],[l_nmdg.nmdgent])
                CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',2).Value'],[l_nmdg.nmdgsite])
                CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',3).Value'],[l_nmdg.nmdgcomf])
                CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',4).Value'],[l_nmdg.nmdg001])
                CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',5).Value'],[l_nmdg.nmdg002])
                CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',6).Value'],[l_nmdg.nmdg003])
                CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',7).Value'],[l_nmdg.nmdg004])
                CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',8).Value'],[l_nmdg.nmdg005])
                CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',9).Value'],[l_nmdg.nmdg006])
                CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',10).Value'],[l_nmdg.nmdg007])
                CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',11).Value'],[l_nmdg.nmdg008])
                CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',12).Value'],[l_nmdg.nmdg009])
                CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',13).Value'],[l_nmdg.nmdg010])
                CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',14).Value'],[l_nmdg.nmdg011])
                CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',15).Value'],[l_nmdg.nmdg012])
                CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',16).Value'],[l_nmdg.nmdg013])
                CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',17).Value'],[l_nmdg.nmdg014])
                CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',18).Value'],[l_nmdg.nmdg015])
                CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',19).Value'],[l_nmdg.nmdg016])
                CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',20).Value'],[l_nmdg.nmdg017])
                CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',21).Value'],[l_nmdg.nmdg018])
                CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',22).Value'],[l_nmdg.nmdg019])
                
                #赋默认值

               #161128-00061#3-----modify--begin----------    
               #INSERT INTO nmdg_t VALUES l_nmdg.*
                INSERT INTO nmdg_t (nmdgent,nmdgsite,nmdgcomf,nmdg001,nmdg002,nmdg003,nmdg004,nmdg005,nmdg006,nmdg007,
                                    nmdg008,nmdg009,nmdg010,nmdg011,nmdg012,nmdg013,nmdg014,nmdg015,nmdg016,nmdg017,nmdg018,nmdg019)
                 VALUES(l_nmdg.nmdgent,l_nmdg.nmdgsite,l_nmdg.nmdgcomf,l_nmdg.nmdg001,l_nmdg.nmdg002,l_nmdg.nmdg003,l_nmdg.nmdg004,l_nmdg.nmdg005,l_nmdg.nmdg006,l_nmdg.nmdg007,
                        l_nmdg.nmdg008,l_nmdg.nmdg009,l_nmdg.nmdg010,l_nmdg.nmdg011,l_nmdg.nmdg012,l_nmdg.nmdg013,l_nmdg.nmdg014,l_nmdg.nmdg015,l_nmdg.nmdg016,l_nmdg.nmdg017,l_nmdg.nmdg018,l_nmdg.nmdg019)
               #161128-00061#3-----modify--end----------
               
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = 'ins nmdg'
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET r_success = FALSE
                  EXIT FOR
               END IF
            END FOR
         END IF
      ELSE
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = ''
         LET g_errparam.extend = 'NO FILE'
         LET g_errparam.popup = TRUE
         CALL cl_err()

         LET r_success = FALSE
      END IF
   ELSE
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = ''
      LET g_errparam.extend = 'NO EXCEL'
      LET g_errparam.popup = TRUE
      CALL cl_err()

      LET r_success = FALSE
   END IF

   CALL ui.interface.frontCall('WinCOM','CallMethod',[xlApp,'Quit'],[iRes])
   CALL ui.interface.frontCall('WinCOM','ReleaseInstance',[xlApp],[iRes])

   RETURN r_success
END FUNCTION

 
{</section>}
 
