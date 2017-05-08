#該程式未解開Section, 採用最新樣板產出!
{<section id="abgi045_02.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0007(2016-11-11 14:46:42), PR版次:0007(2017-01-05 10:01:28)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000027
#+ Filename...: abgi045_02
#+ Description: 由科目參照表整批產生
#+ Creator....: 06821(2016-04-08 11:26:20)
#+ Modifier...: 08171 -SD/PR- 05016
 
{</section>}
 
{<section id="abgi045_02.global" >}
#應用 c01b 樣板自動產生(Version:10)
#add-point:填寫註解說明 name="global.memo"
#160425-00020#4  160428 By Jessy "由科目參照表整批產生"ACTION改由abgi040中執行，並同時產生abgi040+abgi045資料
#160425-00020#4  160505 By Jessy ACTION INPUT增加"預算專案參照表號"當目標,由科目參照表當來源寫入單身,QBE增加統制/明細別&科目層級欄位
#160630-00008#4  160704 By albireo 多寫入abgi140
#160630-00008#6  160712 By 06821   由科目參照表整批產生: QBE統制明細別 : 下拉改為三個選項 1.統制+獨立  2.明細+獨立  3.統制
#161003-00014#16 161020 By Hans    1.由科目參照表產生科目對應檔時,統制科目產生到對應的檔案abgi140 時,為統制科目下的全部科目
#161104-00024#7  161108 By 08171   程式中DEFINE RECORD LIKE時不可以用*的寫法，要一個一個欄位定義
#161108-00017#5  161110 By 08732   程式中INSERT INTO時不可以用*的寫法，要一個一個欄位定義
#161003-00014#23 161111 By Hans     1.統制/明細別: 改為 input 2.科目層級改為統制層級 input 
#                                   3.統制/明細別:若選2 .明細+獨立時,科目層級不可輸入 4.若統科目層級選1時, abgi140 要對應到99層的明細科目
#                                   5.重產資料時 要整個重產。
#161206-00002#1  161209 By 05016    由科目產生時, 資產負債,改放科目類別glac007,下拉同 glac007
#161221-00038#1  161221 By 05016    abgi040批次產生的時候不刪除原本已經存在的預算項目。
#170104-00017#1  170104 By 05016   4.批次產生時:bgae008 = 空白


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
PRIVATE type type_g_glac_m        RECORD
       bgae006 LIKE bgae_t.bgae006, 
   bgae006_desc LIKE type_t.chr80, 
   glac001 LIKE glac_t.glac001, 
   glac001_desc LIKE type_t.chr80, 
   glac003 LIKE glac_t.glac003, 
   glac005 LIKE glac_t.glac005, 
   glac002 LIKE glac_t.glac002
       END RECORD
	   
#add-point:自定義模組變數(Module Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_wc         STRING

DEFINE g_tree_idx   LIKE type_t.num10
DEFINE g_tree       DYNAMIC ARRAY OF RECORD
       b_show          LIKE type_t.chr100,    #外顯欄位
       b_pid           LIKE type_t.chr100,    #父節點id
       b_id            LIKE type_t.chr100,    #本身節點id
       b_exp           LIKE type_t.chr100,    #是否展開
       b_hasC          LIKE type_t.num5,      #是否有子節點
       b_isExp         LIKE type_t.num5,      #是否已展開
       b_expcode       LIKE type_t.num5,       #展開值
       b_gldbld        LIKE gldb_t.gldbld,    #跟雙檔g_browser對的KEY1
       b_gldb001       LIKE gldb_t.gldb001    #跟雙檔g_browser對的KEY2
                    END RECORD
#end add-point
 
DEFINE g_glac_m        type_g_glac_m
 
   DEFINE g_glac001_t LIKE glac_t.glac001
DEFINE g_glac002_t LIKE glac_t.glac002
 
 
DEFINE g_ref_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明(global.argv) name="global.argv"

#end add-point
 
{</section>}
 
{<section id="abgi045_02.input" >}
#+ 資料輸入
PUBLIC FUNCTION abgi045_02(--)
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
   DEFINE l_n             LIKE type_t.num10
   DEFINE r_success       LIKE type_t.num5
   DEFINE r_bgae006       LIKE bgae_t.bgae006
   #end add-point
   
   #畫面開啟 (identifier)
   OPEN WINDOW w_abgi045_02 WITH FORM cl_ap_formpath("abg","abgi045_02")
 
   #瀏覽頁簽資料初始化
   CALL cl_ui_init()
   
   LET g_qryparam.state = "i"
   LET p_cmd = 'a'
   
   #輸入前處理
   #add-point:單頭前置處理 name="input.pre_input"
   CLEAR FORM
   WHENEVER ERROR CONTINUE
   
   INITIALIZE g_glac_m.* TO NULL
   
   #end add-point
  
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      #輸入開始
      INPUT BY NAME g_glac_m.bgae006,g_glac_m.glac001,g_glac_m.glac003,g_glac_m.glac005 ATTRIBUTE(WITHOUT  
          DEFAULTS)
         
         #自訂ACTION
         #add-point:單頭前置處理 name="input.action"
         
         #end add-point
         
         #自訂ACTION(master_input)
         
         
         BEFORE INPUT
            #add-point:單頭輸入前處理 name="input.before_input"
            LET g_glac_m.glac003 = '1' #161003-00014#23
            #end add-point
          
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgae006
            
            #add-point:AFTER FIELD bgae006 name="input.a.bgae006"
            #此段落由子樣板a05產生
            #160425-00020#4 --s add
            IF NOT cl_null(g_glac_m.bgae006) THEN 
               SELECT COUNT(*) INTO l_n FROM ooal_t WHERE ooalent = g_enterprise AND ooal001='11' AND ooal002 = g_glac_m.bgae006
               IF l_n = 0 THEN
                  LET g_glac_m.bgae006 = NULL
                  LET g_glac_m.bgae006_desc = NULL
                  DISPLAY BY NAME g_glac_m.bgae006_desc
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'sub-01305'
                  LET g_errparam.extend = ''
                  LET g_errparam.replace[1] = 'aooi081'
                  LET g_errparam.replace[2] = cl_get_progname('aooi081',g_lang,"2")
                  LET g_errparam.exeprog = 'aooi081'
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
               SELECT COUNT(*) INTO l_n FROM ooal_t WHERE ooalent = g_enterprise AND ooal001='11' AND ooalstus = 'Y' AND ooal002 = g_glac_m.bgae006
               IF l_n = 0 THEN
                  LET g_glac_m.bgae006 = NULL
                  LET g_glac_m.bgae006_desc = NULL
                  DISPLAY BY NAME g_glac_m.bgae006_desc
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'sub-01302'
                  LET g_errparam.extend = ''
                  LET g_errparam.replace[1] = 'aooi081'
                  LET g_errparam.replace[2] = cl_get_progname('aooi081',g_lang,"2")
                  LET g_errparam.exeprog = 'aooi081'
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
            END IF
            
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_glac_m.bgae006
            CALL ap_ref_array2(g_ref_fields,"SELECT ooall004 FROM ooall_t WHERE ooallent='"||g_enterprise||"' AND ooall001='11' AND ooall002=? AND ooall003='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_glac_m.bgae006_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_glac_m.bgae006_desc
            #160425-00020#4 --e add
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgae006
            #add-point:BEFORE FIELD bgae006 name="input.b.bgae006"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgae006
            #add-point:ON CHANGE bgae006 name="input.g.bgae006"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glac001
            
            #add-point:AFTER FIELD glac001 name="input.a.glac001"
            LET g_glac_m.glac001_desc = ''
            DISPLAY BY NAME g_glac_m.glac001_desc
            IF NOT abgi045_02_glac001_chk(g_glac_m.glac001) THEN
               LET g_glac_m.glac001 = ''
               LET g_glac_m.glac001_desc = s_desc_ooal002_desc('0',g_glac_m.glac001)
               DISPLAY BY NAME g_glac_m.glac001,g_glac_m.glac001_desc
               NEXT FIELD glac001
            END IF 
            LET g_glac_m.glac001_desc = s_desc_ooal002_desc('0',g_glac_m.glac001)
            DISPLAY BY NAME g_glac_m.glac001_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glac001
            #add-point:BEFORE FIELD glac001 name="input.b.glac001"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glac001
            #add-point:ON CHANGE glac001 name="input.g.glac001"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glac003
            #add-point:BEFORE FIELD glac003 name="input.b.glac003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glac003
            
            #add-point:AFTER FIELD glac003 name="input.a.glac003"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glac003
            #add-point:ON CHANGE glac003 name="input.g.glac003"
            #161003-00014#23---e---
            CALL cl_set_comp_entry('glac005',TRUE)
            IF g_glac_m.glac003 = '2' THEN
               LET g_glac_m.glac005 = ''
               CALL cl_set_comp_entry('glac005',FALSE)                        
            END IF
            #161003-00014#23---e---
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glac005
            #add-point:BEFORE FIELD glac005 name="input.b.glac005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glac005
            
            #add-point:AFTER FIELD glac005 name="input.a.glac005"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glac005
            #add-point:ON CHANGE glac005 name="input.g.glac005"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.bgae006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgae006
            #add-point:ON ACTION controlp INFIELD bgae006 name="input.c.bgae006"
            #應用 a07 樣板自動產生(Version:3)   
            #160425-00020#4 --s add
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_glac_m.bgae006             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

 
            CALL q_ooal002_12()                                #呼叫開窗
 
            LET g_glac_m.bgae006 = g_qryparam.return1              

            DISPLAY g_glac_m.bgae006 TO bgae006              #

            NEXT FIELD bgae006                          #返回原欄位
            #160425-00020#4 --e add

            #END add-point
 
 
         #Ctrlp:input.c.glac001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glac001
            #add-point:ON ACTION controlp INFIELD glac001 name="input.c.glac001"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_glac_m.glac001  #給予default值
            CALL q_ooal002_1()                          #呼叫開窗
            LET g_glac_m.glac001 = g_qryparam.return1              
            LET g_glac_m.glac001_desc = s_desc_ooal002_desc('0',g_glac_m.glac001)
            DISPLAY BY NAME g_glac_m.glac001,g_glac_m.glac001_desc
            NEXT FIELD glac001                          #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.glac003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glac003
            #add-point:ON ACTION controlp INFIELD glac003 name="input.c.glac003"
            
            #END add-point
 
 
         #Ctrlp:input.c.glac005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glac005
            #add-point:ON ACTION controlp INFIELD glac005 name="input.c.glac005"
            
            #END add-point
 
 
 #欄位開窗
 
         AFTER INPUT
            #add-point:單頭輸入後處理 name="input.after_input"
            
            #end add-point
            
      END INPUT
    
      #add-point:自定義input name="input.more_input"
      #CONSTRUCT BY NAME g_wc ON glac002,glac003,glac005 #161003-00014#23 
      CONSTRUCT BY NAME g_wc ON glac002                  #161003-00014#23 
         BEFORE CONSTRUCT
         
         ON ACTION controlp INFIELD glac002
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " glac001 = '",g_glac_m.glac001,"' "
            CALL q_glac002_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO glac002  #顯示到畫面上
            NEXT FIELD glac002                     #返回原欄位

       #  ON ACTION controlp INFIELD glac003 #161003-00014#23 
       
       #  ON ACTION controlp INFIELD glac005 #161003-00014#23 

      END CONSTRUCT
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
   CLOSE WINDOW w_abgi045_02 
   
   #add-point:input段after input name="input.post_input"
   LET r_success = TRUE
   LET r_bgae006 = ''
   
   CALL cl_err_collect_init()
   IF INT_FLAG THEN
      LET r_success= FALSE
      LET INT_FLAG = 0
   ELSE
      CALL abgi045_02_ins_bgae() RETURNING g_sub_success
      IF NOT g_sub_success THEN
         LET r_success= FALSE
      ELSE
         #LET r_bgae006 = g_glac_m.glac001 #160425-00020#4 mark
         LET r_bgae006 = g_glac_m.bgae006  #160425-00020#4 add
      END IF
   END IF
   CALL cl_err_collect_show()
   
   RETURN r_success,r_bgae006 
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="abgi045_02.other_dialog" readonly="Y" >}

 
{</section>}
 
{<section id="abgi045_02.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 會計科目參照表檢核
# Memo...........:
# Usage..........: CALL abgi045_02_glac001_chk(p_glac001)
# Date & Author..: 160408 By Jessy
# Modify.........:
################################################################################
PRIVATE FUNCTION abgi045_02_glac001_chk(p_glac001)
DEFINE p_glac001 LIKE glac_t.glac001
DEFINE r_success LIKE type_t.num5
DEFINE l_n       LIKE type_t.num5

   LET r_success = TRUE
   IF NOT cl_null(p_glac001) THEN
      #檢查是否存在且參照表類型為0
      LET l_n = 0
      SELECT COUNT(*) INTO l_n FROM ooal_t 
       WHERE ooalent = g_enterprise AND ooal001 = '0' AND ooal002 = p_glac001
      IF l_n = 0 THEN
         INITIALIZE g_errparam.* TO NULL
         LET g_errparam.extend = ''
         LET g_errparam.code = 'sub-01305'
         LET g_errparam.replace[1] = 'aooi070'
         LET g_errparam.replace[2] = cl_get_progname('aooi070',g_lang,"2")
         LET g_errparam.exeprog = 'aooi070'
         LET g_errparam.popup = TRUE
         CALL cl_err()  
         LET r_success = FALSE
         RETURN r_success
      END IF 
      #檢查是否有效
      IF r_success THEN
         IF NOT ap_chk_isExist(p_glac001,"SELECT COUNT(*) FROM ooal_t WHERE "
            ||"ooalent = '" ||g_enterprise|| "' AND "||"ooal001 = '0' AND ooal002 = ? AND ooalstus = 'Y'  ",'sub-01302','aooi070') THEN
            LET r_success = FALSE
         END IF 
      END IF
   END IF 
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 由科目參照表整批產生預算項目維度
# Memo...........:
# Usage..........: CALL abgi045_02_ins_bgae()
# Date & Author..: 160408 By Jessy
# Modify.........:
################################################################################
PRIVATE FUNCTION abgi045_02_ins_bgae()
DEFINE ld_date       DATETIME YEAR TO SECOND
DEFINE l_sql         STRING
DEFINE l_sql1        STRING                 #160425-00020#4 add
DEFINE l_glac        RECORD                 #來源table
         glac002	   LIKE glac_t.glac002,   #會計科目編號
         glac017	   LIKE glac_t.glac017,   #啟用部門
         glac018	   LIKE glac_t.glac018,   #啟用利潤成本
         glac019	   LIKE glac_t.glac019,   #啟用區域
         glac020	   LIKE glac_t.glac020,   #啟用交易客商
         glac027	   LIKE glac_t.glac027,   #啟用帳款客商
         glac021	   LIKE glac_t.glac021,   #啟用客群
         glac022	   LIKE glac_t.glac022,   #啟用產品類別
         glac023	   LIKE glac_t.glac023,   #啟用人員
         glac025	   LIKE glac_t.glac025,   #啟用專案
         glac026	   LIKE glac_t.glac026,   #啟用WBS
         glac028	   LIKE glac_t.glac028,   #啟用經營方式
         glac029	   LIKE glac_t.glac029,   #啟用渠道
         glac030	   LIKE glac_t.glac030,   #啟用品牌
         glac041	   LIKE glac_t.glac041,   #啟用自由核算項一
         glac042	   LIKE glac_t.glac042,   #啟用自由核算項二
         glac043	   LIKE glac_t.glac043,   #啟用自由核算項三
         glac044	   LIKE glac_t.glac044,   #啟用自由核算項四
         glac045	   LIKE glac_t.glac045,   #啟用自由核算項五
         glac046	   LIKE glac_t.glac046,   #啟用自由核算項六
         glac047	   LIKE glac_t.glac047,   #啟用自由核算項七
         glac048	   LIKE glac_t.glac048,   #啟用自由核算項八
         glac049	   LIKE glac_t.glac049,   #啟用自由核算項九
         glac050	   LIKE glac_t.glac050,   #啟用自由核算項十
         glac007	   LIKE glac_t.glac007,   #科目類別             #160425-00020#4 add
         glac008	   LIKE glac_t.glac008,   #正常餘額形態         #160425-00020#4 add
         glac016	   LIKE glac_t.glac016,   #現金科目否           #160425-00020#4 add
         glac003     LIKE glac_t.glac003,   #科目類別             #161003-00014#23
         glac005     LIKE glac_t.glac005    #科目層級             #161003-00014#23
                     END RECORD
#160425-00020#4 --s add                     
DEFINE l_bgael       RECORD                 #多語言table
         bgael006    LIKE bgael_t.bgael006, 
         bgael001    LIKE bgael_t.bgael001, 
         bgael002    LIKE bgael_t.bgael002, 
         bgael003    LIKE bgael_t.bgael003, 
         bgael004    LIKE bgael_t.bgael004
                     END RECORD                                    
DEFINE l_bgae003     LIKE bgae_t.bgae003            
DEFINE l_bgae036     LIKE bgae_t.bgae036            
DEFINE l_cnt         LIKE type_t.num10     
#160425-00020#4 --e add    
#160630-00008#4-----s
#DEFINE l_bgao        RECORD LIKE bgao_t.* #161104-00024#7 mark
#161104-00024#7 --s add
DEFINE l_bgao RECORD  #專案科目對應檔
       bgaoent LIKE bgao_t.bgaoent, #企業編號
       bgao001 LIKE bgao_t.bgao001, #預算細項參照表號
       bgao002 LIKE bgao_t.bgao002, #會計科目參照表編號
       bgao003 LIKE bgao_t.bgao003, #會計科目編號
       bgao004 LIKE bgao_t.bgao004, #預算細項編號
       bgaostus LIKE bgao_t.bgaostus, #狀態碼
       bgaocrtid LIKE bgao_t.bgaocrtid, #資料建立者
       bgaocrtdt LIKE bgao_t.bgaocrtdt, #資料創建日
       bgaomodid LIKE bgao_t.bgaomodid, #資料修改者
       bgaomoddt LIKE bgao_t.bgaomoddt, #最近修改日
       bgaoownid LIKE bgao_t.bgaoownid, #資料所有者
       bgaoowndp LIKE bgao_t.bgaoowndp, #資料所屬部門
       bgaocrtdp LIKE bgao_t.bgaocrtdp, #資料建立部門
       bgaoud001 LIKE bgao_t.bgaoud001, #自定義欄位(文字)001
       bgaoud002 LIKE bgao_t.bgaoud002, #自定義欄位(文字)002
       bgaoud003 LIKE bgao_t.bgaoud003, #自定義欄位(文字)003
       bgaoud004 LIKE bgao_t.bgaoud004, #自定義欄位(文字)004
       bgaoud005 LIKE bgao_t.bgaoud005, #自定義欄位(文字)005
       bgaoud006 LIKE bgao_t.bgaoud006, #自定義欄位(文字)006
       bgaoud007 LIKE bgao_t.bgaoud007, #自定義欄位(文字)007
       bgaoud008 LIKE bgao_t.bgaoud008, #自定義欄位(文字)008
       bgaoud009 LIKE bgao_t.bgaoud009, #自定義欄位(文字)009
       bgaoud010 LIKE bgao_t.bgaoud010, #自定義欄位(文字)010
       bgaoud011 LIKE bgao_t.bgaoud011, #自定義欄位(數字)011
       bgaoud012 LIKE bgao_t.bgaoud012, #自定義欄位(數字)012
       bgaoud013 LIKE bgao_t.bgaoud013, #自定義欄位(數字)013
       bgaoud014 LIKE bgao_t.bgaoud014, #自定義欄位(數字)014
       bgaoud015 LIKE bgao_t.bgaoud015, #自定義欄位(數字)015
       bgaoud016 LIKE bgao_t.bgaoud016, #自定義欄位(數字)016
       bgaoud017 LIKE bgao_t.bgaoud017, #自定義欄位(數字)017
       bgaoud018 LIKE bgao_t.bgaoud018, #自定義欄位(數字)018
       bgaoud019 LIKE bgao_t.bgaoud019, #自定義欄位(數字)019
       bgaoud020 LIKE bgao_t.bgaoud020, #自定義欄位(數字)020
       bgaoud021 LIKE bgao_t.bgaoud021, #自定義欄位(日期時間)021
       bgaoud022 LIKE bgao_t.bgaoud022, #自定義欄位(日期時間)022
       bgaoud023 LIKE bgao_t.bgaoud023, #自定義欄位(日期時間)023
       bgaoud024 LIKE bgao_t.bgaoud024, #自定義欄位(日期時間)024
       bgaoud025 LIKE bgao_t.bgaoud025, #自定義欄位(日期時間)025
       bgaoud026 LIKE bgao_t.bgaoud026, #自定義欄位(日期時間)026
       bgaoud027 LIKE bgao_t.bgaoud027, #自定義欄位(日期時間)027
       bgaoud028 LIKE bgao_t.bgaoud028, #自定義欄位(日期時間)028
       bgaoud029 LIKE bgao_t.bgaoud029, #自定義欄位(日期時間)029
       bgaoud030 LIKE bgao_t.bgaoud030, #自定義欄位(日期時間)030
       bgao006 LIKE bgao_t.bgao006 #參照表號類型
END RECORD
#161104-00024#7 --e add
#160630-00008#4-----e
DEFINE r_success     LIKE type_t.num5
DEFINE l_glac002     LIKE glac_t.glac002  #161003-00014#16
DEFINE l_glac003     LIKE glac_t.glac003  #161003-00014#16

   LET r_success = TRUE
   WHENEVER ERROR CONTINUE
   
   #IF cl_null(g_wc) THEN LET g_wc = " 1=1" END IF #160425-00020#4 mark
   #160425-00020#4 --s add 
   IF cl_null(g_wc) THEN 
      LET g_wc = " 1=1" 
   ELSE
      #LET g_wc = cl_replace_str(g_wc,"glac003='1'","glac003 IN ('1','3')")  #160630-00008#6 mark
      #160630-00008#6 --s add #161003-00014#23--s mark
      #LET g_wc = cl_replace_str(g_wc,"glac003='1'","glac003 IN ('1','3')")  #1.統制+獨立
      #LET g_wc = cl_replace_str(g_wc,"glac003='2'","glac003 IN ('2','3')")  #2.明細+獨立
      #LET g_wc = cl_replace_str(g_wc,"glac003='3'","glac003 = '1' ")        #3.統制
      #160630-00008#6 --e add #161003-00014#23--e mark
   END IF
   #160425-00020#4 --e add 
   CASE g_glac_m.glac003 
      WHEN 1 
         LET g_wc = g_wc," AND glac003 IN ('1','3')"
      WHEN 2 
         LET g_wc = g_wc," AND glac003 IN ('2','3')"
      WHEN 3
         LET g_wc = g_wc," AND glac003 = '1' " 
    END CASE
    
   LET ld_date = cl_get_current()  
   
   #160425-00020#4 --s add
   #檢查若已有資料存在,是否重新產生_是:刪除後產生 / 否:取消執行
   LET l_cnt = 0
   SELECT COUNT(*) INTO l_cnt 
     FROM bgae_t 
    WHERE bgaeent = g_enterprise 
      AND bgae006 = g_glac_m.bgae006  #160425-00020#4 add
      #AND bgae006 = g_glac_m.glac001 #160425-00020#4 mark
   
   #161221-00038#1---s--
   LET l_cnt = 0
   LET  l_sql = " SELECT COUNT(1) FROM bgae_t  WHERE bgaeent = ",g_enterprise," ", 
                "    AND bgae006 = '",g_glac_m.bgae006,"' ",
                "    AND bgae001 IN (SELECT glac002 FROM glac_t WHERE glacent = ",g_enterprise,"  ",
                "                                                 AND glac001 = '",g_glac_m.glac001,"' AND glacstus = 'Y' ",
                "                                                 AND ",g_wc," ) "
   PREPARE abgi045_02_glac002 FROM l_sql                
   EXECUTE abgi045_02_glac002 INTO l_cnt
   #161221-00038#1---e--
   
   IF cl_null(l_cnt) THEN LET l_cnt = 0 END IF
   
   IF l_cnt > 0 THEN
      IF NOT cl_ask_confirm("ais-00196") THEN
         LET r_success = FALSE
         RETURN r_success
      END IF
   END IF 
   #161221-00038#1---s--- mark
   #DELETE FROM bgae_t  WHERE bgaeent  = g_enterprise  AND bgae006  = g_glac_m.bgae006     #161003-00014#23
   #DELETE FROM bgael_t WHERE bgaelent = g_enterprise  AND bgael006 = g_glac_m.bgae006  #161003-00014#23
   #DELETE FROM bgao_t  WHERE bgaoent  = g_enterprise  AND bgao001  = g_glac_m.bgae006 AND bgao002 = g_glac_m.glac001  #161003-00014#23
   #161221-00038#1---e--- mark
   #取得科目多語言說明 
   LET l_sql1 = " SELECT glacl001,glacl002,glacl003,glacl004,glacl005 ",
                "   FROM glacl_t ",
                "  WHERE glaclent = '",g_enterprise,"'",
                "    AND glacl001 = ? ",
                "    AND glacl002 = ? "
   DECLARE abgi045_02_glacl_c CURSOR FROM l_sql1
   #160425-00020#4 --e add
   
   
   #撈出會計科目表資訊agli021
   INITIALIZE l_glac.* TO NULL
   LET l_sql = " SELECT glac002,glac017,glac018,glac019,glac020,glac027,
                        glac021,glac022,glac023,glac025,glac026,glac028,
                        glac029,glac030,glac041,glac042,glac043,glac044,
                        glac045,glac046,glac047,glac048,glac049,glac050,
                        glac007,glac008,glac016,glac003,glac005 ", #160425-00020#4 add #161003-00014#23 add glac003,glac005
               "   FROM glac_t ",
               "  WHERE glacent = ",g_enterprise,
               "    AND glac001 = '",g_glac_m.glac001,"' AND glacstus = 'Y' ",
               "    AND ",g_wc,               
               "  ORDER BY glac001,glac002 "
               
   PREPARE abgi045_02_p FROM l_sql
   DECLARE abgi045_02_c CURSOR FOR abgi045_02_p
   FOREACH abgi045_02_c INTO l_glac.*
       #161003-00014#23---s---
      #因可重覆執行,寫入前先刪除資料
      #DELETE FROM bgae_t 
      # WHERE bgaeent = g_enterprise 
      #   #AND bgae006 = g_glac_m.glac001     #160425-00020#4 mark
      #   AND bgae006 = g_glac_m.bgae006      #160425-00020#4 add
      #   AND bgae001 = l_glac.glac002
      #161003-00014#23---e---                        
      
      #161003-00014#23---s--- 統制科目看層級
      IF l_glac.glac003 = '1' AND l_glac.glac005 <>  g_glac_m.glac005 THEN
         CONTINUE FOREACH
      END IF    
      #161003-00014#23---e---
       #161221-00038#1---s--- 
       DELETE FROM bgae_t 
        WHERE bgaeent = g_enterprise 
          AND bgae006 = g_glac_m.bgae006 
          AND bgae001 = l_glac.glac002
       #161221-00038#1---e---             
      
      
      
      #160425-00020#4 --s add 
      #資產損益別(科目類別)= 1,2,3,4 THEN = 1 ELSE = 2
     #161206-00002#1---s---   
     #LET l_bgae003 = ''
     #IF l_glac.glac007 MATCHES '[1234]' THEN
     #   LET l_bgae003 = '1'
     #ELSE
     #   LET l_bgae003 = '2'
     #END IF
     LET l_bgae003 = l_glac.glac007
     #161206-00002#1---e---
      
      #現金類項目(現金科目) Y則 ='1' 現金類 ELSE 2.非現金類 
      LET l_bgae036 = ''
      IF l_glac.glac016 = 'Y' THEN
         LET l_bgae036 = '1'
      ELSE
         LET l_bgae036 = '2'
      END IF
      #160425-00020#4 --e add

      #寫入bgae_t      
      INSERT INTO bgae_t(bgaeent,bgae006,bgae001,bgae037,bgae015,bgae016,
                         bgae017,bgae018,bgae019,bgae020,bgae021,bgae022,
                         bgae023,bgae024,bgae025,bgae040,bgae041,bgae026,
                         bgae027,bgae028,bgae029,bgae030,bgae031,bgae032,
                         bgae033,bgae034,bgae035,bgaeownid,bgaeowndp,bgaecrtid,
                         #bgaecrtdp,bgaecrtdt,bgaemodid,bgaemoddt,bgae007)         #160425-00020#4 mark
                         bgaecrtdp,bgaecrtdt,bgaemodid,bgaemoddt,bgae007,bgae002,  #160425-00020#4 add
                         bgae003,bgae004,bgae005,bgae008,bgae036,bgaestus,         #160425-00020#4 add
                         bgae039)                                                  #160425-00020#4 add
                  #VALUES(g_enterprise,g_glac_m.glac001,l_glac.glac002,'Y',l_glac.glac017,l_glac.glac018, #160425-00020#4 mark
                  VALUES(g_enterprise,g_glac_m.bgae006,l_glac.glac002,'Y',l_glac.glac017,l_glac.glac018,  #160425-00020#4 add
                         l_glac.glac019,l_glac.glac020,l_glac.glac027,l_glac.glac021,l_glac.glac022,l_glac.glac023,
                         l_glac.glac025,l_glac.glac026,l_glac.glac028,l_glac.glac029,l_glac.glac030,l_glac.glac041,
                         l_glac.glac042,l_glac.glac043,l_glac.glac044,l_glac.glac045,l_glac.glac046,l_glac.glac047,
                         l_glac.glac048,l_glac.glac049,l_glac.glac050,g_user,g_dept,g_user,
                         #g_dept,ld_date,g_user,ld_date,'1')                       #160425-00020#4 mark
                         g_dept,ld_date,g_user,ld_date,'1',l_glac.glac008,         #160425-00020#4 add
                         #l_bgae003,'1','7','2',l_bgae036,'Y',                     #160425-00020#4 add    170104-00017#1 mark                      
                         l_bgae003,'1','7','',l_bgae036,'Y'  ,                     #170104-00017#1                           
                         'N')                                                      #160425-00020#4 add
                         
      IF SQLCA.SQLcode  THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.SQLCODE
         LET g_errparam.extend = "ins_bgae_wrong"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
         EXIT FOREACH
      END IF
      
      #160425-00020#4 --s add       
      #刪除bgael 原多語言
      DELETE FROM bgael_t 
       WHERE bgaelent = g_enterprise
         #AND bgael006 = g_glac_m.glac001     #160425-00020#4 mark
         AND bgael006 = g_glac_m.bgae006      #160425-00020#4 add
         AND bgael001 = l_glac.glac002
      
      #一併寫入多語言
      INITIALIZE l_bgael.* TO NULL
      FOREACH abgi045_02_glacl_c USING g_glac_m.glac001,l_glac.glac002 INTO l_bgael.*

         #寫入bgael_t      
         INSERT INTO bgael_t(bgaelent,bgael006,bgael001,bgael002,bgael003,bgael004)        #160425-00020#4 add
                      VALUES(g_enterprise,g_glac_m.bgae006,l_bgael.bgael001,l_bgael.bgael002,l_bgael.bgael003,l_bgael.bgael004)  
                      #VALUES(g_enterprise,l_bgael.*)  
   
         IF SQLCA.SQLcode  THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.SQLCODE
            LET g_errparam.extend = "ins_bgael_wrong"
            LET g_errparam.popup = TRUE
            CALL cl_err()
            LET r_success = FALSE
            EXIT FOREACH
         END IF
      END FOREACH
      
      IF NOT r_success THEN
         LET r_success = FALSE
         EXIT FOREACH
      END IF             
    
      LET l_glac003 = ''
      SELECT glac003 INTO l_glac003 FROM glac_t
       WHERE glacent = g_enterprise AND glac001 = g_glac_m.glac001 AND glac002 =  l_glac.glac002
      IF l_glac003 = '1' THEN
         CALL abgi045_02_ins_bgao(l_glac.glac002,'') #如果是統制科目需要產生底下的明細科目
      #   LET l_sql = " SELECT glac002 FROM glac_t ",
      #               "  WHERE glacent = ",g_enterprise," AND glac004 = '",l_glac.glac002,"' ",
      #               "    AND glac001 = '",g_glac_m.bgae006,"' AND glacstus = 'Y' " #161003-00014#16 add glacstus = 'Y'
      #   PREPARE abgi045_ins_bgao_prep FROM l_sql
      #   DECLARE abgi045_ins_bgao_curs CURSOR FOR abgi045_ins_bgao_prep
      #   FOREACH abgi045_ins_bgao_curs INTO l_glac002 
      #      IF l_glac002 = l_glac.glac002 THEN CONTINUE FOREACH END IF #統制科目不寫入
      #      DELETE FROM bgao_t WHERE bgaoent = g_enterprise AND bgao001 = g_glac_m.bgae006 
      #         AND bgao002 = g_glac_m.glac001 AND bgao003 = l_glac002 AND bgao004 = l_glac.glac002 
      #      INITIALIZE l_bgao.* TO NULL
      #      LET l_bgao.bgaoent = g_enterprise
      #      LET l_bgao.bgao001 = g_glac_m.bgae006
      #      LET l_bgao.bgao002 = g_glac_m.glac001
      #      LET l_bgao.bgao003 = l_glac002       #明細科目
      #      LET l_bgao.bgao004 = l_glac.glac002  #統制科目
      #      LET l_bgao.bgaostus = 'Y' 
      #      LET l_bgao.bgaocrtid = g_user
      #      LET l_bgao.bgaocrtdt = ld_date
      #      LET l_bgao.bgaocrtdp = g_dept
      #      LET l_bgao.bgaoownid = g_user
      #      LET l_bgao.bgaoowndp = g_dept
      #      #INSERT INTO bgao_t VALUES(l_bgao.*)   #161108-00017#5   mark
      #      #161108-00017#5   add---s
      #      INSERT INTO bgao_t (bgaoent,bgao001,bgao002,bgao003,bgao004,
      #                          bgaostus,bgaocrtid,bgaocrtdt,bgaomodid,bgaomoddt,
      #                          bgaoownid,bgaoowndp,bgaocrtdp,bgaoud001,bgaoud002,
      #                          bgaoud003,bgaoud004,bgaoud005,bgaoud006,bgaoud007,
      #                          bgaoud008,bgaoud009,bgaoud010,bgaoud011,bgaoud012,
      #                          bgaoud013,bgaoud014,bgaoud015,bgaoud016,bgaoud017,
      #                          bgaoud018,bgaoud019,bgaoud020,bgaoud021,bgaoud022,
      #                          bgaoud023,bgaoud024,bgaoud025,bgaoud026,bgaoud027,
      #                          bgaoud028,bgaoud029,bgaoud030,bgao006)
      #                  VALUES (l_bgao.bgaoent,l_bgao.bgao001,l_bgao.bgao002,l_bgao.bgao003,l_bgao.bgao004,
      #                          l_bgao.bgaostus,l_bgao.bgaocrtid,l_bgao.bgaocrtdt,l_bgao.bgaomodid,l_bgao.bgaomoddt,
      #                          l_bgao.bgaoownid,l_bgao.bgaoowndp,l_bgao.bgaocrtdp,l_bgao.bgaoud001,l_bgao.bgaoud002,
      #                          l_bgao.bgaoud003,l_bgao.bgaoud004,l_bgao.bgaoud005,l_bgao.bgaoud006,l_bgao.bgaoud007,
      #                          l_bgao.bgaoud008,l_bgao.bgaoud009,l_bgao.bgaoud010,l_bgao.bgaoud011,l_bgao.bgaoud012,
      #                          l_bgao.bgaoud013,l_bgao.bgaoud014,l_bgao.bgaoud015,l_bgao.bgaoud016,l_bgao.bgaoud017,
      #                          l_bgao.bgaoud018,l_bgao.bgaoud019,l_bgao.bgaoud020,l_bgao.bgaoud021,l_bgao.bgaoud022,
      #                          l_bgao.bgaoud023,l_bgao.bgaoud024,l_bgao.bgaoud025,l_bgao.bgaoud026,l_bgao.bgaoud027,
      #                          l_bgao.bgaoud028,l_bgao.bgaoud029,l_bgao.bgaoud030,l_bgao.bgao006)
      #      #161108-00017#5   add---e
      #   END FOREACH
      ELSE
         #161003-00014#16---e---       
         #160630-00008#4-----s
         DELETE FROM bgao_t WHERE bgaoent = g_enterprise AND bgao001 = g_glac_m.bgae006 AND bgao002 = g_glac_m.glac001 AND bgao003 = l_glac.glac002 AND bgao004 = l_glac.glac002 
         
         INITIALIZE l_bgao.* TO NULL
         LET l_bgao.bgaoent = g_enterprise
         LET l_bgao.bgao001 = g_glac_m.bgae006
         LET l_bgao.bgao002 = g_glac_m.glac001
         LET l_bgao.bgao003 = l_glac.glac002
         LET l_bgao.bgao004 = l_glac.glac002
         LET l_bgao.bgaostus = 'Y'
         LET l_bgao.bgaocrtid = g_user
         LET l_bgao.bgaocrtdt = ld_date
         LET l_bgao.bgaocrtdp = g_dept
         LET l_bgao.bgaoownid = g_user
         LET l_bgao.bgaoowndp = g_dept
         #INSERT INTO bgao_t VALUES(l_bgao.*)   #161108-00017#5   mark
         #161108-00017#5   add---s
         INSERT INTO bgao_t (bgaoent,bgao001,bgao002,bgao003,bgao004,
                             bgaostus,bgaocrtid,bgaocrtdt,bgaomodid,bgaomoddt,
                             bgaoownid,bgaoowndp,bgaocrtdp,bgaoud001,bgaoud002,
                             bgaoud003,bgaoud004,bgaoud005,bgaoud006,bgaoud007,
                             bgaoud008,bgaoud009,bgaoud010,bgaoud011,bgaoud012,
                             bgaoud013,bgaoud014,bgaoud015,bgaoud016,bgaoud017,
                             bgaoud018,bgaoud019,bgaoud020,bgaoud021,bgaoud022,
                             bgaoud023,bgaoud024,bgaoud025,bgaoud026,bgaoud027,
                             bgaoud028,bgaoud029,bgaoud030,bgao006)
                     VALUES (l_bgao.bgaoent,l_bgao.bgao001,l_bgao.bgao002,l_bgao.bgao003,l_bgao.bgao004,
                             l_bgao.bgaostus,l_bgao.bgaocrtid,l_bgao.bgaocrtdt,l_bgao.bgaomodid,l_bgao.bgaomoddt,
                             l_bgao.bgaoownid,l_bgao.bgaoowndp,l_bgao.bgaocrtdp,l_bgao.bgaoud001,l_bgao.bgaoud002,
                             l_bgao.bgaoud003,l_bgao.bgaoud004,l_bgao.bgaoud005,l_bgao.bgaoud006,l_bgao.bgaoud007,
                             l_bgao.bgaoud008,l_bgao.bgaoud009,l_bgao.bgaoud010,l_bgao.bgaoud011,l_bgao.bgaoud012,
                             l_bgao.bgaoud013,l_bgao.bgaoud014,l_bgao.bgaoud015,l_bgao.bgaoud016,l_bgao.bgaoud017,
                             l_bgao.bgaoud018,l_bgao.bgaoud019,l_bgao.bgaoud020,l_bgao.bgaoud021,l_bgao.bgaoud022,
                             l_bgao.bgaoud023,l_bgao.bgaoud024,l_bgao.bgaoud025,l_bgao.bgaoud026,l_bgao.bgaoud027,
                             l_bgao.bgaoud028,l_bgao.bgaoud029,l_bgao.bgaoud030,l_bgao.bgao006)
         #161108-00017#5   add---e     
      END IF
   END FOREACH  #161003-00014#16 
   
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
PRIVATE FUNCTION abgi045_02_ins_bgao(p_glac002,p_glac004)
DEFINE p_glac002 LIKE glac_t.glac002 #會計科目編號 
DEFINE p_glac004 LIKE glac_t.glac004 
DEFINE ld_date       DATETIME YEAR TO SECOND
DEFINE l_bgao RECORD  #專案科目對應檔
       bgaoent LIKE bgao_t.bgaoent, #企業編號
       bgao001 LIKE bgao_t.bgao001, #預算細項參照表號
       bgao002 LIKE bgao_t.bgao002, #會計科目參照表編號
       bgao003 LIKE bgao_t.bgao003, #會計科目編號
       bgao004 LIKE bgao_t.bgao004, #預算細項編號
       bgaostus LIKE bgao_t.bgaostus, #狀態碼
       bgaocrtid LIKE bgao_t.bgaocrtid, #資料建立者
       bgaocrtdt LIKE bgao_t.bgaocrtdt, #資料創建日
       bgaomodid LIKE bgao_t.bgaomodid, #資料修改者
       bgaomoddt LIKE bgao_t.bgaomoddt, #最近修改日
       bgaoownid LIKE bgao_t.bgaoownid, #資料所有者
       bgaoowndp LIKE bgao_t.bgaoowndp, #資料所屬部門
       bgaocrtdp LIKE bgao_t.bgaocrtdp, #資料建立部門
       bgaoud001 LIKE bgao_t.bgaoud001, #自定義欄位(文字)001
       bgaoud002 LIKE bgao_t.bgaoud002, #自定義欄位(文字)002
       bgaoud003 LIKE bgao_t.bgaoud003, #自定義欄位(文字)003
       bgaoud004 LIKE bgao_t.bgaoud004, #自定義欄位(文字)004
       bgaoud005 LIKE bgao_t.bgaoud005, #自定義欄位(文字)005
       bgaoud006 LIKE bgao_t.bgaoud006, #自定義欄位(文字)006
       bgaoud007 LIKE bgao_t.bgaoud007, #自定義欄位(文字)007
       bgaoud008 LIKE bgao_t.bgaoud008, #自定義欄位(文字)008
       bgaoud009 LIKE bgao_t.bgaoud009, #自定義欄位(文字)009
       bgaoud010 LIKE bgao_t.bgaoud010, #自定義欄位(文字)010
       bgaoud011 LIKE bgao_t.bgaoud011, #自定義欄位(數字)011
       bgaoud012 LIKE bgao_t.bgaoud012, #自定義欄位(數字)012
       bgaoud013 LIKE bgao_t.bgaoud013, #自定義欄位(數字)013
       bgaoud014 LIKE bgao_t.bgaoud014, #自定義欄位(數字)014
       bgaoud015 LIKE bgao_t.bgaoud015, #自定義欄位(數字)015
       bgaoud016 LIKE bgao_t.bgaoud016, #自定義欄位(數字)016
       bgaoud017 LIKE bgao_t.bgaoud017, #自定義欄位(數字)017
       bgaoud018 LIKE bgao_t.bgaoud018, #自定義欄位(數字)018
       bgaoud019 LIKE bgao_t.bgaoud019, #自定義欄位(數字)019
       bgaoud020 LIKE bgao_t.bgaoud020, #自定義欄位(數字)020
       bgaoud021 LIKE bgao_t.bgaoud021, #自定義欄位(日期時間)021
       bgaoud022 LIKE bgao_t.bgaoud022, #自定義欄位(日期時間)022
       bgaoud023 LIKE bgao_t.bgaoud023, #自定義欄位(日期時間)023
       bgaoud024 LIKE bgao_t.bgaoud024, #自定義欄位(日期時間)024
       bgaoud025 LIKE bgao_t.bgaoud025, #自定義欄位(日期時間)025
       bgaoud026 LIKE bgao_t.bgaoud026, #自定義欄位(日期時間)026
       bgaoud027 LIKE bgao_t.bgaoud027, #自定義欄位(日期時間)027
       bgaoud028 LIKE bgao_t.bgaoud028, #自定義欄位(日期時間)028
       bgaoud029 LIKE bgao_t.bgaoud029, #自定義欄位(日期時間)029
       bgaoud030 LIKE bgao_t.bgaoud030, #自定義欄位(日期時間)030
       bgao006 LIKE bgao_t.bgao006 #參照表號類型
END RECORD
DEFINE l_glac002 LIKE glac_t.glac002
DEFINE l_glac003 LIKE glac_t.glac003
DEFINE l_glac004 LIKE glac_t.glac004
DEFINE l_sql STRING
DEFINE l_node    DYNAMIC ARRAY OF RECORD
                    glac002  LIKE glac_t.glac002,
                    glac004  LIKE glac_t.glac004                    
                    END RECORD
DEFINE l_idx     LIKE type_t.num10
DEFINE l_id      LIKE type_t.chr100
   
   LET l_sql = " SELECT glac002,glac004 FROM glac_t WHERE glacent = '",g_enterprise,"'  ",
               "    AND glacstus = 'Y' AND glac004 = '",p_glac002,"' AND glac001 = '",g_glac_m.glac001,"'  ",
               "    ORDER BY glac002                                                                       "
               
   PREPARE abgp045_02_ins_bgao_prep FROM l_sql
   DECLARE abgp045_02_ins_bgao_curs CURSOR FOR abgp045_02_ins_bgao_prep      
   CALL l_node.clear()
   LET l_idx = 1
   FOREACH abgp045_02_ins_bgao_curs INTO l_node[l_idx].glac002,l_node[l_idx].glac004      
      IF SQLCA.SQLCODE THEN
         EXIT FOREACH
      END IF
      LET l_idx = l_idx + 1
   END FOREACH             
   IF cl_null(p_glac004) THEN LET p_glac004 = p_glac002 END IF   
   #如果l_idx = 1 代表沒往下的節點
   #         > 1 代表有往下的節點
   IF l_idx = 1 THEN
      SELECT glac003 INTO l_glac003 FROM glac_t
       WHERE glacent = g_enterprise AND glac001 = g_glac_m.glac001 AND glac002 = p_glac002 
      IF l_glac003 <> 1 THEN     
         DELETE FROM bgao_t WHERE bgaoent = g_enterprise AND bgao001 = g_glac_m.bgae006 AND bgao002 = g_glac_m.glac001  AND bgao003 = p_glac002  
         SELECT glac004 INTO l_glac004 FROM glac_t WHERE glacent = g_enterprise AND glac001 = g_glac_m.glac001 AND glac002 =  p_glac002 #找出上層科目
         IF cl_null(l_glac004) THEN LET l_glac004 = p_glac002 END IF
         INITIALIZE l_bgao.* TO NULL
         LET l_bgao.bgaoent = g_enterprise
         LET l_bgao.bgao001 = g_glac_m.bgae006
         LET l_bgao.bgao002 = g_glac_m.glac001
         LET l_bgao.bgao003 = p_glac002
         LET l_bgao.bgao004 = p_glac004
         LET l_bgao.bgaostus = 'Y'
         LET l_bgao.bgaocrtid = g_user
         LET l_bgao.bgaocrtdt = ld_date
         LET l_bgao.bgaocrtdp = g_dept
         LET l_bgao.bgaoownid = g_user
         LET l_bgao.bgaoowndp = g_dept
         INSERT INTO bgao_t (bgaoent,bgao001,bgao002,bgao003,bgao004,
                             bgaostus,bgaocrtid,bgaocrtdt,bgaomodid,bgaomoddt,
                             bgaoownid,bgaoowndp,bgaocrtdp,bgaoud001,bgaoud002,
                             bgaoud003,bgaoud004,bgaoud005,bgaoud006,bgaoud007,
                             bgaoud008,bgaoud009,bgaoud010,bgaoud011,bgaoud012,
                             bgaoud013,bgaoud014,bgaoud015,bgaoud016,bgaoud017,
                             bgaoud018,bgaoud019,bgaoud020,bgaoud021,bgaoud022,
                             bgaoud023,bgaoud024,bgaoud025,bgaoud026,bgaoud027,
                             bgaoud028,bgaoud029,bgaoud030,bgao006)
                     VALUES (l_bgao.bgaoent,l_bgao.bgao001,l_bgao.bgao002,l_bgao.bgao003,l_bgao.bgao004,
                             l_bgao.bgaostus,l_bgao.bgaocrtid,l_bgao.bgaocrtdt,l_bgao.bgaomodid,l_bgao.bgaomoddt,
                             l_bgao.bgaoownid,l_bgao.bgaoowndp,l_bgao.bgaocrtdp,l_bgao.bgaoud001,l_bgao.bgaoud002,
                             l_bgao.bgaoud003,l_bgao.bgaoud004,l_bgao.bgaoud005,l_bgao.bgaoud006,l_bgao.bgaoud007,
                             l_bgao.bgaoud008,l_bgao.bgaoud009,l_bgao.bgaoud010,l_bgao.bgaoud011,l_bgao.bgaoud012,
                             l_bgao.bgaoud013,l_bgao.bgaoud014,l_bgao.bgaoud015,l_bgao.bgaoud016,l_bgao.bgaoud017,
                             l_bgao.bgaoud018,l_bgao.bgaoud019,l_bgao.bgaoud020,l_bgao.bgaoud021,l_bgao.bgaoud022,
                             l_bgao.bgaoud023,l_bgao.bgaoud024,l_bgao.bgaoud025,l_bgao.bgaoud026,l_bgao.bgaoud027,
                             l_bgao.bgaoud028,l_bgao.bgaoud029,l_bgao.bgaoud030,l_bgao.bgao006)                                           
      END IF      
   END IF
   CALL l_node.deleteElement(l_idx)
   #FOR 跑遞迴 再往下找節點
   FOR l_idx = 1 TO l_node.getLength()
      IF cl_null(l_node[l_idx].glac002) THEN CONTINUE FOR END IF
      IF l_node[l_idx].glac002 = l_node[l_idx].glac004 THEN CONTINUE FOR END IF  
      CALL abgi045_02_ins_bgao(l_node[l_idx].glac002,p_glac004)   
   END FOR
      
END FUNCTION

 
{</section>}
 
