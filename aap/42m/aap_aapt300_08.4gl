#該程式未解開Section, 採用最新樣板產出!
{<section id="aapt300_08.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0015(2016-10-11 18:15:30), PR版次:0015(2017-02-09 15:53:19)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000127
#+ Filename...: aapt300_08
#+ Description: 其他訊息
#+ Creator....: 02097(2014-09-25 17:19:08)
#+ Modifier...: 05016 -SD/PR- 04152
 
{</section>}
 
{<section id="aapt300_08.global" >}
#應用 c02b 樣板自動產生(Version:10)
#add-point:填寫註解說明 name="global.memo"
#141218-00011#6              By Belle    單身維護時：其他信息的核算，不必檢核是否有輸入及合理性。
#150106-00011#3              By Belle    修改部門/責任中心預設值
#150205-00012#1              BY Hans     進欄位之後只顯示編號不顯示中文名稱
#150206-00013#3              BY Hans     單身最後方,參考單號之後,增加【存貨科目】apcb021、科目說明、【摘要】apcb047 的顯示及維護。
#150210-00009#1   2015/02/12 By Belle    修改 詢問分錄底稿產生位置
#150310-00009#10  2015/06/30 By lixiang  應付帶入來源單據的專案編號、WBS編號、活動編號，不可修改
#150901-00020#7   2015/09/03 By apo      aapt300/301/340/341業務部門改至帳款明細維護,其他訊息中不可維護
#150828-00001#7   2015/09/11 By Jessy    aapt310/320業務部門改至帳款明細維護,其他訊息中不可維護
#150916-00015#1   2015/12/07 By Xiaozg   1.快捷带出类似科目编号 2.当有账套时，科目检查改为检查是否存在于glad_t中
#160107-00003#8   2016/01/19 By fionchen 單身的自由核算項開窗資料的設定取值,  要以這二個科目的聯集作檢查, 同時都有設定者， 則取”存貨科目”為主
#160129-00015#5   2016/02/22 By sakura   效能調校
#160321-00016#20  2016/03/23 By Jessy    修正azzi920重複定義之錯誤訊息
#160509-00004#110 2016/07/31 By 02114    單身增加帳款客戶 收款客戶
#160920-00019#1   2016/09/21 By 08732    交易對象開窗校驗調整
#160902-00034#1   2016/09/21 By Hans     單身新增預算細項
#161104-00024#2   2016/11/10 By 08729    處理DEFINE有星號
#170123-00010#1   2017/01/23 By 06821    SQL中缺乏ent條件
#161221-00054#1   2017/02/06 By Reanna   核算项开窗检核增加agli060相关联判断，当agli060中有维护核算项资料时，
#                                        如果是正向(允许)，核算项只可以抓取agli060中维护的值；如果是反向(拒绝)，核算项不可以抓取agli060中维护的值；
#                                        如果没有维护agli060中的值，就按照原逻辑
#end add-point
#add-point:填寫註解說明(客製用) name="global.memo_customerization"

#end add-point
 
IMPORT os
IMPORT FGL lib_cl_dlg
#add-point:增加匯入項目 name="global.import"
 
#end add-point
 
SCHEMA ds
 
GLOBALS "../../cfg/top_global.inc"
 
#add-point:增加匯入變數檔 name="global.inc"

#end add-point
 
#單身 type 宣告
PRIVATE TYPE type_g_apcb_d        RECORD
       apcbdocno LIKE apcb_t.apcbdocno, 
   apcbld LIKE apcb_t.apcbld, 
   apcbseq LIKE apcb_t.apcbseq, 
   apcb047 LIKE apcb_t.apcb047, 
   apcb021 LIKE apcb_t.apcb021, 
   l_apcb021_desc LIKE type_t.chr500, 
   apcb029 LIKE apcb_t.apcb029, 
   l_apcb029_desc LIKE type_t.chr500, 
   apcb051 LIKE apcb_t.apcb051, 
   l_apcb051_desc LIKE type_t.chr500, 
   apcb010 LIKE apcb_t.apcb010, 
   l_apcb010_desc LIKE type_t.chr500, 
   apcb011 LIKE apcb_t.apcb011, 
   l_apcb011_desc LIKE type_t.chr500, 
   apcb024 LIKE apcb_t.apcb024, 
   l_apcb024_desc LIKE type_t.chr500, 
   apcb012 LIKE apcb_t.apcb012, 
   l_apcb012_desc LIKE type_t.chr500, 
   apcb015 LIKE apcb_t.apcb015, 
   l_apcb015_desc LIKE type_t.chr500, 
   apcb016 LIKE apcb_t.apcb016, 
   l_apcb016_desc LIKE type_t.chr500, 
   apcb017 LIKE apcb_t.apcb017, 
   l_apcb017_desc LIKE type_t.chr500, 
   apcb033 LIKE apcb_t.apcb033, 
   apcb034 LIKE apcb_t.apcb034, 
   l_apcb034_desc LIKE type_t.chr500, 
   apcb035 LIKE apcb_t.apcb035, 
   l_apcb035_desc LIKE type_t.chr500, 
   apcb036 LIKE apcb_t.apcb036, 
   l_apcb036_desc LIKE type_t.chr500, 
   apcb054 LIKE apcb_t.apcb054, 
   l_apcb054_desc LIKE type_t.chr500, 
   apcb055 LIKE apcb_t.apcb055, 
   l_apcb055_desc LIKE type_t.chr500, 
   apcb037 LIKE apcb_t.apcb037, 
   l_apcb037_desc LIKE type_t.chr500, 
   apcb038 LIKE apcb_t.apcb038, 
   l_apcb038_desc LIKE type_t.chr500, 
   apcb039 LIKE apcb_t.apcb039, 
   l_apcb039_desc LIKE type_t.chr500, 
   apcb040 LIKE apcb_t.apcb040, 
   l_apcb040_desc LIKE type_t.chr500, 
   apcb041 LIKE apcb_t.apcb041, 
   l_apcb041_desc LIKE type_t.chr500, 
   apcb042 LIKE apcb_t.apcb042, 
   l_apcb042_desc LIKE type_t.chr500, 
   apcb043 LIKE apcb_t.apcb043, 
   l_apcb043_desc LIKE type_t.chr500, 
   apcb044 LIKE apcb_t.apcb044, 
   l_apcb044_desc LIKE type_t.chr500, 
   apcb045 LIKE apcb_t.apcb045, 
   l_apcb045_desc LIKE type_t.chr500, 
   apcb046 LIKE apcb_t.apcb046, 
   l_apcb046_desc LIKE type_t.chr500, 
   img1 LIKE type_t.chr500
       END RECORD
 
 
#add-point:自定義模組變數(Module Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_rec_b04              LIKE type_t.num5
GLOBALS
   DEFINE g_apcb_d4           DYNAMIC ARRAY OF type_g_apcb_d
END GLOBALS     
#end add-point
 
DEFINE g_apcb_d          DYNAMIC ARRAY OF type_g_apcb_d
DEFINE g_apcb_d_t        type_g_apcb_d
 
 
DEFINE g_apcbld_t   LIKE apcb_t.apcbld    #Key值備份
DEFINE g_apcbdocno_t      LIKE apcb_t.apcbdocno    #Key值備份
DEFINE g_apcbseq_t      LIKE apcb_t.apcbseq    #Key值備份
 
 
DEFINE l_ac                  LIKE type_t.num10
DEFINE g_ref_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_ref_vars            DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rec_b               LIKE type_t.num10 
DEFINE g_detail_idx          LIKE type_t.num10
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
    
#add-point:傳入參數說明(global.argv) name="global.argv"

#end add-point    
 
{</section>}
 
{<section id="aapt300_08.input" >}
#+ 資料輸入
PUBLIC FUNCTION aapt300_08(--)
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
   DEFINE l_cmd           LIKE type_t.chr5
   #add-point:input段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="input.define"
   
   #end add-point
 
   #畫面開啟 (identifier)
   OPEN WINDOW w_aapt300_08 WITH FORM cl_ap_formpath("aap","aapt300_08")
 
   #瀏覽頁簽資料初始化
   CALL cl_ui_init()
   
   LET g_qryparam.state = "i"
   
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   
   #輸入前處理
   #add-point:單身前置處理 name="input.pre_input"
   CALL cl_set_combo_scc('apcb033','6310')
   #end add-point
  
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      #輸入開始
      INPUT ARRAY g_apcb_d FROM s_detail1_aapt300_08.*
          ATTRIBUTE(COUNT = g_rec_b,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS, 
                  INSERT ROW = FALSE,
                  DELETE ROW = FALSE,
                  APPEND ROW = FALSE)
         
         #自訂ACTION
         #add-point:單身前置處理 name="input.action"
         
         #end add-point
         
         #自訂ACTION(detail_input)
         
         
         BEFORE INPUT
            #add-point:單身輸入前處理 name="input.before_input"
            
            #end add-point
          
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcbdocno
            #add-point:BEFORE FIELD apcbdocno name="input.b.page1_aapt300_08.apcbdocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcbdocno
            
            #add-point:AFTER FIELD apcbdocno name="input.a.page1_aapt300_08.apcbdocno"
 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apcbdocno
            #add-point:ON CHANGE apcbdocno name="input.g.page1_aapt300_08.apcbdocno"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcbld
            #add-point:BEFORE FIELD apcbld name="input.b.page1_aapt300_08.apcbld"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcbld
            
            #add-point:AFTER FIELD apcbld name="input.a.page1_aapt300_08.apcbld"
 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apcbld
            #add-point:ON CHANGE apcbld name="input.g.page1_aapt300_08.apcbld"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcbseq
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_apcb_d[l_ac].apcbseq,"1.000","1","","","azz-00079",1) THEN
               NEXT FIELD apcbseq
            END IF 
 
 
 
            #add-point:AFTER FIELD apcbseq name="input.a.page1_aapt300_08.apcbseq"
 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcbseq
            #add-point:BEFORE FIELD apcbseq name="input.b.page1_aapt300_08.apcbseq"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apcbseq
            #add-point:ON CHANGE apcbseq name="input.g.page1_aapt300_08.apcbseq"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcb047
            #add-point:BEFORE FIELD apcb047 name="input.b.page1_aapt300_08.apcb047"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcb047
            
            #add-point:AFTER FIELD apcb047 name="input.a.page1_aapt300_08.apcb047"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apcb047
            #add-point:ON CHANGE apcb047 name="input.g.page1_aapt300_08.apcb047"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcb021
            #add-point:BEFORE FIELD apcb021 name="input.b.page1_aapt300_08.apcb021"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcb021
            
            #add-point:AFTER FIELD apcb021 name="input.a.page1_aapt300_08.apcb021"
 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apcb021
            #add-point:ON CHANGE apcb021 name="input.g.page1_aapt300_08.apcb021"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcb029
            #add-point:BEFORE FIELD apcb029 name="input.b.page1_aapt300_08.apcb029"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcb029
            
            #add-point:AFTER FIELD apcb029 name="input.a.page1_aapt300_08.apcb029"
 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apcb029
            #add-point:ON CHANGE apcb029 name="input.g.page1_aapt300_08.apcb029"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcb051
            #add-point:BEFORE FIELD apcb051 name="input.b.page1_aapt300_08.apcb051"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcb051
            
            #add-point:AFTER FIELD apcb051 name="input.a.page1_aapt300_08.apcb051"
 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apcb051
            #add-point:ON CHANGE apcb051 name="input.g.page1_aapt300_08.apcb051"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_apcb051_desc
            #add-point:BEFORE FIELD l_apcb051_desc name="input.b.page1_aapt300_08.l_apcb051_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_apcb051_desc
            
            #add-point:AFTER FIELD l_apcb051_desc name="input.a.page1_aapt300_08.l_apcb051_desc"
 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_apcb051_desc
            #add-point:ON CHANGE l_apcb051_desc name="input.g.page1_aapt300_08.l_apcb051_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcb010
            #add-point:BEFORE FIELD apcb010 name="input.b.page1_aapt300_08.apcb010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcb010
            
            #add-point:AFTER FIELD apcb010 name="input.a.page1_aapt300_08.apcb010"
 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apcb010
            #add-point:ON CHANGE apcb010 name="input.g.page1_aapt300_08.apcb010"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_apcb010_desc
            #add-point:BEFORE FIELD l_apcb010_desc name="input.b.page1_aapt300_08.l_apcb010_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_apcb010_desc
            
            #add-point:AFTER FIELD l_apcb010_desc name="input.a.page1_aapt300_08.l_apcb010_desc"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_apcb010_desc
            #add-point:ON CHANGE l_apcb010_desc name="input.g.page1_aapt300_08.l_apcb010_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcb011
            #add-point:BEFORE FIELD apcb011 name="input.b.page1_aapt300_08.apcb011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcb011
            
            #add-point:AFTER FIELD apcb011 name="input.a.page1_aapt300_08.apcb011"
 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apcb011
            #add-point:ON CHANGE apcb011 name="input.g.page1_aapt300_08.apcb011"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_apcb011_desc
            #add-point:BEFORE FIELD l_apcb011_desc name="input.b.page1_aapt300_08.l_apcb011_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_apcb011_desc
            
            #add-point:AFTER FIELD l_apcb011_desc name="input.a.page1_aapt300_08.l_apcb011_desc"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_apcb011_desc
            #add-point:ON CHANGE l_apcb011_desc name="input.g.page1_aapt300_08.l_apcb011_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcb024
            #add-point:BEFORE FIELD apcb024 name="input.b.page1_aapt300_08.apcb024"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcb024
            
            #add-point:AFTER FIELD apcb024 name="input.a.page1_aapt300_08.apcb024"
 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apcb024
            #add-point:ON CHANGE apcb024 name="input.g.page1_aapt300_08.apcb024"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_apcb024_desc
            #add-point:BEFORE FIELD l_apcb024_desc name="input.b.page1_aapt300_08.l_apcb024_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_apcb024_desc
            
            #add-point:AFTER FIELD l_apcb024_desc name="input.a.page1_aapt300_08.l_apcb024_desc"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_apcb024_desc
            #add-point:ON CHANGE l_apcb024_desc name="input.g.page1_aapt300_08.l_apcb024_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcb012
            #add-point:BEFORE FIELD apcb012 name="input.b.page1_aapt300_08.apcb012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcb012
            
            #add-point:AFTER FIELD apcb012 name="input.a.page1_aapt300_08.apcb012"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apcb012
            #add-point:ON CHANGE apcb012 name="input.g.page1_aapt300_08.apcb012"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_apcb012_desc
            #add-point:BEFORE FIELD l_apcb012_desc name="input.b.page1_aapt300_08.l_apcb012_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_apcb012_desc
            
            #add-point:AFTER FIELD l_apcb012_desc name="input.a.page1_aapt300_08.l_apcb012_desc"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_apcb012_desc
            #add-point:ON CHANGE l_apcb012_desc name="input.g.page1_aapt300_08.l_apcb012_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcb015
            #add-point:BEFORE FIELD apcb015 name="input.b.page1_aapt300_08.apcb015"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcb015
            
            #add-point:AFTER FIELD apcb015 name="input.a.page1_aapt300_08.apcb015"
 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apcb015
            #add-point:ON CHANGE apcb015 name="input.g.page1_aapt300_08.apcb015"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_apcb015_desc
            #add-point:BEFORE FIELD l_apcb015_desc name="input.b.page1_aapt300_08.l_apcb015_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_apcb015_desc
            
            #add-point:AFTER FIELD l_apcb015_desc name="input.a.page1_aapt300_08.l_apcb015_desc"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_apcb015_desc
            #add-point:ON CHANGE l_apcb015_desc name="input.g.page1_aapt300_08.l_apcb015_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcb016
            #add-point:BEFORE FIELD apcb016 name="input.b.page1_aapt300_08.apcb016"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcb016
            
            #add-point:AFTER FIELD apcb016 name="input.a.page1_aapt300_08.apcb016"
 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apcb016
            #add-point:ON CHANGE apcb016 name="input.g.page1_aapt300_08.apcb016"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_apcb016_desc
            #add-point:BEFORE FIELD l_apcb016_desc name="input.b.page1_aapt300_08.l_apcb016_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_apcb016_desc
            
            #add-point:AFTER FIELD l_apcb016_desc name="input.a.page1_aapt300_08.l_apcb016_desc"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_apcb016_desc
            #add-point:ON CHANGE l_apcb016_desc name="input.g.page1_aapt300_08.l_apcb016_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcb017
            #add-point:BEFORE FIELD apcb017 name="input.b.page1_aapt300_08.apcb017"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcb017
            
            #add-point:AFTER FIELD apcb017 name="input.a.page1_aapt300_08.apcb017"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apcb017
            #add-point:ON CHANGE apcb017 name="input.g.page1_aapt300_08.apcb017"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_apcb017_desc
            #add-point:BEFORE FIELD l_apcb017_desc name="input.b.page1_aapt300_08.l_apcb017_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_apcb017_desc
            
            #add-point:AFTER FIELD l_apcb017_desc name="input.a.page1_aapt300_08.l_apcb017_desc"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_apcb017_desc
            #add-point:ON CHANGE l_apcb017_desc name="input.g.page1_aapt300_08.l_apcb017_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcb033
            #add-point:BEFORE FIELD apcb033 name="input.b.page1_aapt300_08.apcb033"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcb033
            
            #add-point:AFTER FIELD apcb033 name="input.a.page1_aapt300_08.apcb033"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apcb033
            #add-point:ON CHANGE apcb033 name="input.g.page1_aapt300_08.apcb033"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcb034
            #add-point:BEFORE FIELD apcb034 name="input.b.page1_aapt300_08.apcb034"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcb034
            
            #add-point:AFTER FIELD apcb034 name="input.a.page1_aapt300_08.apcb034"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apcb034
            #add-point:ON CHANGE apcb034 name="input.g.page1_aapt300_08.apcb034"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_apcb034_desc
            #add-point:BEFORE FIELD l_apcb034_desc name="input.b.page1_aapt300_08.l_apcb034_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_apcb034_desc
            
            #add-point:AFTER FIELD l_apcb034_desc name="input.a.page1_aapt300_08.l_apcb034_desc"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_apcb034_desc
            #add-point:ON CHANGE l_apcb034_desc name="input.g.page1_aapt300_08.l_apcb034_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcb035
            #add-point:BEFORE FIELD apcb035 name="input.b.page1_aapt300_08.apcb035"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcb035
            
            #add-point:AFTER FIELD apcb035 name="input.a.page1_aapt300_08.apcb035"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apcb035
            #add-point:ON CHANGE apcb035 name="input.g.page1_aapt300_08.apcb035"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_apcb035_desc
            #add-point:BEFORE FIELD l_apcb035_desc name="input.b.page1_aapt300_08.l_apcb035_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_apcb035_desc
            
            #add-point:AFTER FIELD l_apcb035_desc name="input.a.page1_aapt300_08.l_apcb035_desc"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_apcb035_desc
            #add-point:ON CHANGE l_apcb035_desc name="input.g.page1_aapt300_08.l_apcb035_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcb036
            #add-point:BEFORE FIELD apcb036 name="input.b.page1_aapt300_08.apcb036"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcb036
            
            #add-point:AFTER FIELD apcb036 name="input.a.page1_aapt300_08.apcb036"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apcb036
            #add-point:ON CHANGE apcb036 name="input.g.page1_aapt300_08.apcb036"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_apcb036_desc
            #add-point:BEFORE FIELD l_apcb036_desc name="input.b.page1_aapt300_08.l_apcb036_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_apcb036_desc
            
            #add-point:AFTER FIELD l_apcb036_desc name="input.a.page1_aapt300_08.l_apcb036_desc"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_apcb036_desc
            #add-point:ON CHANGE l_apcb036_desc name="input.g.page1_aapt300_08.l_apcb036_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcb054
            #add-point:BEFORE FIELD apcb054 name="input.b.page1_aapt300_08.apcb054"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcb054
            
            #add-point:AFTER FIELD apcb054 name="input.a.page1_aapt300_08.apcb054"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apcb054
            #add-point:ON CHANGE apcb054 name="input.g.page1_aapt300_08.apcb054"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_apcb054_desc
            #add-point:BEFORE FIELD l_apcb054_desc name="input.b.page1_aapt300_08.l_apcb054_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_apcb054_desc
            
            #add-point:AFTER FIELD l_apcb054_desc name="input.a.page1_aapt300_08.l_apcb054_desc"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_apcb054_desc
            #add-point:ON CHANGE l_apcb054_desc name="input.g.page1_aapt300_08.l_apcb054_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcb055
            #add-point:BEFORE FIELD apcb055 name="input.b.page1_aapt300_08.apcb055"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcb055
            
            #add-point:AFTER FIELD apcb055 name="input.a.page1_aapt300_08.apcb055"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apcb055
            #add-point:ON CHANGE apcb055 name="input.g.page1_aapt300_08.apcb055"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_apcb055_desc
            #add-point:BEFORE FIELD l_apcb055_desc name="input.b.page1_aapt300_08.l_apcb055_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_apcb055_desc
            
            #add-point:AFTER FIELD l_apcb055_desc name="input.a.page1_aapt300_08.l_apcb055_desc"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_apcb055_desc
            #add-point:ON CHANGE l_apcb055_desc name="input.g.page1_aapt300_08.l_apcb055_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcb037
            #add-point:BEFORE FIELD apcb037 name="input.b.page1_aapt300_08.apcb037"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcb037
            
            #add-point:AFTER FIELD apcb037 name="input.a.page1_aapt300_08.apcb037"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apcb037
            #add-point:ON CHANGE apcb037 name="input.g.page1_aapt300_08.apcb037"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_apcb037_desc
            #add-point:BEFORE FIELD l_apcb037_desc name="input.b.page1_aapt300_08.l_apcb037_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_apcb037_desc
            
            #add-point:AFTER FIELD l_apcb037_desc name="input.a.page1_aapt300_08.l_apcb037_desc"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_apcb037_desc
            #add-point:ON CHANGE l_apcb037_desc name="input.g.page1_aapt300_08.l_apcb037_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcb038
            #add-point:BEFORE FIELD apcb038 name="input.b.page1_aapt300_08.apcb038"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcb038
            
            #add-point:AFTER FIELD apcb038 name="input.a.page1_aapt300_08.apcb038"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apcb038
            #add-point:ON CHANGE apcb038 name="input.g.page1_aapt300_08.apcb038"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_apcb038_desc
            #add-point:BEFORE FIELD l_apcb038_desc name="input.b.page1_aapt300_08.l_apcb038_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_apcb038_desc
            
            #add-point:AFTER FIELD l_apcb038_desc name="input.a.page1_aapt300_08.l_apcb038_desc"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_apcb038_desc
            #add-point:ON CHANGE l_apcb038_desc name="input.g.page1_aapt300_08.l_apcb038_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcb039
            #add-point:BEFORE FIELD apcb039 name="input.b.page1_aapt300_08.apcb039"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcb039
            
            #add-point:AFTER FIELD apcb039 name="input.a.page1_aapt300_08.apcb039"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apcb039
            #add-point:ON CHANGE apcb039 name="input.g.page1_aapt300_08.apcb039"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_apcb039_desc
            #add-point:BEFORE FIELD l_apcb039_desc name="input.b.page1_aapt300_08.l_apcb039_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_apcb039_desc
            
            #add-point:AFTER FIELD l_apcb039_desc name="input.a.page1_aapt300_08.l_apcb039_desc"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_apcb039_desc
            #add-point:ON CHANGE l_apcb039_desc name="input.g.page1_aapt300_08.l_apcb039_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcb040
            #add-point:BEFORE FIELD apcb040 name="input.b.page1_aapt300_08.apcb040"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcb040
            
            #add-point:AFTER FIELD apcb040 name="input.a.page1_aapt300_08.apcb040"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apcb040
            #add-point:ON CHANGE apcb040 name="input.g.page1_aapt300_08.apcb040"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_apcb040_desc
            #add-point:BEFORE FIELD l_apcb040_desc name="input.b.page1_aapt300_08.l_apcb040_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_apcb040_desc
            
            #add-point:AFTER FIELD l_apcb040_desc name="input.a.page1_aapt300_08.l_apcb040_desc"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_apcb040_desc
            #add-point:ON CHANGE l_apcb040_desc name="input.g.page1_aapt300_08.l_apcb040_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcb041
            #add-point:BEFORE FIELD apcb041 name="input.b.page1_aapt300_08.apcb041"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcb041
            
            #add-point:AFTER FIELD apcb041 name="input.a.page1_aapt300_08.apcb041"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apcb041
            #add-point:ON CHANGE apcb041 name="input.g.page1_aapt300_08.apcb041"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_apcb041_desc
            #add-point:BEFORE FIELD l_apcb041_desc name="input.b.page1_aapt300_08.l_apcb041_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_apcb041_desc
            
            #add-point:AFTER FIELD l_apcb041_desc name="input.a.page1_aapt300_08.l_apcb041_desc"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_apcb041_desc
            #add-point:ON CHANGE l_apcb041_desc name="input.g.page1_aapt300_08.l_apcb041_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcb042
            #add-point:BEFORE FIELD apcb042 name="input.b.page1_aapt300_08.apcb042"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcb042
            
            #add-point:AFTER FIELD apcb042 name="input.a.page1_aapt300_08.apcb042"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apcb042
            #add-point:ON CHANGE apcb042 name="input.g.page1_aapt300_08.apcb042"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_apcb042_desc
            #add-point:BEFORE FIELD l_apcb042_desc name="input.b.page1_aapt300_08.l_apcb042_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_apcb042_desc
            
            #add-point:AFTER FIELD l_apcb042_desc name="input.a.page1_aapt300_08.l_apcb042_desc"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_apcb042_desc
            #add-point:ON CHANGE l_apcb042_desc name="input.g.page1_aapt300_08.l_apcb042_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcb043
            #add-point:BEFORE FIELD apcb043 name="input.b.page1_aapt300_08.apcb043"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcb043
            
            #add-point:AFTER FIELD apcb043 name="input.a.page1_aapt300_08.apcb043"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apcb043
            #add-point:ON CHANGE apcb043 name="input.g.page1_aapt300_08.apcb043"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_apcb043_desc
            #add-point:BEFORE FIELD l_apcb043_desc name="input.b.page1_aapt300_08.l_apcb043_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_apcb043_desc
            
            #add-point:AFTER FIELD l_apcb043_desc name="input.a.page1_aapt300_08.l_apcb043_desc"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_apcb043_desc
            #add-point:ON CHANGE l_apcb043_desc name="input.g.page1_aapt300_08.l_apcb043_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcb044
            #add-point:BEFORE FIELD apcb044 name="input.b.page1_aapt300_08.apcb044"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcb044
            
            #add-point:AFTER FIELD apcb044 name="input.a.page1_aapt300_08.apcb044"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apcb044
            #add-point:ON CHANGE apcb044 name="input.g.page1_aapt300_08.apcb044"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_apcb044_desc
            #add-point:BEFORE FIELD l_apcb044_desc name="input.b.page1_aapt300_08.l_apcb044_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_apcb044_desc
            
            #add-point:AFTER FIELD l_apcb044_desc name="input.a.page1_aapt300_08.l_apcb044_desc"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_apcb044_desc
            #add-point:ON CHANGE l_apcb044_desc name="input.g.page1_aapt300_08.l_apcb044_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcb045
            #add-point:BEFORE FIELD apcb045 name="input.b.page1_aapt300_08.apcb045"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcb045
            
            #add-point:AFTER FIELD apcb045 name="input.a.page1_aapt300_08.apcb045"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apcb045
            #add-point:ON CHANGE apcb045 name="input.g.page1_aapt300_08.apcb045"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_apcb045_desc
            #add-point:BEFORE FIELD l_apcb045_desc name="input.b.page1_aapt300_08.l_apcb045_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_apcb045_desc
            
            #add-point:AFTER FIELD l_apcb045_desc name="input.a.page1_aapt300_08.l_apcb045_desc"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_apcb045_desc
            #add-point:ON CHANGE l_apcb045_desc name="input.g.page1_aapt300_08.l_apcb045_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcb046
            #add-point:BEFORE FIELD apcb046 name="input.b.page1_aapt300_08.apcb046"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcb046
            
            #add-point:AFTER FIELD apcb046 name="input.a.page1_aapt300_08.apcb046"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apcb046
            #add-point:ON CHANGE apcb046 name="input.g.page1_aapt300_08.apcb046"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_apcb046_desc
            #add-point:BEFORE FIELD l_apcb046_desc name="input.b.page1_aapt300_08.l_apcb046_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_apcb046_desc
            
            #add-point:AFTER FIELD l_apcb046_desc name="input.a.page1_aapt300_08.l_apcb046_desc"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_apcb046_desc
            #add-point:ON CHANGE l_apcb046_desc name="input.g.page1_aapt300_08.l_apcb046_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD img1
            #add-point:BEFORE FIELD img1 name="input.b.page1_aapt300_08.img1"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD img1
            
            #add-point:AFTER FIELD img1 name="input.a.page1_aapt300_08.img1"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE img1
            #add-point:ON CHANGE img1 name="input.g.page1_aapt300_08.img1"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1_aapt300_08.apcbdocno
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcbdocno
            #add-point:ON ACTION controlp INFIELD apcbdocno name="input.c.page1_aapt300_08.apcbdocno"
 
            #END add-point
 
 
         #Ctrlp:input.c.page1_aapt300_08.apcbld
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcbld
            #add-point:ON ACTION controlp INFIELD apcbld name="input.c.page1_aapt300_08.apcbld"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1_aapt300_08.apcbseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcbseq
            #add-point:ON ACTION controlp INFIELD apcbseq name="input.c.page1_aapt300_08.apcbseq"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1_aapt300_08.apcb047
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcb047
            #add-point:ON ACTION controlp INFIELD apcb047 name="input.c.page1_aapt300_08.apcb047"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1_aapt300_08.apcb021
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcb021
            #add-point:ON ACTION controlp INFIELD apcb021 name="input.c.page1_aapt300_08.apcb021"
 
            #END add-point
 
 
         #Ctrlp:input.c.page1_aapt300_08.apcb029
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcb029
            #add-point:ON ACTION controlp INFIELD apcb029 name="input.c.page1_aapt300_08.apcb029"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1_aapt300_08.apcb051
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcb051
            #add-point:ON ACTION controlp INFIELD apcb051 name="input.c.page1_aapt300_08.apcb051"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1_aapt300_08.l_apcb051_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_apcb051_desc
            #add-point:ON ACTION controlp INFIELD l_apcb051_desc name="input.c.page1_aapt300_08.l_apcb051_desc"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1_aapt300_08.apcb010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcb010
            #add-point:ON ACTION controlp INFIELD apcb010 name="input.c.page1_aapt300_08.apcb010"
 
            #END add-point
 
 
         #Ctrlp:input.c.page1_aapt300_08.l_apcb010_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_apcb010_desc
            #add-point:ON ACTION controlp INFIELD l_apcb010_desc name="input.c.page1_aapt300_08.l_apcb010_desc"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1_aapt300_08.apcb011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcb011
            #add-point:ON ACTION controlp INFIELD apcb011 name="input.c.page1_aapt300_08.apcb011"
 
            #END add-point
 
 
         #Ctrlp:input.c.page1_aapt300_08.l_apcb011_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_apcb011_desc
            #add-point:ON ACTION controlp INFIELD l_apcb011_desc name="input.c.page1_aapt300_08.l_apcb011_desc"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1_aapt300_08.apcb024
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcb024
            #add-point:ON ACTION controlp INFIELD apcb024 name="input.c.page1_aapt300_08.apcb024"
 
            #END add-point
 
 
         #Ctrlp:input.c.page1_aapt300_08.l_apcb024_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_apcb024_desc
            #add-point:ON ACTION controlp INFIELD l_apcb024_desc name="input.c.page1_aapt300_08.l_apcb024_desc"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1_aapt300_08.apcb012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcb012
            #add-point:ON ACTION controlp INFIELD apcb012 name="input.c.page1_aapt300_08.apcb012"
 
            #END add-point
 
 
         #Ctrlp:input.c.page1_aapt300_08.l_apcb012_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_apcb012_desc
            #add-point:ON ACTION controlp INFIELD l_apcb012_desc name="input.c.page1_aapt300_08.l_apcb012_desc"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1_aapt300_08.apcb015
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcb015
            #add-point:ON ACTION controlp INFIELD apcb015 name="input.c.page1_aapt300_08.apcb015"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1_aapt300_08.l_apcb015_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_apcb015_desc
            #add-point:ON ACTION controlp INFIELD l_apcb015_desc name="input.c.page1_aapt300_08.l_apcb015_desc"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1_aapt300_08.apcb016
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcb016
            #add-point:ON ACTION controlp INFIELD apcb016 name="input.c.page1_aapt300_08.apcb016"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1_aapt300_08.l_apcb016_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_apcb016_desc
            #add-point:ON ACTION controlp INFIELD l_apcb016_desc name="input.c.page1_aapt300_08.l_apcb016_desc"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1_aapt300_08.apcb017
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcb017
            #add-point:ON ACTION controlp INFIELD apcb017 name="input.c.page1_aapt300_08.apcb017"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1_aapt300_08.l_apcb017_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_apcb017_desc
            #add-point:ON ACTION controlp INFIELD l_apcb017_desc name="input.c.page1_aapt300_08.l_apcb017_desc"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1_aapt300_08.apcb033
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcb033
            #add-point:ON ACTION controlp INFIELD apcb033 name="input.c.page1_aapt300_08.apcb033"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1_aapt300_08.apcb034
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcb034
            #add-point:ON ACTION controlp INFIELD apcb034 name="input.c.page1_aapt300_08.apcb034"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1_aapt300_08.l_apcb034_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_apcb034_desc
            #add-point:ON ACTION controlp INFIELD l_apcb034_desc name="input.c.page1_aapt300_08.l_apcb034_desc"
 
            #END add-point
 
 
         #Ctrlp:input.c.page1_aapt300_08.apcb035
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcb035
            #add-point:ON ACTION controlp INFIELD apcb035 name="input.c.page1_aapt300_08.apcb035"
 
            #END add-point
 
 
         #Ctrlp:input.c.page1_aapt300_08.l_apcb035_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_apcb035_desc
            #add-point:ON ACTION controlp INFIELD l_apcb035_desc name="input.c.page1_aapt300_08.l_apcb035_desc"
 
            #END add-point
 
 
         #Ctrlp:input.c.page1_aapt300_08.apcb036
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcb036
            #add-point:ON ACTION controlp INFIELD apcb036 name="input.c.page1_aapt300_08.apcb036"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1_aapt300_08.l_apcb036_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_apcb036_desc
            #add-point:ON ACTION controlp INFIELD l_apcb036_desc name="input.c.page1_aapt300_08.l_apcb036_desc"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1_aapt300_08.apcb054
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcb054
            #add-point:ON ACTION controlp INFIELD apcb054 name="input.c.page1_aapt300_08.apcb054"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1_aapt300_08.l_apcb054_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_apcb054_desc
            #add-point:ON ACTION controlp INFIELD l_apcb054_desc name="input.c.page1_aapt300_08.l_apcb054_desc"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1_aapt300_08.apcb055
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcb055
            #add-point:ON ACTION controlp INFIELD apcb055 name="input.c.page1_aapt300_08.apcb055"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1_aapt300_08.l_apcb055_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_apcb055_desc
            #add-point:ON ACTION controlp INFIELD l_apcb055_desc name="input.c.page1_aapt300_08.l_apcb055_desc"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1_aapt300_08.apcb037
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcb037
            #add-point:ON ACTION controlp INFIELD apcb037 name="input.c.page1_aapt300_08.apcb037"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1_aapt300_08.l_apcb037_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_apcb037_desc
            #add-point:ON ACTION controlp INFIELD l_apcb037_desc name="input.c.page1_aapt300_08.l_apcb037_desc"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1_aapt300_08.apcb038
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcb038
            #add-point:ON ACTION controlp INFIELD apcb038 name="input.c.page1_aapt300_08.apcb038"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1_aapt300_08.l_apcb038_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_apcb038_desc
            #add-point:ON ACTION controlp INFIELD l_apcb038_desc name="input.c.page1_aapt300_08.l_apcb038_desc"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1_aapt300_08.apcb039
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcb039
            #add-point:ON ACTION controlp INFIELD apcb039 name="input.c.page1_aapt300_08.apcb039"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1_aapt300_08.l_apcb039_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_apcb039_desc
            #add-point:ON ACTION controlp INFIELD l_apcb039_desc name="input.c.page1_aapt300_08.l_apcb039_desc"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1_aapt300_08.apcb040
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcb040
            #add-point:ON ACTION controlp INFIELD apcb040 name="input.c.page1_aapt300_08.apcb040"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1_aapt300_08.l_apcb040_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_apcb040_desc
            #add-point:ON ACTION controlp INFIELD l_apcb040_desc name="input.c.page1_aapt300_08.l_apcb040_desc"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1_aapt300_08.apcb041
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcb041
            #add-point:ON ACTION controlp INFIELD apcb041 name="input.c.page1_aapt300_08.apcb041"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1_aapt300_08.l_apcb041_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_apcb041_desc
            #add-point:ON ACTION controlp INFIELD l_apcb041_desc name="input.c.page1_aapt300_08.l_apcb041_desc"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1_aapt300_08.apcb042
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcb042
            #add-point:ON ACTION controlp INFIELD apcb042 name="input.c.page1_aapt300_08.apcb042"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1_aapt300_08.l_apcb042_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_apcb042_desc
            #add-point:ON ACTION controlp INFIELD l_apcb042_desc name="input.c.page1_aapt300_08.l_apcb042_desc"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1_aapt300_08.apcb043
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcb043
            #add-point:ON ACTION controlp INFIELD apcb043 name="input.c.page1_aapt300_08.apcb043"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1_aapt300_08.l_apcb043_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_apcb043_desc
            #add-point:ON ACTION controlp INFIELD l_apcb043_desc name="input.c.page1_aapt300_08.l_apcb043_desc"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1_aapt300_08.apcb044
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcb044
            #add-point:ON ACTION controlp INFIELD apcb044 name="input.c.page1_aapt300_08.apcb044"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1_aapt300_08.l_apcb044_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_apcb044_desc
            #add-point:ON ACTION controlp INFIELD l_apcb044_desc name="input.c.page1_aapt300_08.l_apcb044_desc"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1_aapt300_08.apcb045
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcb045
            #add-point:ON ACTION controlp INFIELD apcb045 name="input.c.page1_aapt300_08.apcb045"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1_aapt300_08.l_apcb045_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_apcb045_desc
            #add-point:ON ACTION controlp INFIELD l_apcb045_desc name="input.c.page1_aapt300_08.l_apcb045_desc"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1_aapt300_08.apcb046
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcb046
            #add-point:ON ACTION controlp INFIELD apcb046 name="input.c.page1_aapt300_08.apcb046"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1_aapt300_08.l_apcb046_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_apcb046_desc
            #add-point:ON ACTION controlp INFIELD l_apcb046_desc name="input.c.page1_aapt300_08.l_apcb046_desc"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1_aapt300_08.img1
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD img1
            #add-point:ON ACTION controlp INFIELD img1 name="input.c.page1_aapt300_08.img1"
            
            #END add-point
 
 
 
 
         #自訂ACTION
         #add-point:單身其他段落處理(EX:on row change, etc...) name="input.other"
         
         #end add-point
 
         AFTER INPUT
            #add-point:單身輸入後處理 name="input.after_input"
            
            #end add-point
            
      END INPUT
      
 
      
      #add-point:自定義input name="input.more_input"
      
      #end add-point
    
      #公用action
      ON ACTION accept
         ACCEPT DIALOG
        
      ON ACTION cancel
         #add-point:cancel name="input.cancel"
         
         #end add-point
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
   CLOSE WINDOW w_aapt300_08 
   
   #add-point:input段after input name="input.post_input"
   
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="aapt300_08.other_dialog" readonly="Y" >}

################################################################################
# Descriptions...: 單身其他訊息
# Memo...........:
# Usage..........: aapt300_08_display()
# Date & Author..: 14/09/25 By Belle
# Modify.........:
################################################################################
DIALOG aapt300_08_display()

   DISPLAY ARRAY g_apcb_d TO s_detail1_aapt300_08.* ATTRIBUTES(COUNT=g_rec_b04) 
   
      BEFORE DISPLAY
         CALL FGL_SET_ARR_CURR(g_detail_idx)
      
      AFTER DISPLAY
         LET g_apcb_d4.* = g_apcb_d.*
   END DISPLAY
   
END DIALOG

################################################################################
# Descriptions...: 
# Memo...........:
# Usage..........: aapt300_08_input()
# Date & Author..: 14/09/25 By Belle
# Modify.........:
################################################################################
DIALOG aapt300_08_input()
#DEFINE l_apcb         RECORD LIKE apcb_t.* #161104-00024#2 mark
#161104-00024#2-add(s)
DEFINE l_apcb  RECORD  #應付憑單單身
       apcbent   LIKE apcb_t.apcbent, #企業編號
       apcbld    LIKE apcb_t.apcbld, #帳套
       apcblegl  LIKE apcb_t.apcblegl, #核算組織
       apcborga  LIKE apcb_t.apcborga, #帳務歸屬組織(來源組織)
       apcbsite  LIKE apcb_t.apcbsite, #應付帳務組織
       apcbdocno LIKE apcb_t.apcbdocno, #單號
       apcbseq   LIKE apcb_t.apcbseq, #項次
       apcb001   LIKE apcb_t.apcb001, #來源類型
       apcb002   LIKE apcb_t.apcb002, #來源業務單據號碼
       apcb003   LIKE apcb_t.apcb003, #來源業務單據項次
       apcb004   LIKE apcb_t.apcb004, #產品編號
       apcb005   LIKE apcb_t.apcb005, #品名規格
       apcb006   LIKE apcb_t.apcb006, #單位
       apcb007   LIKE apcb_t.apcb007, #計價數量
       apcb008   LIKE apcb_t.apcb008, #參考單據號碼
       apcb009   LIKE apcb_t.apcb009, #參考單據項次
       apcb010   LIKE apcb_t.apcb010, #業務部門
       apcb011   LIKE apcb_t.apcb011, #責任中心
       apcb012   LIKE apcb_t.apcb012, #產品類別
       apcb013   LIKE apcb_t.apcb013, #搭贈
       apcb014   LIKE apcb_t.apcb014, #理由碼
       apcb015   LIKE apcb_t.apcb015, #專案編號
       apcb016   LIKE apcb_t.apcb016, #WBS編號
       apcb017   LIKE apcb_t.apcb017, #預算細項
       apcb018   LIKE apcb_t.apcb018, #专柜编号
       apcb019   LIKE apcb_t.apcb019, #開票性質
       apcb020   LIKE apcb_t.apcb020, #稅別
       apcb021   LIKE apcb_t.apcb021, #費用會計科目
       apcb022   LIKE apcb_t.apcb022, #正負值
       apcb023   LIKE apcb_t.apcb023, #沖暫估單否
       apcb024   LIKE apcb_t.apcb024, #區域
       apcb025   LIKE apcb_t.apcb025, #傳票號碼
       apcb026   LIKE apcb_t.apcb026, #傳票項次
       apcb027   LIKE apcb_t.apcb027, #發票代碼
       apcb028   LIKE apcb_t.apcb028, #發票號碼
       apcb029   LIKE apcb_t.apcb029, #應付帳款科目
       apcb030   LIKE apcb_t.apcb030, #付款條件
       apcb032   LIKE apcb_t.apcb032, #訂金序次
       apcb033   LIKE apcb_t.apcb033, #經營方式
       apcb034   LIKE apcb_t.apcb034, #通路
       apcb035   LIKE apcb_t.apcb035, #品牌
       apcb036   LIKE apcb_t.apcb036, #客群
       apcb037   LIKE apcb_t.apcb037, #自由核算項一
       apcb038   LIKE apcb_t.apcb038, #自由核算項二
       apcb039   LIKE apcb_t.apcb039, #自由核算項三
       apcb040   LIKE apcb_t.apcb040, #自由核算項四
       apcb041   LIKE apcb_t.apcb041, #自由核算項五
       apcb042   LIKE apcb_t.apcb042, #自由核算項六
       apcb043   LIKE apcb_t.apcb043, #自由核算項七
       apcb044   LIKE apcb_t.apcb044, #自由核算項八
       apcb045   LIKE apcb_t.apcb045, #自由核算項九
       apcb046   LIKE apcb_t.apcb046, #自由核算項十
       apcb047   LIKE apcb_t.apcb047, #摘要
       apcb048   LIKE apcb_t.apcb048, #來源訂購單號
       apcb049   LIKE apcb_t.apcb049, #開票單號
       apcb050   LIKE apcb_t.apcb050, #開票項次
       apcb051   LIKE apcb_t.apcb051, #業務人員
       apcb100   LIKE apcb_t.apcb100, #交易原幣
       apcb101   LIKE apcb_t.apcb101, #交易原幣單價
       apcb102   LIKE apcb_t.apcb102, #原幣匯率
       apcb103   LIKE apcb_t.apcb103, #交易原幣未稅金額
       apcb104   LIKE apcb_t.apcb104, #交易原幣稅額
       apcb105   LIKE apcb_t.apcb105, #交易原幣含稅金額
       apcb106   LIKE apcb_t.apcb106, #交易幣標準成本金額
       apcb107   LIKE apcb_t.apcb107, #NO USE
       apcb108   LIKE apcb_t.apcb108, #交易原幣成本認列金額
       apcb111   LIKE apcb_t.apcb111, #本幣單價
       apcb113   LIKE apcb_t.apcb113, #本幣未稅金額
       apcb114   LIKE apcb_t.apcb114, #本幣稅額
       apcb115   LIKE apcb_t.apcb115, #本幣含稅金額
       apcb116   LIKE apcb_t.apcb116, #本幣標準成本金額
       apcb117   LIKE apcb_t.apcb117, #NO USE
       apcb118   LIKE apcb_t.apcb118, #本幣成本認列金額
       apcb119   LIKE apcb_t.apcb119, #應開發票含稅金額
       apcb121   LIKE apcb_t.apcb121, #本位幣二匯率
       apcb123   LIKE apcb_t.apcb123, #本位幣二未稅金額
       apcb124   LIKE apcb_t.apcb124, #本位幣二稅額
       apcb125   LIKE apcb_t.apcb125, #本位幣二含稅金額
       apcb126   LIKE apcb_t.apcb126, #本幣二標準成本金額
       apcb127   LIKE apcb_t.apcb127, #NO USE
       apcb128   LIKE apcb_t.apcb128, #本位幣二成本認列金額
       apcb131   LIKE apcb_t.apcb131, #本位幣三匯率
       apcb133   LIKE apcb_t.apcb133, #本位幣三未稅金額
       apcb134   LIKE apcb_t.apcb134, #本位幣三稅額
       apcb135   LIKE apcb_t.apcb135, #本位幣三含稅金額
       apcb136   LIKE apcb_t.apcb136, #本幣三標準成本金額
       apcb137   LIKE apcb_t.apcb137, #NO USE
       apcb138   LIKE apcb_t.apcb138, #本位幣三成本認列金額
       apcbud001 LIKE apcb_t.apcbud001, #自定義欄位(文字)001
       apcbud002 LIKE apcb_t.apcbud002, #自定義欄位(文字)002
       apcbud003 LIKE apcb_t.apcbud003, #自定義欄位(文字)003
       apcbud004 LIKE apcb_t.apcbud004, #自定義欄位(文字)004
       apcbud005 LIKE apcb_t.apcbud005, #自定義欄位(文字)005
       apcbud006 LIKE apcb_t.apcbud006, #自定義欄位(文字)006
       apcbud007 LIKE apcb_t.apcbud007, #自定義欄位(文字)007
       apcbud008 LIKE apcb_t.apcbud008, #自定義欄位(文字)008
       apcbud009 LIKE apcb_t.apcbud009, #自定義欄位(文字)009
       apcbud010 LIKE apcb_t.apcbud010, #自定義欄位(文字)010
       apcbud011 LIKE apcb_t.apcbud011, #自定義欄位(數字)011
       apcbud012 LIKE apcb_t.apcbud012, #自定義欄位(數字)012
       apcbud013 LIKE apcb_t.apcbud013, #自定義欄位(數字)013
       apcbud014 LIKE apcb_t.apcbud014, #自定義欄位(數字)014
       apcbud015 LIKE apcb_t.apcbud015, #自定義欄位(數字)015
       apcbud016 LIKE apcb_t.apcbud016, #自定義欄位(數字)016
       apcbud017 LIKE apcb_t.apcbud017, #自定義欄位(數字)017
       apcbud018 LIKE apcb_t.apcbud018, #自定義欄位(數字)018
       apcbud019 LIKE apcb_t.apcbud019, #自定義欄位(數字)019
       apcbud020 LIKE apcb_t.apcbud020, #自定義欄位(數字)020
       apcbud021 LIKE apcb_t.apcbud021, #自定義欄位(日期時間)021
       apcbud022 LIKE apcb_t.apcbud022, #自定義欄位(日期時間)022
       apcbud023 LIKE apcb_t.apcbud023, #自定義欄位(日期時間)023
       apcbud024 LIKE apcb_t.apcbud024, #自定義欄位(日期時間)024
       apcbud025 LIKE apcb_t.apcbud025, #自定義欄位(日期時間)025
       apcbud026 LIKE apcb_t.apcbud026, #自定義欄位(日期時間)026
       apcbud027 LIKE apcb_t.apcbud027, #自定義欄位(日期時間)027
       apcbud028 LIKE apcb_t.apcbud028, #自定義欄位(日期時間)028
       apcbud029 LIKE apcb_t.apcbud029, #自定義欄位(日期時間)029
       apcbud030 LIKE apcb_t.apcbud030, #自定義欄位(日期時間)030
       apcb052   LIKE apcb_t.apcb052, #稅額
       apcb053   LIKE apcb_t.apcb053, #含稅金額
       apcb054   LIKE apcb_t.apcb054, #帳款對象
       apcb055   LIKE apcb_t.apcb055  #付款對象
           END RECORD
#161104-00024#2-add(e)
DEFINE l_forupd_sql   STRING
DEFINE l_lock_sw      LIKE type_t.chr1 
DEFINE l_apcadocdt    LIKE apca_t.apcadocdt
DEFINE l_apcald       LIKE apca_t.apcald
DEFINE l_apcadocno    LIKE apca_t.apcadocno
DEFINE l_glaa004      LIKE glaa_t.glaa004   
DEFINE l_glaa121      LIKE glaa_t.glaa121  
DEFINE l_glaacomp     LIKE glaa_t.glaacomp
DEFINE l_dfin0030     LIKE type_t.chr1
DEFINE l_ap_slip      LIKE apca_t.apcadocno
DEFINE l_cmd          LIKE type_t.chr5
DEFINE l_glae009      LIKE glae_t.glae009
DEFINE l_glad         RECORD
                      glad0171    LIKE  glad_t.glad0171, 
                      glad0172    LIKE  glad_t.glad0172,
                      glad0181    LIKE  glad_t.glad0181,
                      glad0182    LIKE  glad_t.glad0182,
                      glad0191    LIKE  glad_t.glad0191,
                      glad0192    LIKE  glad_t.glad0192,
                      glad0201    LIKE  glad_t.glad0201,
                      glad0202    LIKE  glad_t.glad0202,
                      glad0211    LIKE  glad_t.glad0211,
                      glad0212    LIKE  glad_t.glad0212,
                      glad0221    LIKE  glad_t.glad0221,
                      glad0222    LIKE  glad_t.glad0222,
                      glad0231    LIKE  glad_t.glad0231,
                      glad0232    LIKE  glad_t.glad0232,
                      glad0241    LIKE  glad_t.glad0241,
                      glad0242    LIKE  glad_t.glad0242,
                      glad0251    LIKE  glad_t.glad0251,
                      glad0252    LIKE  glad_t.glad0252,
                      glad0261    LIKE  glad_t.glad0261,
                      glad0262    LIKE  glad_t.glad0262
                  END RECORD
   #ADD BY XZG20151203 B
   DEFINE l_sql                  STRING
   #ADD BY XZG20151203 e
#160107-00003#8 add --start--
DEFINE l_glad_029 RECORD
                      glad0171    LIKE  glad_t.glad0171, 
                      glad0172    LIKE  glad_t.glad0172,
                      glad0181    LIKE  glad_t.glad0181,
                      glad0182    LIKE  glad_t.glad0182,
                      glad0191    LIKE  glad_t.glad0191,
                      glad0192    LIKE  glad_t.glad0192,
                      glad0201    LIKE  glad_t.glad0201,
                      glad0202    LIKE  glad_t.glad0202,
                      glad0211    LIKE  glad_t.glad0211,
                      glad0212    LIKE  glad_t.glad0212,
                      glad0221    LIKE  glad_t.glad0221,
                      glad0222    LIKE  glad_t.glad0222,
                      glad0231    LIKE  glad_t.glad0231,
                      glad0232    LIKE  glad_t.glad0232,
                      glad0241    LIKE  glad_t.glad0241,
                      glad0242    LIKE  glad_t.glad0242,
                      glad0251    LIKE  glad_t.glad0251,
                      glad0252    LIKE  glad_t.glad0252,
                      glad0261    LIKE  glad_t.glad0261,
                      glad0262    LIKE  glad_t.glad0262
                  END RECORD
#160107-00003#8 add --end--
#160902-00034#1 ---s---
DEFINE l_apca059     LIKE apca_t.apca059 #預算編號
DEFINE l_apcacomp    LIKE apca_t.apcacomp
DEFINE l_bgaa008     LIKE bgaa_t.bgaa008 #預算細項參照表
DEFINE l_dfin5002    LIKE type_t.chr1    #是否使用預算編制
#160902-00034#1 ---e---
DEFINE l_sql_ctrl    STRING   #160920-00019#1---add
DEFINE l_apcb002     LIKE apcb_t.apcb002
#161221-00054#1 add ------
DEFINE l_wc          STRING
DEFINE l_glak_sql    STRING
DEFINE l_ooaa002     LIKE ooaa_t.ooaa002
#161221-00054#1 add end---

   INPUT ARRAY g_apcb_d FROM s_detail1_aapt300_08.*
      ATTRIBUTE(COUNT = g_rec_b04,MAXCOUNT = g_rec_b04,WITHOUT DEFAULTS, 
                INSERT ROW = FALSE,
                DELETE ROW = FALSE,
                APPEND ROW = FALSE)
         
      BEFORE INPUT 
         #150901-00020#7--s
         IF g_prog MATCHES 'aapt30[01]' OR g_prog MATCHES 'aapt34[01]' OR g_prog MATCHES 'aapt3[21]0' THEN  #150828-00001#7 add aapt310/aapt320
            CALL cl_set_comp_entry("l_apcb010_desc",FALSE)
         END IF
         #150901-00020#7--e
         SELECT apcadocdt INTO l_apcadocdt
           FROM apca_t
          WHERE apcaent = g_enterprise
            AND apcald  = g_apcb_d[1].apcbld AND apcadocno =  g_apcb_d[1].apcbdocno
         CALL s_ld_sel_glaa(g_apcb_d[1].apcbld,'glaa004|glaa121|glaacomp') RETURNING g_sub_success,l_glaa004,l_glaa121,l_glaacomp
         CALL cl_set_combo_scc('apcb033','6013')
         LET l_forupd_sql = " SELECT apcbdocno,apcbld,apcbseq,apcb047,  ",
                            "        apcb021,'',apcb029,'',apcb051,'',apcb010,'',apcb011,'',apcb024,'',",
                            "        apcb012,'',apcb015,'',apcb016,'',apcb017,'',apcb033,   apcb034,'',", #
                            "        apcb035,'',apcb036,'',apcb054,'',apcb055,'' ",   #160509-00004#110 add apcb054,'',apcb055,'' lujh
                            "        apcb037,'',apcb038,'',apcb039,'',apcb040,'',apcb041,'',",
                            "        apcb042,'',apcb043,'',apcb044,'',apcb045,'',apcb046,'' ",
                            "   FROM apcb_t ",
                            "  WHERE apcbent = ",g_enterprise," AND apcbld = ? AND apcbdocno = ? AND apcbseq = ?",
                            "    FOR UPDATE"
         LET l_forupd_sql = cl_sql_forupd(l_forupd_sql)  
         PREPARE aapt300_08_input_p FROM l_forupd_sql
         DECLARE aapt300_08_input_c CURSOR FOR aapt300_08_input_p
         #160920-00019#1---s
         LET l_sql_ctrl = NULL
         CALL s_control_get_supplier_sql('4',g_site,g_user,g_dept,'') RETURNING g_sub_success,l_sql_ctrl
         #160920-00019#1---e
            
      BEFORE ROW
         LET l_cmd = ''
         LET l_ac = ARR_CURR()
         LET l_lock_sw = 'N'            #DEFAULT
         DISPLAY l_ac TO FORMONLY.idx
      
         CALL s_transaction_begin()
         LET g_rec_b = g_apcb_d.getLength()
         
         LET l_cmd='u'
         SELECT apcadocdt,apcacomp,apca059 INTO l_apcadocdt,l_apcacomp,l_apca059 #160902-00034#1 add apcacomp,apca059
           FROM apca_t
          WHERE apcaent = g_enterprise  
            AND apcald  = g_apcb_d[l_ac].apcbld AND apcadocno = g_apcb_d[l_ac].apcbdocno
         LET l_apcald   = g_apcb_d[l_ac].apcbld
         LET l_apcadocno= g_apcb_d[l_ac].apcbdocno                 
         
         LET g_apcb_d_t.* = g_apcb_d[l_ac].*  
         CALL s_transaction_begin()
         
         OPEN aapt300_08_input_c USING g_apcb_d[l_ac].apcbld,g_apcb_d[l_ac].apcbdocno,g_apcb_d[l_ac].apcbseq 
         IF SQLCA.sqlcode THEN
            LET l_lock_sw='Y'
         ELSE
            FETCH aapt300_08_input_c INTO g_apcb_d[l_ac].*
            IF SQLCA.sqlcode THEN
               LET l_lock_sw = "Y"
            END IF
            CALL cl_show_fld_cont()
            
            #一定要寫在這個位置，避免觸發SQLCA.sqlcode導致l_lock_sw = "Y"
            CALL s_fin_sel_glad(g_apcb_d[l_ac].apcbld,g_apcb_d[l_ac].apcb021,'glad0171|glad0172|glad0181|glad0182|glad0191|glad0192|glad0201|glad0202|glad0211|glad0212|glad0221|glad0222|glad0231|glad0232|glad0241|glad0242|glad0251|glad0252|glad0261|glad0262') 
                 RETURNING g_errno,l_glad.*
            #160107-00003#8 add --start--
            CALL s_fin_sel_glad(g_apcb_d[l_ac].apcbld,g_apcb_d[l_ac].apcb029,'glad0171|glad0172|glad0181|glad0182|glad0191|glad0192|glad0201|glad0202|glad0211|glad0212|glad0221|glad0222|glad0231|glad0232|glad0241|glad0242|glad0251|glad0252|glad0261|glad0262') 
                 RETURNING g_errno,l_glad_029.*
            IF cl_null(l_glad.glad0171) THEN LET l_glad.glad0171 = l_glad_029.glad0171 END IF
            IF cl_null(l_glad.glad0172) THEN LET l_glad.glad0172 = l_glad_029.glad0172 END IF
            IF cl_null(l_glad.glad0181) THEN LET l_glad.glad0181 = l_glad_029.glad0181 END IF
            IF cl_null(l_glad.glad0182) THEN LET l_glad.glad0182 = l_glad_029.glad0182 END IF
            IF cl_null(l_glad.glad0191) THEN LET l_glad.glad0191 = l_glad_029.glad0191 END IF
            IF cl_null(l_glad.glad0192) THEN LET l_glad.glad0192 = l_glad_029.glad0192 END IF
            IF cl_null(l_glad.glad0201) THEN LET l_glad.glad0201 = l_glad_029.glad0201 END IF
            IF cl_null(l_glad.glad0202) THEN LET l_glad.glad0202 = l_glad_029.glad0202 END IF
            IF cl_null(l_glad.glad0211) THEN LET l_glad.glad0211 = l_glad_029.glad0211 END IF
            IF cl_null(l_glad.glad0212) THEN LET l_glad.glad0212 = l_glad_029.glad0212 END IF
            IF cl_null(l_glad.glad0221) THEN LET l_glad.glad0221 = l_glad_029.glad0221 END IF
            IF cl_null(l_glad.glad0222) THEN LET l_glad.glad0222 = l_glad_029.glad0222 END IF
            IF cl_null(l_glad.glad0231) THEN LET l_glad.glad0231 = l_glad_029.glad0231 END IF
            IF cl_null(l_glad.glad0232) THEN LET l_glad.glad0232 = l_glad_029.glad0232 END IF
            IF cl_null(l_glad.glad0241) THEN LET l_glad.glad0241 = l_glad_029.glad0241 END IF
            IF cl_null(l_glad.glad0242) THEN LET l_glad.glad0242 = l_glad_029.glad0242 END IF
            IF cl_null(l_glad.glad0251) THEN LET l_glad.glad0251 = l_glad_029.glad0251 END IF
            IF cl_null(l_glad.glad0252) THEN LET l_glad.glad0252 = l_glad_029.glad0252 END IF
            IF cl_null(l_glad.glad0261) THEN LET l_glad.glad0261 = l_glad_029.glad0261 END IF
            IF cl_null(l_glad.glad0262) THEN LET l_glad.glad0262 = l_glad_029.glad0262 END IF
            #160107-00003#8 add --end--
            LET g_apcb_d[l_ac].l_apcb051_desc = s_desc_show1(g_apcb_d[l_ac].apcb051,s_desc_get_person_desc(g_apcb_d[l_ac].apcb051))
            LET g_apcb_d[l_ac].l_apcb010_desc = s_desc_show1(g_apcb_d[l_ac].apcb010,s_desc_get_department_desc(g_apcb_d[l_ac].apcb010))
            LET g_apcb_d[l_ac].l_apcb011_desc = s_desc_show1(g_apcb_d[l_ac].apcb011,s_desc_get_department_desc(g_apcb_d[l_ac].apcb011))
            LET g_apcb_d[l_ac].l_apcb012_desc = s_desc_show1(g_apcb_d[l_ac].apcb012,s_desc_get_rtaxl003_desc(g_apcb_d[l_ac].apcb012))
            LET g_apcb_d[l_ac].l_apcb015_desc = s_desc_show1(g_apcb_d[l_ac].apcb015,s_desc_get_project_desc(g_apcb_d[l_ac].apcb015))
            LET g_apcb_d[l_ac].l_apcb021_desc = s_desc_show1(g_apcb_d[l_ac].apcb021 ,s_desc_get_account_desc(g_apcb_d[l_ac].apcbld,g_apcb_d[l_ac].apcb021))
            LET g_apcb_d[l_ac].l_apcb024_desc = s_desc_show1(g_apcb_d[l_ac].apcb024,s_desc_get_acc_desc('287',g_apcb_d[l_ac].apcb024))
            
            LET g_apcb_d[l_ac].l_apcb029_desc = s_desc_show1(g_apcb_d[l_ac].apcb029 ,s_desc_get_account_desc(g_apcb_d[l_ac].apcbld,g_apcb_d[l_ac].apcb029))
            LET g_apcb_d[l_ac].l_apcb034_desc = s_desc_show1(g_apcb_d[l_ac].apcb034, s_desc_get_oojdl003_desc(g_apcb_d[l_ac].apcb034))
            LET g_apcb_d[l_ac].l_apcb035_desc = s_desc_show1(g_apcb_d[l_ac].apcb035,s_desc_get_acc_desc('2002',g_apcb_d[l_ac].apcb035))
            LET g_apcb_d[l_ac].l_apcb036_desc = s_desc_show1(g_apcb_d[l_ac].apcb036,s_desc_get_acc_desc('281',g_apcb_d[l_ac].apcb036))
            
            #160902-00034#1---s---
            IF NOT cl_null(g_apcb_d[l_ac].apcb017) THEN
              #取得預算細項參照表 預算細項          
              SELECT bgaa008 INTO l_bgaa008 FROM bgaa_t WHERE bgaaent = g_enterprise AND bgaa001 = l_apca059
              SELECT bgael003 INTO g_apcb_d[l_ac].l_apcb017_desc 
                FROM bgael_t 
               WHERE bgaelent = g_enterprise AND bgael006 = l_bgaa008 
                 AND bgael001 = g_apcb_d[l_ac].apcb017 AND bgael002 = g_dlang
              LET g_apcb_d[l_ac].l_apcb017_desc = s_desc_show1(g_apcb_d[l_ac].apcb017,g_apcb_d[l_ac].l_apcb017_desc)
            END IF
            #160902-00034#1---e---
            
            #160509-00004#110--add--str--lujh
            IF NOT cl_null(g_apcb_d[l_ac].apcb054) THEN 
               LET g_apcb_d[l_ac].l_apcb054_desc = s_desc_show1(g_apcb_d[l_ac].apcb054,g_apcb_d[l_ac].l_apcb054_desc)
            END IF
            
            IF NOT cl_null(g_apcb_d[l_ac].apcb055) THEN 
               LET g_apcb_d[l_ac].l_apcb055_desc = s_desc_show1(g_apcb_d[l_ac].apcb055,g_apcb_d[l_ac].l_apcb055_desc)
            END IF
            #160509-00004#110--add--end--lujh
            
            IF NOT cl_null(g_apcb_d[l_ac].l_apcb037_desc) THEN
               LET g_apcb_d[l_ac].l_apcb037_desc = s_desc_show1(g_apcb_d[l_ac].apcb037,s_fin_get_accting_desc(l_glad.glad0171,g_apcb_d[l_ac].apcb037))
            END IF
            IF NOT cl_null(g_apcb_d[l_ac].l_apcb038_desc) THEN
               LET g_apcb_d[l_ac].l_apcb038_desc = s_desc_show1(g_apcb_d[l_ac].apcb038,s_fin_get_accting_desc(l_glad.glad0181,g_apcb_d[l_ac].apcb038))
            END IF
            IF NOT cl_null(g_apcb_d[l_ac].l_apcb039_desc) THEN
               LET g_apcb_d[l_ac].l_apcb039_desc = s_desc_show1(g_apcb_d[l_ac].apcb039,s_fin_get_accting_desc(l_glad.glad0191,g_apcb_d[l_ac].apcb039))
            END IF
            IF NOT cl_null(g_apcb_d[l_ac].l_apcb040_desc) THEN
               LET g_apcb_d[l_ac].l_apcb040_desc = s_desc_show1(g_apcb_d[l_ac].apcb040,s_fin_get_accting_desc(l_glad.glad0201,g_apcb_d[l_ac].apcb040))
            END IF
            IF NOT cl_null(g_apcb_d[l_ac].l_apcb041_desc) THEN
               LET g_apcb_d[l_ac].l_apcb041_desc = s_desc_show1(g_apcb_d[l_ac].apcb041,s_fin_get_accting_desc(l_glad.glad0211,g_apcb_d[l_ac].apcb041))
            END IF
            IF NOT cl_null(g_apcb_d[l_ac].l_apcb042_desc) THEN
               LET g_apcb_d[l_ac].l_apcb042_desc = s_desc_show1(g_apcb_d[l_ac].apcb042,s_fin_get_accting_desc(l_glad.glad0221,g_apcb_d[l_ac].apcb042))
            END IF
            IF NOT cl_null(g_apcb_d[l_ac].l_apcb043_desc) THEN
               LET g_apcb_d[l_ac].l_apcb043_desc = s_desc_show1(g_apcb_d[l_ac].apcb043,s_fin_get_accting_desc(l_glad.glad0231,g_apcb_d[l_ac].apcb043))
            END IF
            IF NOT cl_null(g_apcb_d[l_ac].l_apcb044_desc) THEN
               LET g_apcb_d[l_ac].l_apcb044_desc = s_desc_show1(g_apcb_d[l_ac].apcb044,s_fin_get_accting_desc(l_glad.glad0241,g_apcb_d[l_ac].apcb044))
            END IF
            IF NOT cl_null(g_apcb_d[l_ac].l_apcb045_desc) THEN
               LET g_apcb_d[l_ac].l_apcb045_desc = s_desc_show1(g_apcb_d[l_ac].apcb045,s_fin_get_accting_desc(l_glad.glad0251,g_apcb_d[l_ac].apcb045))
            END IF
            IF NOT cl_null(g_apcb_d[l_ac].l_apcb046_desc) THEN
               LET g_apcb_d[l_ac].l_apcb046_desc = s_desc_show1(g_apcb_d[l_ac].apcb046,s_fin_get_accting_desc(l_glad.glad0261,g_apcb_d[l_ac].apcb046))
            END IF
            
            #161221-00054#1 add ------
            LET l_wc = g_apcb_d[l_ac].apcb021,",",g_apcb_d[l_ac].apcb029
            CALL s_fin_get_wc_str(l_wc) RETURNING l_wc
            #161221-00054#1 add end---
      
         END IF

      ON ROW CHANGE
         IF INT_FLAG THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = 9001
            LET g_errparam.extend = ''
            LET g_errparam.popup = TRUE
            CALL cl_err()
            LET INT_FLAG = 0
            LET g_apcb_d[l_ac].* = g_apcb_d_t.*
            CLOSE aapt300_08_input_c
            CALL s_transaction_end('N',0)
            EXIT DIALOG 
         END IF
            
            
         IF l_lock_sw = 'Y' THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = -263
            LET g_errparam.extend = g_apcb_d[l_ac].apcbseq                
            LET g_errparam.popup = TRUE
            CALL cl_err()
            LET g_apcb_d[l_ac].* = g_apcb_d_t.*
         ELSE          
         
            UPDATE apcb_t SET apcb021 = g_apcb_d[l_ac].apcb021, apcb029 = g_apcb_d[l_ac].apcb029,
                              apcb051 = g_apcb_d[l_ac].apcb051, 
                              apcb010 = g_apcb_d[l_ac].apcb010, apcb011 = g_apcb_d[l_ac].apcb011,
                              apcb024 = g_apcb_d[l_ac].apcb024, apcb012 = g_apcb_d[l_ac].apcb012,
                              apcb015 = g_apcb_d[l_ac].apcb015, apcb016 = g_apcb_d[l_ac].apcb016,
                              apcb017 = g_apcb_d[l_ac].apcb017,                                     #160902-00034#1---e---
                              apcb033 = g_apcb_d[l_ac].apcb033, apcb034 = g_apcb_d[l_ac].apcb034,
                              apcb035 = g_apcb_d[l_ac].apcb035, apcb036 = g_apcb_d[l_ac].apcb036,
                              apcb037 = g_apcb_d[l_ac].apcb037, apcb038 = g_apcb_d[l_ac].apcb038,
                              apcb039 = g_apcb_d[l_ac].apcb039, apcb040 = g_apcb_d[l_ac].apcb040,
                              apcb041 = g_apcb_d[l_ac].apcb041, apcb042 = g_apcb_d[l_ac].apcb042,
                              apcb043 = g_apcb_d[l_ac].apcb043, apcb044 = g_apcb_d[l_ac].apcb044,
                              apcb045 = g_apcb_d[l_ac].apcb045, apcb046 = g_apcb_d[l_ac].apcb046,
                              apcb047 = g_apcb_d[l_ac].apcb047,
                              apcb054 = g_apcb_d[l_ac].apcb054, apcb055 = g_apcb_d[l_ac].apcb055   #160509-00004#110 add lujh
             WHERE apcbent = g_enterprise AND apcbld = g_apcb_d[l_ac].apcbld              
               AND apcbdocno = g_apcb_d[l_ac].apcbdocno AND apcbseq = g_apcb_d[l_ac].apcbseq  

            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "apcb_t"
               LET g_errparam.popup = TRUE
               CALL cl_err()

               LET g_apcb_d[l_ac].* = g_apcb_d_t.*
               CALL s_transaction_end('N',0) 
               NEXT FIELD l_apcb021_desc
           # ELSE
           #    CALL s_transaction_end('Y',0)              
            END IF
            
            #檢核新的預算編號是否存在
            #160902-00034#1 ---s---
            CALL s_aooi200_fin_get_slip(g_apcb_d[l_ac].apcbdocno) RETURNING g_sub_success,l_ap_slip
            CALL s_fin_get_doc_para(g_apcb_d[l_ac].apcbld,l_apcacomp,l_ap_slip,'D-FIN-5002') RETURNING l_dfin5002
            IF l_dfin5002 = 'Y' THEN       
               DELETE FROM bgbd_t WHERE bgbdent = g_enterprise AND bgbd037 = g_apcb_d[l_ac].apcbdocno AND bgbd038 = g_apcb_d[l_ac].apcbseq 

               CALL s_aapt300_bgbd_upd(g_apcb_d[l_ac].apcbdocno,g_apcb_d[l_ac].apcbld,g_apcb_d[l_ac].apcbseq,'','4')
                  RETURNING g_sub_success,g_errno #預算是否存在                                                
               IF g_sub_success THEN
                  CALL s_aapt300_bgbd_upd(g_apcb_d[l_ac].apcbdocno,g_apcb_d[l_ac].apcbld,g_apcb_d[l_ac].apcbseq,'','2')
                      RETURNING g_sub_success,g_errno        #預算額度是否超過 
                  IF NOT g_sub_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     CALL s_transaction_end('N','0')
                     NEXT FIELD l_apcb021_desc                    
                  END IF                                      
                  IF g_sub_success THEN               
                     CALL s_aapt300_bgbd_upd(g_apcb_d[l_ac].apcbdocno,g_apcb_d[l_ac].apcbld,g_apcb_d[l_ac].apcbseq,'I','3')
                        RETURNING g_sub_success,g_errno                   #新增一筆bgbd_t
                     IF NOT g_sub_success THEN
                        INITIALIZE g_errparam TO NULL 
                        LET g_errparam.extend = '' 
                        LET g_errparam.code   = g_errno 
                        LET g_errparam.popup  = TRUE 
                        CALL cl_err()        
                        CALL s_transaction_end('N','0')
                        NEXT FIELD l_apcb021_desc  
                     END IF             
                  END IF
               END IF
            END IF                                          
         END IF
         CALL s_transaction_end('Y',0)
         #160902-00034#1 ---e---
         AFTER ROW
            CLOSE aapt300_08_input_c
  
         BEFORE FIELD l_apcb021_desc                                    #150205-00012#1
            LET g_apcb_d[l_ac].l_apcb021_desc = g_apcb_d[l_ac].apcb021  #150205-00012#1  
         
         #費用會計科目
         AFTER FIELD l_apcb021_desc
            IF NOT cl_null(g_apcb_d[l_ac].l_apcb021_desc) THEN
               #  150916-00015#1 BEGIN    快捷带出类似科目编号     ADD BY XZG201511207
               LET l_sql = ""
               IF s_aglt310_getlike_lc_subject(g_apcb_d[1].apcbld,g_apcb_d[l_ac].l_apcb021_desc,l_sql) THEN
                 INITIALIZE g_qryparam.* TO NULL
                 SELECT glaa004 INTO l_glaa004
                   FROM glaa_t
                  WHERE glaaent = g_enterprise
                    AND glaald =g_apcb_d[1].apcbld
                 LET g_qryparam.state = 'i'
                 LET g_qryparam.reqry = 'FALSE'
                 LET g_qryparam.default1 = g_apcb_d[l_ac].l_apcb021_desc
                 LET g_qryparam.arg1 = l_glaa004
                 LET g_qryparam.arg2 = g_apcb_d[l_ac].l_apcb021_desc
                 LET g_qryparam.arg3 = g_apcb_d[1].apcbld
                 LET g_qryparam.arg4 = "1 "
                 CALL q_glac002_6()
                 LET g_apcb_d[l_ac].apcb021       = g_qryparam.return1
                 LET g_apcb_d[l_ac].l_apcb021_desc= g_apcb_d[l_ac].apcb021
                 DISPLAY BY NAME g_apcb_d[l_ac].apcb021,g_apcb_d[l_ac].l_apcb021_desc
                 NEXT FIELD l_apcb021_desc
               END IF
               IF NOT s_aglt310_lc_subject(g_apcb_d[1].apcbld,g_apcb_d[l_ac].l_apcb021_desc,'N') THEN
                   LET g_apcb_d[l_ac].apcb021        = g_apcb_d_t.apcb021
                   LET g_apcb_d[l_ac].l_apcb021_desc = g_apcb_d_t.l_apcb021_desc
                   DISPLAY BY NAME g_apcb_d[l_ac].apcb021,g_apcb_d[l_ac].l_apcb021_desc
                   NEXT FIELD CURRENT
               END IF
               #  150916-00015#1 END
               IF g_apcb_d[l_ac].l_apcb021_desc != g_apcb_d_t.l_apcb021_desc OR g_apcb_d_t.l_apcb021_desc IS NULL THEN
                  LET g_apcb_d[l_ac].apcb021 = g_apcb_d[l_ac].l_apcb021_desc
                  IF (g_apcb_d[l_ac].apcb021 != g_apcb_d_t.apcb021 OR g_apcb_d_t.apcb021 IS NULL) THEN
                     CALL s_aap_glac002_chk(g_apcb_d[l_ac].apcb021,g_apcb_d[l_ac].apcbld) RETURNING g_sub_success,g_errno
                     IF NOT g_sub_success THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = g_errno
                        LET g_errparam.extend = ''
                        #160321-00016#20 --s add
                        LET g_errparam.replace[1] = 'agli020'
                        LET g_errparam.replace[2] = cl_get_progname('agli020',g_lang,"2")
                        LET g_errparam.exeprog = 'agli020'
                        #160321-00016#20 --e add
                        LET g_errparam.popup = TRUE
                        CALL cl_err()
                        LET g_apcb_d[l_ac].apcb021        = g_apcb_d_t.apcb021
                        LET g_apcb_d[l_ac].l_apcb021_desc = g_apcb_d_t.l_apcb021_desc
                        DISPLAY BY NAME g_apcb_d[l_ac].apcb021,g_apcb_d[l_ac].l_apcb021_desc
                        NEXT FIELD CURRENT
                     END IF
                     #檢查是否適用預算科目  #160902-00034#1---s--
                     CALL s_aooi200_fin_get_slip(g_apcb_d[l_ac].apcbdocno) RETURNING g_sub_success,l_ap_slip
                     CALL s_fin_get_doc_para(g_apcb_d[l_ac].apcbld,l_apcacomp,l_ap_slip,'D-FIN-5002') RETURNING l_dfin5002
                     IF l_dfin5002 = 'Y' THEN
                        LET l_apcb002 = ''
                        SELECT apcb002 INTO l_apcb002 
                          FROM apcb_t 
                         WHERE apcbdocno = g_apcb_d[l_ac].apcbdocno
                           AND apcbent = g_enterprise   #170123-00010#1 add
                           AND apcbld  = g_apcb_d[l_ac].apcbld
                           AND apcbseq = g_apcb_d[l_ac].apcbseq
                        IF cl_null(l_apcb002) THEN #當沒有來源單據的時候 才會重新帶出預算細項。
                           #取得預算細項參照表
                           SELECT bgaa008 INTO l_bgaa008  FROM bgaa_t
                            WHERE bgaaent = g_enterprise  AND  bgaa001 = l_apca059
                           #取得會計科目所對應的預算細項
                           LET g_apcb_d[l_ac].apcb017  = ''
                           SELECT bgao004 INTO g_apcb_d[l_ac].apcb017
                             FROM bgao_t
                            WHERE bgao001 = l_bgaa008 AND bgaoent = g_enterprise
                              AND bgao002 = l_glaa004 AND bgao003 = g_apcb_d[l_ac].apcb021
                           #預算細項說明    
                           SELECT bgael003 INTO g_apcb_d[l_ac].l_apcb017_desc
                             FROM bgael_t 
                            WHERE bgaelent = g_enterprise           AND bgael006 = l_bgaa008
                              AND bgael001 = g_apcb_d[l_ac].apcb017 AND bgael002 = g_dlang
                           #檢核預算細項是否可被使用(abgi100)
                           CALL s_abg_bgai_chk(l_apca059,l_apcacomp,g_apcb_d[l_ac].apcb017)
                              RETURNING g_sub_success,g_errno
                           IF NOT g_sub_success THEN
                              INITIALIZE g_errparam TO NULL
                              LET g_errparam.extend = g_apcb_d[l_ac].apcb017
                              LET g_errparam.code = g_errno
                              LET g_errparam.popup = TRUE
                              CALL cl_err()
                              LET g_apcb_d[l_ac].apcb017        = g_apcb_d_t.apcb017
                              LET g_apcb_d[l_ac].l_apcb017_desc = g_apcb_d_t.l_apcb017_desc
                              LET g_apcb_d[l_ac].apcb021        = g_apcb_d_t.apcb021
                              LET g_apcb_d[l_ac].l_apcb021_desc = g_apcb_d_t.l_apcb021_desc
                              DISPLAY BY NAME g_apcb_d[l_ac].apcb017,g_apcb_d[l_ac].l_apcb017_desc,
                                              g_apcb_d[l_ac].apcb021,g_apcb_d[l_ac].l_apcb021_desc
                              NEXT FIELD CURRENT
                           END IF
                           DISPLAY BY NAME g_apcb_d[l_ac].apcb017,g_apcb_d[l_ac].l_apcb017_desc
                        END IF
                     END IF
                     #150703-00021#24  ---e---
                  END IF
               END IF
            ELSE
               LET g_apcb_d[l_ac].apcb021 = ''
               LET g_apcb_d[l_ac].apcb017 = ''       #150703-00021#24
               LET g_apcb_d[l_ac].l_apcb017_desc = ''#150703-00021#24
            END IF
            #161221-00054#1 add ------
            LET l_wc = g_apcb_d[l_ac].apcb021,",",g_apcb_d[l_ac].apcb029
            CALL s_fin_get_wc_str(l_wc) RETURNING l_wc
            #161221-00054#1 add end---
            LET g_apcb_d[l_ac].l_apcb017_desc = s_desc_show1(g_apcb_d[l_ac].apcb017,g_apcb_d[l_ac].l_apcb017_desc)  #150703-00021#24
            LET g_apcb_d[l_ac].l_apcb021_desc = s_desc_show1(g_apcb_d[l_ac].apcb021 ,s_desc_get_account_desc(g_apcb_d[l_ac].apcbld,g_apcb_d[l_ac].apcb021))
            LET g_apcb_d_t.l_apcb021_desc = g_apcb_d[l_ac].l_apcb021_desc
            DISPLAY BY NAME g_apcb_d[l_ac].apcb021,g_apcb_d[l_ac].l_apcb021_desc
            DISPLAY BY NAME g_apcb_d[l_ac].apcb017,g_apcb_d[l_ac].l_apcb017_desc #150703-00021#24
            
            
         ON ACTION controlp INFIELD l_apcb021_desc
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_apcb_d[l_ac].apcb021
            LET g_qryparam.where = "glac001 = '",l_glaa004,"' AND  glac003 <>'1' ",  #glac001(會計科目參照表)/glac003(科目類型)
                                   " AND glac002 IN (SELECT glad001 FROM glad_t,glac_t WHERE glad001= glac002 ",
                                   " AND gladld='",g_apcb_d[1].apcbld,"' AND gladent=",g_enterprise,
                                   " AND gladstus = 'Y' )"
             CALL aglt310_04()
            LET g_apcb_d[l_ac].apcb021       = g_qryparam.return1
            LET g_apcb_d[l_ac].l_apcb021_desc= g_apcb_d[l_ac].apcb021
            DISPLAY BY NAME g_apcb_d[l_ac].apcb021,g_apcb_d[l_ac].l_apcb021_desc
            NEXT FIELD l_apcb021_desc
         
         BEFORE FIELD l_apcb029_desc                                    #150205-00012#1
            LET g_apcb_d[l_ac].l_apcb029_desc = g_apcb_d[l_ac].apcb029  #150205-00012#1
         
         #應付帳款科目
         AFTER FIELD l_apcb029_desc
            IF NOT cl_null(g_apcb_d[l_ac].l_apcb029_desc) THEN
               #  150916-00015#1 BEGIN    快捷带出类似科目编号     ADD BY XZG201511207
               LET l_sql = ""
               IF  s_aglt310_getlike_lc_subject(g_apcb_d[1].apcbld,g_apcb_d[l_ac].l_apcb029_desc,l_sql) THEN
                  INITIALIZE g_qryparam.* TO NULL
                  SELECT glaa004 INTO l_glaa004
                    FROM glaa_t
                   WHERE glaaent = g_enterprise
                     AND glaald = g_apcb_d[1].apcbld
                 LET g_qryparam.state = 'i'
                 LET g_qryparam.reqry = 'FALSE'
                 LET g_qryparam.default1 = g_apcb_d[l_ac].l_apcb029_desc
                 LET g_qryparam.arg1 = l_glaa004
                 LET g_qryparam.arg2 = g_apcb_d[l_ac].l_apcb029_desc
                 LET g_qryparam.arg3 = g_apcb_d[1].apcbld
                 LET g_qryparam.arg4 = "1 "
                 CALL q_glac002_6()
                 LET g_apcb_d[l_ac].apcb029       = g_qryparam.return1
                 LET g_apcb_d[l_ac].l_apcb029_desc= g_apcb_d[l_ac].apcb029
                 DISPLAY BY NAME g_apcb_d[l_ac].apcb029,g_apcb_d[l_ac].l_apcb029_desc
                 NEXT FIELD l_apcb029_desc
               END IF
               IF NOT s_aglt310_lc_subject(g_apcb_d[1].apcbld,g_apcb_d[l_ac].l_apcb029_desc,'N') THEN
                  LET g_apcb_d[l_ac].apcb029        = g_apcb_d_t.apcb029
                  LET g_apcb_d[l_ac].l_apcb029_desc = g_apcb_d_t.l_apcb029_desc
                  DISPLAY BY NAME g_apcb_d[l_ac].apcb029,g_apcb_d[l_ac].l_apcb029_desc
                  NEXT FIELD CURRENT
               END IF
               #  150916-00015#1 END
               IF g_apcb_d[l_ac].l_apcb029_desc != g_apcb_d_t.l_apcb029_desc OR g_apcb_d_t.l_apcb029_desc IS NULL THEN
                  LET g_apcb_d[l_ac].apcb029 = g_apcb_d[l_ac].l_apcb029_desc
                  IF (g_apcb_d[l_ac].apcb029 != g_apcb_d_t.apcb029 OR g_apcb_d_t.apcb029 IS NULL) THEN
                     CALL s_aap_glac002_chk(g_apcb_d[l_ac].apcb029,g_apcb_d[l_ac].apcbld) RETURNING g_sub_success,g_errno
                     IF NOT g_sub_success THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = g_errno
                        LET g_errparam.extend = ''
                        #160321-00016#20 --s add
                        LET g_errparam.replace[1] = 'agli020'
                        LET g_errparam.replace[2] = cl_get_progname('agli020',g_lang,"2")
                        LET g_errparam.exeprog = 'agli020'
                        #160321-00016#20 --e add
                        LET g_errparam.popup = TRUE
                        CALL cl_err()
                        LET g_apcb_d[l_ac].apcb029        = g_apcb_d_t.apcb029
                        LET g_apcb_d[l_ac].l_apcb029_desc = g_apcb_d_t.l_apcb029_desc
                        DISPLAY BY NAME g_apcb_d[l_ac].apcb029,g_apcb_d[l_ac].l_apcb029_desc
                        NEXT FIELD CURRENT
                     END IF
                  END IF
               END IF
            ELSE
               LET g_apcb_d[l_ac].apcb029 = ''
            END IF
            #161221-00054#1 add ------
            LET l_wc = g_apcb_d[l_ac].apcb021,",",g_apcb_d[l_ac].apcb029
            CALL s_fin_get_wc_str(l_wc) RETURNING l_wc
            #161221-00054#1 add end---
            LET g_apcb_d[l_ac].l_apcb029_desc = s_desc_show1(g_apcb_d[l_ac].apcb029 ,s_desc_get_account_desc(g_apcb_d[l_ac].apcbld,g_apcb_d[l_ac].apcb029))
            LET g_apcb_d_t.l_apcb029_desc = g_apcb_d[l_ac].l_apcb029_desc
            DISPLAY BY NAME g_apcb_d[l_ac].apcb029,g_apcb_d[l_ac].l_apcb029_desc
            

         ON ACTION controlp INFIELD l_apcb029_desc
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_apcb_d[l_ac].apcb029
            LET g_qryparam.where = "glac001 = '",l_glaa004,"' AND  glac003 <>'1' " , #glac001(會計科目參照表)/glac003(科目類型)
                                   " AND glac002 IN (SELECT glad001 FROM glad_t,glac_t WHERE glad001= glac002 ",
                                   " AND gladld='",g_apcb_d[1].apcbld,"' AND gladent=",g_enterprise,
                                   " AND gladstus = 'Y' )"
            CALL aglt310_04()
            LET g_apcb_d[l_ac].apcb029       = g_qryparam.return1
            LET g_apcb_d[l_ac].l_apcb029_desc= g_apcb_d[l_ac].apcb029
            DISPLAY BY NAME g_apcb_d[l_ac].apcb029,g_apcb_d[l_ac].l_apcb029_desc
            NEXT FIELD l_apcb029_desc
         
         
         BEFORE FIELD l_apcb051_desc                                    #150205-00012#1
            LET g_apcb_d[l_ac].l_apcb051_desc = g_apcb_d[l_ac].apcb051  #150205-00012#1
         
         #業務人員
         AFTER FIELD l_apcb051_desc
            IF NOT cl_null(g_apcb_d[l_ac].l_apcb051_desc) THEN
               IF ( g_apcb_d[l_ac].l_apcb051_desc != g_apcb_d_t.l_apcb051_desc OR g_apcb_d_t.l_apcb051_desc IS NULL ) THEN
                  LET g_apcb_d[l_ac].apcb051 = g_apcb_d[l_ac].l_apcb051_desc
                  IF l_glaa121 = 'N' THEN     #141218-00011#6
                     IF (g_apcb_d[l_ac].apcb051 != g_apcb_d_t.apcb051 OR g_apcb_d_t.apcb051 IS NULL) THEN
                        CALL s_employee_chk(g_apcb_d[l_ac].apcb051) RETURNING g_sub_success
                        IF NOT g_sub_success THEN
                           LET g_apcb_d[l_ac].apcb051        = g_apcb_d_t.apcb051
                           LET g_apcb_d[l_ac].l_apcb051_desc = g_apcb_d_t.l_apcb051_desc
                           DISPLAY BY NAME g_apcb_d[l_ac].apcb051,g_apcb_d[l_ac].l_apcb051_desc
                           NEXT FIELD CURRENT
                        END IF
                        #161221-00054#1 add ------
                        #判断agli060是否设置限制核算项资料，如果设置，判断是否满足agli060条件
                        CALL s_voucher_hsx_glak_chk(g_apcb_d[1].apcbld,'12',g_apcb_d[l_ac].apcb021,g_apcb_d[l_ac].apcb051) RETURNING g_sub_success
                        IF NOT g_sub_success THEN
                           LET g_apcb_d[l_ac].apcb051        = g_apcb_d_t.apcb051
                           LET g_apcb_d[l_ac].l_apcb051_desc = g_apcb_d_t.l_apcb051_desc
                           DISPLAY BY NAME g_apcb_d[l_ac].apcb051,g_apcb_d[l_ac].l_apcb051_desc
                           NEXT FIELD CURRENT
                        END IF
                        CALL s_voucher_hsx_glak_chk(g_apcb_d[1].apcbld,'12',g_apcb_d[l_ac].apcb029,g_apcb_d[l_ac].apcb051) RETURNING g_sub_success
                        IF NOT g_sub_success THEN
                           LET g_apcb_d[l_ac].apcb051        = g_apcb_d_t.apcb051
                           LET g_apcb_d[l_ac].l_apcb051_desc = g_apcb_d_t.l_apcb051_desc
                           DISPLAY BY NAME g_apcb_d[l_ac].apcb051,g_apcb_d[l_ac].l_apcb051_desc
                           NEXT FIELD CURRENT
                        END IF
                        #161221-00054#1 add end---
                     END IF
                  END IF
               END IF
            ELSE
               LET g_apcb_d[l_ac].apcb051 = ''
            END IF
            LET g_apcb_d[l_ac].l_apcb051_desc = s_desc_show1(g_apcb_d[l_ac].apcb051,s_desc_get_person_desc(g_apcb_d[l_ac].apcb051))
            LET g_apcb_d_t.l_apcb051_desc = g_apcb_d[l_ac].l_apcb051_desc
            DISPLAY BY NAME g_apcb_d[l_ac].apcb051,g_apcb_d[l_ac].l_apcb051_desc
            
         ON ACTION controlp INFIELD l_apcb051_desc
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_apcb_d[l_ac].apcb051
            #161221-00054#1 add ------
            #agli060设置的人員限制条件
            CALL s_voucher_get_glak_sql(g_apcb_d[1].apcbld,'12',l_wc) RETURNING l_glak_sql
            LET g_qryparam.where = l_glak_sql
            #161221-00054#1 add end---
            CALL q_ooag001_8()
            LET g_apcb_d[l_ac].apcb051 = g_qryparam.return1
            LET g_apcb_d[l_ac].l_apcb051_desc= g_apcb_d[l_ac].apcb051
            DISPLAY BY NAME g_apcb_d[l_ac].apcb051,g_apcb_d[l_ac].l_apcb051_desc
            NEXT FIELD l_apcb051_desc
         
         
         
         BEFORE FIELD l_apcb010_desc                                    #150205-00012#1
            LET g_apcb_d[l_ac].l_apcb010_desc = g_apcb_d[l_ac].apcb010  #150205-00012#1
            
         #業務部門
         AFTER FIELD l_apcb010_desc
            IF NOT cl_null(g_apcb_d[l_ac].l_apcb010_desc)  THEN
               IF ( g_apcb_d[l_ac].l_apcb010_desc != g_apcb_d_t.l_apcb010_desc OR g_apcb_d_t.l_apcb010_desc IS NULL ) THEN
                  LET g_apcb_d[l_ac].apcb010 = g_apcb_d[l_ac].l_apcb010_desc
                  IF l_glaa121 = 'N' THEN     #141218-00011#6
                     IF (g_apcb_d[l_ac].apcb010 != g_apcb_d_t.apcb010 OR g_apcb_d_t.apcb010 IS NULL) THEN
                        CALL s_department_chk(g_apcb_d[l_ac].apcb010,l_apcadocdt) RETURNING g_sub_success
                        IF NOT g_sub_success THEN
                           LET g_apcb_d[l_ac].apcb010        = g_apcb_d_t.apcb010
                           LET g_apcb_d[l_ac].l_apcb010_desc = g_apcb_d_t.l_apcb010_desc
                           DISPLAY BY NAME g_apcb_d[l_ac].apcb010,g_apcb_d[l_ac].l_apcb010_desc
                           NEXT FIELD CURRENT
                        END IF
                        #161221-00054#1 add ------
                        #判断agli060是否设置限制核算项资料，如果设置，判断是否满足agli060条件
                        CALL s_voucher_hsx_glak_chk(g_apcb_d[1].apcbld,'02',g_apcb_d[l_ac].apcb021,g_apcb_d[l_ac].apcb010) RETURNING g_sub_success
                        IF NOT g_sub_success THEN
                           LET g_apcb_d[l_ac].apcb010        = g_apcb_d_t.apcb010
                           LET g_apcb_d[l_ac].l_apcb010_desc = g_apcb_d_t.l_apcb010_desc
                           DISPLAY BY NAME g_apcb_d[l_ac].apcb010,g_apcb_d[l_ac].l_apcb010_desc
                           NEXT FIELD CURRENT
                        END IF
                        CALL s_voucher_hsx_glak_chk(g_apcb_d[1].apcbld,'02',g_apcb_d[l_ac].apcb029,g_apcb_d[l_ac].apcb010) RETURNING g_sub_success
                        IF NOT g_sub_success THEN
                           LET g_apcb_d[l_ac].apcb010        = g_apcb_d_t.apcb010
                           LET g_apcb_d[l_ac].l_apcb010_desc = g_apcb_d_t.l_apcb010_desc
                           DISPLAY BY NAME g_apcb_d[l_ac].apcb010,g_apcb_d[l_ac].l_apcb010_desc
                           NEXT FIELD CURRENT
                        END IF
                        #161221-00054#1 add end---
                     END IF
                  END IF
                  #141114-00010#20--(S)
                  CALL s_department_get_respon_center(g_apcb_d[l_ac].apcb010,l_apcadocdt)
                       RETURNING g_sub_success,g_errno,g_apcb_d[l_ac].apcb011,g_apcb_d[l_ac].l_apcb011_desc
                  LET g_apcb_d[l_ac].l_apcb011_desc = s_desc_show1(g_apcb_d[l_ac].apcb011,g_apcb_d[l_ac].l_apcb011_desc)
                  LET g_apcb_d_t.l_apcb011_desc = g_apcb_d[l_ac].l_apcb011_desc
                  DISPLAY BY NAME g_apcb_d[l_ac].apcb011,g_apcb_d[l_ac].l_apcb011_desc
                  #141114-00010#20--(E)
               END IF
            ELSE
               LET g_apcb_d[l_ac].apcb010 = ''
            END IF
            LET g_apcb_d[l_ac].l_apcb010_desc = s_desc_show1(g_apcb_d[l_ac].apcb010,s_desc_get_department_desc(g_apcb_d[l_ac].apcb010))
            LET g_apcb_d_t.l_apcb010_desc = g_apcb_d[l_ac].l_apcb010_desc
            DISPLAY BY NAME g_apcb_d[l_ac].apcb010,g_apcb_d[l_ac].l_apcb010_desc
            
         ON ACTION controlp INFIELD l_apcb010_desc
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_apcb_d[l_ac].apcb010
            LET g_qryparam.arg1 = l_apcadocdt
            #161221-00054#1 add ------
            #agli060设置的部門限制条件
            CALL s_voucher_get_glak_sql(g_apcb_d[1].apcbld,'02',l_wc) RETURNING l_glak_sql
            LET g_qryparam.where = l_glak_sql
            #161221-00054#1 add end---
            CALL q_ooeg001_4()
            LET g_apcb_d[l_ac].apcb010 = g_qryparam.return1
            LET g_apcb_d[l_ac].l_apcb010_desc= g_apcb_d[l_ac].apcb010
            DISPLAY BY NAME g_apcb_d[l_ac].apcb010,g_apcb_d[l_ac].l_apcb010_desc
            NEXT FIELD l_apcb010_desc
         
         
         
         BEFORE FIELD l_apcb011_desc                                    #150205-00012#1
            LET g_apcb_d[l_ac].l_apcb011_desc = g_apcb_d[l_ac].apcb011  #150205-00012#1
            
         #責任中心
         AFTER FIELD l_apcb011_desc
            IF NOT cl_null(g_apcb_d[l_ac].l_apcb011_desc) THEN
               IF ( g_apcb_d[l_ac].l_apcb011_desc != g_apcb_d_t.l_apcb011_desc OR g_apcb_d_t.l_apcb011_desc IS NULL ) THEN
                  LET g_apcb_d[l_ac].apcb011 = g_apcb_d[l_ac].l_apcb011_desc
                  IF l_glaa121 = 'N' THEN     #141218-00011#6
                     IF (g_apcb_d[l_ac].apcb011 != g_apcb_d_t.apcb011 OR g_apcb_d_t.apcb011 IS NULL) THEN
                        CALL s_voucher_glaq019_chk(g_apcb_d[l_ac].l_apcb011_desc,l_apcadocdt)
                        IF NOT cl_null(g_errno) THEN
                           LET g_apcb_d[l_ac].apcb011        = g_apcb_d_t.apcb011
                           LET g_apcb_d[l_ac].l_apcb011_desc = g_apcb_d_t.l_apcb011_desc
                           DISPLAY BY NAME g_apcb_d[l_ac].apcb011,g_apcb_d[l_ac].l_apcb011_desc
                           NEXT FIELD CURRENT
                        END IF
                        #161221-00054#1 add ------
                        #判断agli060是否设置限制核算项资料，如果设置，判断是否满足agli060条件
                        CALL s_voucher_hsx_glak_chk(g_apcb_d[1].apcbld,'03',g_apcb_d[l_ac].apcb021,g_apcb_d[l_ac].apcb011) RETURNING g_sub_success
                        IF NOT g_sub_success THEN
                           LET g_apcb_d[l_ac].apcb011        = g_apcb_d_t.apcb011
                           LET g_apcb_d[l_ac].l_apcb011_desc = g_apcb_d_t.l_apcb011_desc
                           DISPLAY BY NAME g_apcb_d[l_ac].apcb011,g_apcb_d[l_ac].l_apcb011_desc
                           NEXT FIELD CURRENT
                        END IF
                        CALL s_voucher_hsx_glak_chk(g_apcb_d[1].apcbld,'03',g_apcb_d[l_ac].apcb029,g_apcb_d[l_ac].apcb011) RETURNING g_sub_success
                        IF NOT g_sub_success THEN
                           LET g_apcb_d[l_ac].apcb011        = g_apcb_d_t.apcb011
                           LET g_apcb_d[l_ac].l_apcb011_desc = g_apcb_d_t.l_apcb011_desc
                           DISPLAY BY NAME g_apcb_d[l_ac].apcb011,g_apcb_d[l_ac].l_apcb011_desc
                           NEXT FIELD CURRENT
                        END IF
                        #161221-00054#1 add end---
                     END IF
                  END IF
               END IF
            ELSE
               LET g_apcb_d[l_ac].apcb011 = ''
            END IF
            LET g_apcb_d[l_ac].l_apcb011_desc = s_desc_show1(g_apcb_d[l_ac].apcb011,s_desc_get_department_desc(g_apcb_d[l_ac].apcb011))
            LET g_apcb_d_t.l_apcb011_desc = g_apcb_d[l_ac].l_apcb011_desc
            DISPLAY BY NAME g_apcb_d[l_ac].apcb011,g_apcb_d[l_ac].l_apcb011_desc

         ON ACTION controlp INFIELD l_apcb011_desc
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_apcb_d[l_ac].l_apcb011_desc
            LET g_qryparam.arg1 = l_apcadocdt
            LET g_qryparam.where = " ooeg003 IN ('1','2','3')"
            #161221-00054#1 add ------
            #agli060设置的責任中心限制条件
            CALL s_voucher_get_glak_sql(g_apcb_d[1].apcbld,'03',l_wc) RETURNING l_glak_sql
            LET g_qryparam.where = g_qryparam.where," AND ",l_glak_sql
            #161221-00054#1 add end---
            CALL q_ooeg001_5()
            LET g_apcb_d[l_ac].apcb011        = g_qryparam.return1
            LET g_apcb_d[l_ac].l_apcb011_desc = g_apcb_d[l_ac].apcb011
            DISPLAY BY NAME g_apcb_d[l_ac].apcb011 ,g_apcb_d[l_ac].l_apcb011_desc
            NEXT FIELD l_apcb011_desc
         
         
         
         BEFORE FIELD l_apcb024_desc                                    #150205-00012#1
            LET g_apcb_d[l_ac].l_apcb024_desc = g_apcb_d[l_ac].apcb024  #150205-00012#1
         
         #區域 
         AFTER FIELD l_apcb024_desc
            IF NOT cl_null(g_apcb_d[l_ac].l_apcb024_desc) THEN
               IF ( g_apcb_d[l_ac].l_apcb024_desc != g_apcb_d_t.l_apcb024_desc OR g_apcb_d_t.l_apcb024_desc IS NULL ) THEN
                  LET g_apcb_d[l_ac].apcb024 = g_apcb_d[l_ac].l_apcb024_desc
                  IF l_glaa121 = 'N' THEN     #141218-00011#6
                     IF (g_apcb_d[l_ac].apcb024 != g_apcb_d_t.apcb024 OR g_apcb_d_t.apcb024 IS NULL) THEN
                        IF NOT s_azzi650_chk_exist('287',g_apcb_d[l_ac].l_apcb024_desc) THEN
                           LET g_apcb_d[l_ac].apcb024        = g_apcb_d_t.apcb024
                           LET g_apcb_d[l_ac].l_apcb024_desc = g_apcb_d_t.l_apcb024_desc
                           DISPLAY BY NAME g_apcb_d[l_ac].apcb024,g_apcb_d[l_ac].l_apcb024_desc
                           NEXT FIELD CURRENT
                        END IF
                        #161221-00054#1 add ------
                        #判断agli060是否设置限制核算项资料，如果设置，判断是否满足agli060条件
                        CALL s_voucher_hsx_glak_chk(g_apcb_d[1].apcbld,'04',g_apcb_d[l_ac].apcb021,g_apcb_d[l_ac].apcb024) RETURNING g_sub_success
                        IF NOT g_sub_success THEN
                           LET g_apcb_d[l_ac].apcb024        = g_apcb_d_t.apcb024
                           LET g_apcb_d[l_ac].l_apcb024_desc = g_apcb_d_t.l_apcb024_desc
                           DISPLAY BY NAME g_apcb_d[l_ac].apcb024,g_apcb_d[l_ac].l_apcb024_desc
                           NEXT FIELD CURRENT
                        END IF
                        CALL s_voucher_hsx_glak_chk(g_apcb_d[1].apcbld,'04',g_apcb_d[l_ac].apcb029,g_apcb_d[l_ac].apcb024) RETURNING g_sub_success
                        IF NOT g_sub_success THEN
                           LET g_apcb_d[l_ac].apcb024        = g_apcb_d_t.apcb024
                           LET g_apcb_d[l_ac].l_apcb024_desc = g_apcb_d_t.l_apcb024_desc
                           DISPLAY BY NAME g_apcb_d[l_ac].apcb024,g_apcb_d[l_ac].l_apcb024_desc
                           NEXT FIELD CURRENT
                        END IF
                        #161221-00054#1 add end---
                     END IF
                  END IF
               END IF
            ELSE
               LET g_apcb_d[l_ac].apcb024 = ''
            END IF
            LET g_apcb_d[l_ac].l_apcb024_desc = s_desc_show1(g_apcb_d[l_ac].apcb024,s_desc_get_acc_desc('287',g_apcb_d[l_ac].apcb024))
            LET g_apcb_d_t.l_apcb024_desc = g_apcb_d[l_ac].l_apcb024_desc
            DISPLAY BY NAME g_apcb_d[l_ac].apcb024,g_apcb_d[l_ac].l_apcb024_desc

         ON ACTION controlp INFIELD l_apcb024_desc
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_apcb_d[l_ac].l_apcb024_desc
            #161221-00054#1 add ------
            #agli060设置的區域限制条件
            CALL s_voucher_get_glak_sql(g_apcb_d[1].apcbld,'04',l_wc) RETURNING l_glak_sql
            LET g_qryparam.where = l_glak_sql
            #161221-00054#1 add end---
            CALL q_oocq002_287()
            LET g_apcb_d[l_ac].apcb024        = g_qryparam.return1
            LET g_apcb_d[l_ac].l_apcb024_desc = g_apcb_d[l_ac].apcb024
            DISPLAY BY NAME g_apcb_d[l_ac].apcb024 ,g_apcb_d[l_ac].l_apcb024_desc
            NEXT FIELD l_apcb024_desc
         
         
         
         BEFORE FIELD l_apcb012_desc                                    #150205-00012#1
            LET g_apcb_d[l_ac].l_apcb012_desc = g_apcb_d[l_ac].apcb012  #150205-00012#1
            
         #產品類別
         AFTER FIELD l_apcb012_desc
            IF NOT cl_null(g_apcb_d[l_ac].l_apcb012_desc) THEN
               IF ( g_apcb_d[l_ac].l_apcb012_desc != g_apcb_d_t.l_apcb012_desc OR g_apcb_d_t.l_apcb012_desc IS NULL ) THEN
                  LET g_apcb_d[l_ac].apcb012 = g_apcb_d[l_ac].l_apcb012_desc
                  IF l_glaa121 = 'N' THEN     #141218-00011#6
                     IF (g_apcb_d[l_ac].apcb012 != g_apcb_d_t.apcb012 OR g_apcb_d_t.apcb012 IS NULL) THEN
                        CALL s_voucher_glaq024_chk(g_apcb_d[l_ac].l_apcb012_desc)
                        IF NOT cl_null(g_errno) THEN
                           LET g_apcb_d[l_ac].apcb012        = g_apcb_d_t.apcb012
                           LET g_apcb_d[l_ac].l_apcb012_desc = g_apcb_d_t.l_apcb012_desc
                           DISPLAY BY NAME g_apcb_d[l_ac].apcb012,g_apcb_d[l_ac].l_apcb012_desc
                           NEXT FIELD CURRENT
                        END IF
                        #161221-00054#1 add ------
                        #判断agli060是否设置限制核算项资料，如果设置，判断是否满足agli060条件
                        CALL s_voucher_hsx_glak_chk(g_apcb_d[1].apcbld,'08',g_apcb_d[l_ac].apcb021,g_apcb_d[l_ac].apcb012) RETURNING g_sub_success
                        IF NOT g_sub_success THEN
                           LET g_apcb_d[l_ac].apcb012        = g_apcb_d_t.apcb012
                           LET g_apcb_d[l_ac].l_apcb012_desc = g_apcb_d_t.l_apcb012_desc
                           DISPLAY BY NAME g_apcb_d[l_ac].apcb012,g_apcb_d[l_ac].l_apcb012_desc
                           NEXT FIELD CURRENT
                        END IF
                        CALL s_voucher_hsx_glak_chk(g_apcb_d[1].apcbld,'08',g_apcb_d[l_ac].apcb029,g_apcb_d[l_ac].apcb012) RETURNING g_sub_success
                        IF NOT g_sub_success THEN
                           LET g_apcb_d[l_ac].apcb012        = g_apcb_d_t.apcb012
                           LET g_apcb_d[l_ac].l_apcb012_desc = g_apcb_d_t.l_apcb012_desc
                           DISPLAY BY NAME g_apcb_d[l_ac].apcb012,g_apcb_d[l_ac].l_apcb012_desc
                           NEXT FIELD CURRENT
                        END IF
                        #161221-00054#1 add end---
                     END IF
                  END IF
               END IF
            ELSE
               LET g_apcb_d[l_ac].apcb012 = ''
            END IF
            LET g_apcb_d[l_ac].l_apcb012_desc = s_desc_show1(g_apcb_d[l_ac].apcb012,s_desc_get_rtaxl003_desc(g_apcb_d[l_ac].apcb012))
            LET g_apcb_d_t.l_apcb012_desc = g_apcb_d[l_ac].l_apcb012_desc
            DISPLAY BY NAME g_apcb_d[l_ac].apcb012,g_apcb_d[l_ac].l_apcb012_desc

         ON ACTION controlp INFIELD l_apcb012_desc
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_apcb_d[l_ac].l_apcb012_desc
            #161221-00054#1 add ------
            #品类管理层级aoos010
            CALL cl_get_para(g_enterprise,'','E-CIR-0001') RETURNING l_ooaa002
            #agli060设置的產品類別限制条件
            CALL s_voucher_get_glak_sql(g_apcb_d[1].apcbld,'08',l_wc) RETURNING l_glak_sql
            LET g_qryparam.where =" rtax004='",l_ooaa002,"' AND ",l_glak_sql
            #161221-00054#1 add end---
            CALL q_rtax001()
            LET g_apcb_d[l_ac].apcb012        = g_qryparam.return1
            LET g_apcb_d[l_ac].l_apcb012_desc = g_apcb_d[l_ac].apcb012
            DISPLAY BY NAME g_apcb_d[l_ac].apcb012 ,g_apcb_d[l_ac].l_apcb012_desc
            NEXT FIELD l_apcb012_desc
         
         
         
         BEFORE FIELD l_apcb016_desc                                    #150205-00012#1
            LET g_apcb_d[l_ac].l_apcb016_desc = g_apcb_d[l_ac].apcb016  #150205-00012#1
         
         #WBS
         AFTER FIELD l_apcb016_desc
            IF NOT cl_null(g_apcb_d[l_ac].l_apcb016_desc)  THEN
               IF ( g_apcb_d[l_ac].l_apcb016_desc != g_apcb_d_t.l_apcb016_desc OR g_apcb_d_t.l_apcb016_desc IS NULL ) THEN
                  LET g_apcb_d[l_ac].apcb016 = g_apcb_d[l_ac].l_apcb016_desc
                  IF l_glaa121 = 'N' THEN     #141218-00011#6
                     IF (g_apcb_d[l_ac].apcb016 != g_apcb_d_t.apcb016 OR g_apcb_d_t.apcb016 IS NULL) THEN
                        CALL s_voucher_glaq028_chk(g_apcb_d[l_ac].apcb015,g_apcb_d[l_ac].apcb016) 
                       #CALL s_aap_project_chk( g_apcb_d[l_ac].apcb016) RETURNING g_sub_success,g_errno
                        IF NOT cl_null(g_errno) THEN
                           LET g_apcb_d[l_ac].apcb016        = g_apcb_d_t.apcb016
                           LET g_apcb_d[l_ac].l_apcb016_desc = g_apcb_d_t.l_apcb016_desc
                           DISPLAY BY NAME g_apcb_d[l_ac].apcb016,g_apcb_d[l_ac].l_apcb016_desc
                           NEXT FIELD CURRENT
                        END IF
                        #161221-00054#1 add ------
                        #判断agli060是否设置限制核算项资料，如果设置，判断是否满足agli060条件
                        CALL s_voucher_hsx_glak_chk(g_apcb_d[1].apcbld,'14',g_apcb_d[l_ac].apcb021,g_apcb_d[l_ac].apcb016) RETURNING g_sub_success
                        IF NOT g_sub_success THEN
                           LET g_apcb_d[l_ac].apcb016        = g_apcb_d_t.apcb016
                           LET g_apcb_d[l_ac].l_apcb016_desc = g_apcb_d_t.l_apcb016_desc
                           DISPLAY BY NAME g_apcb_d[l_ac].apcb016,g_apcb_d[l_ac].l_apcb016_desc
                           NEXT FIELD CURRENT
                        END IF
                        CALL s_voucher_hsx_glak_chk(g_apcb_d[1].apcbld,'14',g_apcb_d[l_ac].apcb029,g_apcb_d[l_ac].apcb016) RETURNING g_sub_success
                        IF NOT g_sub_success THEN
                           LET g_apcb_d[l_ac].apcb016        = g_apcb_d_t.apcb016
                           LET g_apcb_d[l_ac].l_apcb016_desc = g_apcb_d_t.l_apcb016_desc
                           DISPLAY BY NAME g_apcb_d[l_ac].apcb016,g_apcb_d[l_ac].l_apcb016_desc
                           NEXT FIELD CURRENT
                        END IF
                        #161221-00054#1 add end---
                     END IF
                  END IF
               END IF
            ELSE
               LET g_apcb_d[l_ac].apcb016 = ''
            END IF
            LET g_apcb_d[l_ac].l_apcb016_desc = s_desc_show1(g_apcb_d[l_ac].apcb016,s_desc_get_pjbbl004_desc(g_apcb_d[l_ac].apcb015,g_apcb_d[l_ac].apcb016))
            LET g_apcb_d_t.l_apcb016_desc = g_apcb_d[l_ac].l_apcb016_desc
            DISPLAY BY NAME g_apcb_d[l_ac].apcb011,g_apcb_d[l_ac].l_apcb016_desc
            
         ON ACTION controlp INFIELD l_apcb016_desc
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_apcb_d[l_ac].apcb016
            IF NOT cl_null(g_apcb_d[l_ac].apcb015) THEN
               LET g_qryparam.where = "pjbb012='1' AND pjbb001='",g_apcb_d[l_ac].apcb015,"'"
            ELSE
               LET g_qryparam.where = "pjbb012='1'"
            END IF
            #161221-00054#1 add ------
            #agli060设置的WBS限制条件
            CALL s_voucher_get_glak_sql(g_apcb_d[1].apcbld,'14',l_wc) RETURNING l_glak_sql
            LET g_qryparam.where = g_qryparam.where," AND ",l_glak_sql
            #161221-00054#1 add end---
            CALL q_pjbb002()
            LET g_apcb_d[l_ac].apcb016        = g_qryparam.return1
            LET g_apcb_d[l_ac].l_apcb016_desc = g_apcb_d[l_ac].apcb016
            DISPLAY BY NAME g_apcb_d[l_ac].apcb016,g_apcb_d[l_ac].l_apcb016_desc
            NEXT FIELD l_apcb016_desc
         
         
         
         BEFORE FIELD l_apcb015_desc                                    #150205-00012#1
            LET g_apcb_d[l_ac].l_apcb015_desc = g_apcb_d[l_ac].apcb015  #150205-00012#1
            
         #專案代號
         AFTER FIELD l_apcb015_desc
            IF NOT cl_null(g_apcb_d[l_ac].l_apcb015_desc) THEN
               IF ( g_apcb_d[l_ac].l_apcb015_desc != g_apcb_d_t.l_apcb015_desc OR g_apcb_d_t.l_apcb015_desc IS NULL ) THEN
                  LET g_apcb_d[l_ac].apcb015 = g_apcb_d[l_ac].l_apcb015_desc
                  IF l_glaa121 = 'N' THEN     #141218-00011#6
                     IF (g_apcb_d[l_ac].apcb015 != g_apcb_d_t.apcb015 OR g_apcb_d_t.apcb015 IS NULL) THEN
                        CALL s_aap_project_chk( g_apcb_d[l_ac].apcb015) RETURNING g_sub_success,g_errno
                        IF NOT g_sub_success THEN
                           INITIALIZE g_errparam TO NULL
                           LET g_errparam.code = g_errno
                           LET g_errparam.extend = ''
                           #160321-00016#20 --s add
                           LET g_errparam.replace[1] = 'apjm200'
                           LET g_errparam.replace[2] = cl_get_progname('apjm200',g_lang,"2")
                           LET g_errparam.exeprog = 'apjm200'
                           #160321-00016#20 --e add
                           LET g_errparam.popup = TRUE
                           CALL cl_err()
                           LET g_apcb_d[l_ac].apcb015        = g_apcb_d_t.apcb015
                           LET g_apcb_d[l_ac].l_apcb015_desc = g_apcb_d_t.l_apcb015_desc
                           DISPLAY BY NAME g_apcb_d[l_ac].apcb015,g_apcb_d[l_ac].l_apcb015_desc
                           NEXT FIELD CURRENT
                        END IF
                        #161221-00054#1 add ------
                        #判断agli060是否设置限制核算项资料，如果设置，判断是否满足agli060条件
                        CALL s_voucher_hsx_glak_chk(g_apcb_d[1].apcbld,'13',g_apcb_d[l_ac].apcb021,g_apcb_d[l_ac].apcb015) RETURNING g_sub_success
                        IF NOT g_sub_success THEN
                           LET g_apcb_d[l_ac].apcb015        = g_apcb_d_t.apcb015
                           LET g_apcb_d[l_ac].l_apcb015_desc = g_apcb_d_t.l_apcb015_desc
                           DISPLAY BY NAME g_apcb_d[l_ac].apcb015,g_apcb_d[l_ac].l_apcb015_desc
                           NEXT FIELD CURRENT
                        END IF
                        CALL s_voucher_hsx_glak_chk(g_apcb_d[1].apcbld,'13',g_apcb_d[l_ac].apcb029,g_apcb_d[l_ac].apcb015) RETURNING g_sub_success
                        IF NOT g_sub_success THEN
                           LET g_apcb_d[l_ac].apcb015        = g_apcb_d_t.apcb015
                           LET g_apcb_d[l_ac].l_apcb015_desc = g_apcb_d_t.l_apcb015_desc
                           DISPLAY BY NAME g_apcb_d[l_ac].apcb015,g_apcb_d[l_ac].l_apcb015_desc
                           NEXT FIELD CURRENT
                        END IF
                        #161221-00054#1 add end---
                     END IF
                  END IF
               END IF
            ELSE
               LET g_apcb_d[l_ac].apcb015 = ''
            END IF
            LET g_apcb_d[l_ac].l_apcb015_desc = s_desc_show1(g_apcb_d[l_ac].apcb015,s_desc_get_project_desc(g_apcb_d[l_ac].apcb015))
            LET g_apcb_d_t.l_apcb015_desc = g_apcb_d[l_ac].l_apcb015_desc
            DISPLAY BY NAME g_apcb_d[l_ac].apcb011,g_apcb_d[l_ac].l_apcb015_desc
            
         ON ACTION controlp INFIELD l_apcb015_desc
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_apcb_d[l_ac].apcb015
            #161221-00054#1 add ------
            #agli060设置的專案代號限制条件
            CALL s_voucher_get_glak_sql(g_apcb_d[1].apcbld,'13',l_wc) RETURNING l_glak_sql
            LET g_qryparam.where = l_glak_sql
            #161221-00054#1 add end---
            CALL q_pjba001()
            LET g_apcb_d[l_ac].apcb015        = g_qryparam.return1
            LET g_apcb_d[l_ac].l_apcb015_desc = g_apcb_d[l_ac].apcb015
            DISPLAY BY NAME g_apcb_d[l_ac].apcb015,g_apcb_d[l_ac].l_apcb015_desc
            NEXT FIELD l_apcb015_desc
         
         
         
         BEFORE FIELD l_apcb036_desc                                    #150205-00012#1
            LET g_apcb_d[l_ac].l_apcb036_desc = g_apcb_d[l_ac].apcb036  #150205-00012#1
            
         #客群
         AFTER FIELD l_apcb036_desc
            IF NOT cl_null(g_apcb_d[l_ac].l_apcb036_desc) THEN
               IF ( g_apcb_d[l_ac].l_apcb036_desc != g_apcb_d_t.l_apcb036_desc OR g_apcb_d_t.l_apcb036_desc IS NULL ) THEN
                  LET g_apcb_d[l_ac].apcb036 = g_apcb_d[l_ac].l_apcb036_desc
                  IF l_glaa121 = 'N' THEN     #141218-00011#6
                     IF (g_apcb_d[l_ac].apcb036 != g_apcb_d_t.apcb036 OR g_apcb_d_t.apcb036 IS NULL) THEN
                        IF NOT s_azzi650_chk_exist('281',g_apcb_d[l_ac].l_apcb036_desc) THEN
                           LET g_apcb_d[l_ac].apcb036        = g_apcb_d_t.apcb036
                           LET g_apcb_d[l_ac].l_apcb036_desc = g_apcb_d_t.l_apcb036_desc
                           DISPLAY BY NAME g_apcb_d[l_ac].apcb036,g_apcb_d[l_ac].l_apcb036_desc
                           NEXT FIELD CURRENT
                        END IF
                        #161221-00054#1 add ------
                        #判断agli060是否设置限制核算项资料，如果设置，判断是否满足agli060条件
                        CALL s_voucher_hsx_glak_chk(g_apcb_d[1].apcbld,'07',g_apcb_d[l_ac].apcb021,g_apcb_d[l_ac].apcb036) RETURNING g_sub_success
                        IF NOT g_sub_success THEN
                           LET g_apcb_d[l_ac].apcb036        = g_apcb_d_t.apcb036
                           LET g_apcb_d[l_ac].l_apcb036_desc = g_apcb_d_t.l_apcb036_desc
                           DISPLAY BY NAME g_apcb_d[l_ac].apcb036,g_apcb_d[l_ac].l_apcb036_desc
                           NEXT FIELD CURRENT
                        END IF
                        CALL s_voucher_hsx_glak_chk(g_apcb_d[1].apcbld,'07',g_apcb_d[l_ac].apcb029,g_apcb_d[l_ac].apcb036) RETURNING g_sub_success
                        IF NOT g_sub_success THEN
                           LET g_apcb_d[l_ac].apcb036        = g_apcb_d_t.apcb036
                           LET g_apcb_d[l_ac].l_apcb036_desc = g_apcb_d_t.l_apcb036_desc
                           DISPLAY BY NAME g_apcb_d[l_ac].apcb036,g_apcb_d[l_ac].l_apcb036_desc
                           NEXT FIELD CURRENT
                        END IF
                        #161221-00054#1 add end---
                     END IF
                  END IF
               END IF
            ELSE
               LET g_apcb_d[l_ac].apcb036 = ''
            END IF
            LET g_apcb_d[l_ac].l_apcb036_desc = s_desc_show1(g_apcb_d[l_ac].apcb036,s_desc_get_acc_desc('281',g_apcb_d[l_ac].apcb036))
            LET g_apcb_d_t.l_apcb036_desc = g_apcb_d[l_ac].l_apcb036_desc
            DISPLAY BY NAME g_apcb_d[l_ac].apcb036,g_apcb_d[l_ac].l_apcb036_desc

         ON ACTION controlp INFIELD l_apcb036_desc
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_apcb_d[l_ac].l_apcb036_desc
            #161221-00054#1 add ------
            #agli060设置的客群限制条件
            CALL s_voucher_get_glak_sql(g_apcb_d[1].apcbld,'07',l_wc) RETURNING l_glak_sql
            LET g_qryparam.where = l_glak_sql
            #161221-00054#1 add end---
            CALL q_oocq002_281()
            LET g_apcb_d[l_ac].apcb036        = g_qryparam.return1
            LET g_apcb_d[l_ac].l_apcb036_desc = g_apcb_d[l_ac].apcb036
            DISPLAY BY NAME g_apcb_d[l_ac].apcb036 ,g_apcb_d[l_ac].l_apcb036_desc
            NEXT FIELD l_apcb036_desc
         
         
         #160509-00004#110--add--str--lujh
         BEFORE FIELD l_apcb054_desc
            LET g_apcb_d[l_ac].l_apcb054_desc = g_apcb_d[l_ac].apcb054
         
         #账款客商
         AFTER FIELD l_apcb054_desc
            IF NOT cl_null(g_apcb_d[l_ac].l_apcb054_desc) THEN
               IF ( g_apcb_d[l_ac].l_apcb054_desc != g_apcb_d_t.l_apcb054_desc OR g_apcb_d_t.l_apcb054_desc IS NULL ) THEN
                  LET g_apcb_d[l_ac].apcb054 = g_apcb_d[l_ac].l_apcb054_desc
                  #160920-00019#1---s
                  CALL s_aap_apca004_chk(g_apcb_d[l_ac].apcb054) RETURNING g_sub_success,g_errno
                  IF NOT cl_null(g_errno)THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = ''
                     LET g_errparam.replace[1] = 'apmm100'
                     LET g_errparam.replace[2] = cl_get_progname('apmm100',g_lang,"2")
                     LET g_errparam.exeprog = 'apmm100'
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_apcb_d[l_ac].apcb054        = g_apcb_d_t.apcb054
                     LET g_apcb_d[l_ac].l_apcb054_desc = g_apcb_d_t.l_apcb054_desc
                     DISPLAY BY NAME g_apcb_d[l_ac].apcb054,g_apcb_d[l_ac].l_apcb054_desc
                     NEXT FIELD CURRENT
                  END IF
                  #160920-00019#1---e
                  IF l_glaa121 = 'N' THEN
                     IF (g_apcb_d[l_ac].apcb054 != g_apcb_d_t.apcb054 OR g_apcb_d_t.apcb054 IS NULL) THEN
                        CALL s_voucher_glaq021_chk(g_apcb_d[l_ac].l_apcb054_desc) 
                        IF NOT cl_null(g_errno) THEN
                           LET g_apcb_d[l_ac].apcb054        = g_apcb_d_t.apcb054
                           LET g_apcb_d[l_ac].l_apcb054_desc = g_apcb_d_t.l_apcb054_desc
                           DISPLAY BY NAME g_apcb_d[l_ac].apcb054,g_apcb_d[l_ac].l_apcb054_desc
                           NEXT FIELD CURRENT
                        END IF
                        #161221-00054#1 add ------
                        #判断agli060是否设置限制核算项资料，如果设置，判断是否满足agli060条件
                        CALL s_voucher_hsx_glak_chk(g_apcb_d[1].apcbld,'06',g_apcb_d[l_ac].apcb021,g_apcb_d[l_ac].apcb054) RETURNING g_sub_success
                        IF NOT g_sub_success THEN
                           LET g_apcb_d[l_ac].apcb054        = g_apcb_d_t.apcb054
                           LET g_apcb_d[l_ac].l_apcb054_desc = g_apcb_d_t.l_apcb054_desc
                           DISPLAY BY NAME g_apcb_d[l_ac].apcb054,g_apcb_d[l_ac].l_apcb054_desc
                           NEXT FIELD CURRENT
                        END IF
                        CALL s_voucher_hsx_glak_chk(g_apcb_d[1].apcbld,'06',g_apcb_d[l_ac].apcb029,g_apcb_d[l_ac].apcb054) RETURNING g_sub_success
                        IF NOT g_sub_success THEN
                           LET g_apcb_d[l_ac].apcb054        = g_apcb_d_t.apcb054
                           LET g_apcb_d[l_ac].l_apcb054_desc = g_apcb_d_t.l_apcb054_desc
                           DISPLAY BY NAME g_apcb_d[l_ac].apcb054,g_apcb_d[l_ac].l_apcb054_desc
                           NEXT FIELD CURRENT
                        END IF
                        #161221-00054#1 add end---
                     END IF
                  END IF
               END IF
            ELSE
               LET g_apcb_d[l_ac].apcb054 = ''
            END IF
            LET g_apcb_d[l_ac].l_apcb054_desc = s_desc_show1(g_apcb_d[l_ac].apcb054,s_desc_get_trading_partner_abbr_desc(g_apcb_d[l_ac].apcb054))
            LET g_apcb_d_t.l_apcb054_desc = g_apcb_d[l_ac].l_apcb054_desc
            DISPLAY BY NAME g_apcb_d[l_ac].apcb054,g_apcb_d[l_ac].l_apcb054_desc

         ON ACTION controlp INFIELD l_apcb054_desc
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            #LET g_qryparam.where = "pmaa002 IN ('1','3')"   #160920-00019#1---mark
            #160920-00019#1---s
            IF NOT cl_null(l_sql_ctrl) AND NOT l_sql_ctrl = ' 1=1'  THEN
               LET g_qryparam.where = l_sql_ctrl
            END IF
            #160920-00019#1---e
            #161221-00054#1 add ------
            IF cl_null(g_qryparam.where) THEN LET g_qryparam.where = " 1=1 " END IF
            #agli060设置的账款客商限制条件
            CALL s_voucher_get_glak_sql(g_apcb_d[1].apcbld,'06',l_wc) RETURNING l_glak_sql
            LET g_qryparam.where = g_qryparam.where," AND ",l_glak_sql
            #161221-00054#1 add end---
            CALL q_pmaa001()
            LET g_qryparam.default1 = g_apcb_d[l_ac].l_apcb054_desc
            LET g_apcb_d[l_ac].apcb054        = g_qryparam.return1
            LET g_apcb_d[l_ac].l_apcb054_desc = g_apcb_d[l_ac].apcb054
            DISPLAY BY NAME g_apcb_d[l_ac].apcb054 ,g_apcb_d[l_ac].l_apcb054_desc
            NEXT FIELD l_apcb054_desc
         
         
         
         BEFORE FIELD l_apcb055_desc
            LET g_apcb_d[l_ac].l_apcb055_desc = g_apcb_d[l_ac].apcb055
         
         #交易客商
         AFTER FIELD l_apcb055_desc
            IF NOT cl_null(g_apcb_d[l_ac].l_apcb055_desc) THEN
               IF ( g_apcb_d[l_ac].l_apcb055_desc != g_apcb_d_t.l_apcb055_desc OR g_apcb_d_t.l_apcb055_desc IS NULL ) THEN
                  LET g_apcb_d[l_ac].apcb055 = g_apcb_d[l_ac].l_apcb055_desc
                  #160920-00019#1---s
                  CALL s_aap_apca004_chk(g_apcb_d[l_ac].apcb055) RETURNING g_sub_success,g_errno
                  IF NOT cl_null(g_errno)THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = ''
                     LET g_errparam.replace[1] = 'apmm100'
                     LET g_errparam.replace[2] = cl_get_progname('apmm100',g_lang,"2")
                     LET g_errparam.exeprog = 'apmm100'
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_apcb_d[l_ac].apcb055        = g_apcb_d_t.apcb055
                     LET g_apcb_d[l_ac].l_apcb055_desc = g_apcb_d_t.l_apcb055_desc
                     DISPLAY BY NAME g_apcb_d[l_ac].apcb055,g_apcb_d[l_ac].l_apcb055_desc
                     NEXT FIELD CURRENT
                  END IF
                  #160920-00019#1---e
                  IF l_glaa121 = 'N' THEN
                     IF (g_apcb_d[l_ac].apcb055 != g_apcb_d_t.apcb055 OR g_apcb_d_t.apcb055 IS NULL) THEN
                        CALL s_voucher_glaq021_chk(g_apcb_d[l_ac].l_apcb055_desc) 
                        IF NOT cl_null(g_errno) THEN
                           LET g_apcb_d[l_ac].apcb055        = g_apcb_d_t.apcb055
                           LET g_apcb_d[l_ac].l_apcb055_desc = g_apcb_d_t.l_apcb055_desc
                           DISPLAY BY NAME g_apcb_d[l_ac].apcb055,g_apcb_d[l_ac].l_apcb055_desc
                           NEXT FIELD CURRENT
                        END IF
                        #161221-00054#1 add ------
                        #判断agli060是否设置限制核算项资料，如果设置，判断是否满足agli060条件
                        CALL s_voucher_hsx_glak_chk(g_apcb_d[1].apcbld,'05',g_apcb_d[l_ac].apcb021,g_apcb_d[l_ac].apcb055) RETURNING g_sub_success
                        IF NOT g_sub_success THEN
                           LET g_apcb_d[l_ac].apcb055        = g_apcb_d_t.apcb055
                           LET g_apcb_d[l_ac].l_apcb055_desc = g_apcb_d_t.l_apcb055_desc
                           DISPLAY BY NAME g_apcb_d[l_ac].apcb055,g_apcb_d[l_ac].l_apcb055_desc
                           NEXT FIELD CURRENT
                        END IF
                        CALL s_voucher_hsx_glak_chk(g_apcb_d[1].apcbld,'05',g_apcb_d[l_ac].apcb029,g_apcb_d[l_ac].apcb055) RETURNING g_sub_success
                        IF NOT g_sub_success THEN
                           LET g_apcb_d[l_ac].apcb055        = g_apcb_d_t.apcb055
                           LET g_apcb_d[l_ac].l_apcb055_desc = g_apcb_d_t.l_apcb055_desc
                           DISPLAY BY NAME g_apcb_d[l_ac].apcb055,g_apcb_d[l_ac].l_apcb055_desc
                           NEXT FIELD CURRENT
                        END IF
                        #161221-00054#1 add end---
                     END IF
                  END IF
               END IF
            ELSE
               LET g_apcb_d[l_ac].apcb055 = ''
            END IF
            LET g_apcb_d[l_ac].l_apcb055_desc = s_desc_show1(g_apcb_d[l_ac].apcb055,s_desc_get_trading_partner_abbr_desc(g_apcb_d[l_ac].apcb055))
            LET g_apcb_d_t.l_apcb055_desc = g_apcb_d[l_ac].l_apcb055_desc
            DISPLAY BY NAME g_apcb_d[l_ac].apcb055,g_apcb_d[l_ac].l_apcb055_desc

         ON ACTION controlp INFIELD l_apcb055_desc
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_apcb_d[l_ac].l_apcb055_desc
            #LET g_qryparam.where = "pmaa002 IN ('1','3')"   #160920-00019#1---mark
            #160920-00019#1---s
            IF NOT cl_null(l_sql_ctrl) AND NOT l_sql_ctrl = ' 1=1'  THEN
               LET g_qryparam.where = l_sql_ctrl
            END IF
            #160920-00019#1---e
            #161221-00054#1 add ------
            IF cl_null(g_qryparam.where) THEN LET g_qryparam.where = " 1=1 " END IF
            #agli060设置的交易客商限制条件
            CALL s_voucher_get_glak_sql(g_apcb_d[1].apcbld,'05',l_wc) RETURNING l_glak_sql
            LET g_qryparam.where = g_qryparam.where," AND ",l_glak_sql
            #161221-00054#1 add end---
            CALL q_pmaa001()  
            LET g_apcb_d[l_ac].apcb055        = g_qryparam.return1
            LET g_apcb_d[l_ac].l_apcb055_desc = g_apcb_d[l_ac].apcb055
            DISPLAY BY NAME g_apcb_d[l_ac].apcb055 ,g_apcb_d[l_ac].l_apcb055_desc
            NEXT FIELD l_apcb055_desc  
         #160509-00004#110--add--end--lujh
         
         
         
         #經營方式
         AFTER FIELD apcb033
            IF NOT cl_null(g_apcb_d[l_ac].apcb033) THEN
               IF ( g_apcb_d[l_ac].apcb033 != g_apcb_d_t.apcb033 OR g_apcb_d_t.apcb033 IS NULL ) THEN
                  IF l_glaa121 = 'N' THEN     #141218-00011#6
                     IF (g_apcb_d[l_ac].apcb033 != g_apcb_d_t.apcb033 OR g_apcb_d_t.apcb033 IS NULL) THEN
                        CALL s_voucher_glaq051_chk(g_apcb_d[l_ac].apcb033)
                        IF NOT cl_null(g_errno) THEN
                           LET g_apcb_d[l_ac].apcb033 = g_apcb_d_t.apcb033
                           LET g_apcb_d[l_ac].apcb033 = g_apcb_d_t.apcb033
                           DISPLAY BY NAME g_apcb_d[l_ac].apcb033,g_apcb_d[l_ac].apcb033
                           NEXT FIELD CURRENT
                        END IF
                        #161221-00054#1 add ------
                        #判断agli060是否设置限制核算项资料，如果设置，判断是否满足agli060条件
                        CALL s_voucher_hsx_glak_chk(g_apcb_d[1].apcbld,'09',g_apcb_d[l_ac].apcb021,g_apcb_d[l_ac].apcb033) RETURNING g_sub_success
                        IF NOT g_sub_success THEN
                           LET g_apcb_d[l_ac].apcb033 = g_apcb_d_t.apcb033
                           DISPLAY BY NAME g_apcb_d[l_ac].apcb033,g_apcb_d[l_ac].apcb033
                           NEXT FIELD CURRENT
                        END IF
                        CALL s_voucher_hsx_glak_chk(g_apcb_d[1].apcbld,'09',g_apcb_d[l_ac].apcb029,g_apcb_d[l_ac].apcb033) RETURNING g_sub_success
                        IF NOT g_sub_success THEN
                           LET g_apcb_d[l_ac].apcb033 = g_apcb_d_t.apcb033
                           DISPLAY BY NAME g_apcb_d[l_ac].apcb033,g_apcb_d[l_ac].apcb033
                           NEXT FIELD CURRENT
                        END IF
                        #161221-00054#1 add end---
                     END IF
                  END IF
               END IF
            END IF
            DISPLAY BY NAME g_apcb_d[l_ac].apcb033
         
         
         
         BEFORE FIELD l_apcb034_desc                                    #150205-00012#1
            LET g_apcb_d[l_ac].l_apcb034_desc = g_apcb_d[l_ac].apcb034  #150205-00012#1
         #渠道
         AFTER FIELD l_apcb034_desc
            IF NOT cl_null(g_apcb_d[l_ac].l_apcb034_desc) THEN
               IF ( g_apcb_d[l_ac].l_apcb034_desc != g_apcb_d_t.l_apcb034_desc OR g_apcb_d_t.l_apcb034_desc IS NULL ) THEN
                  LET g_apcb_d[l_ac].apcb034 = g_apcb_d[l_ac].l_apcb034_desc
                  IF l_glaa121 = 'N' THEN     #141218-00011#6
                     IF (g_apcb_d[l_ac].apcb034 != g_apcb_d_t.apcb034 OR g_apcb_d_t.apcb034 IS NULL) THEN
                        CALL s_voucher_glaq052_chk(g_apcb_d[l_ac].l_apcb034_desc)
                        IF NOT cl_null(g_errno) THEN
                           LET g_apcb_d[l_ac].apcb034        = g_apcb_d_t.apcb034
                           LET g_apcb_d[l_ac].l_apcb034_desc = g_apcb_d_t.l_apcb034_desc
                           DISPLAY BY NAME g_apcb_d[l_ac].apcb034,g_apcb_d[l_ac].l_apcb034_desc
                           NEXT FIELD CURRENT
                        END IF
                        #161221-00054#1 add ------
                        #判断agli060是否设置限制核算项资料，如果设置，判断是否满足agli060条件
                        CALL s_voucher_hsx_glak_chk(g_apcb_d[1].apcbld,'10',g_apcb_d[l_ac].apcb021,g_apcb_d[l_ac].apcb034) RETURNING g_sub_success
                        IF NOT g_sub_success THEN
                           LET g_apcb_d[l_ac].apcb034        = g_apcb_d_t.apcb034
                           LET g_apcb_d[l_ac].l_apcb034_desc = g_apcb_d_t.l_apcb034_desc
                           DISPLAY BY NAME g_apcb_d[l_ac].apcb034,g_apcb_d[l_ac].l_apcb034_desc
                           NEXT FIELD CURRENT
                        END IF
                        CALL s_voucher_hsx_glak_chk(g_apcb_d[1].apcbld,'10',g_apcb_d[l_ac].apcb029,g_apcb_d[l_ac].apcb034) RETURNING g_sub_success
                        IF NOT g_sub_success THEN
                           LET g_apcb_d[l_ac].apcb034        = g_apcb_d_t.apcb034
                           LET g_apcb_d[l_ac].l_apcb034_desc = g_apcb_d_t.l_apcb034_desc
                           DISPLAY BY NAME g_apcb_d[l_ac].apcb034,g_apcb_d[l_ac].l_apcb034_desc
                           NEXT FIELD CURRENT
                        END IF
                        #161221-00054#1 add end---
                     END IF
                  END IF
               END IF
            ELSE
               LET g_apcb_d[l_ac].apcb034 = ''
            END IF
            LET g_apcb_d[l_ac].l_apcb034_desc = s_desc_show1(g_apcb_d[l_ac].apcb034,s_desc_get_oojdl003_desc(g_apcb_d[l_ac].apcb034))
            LET g_apcb_d_t.l_apcb034_desc = g_apcb_d[l_ac].l_apcb034_desc
            DISPLAY BY NAME g_apcb_d[l_ac].apcb034,g_apcb_d[l_ac].l_apcb034_desc

         ON ACTION controlp INFIELD l_apcb034_desc
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_apcb_d[l_ac].l_apcb034_desc
            #161221-00054#1 add ------
            #agli060设置的渠道限制条件
            CALL s_voucher_get_glak_sql(g_apcb_d[1].apcbld,'10',l_wc) RETURNING l_glak_sql
            LET g_qryparam.where = " oojdstus='Y' AND ",l_glak_sql
            #161221-00054#1 add end---
            CALL q_oojd001_2()
            LET g_apcb_d[l_ac].apcb034        = g_qryparam.return1
            LET g_apcb_d[l_ac].l_apcb034_desc = g_apcb_d[l_ac].apcb034
            DISPLAY BY NAME g_apcb_d[l_ac].apcb034 ,g_apcb_d[l_ac].l_apcb034_desc
            NEXT FIELD l_apcb034_desc
         
         
         
         BEFORE FIELD l_apcb035_desc                                    #150205-00012#1
            LET g_apcb_d[l_ac].l_apcb035_desc = g_apcb_d[l_ac].apcb035  #150205-00012#1
         #品牌
         AFTER FIELD l_apcb035_desc
            IF NOT cl_null(g_apcb_d[l_ac].l_apcb035_desc) THEN
               IF ( g_apcb_d[l_ac].l_apcb035_desc != g_apcb_d_t.l_apcb035_desc OR g_apcb_d_t.l_apcb035_desc IS NULL ) THEN
                  LET g_apcb_d[l_ac].apcb035 = g_apcb_d[l_ac].l_apcb035_desc
                  IF l_glaa121 = 'N' THEN     #141218-00011#6
                     IF (g_apcb_d[l_ac].apcb035 != g_apcb_d_t.apcb035 OR g_apcb_d_t.apcb035 IS NULL) THEN
                        IF NOT s_azzi650_chk_exist('2002',g_apcb_d[l_ac].l_apcb035_desc) THEN
                           LET g_apcb_d[l_ac].apcb035        = g_apcb_d_t.apcb035
                           LET g_apcb_d[l_ac].l_apcb035_desc = g_apcb_d_t.l_apcb035_desc
                           DISPLAY BY NAME g_apcb_d[l_ac].apcb035,g_apcb_d[l_ac].l_apcb035_desc
                           NEXT FIELD CURRENT
                        END IF
                        #161221-00054#1 add ------
                        #判断agli060是否设置限制核算项资料，如果设置，判断是否满足agli060条件
                        CALL s_voucher_hsx_glak_chk(g_apcb_d[1].apcbld,'11',g_apcb_d[l_ac].apcb021,g_apcb_d[l_ac].apcb035) RETURNING g_sub_success
                        IF NOT g_sub_success THEN
                           LET g_apcb_d[l_ac].apcb035        = g_apcb_d_t.apcb035
                           LET g_apcb_d[l_ac].l_apcb035_desc = g_apcb_d_t.l_apcb035_desc
                           DISPLAY BY NAME g_apcb_d[l_ac].apcb035,g_apcb_d[l_ac].l_apcb035_desc
                           NEXT FIELD CURRENT
                        END IF
                        CALL s_voucher_hsx_glak_chk(g_apcb_d[1].apcbld,'11',g_apcb_d[l_ac].apcb029,g_apcb_d[l_ac].apcb035) RETURNING g_sub_success
                        IF NOT g_sub_success THEN
                           LET g_apcb_d[l_ac].apcb035        = g_apcb_d_t.apcb035
                           LET g_apcb_d[l_ac].l_apcb035_desc = g_apcb_d_t.l_apcb035_desc
                           DISPLAY BY NAME g_apcb_d[l_ac].apcb035,g_apcb_d[l_ac].l_apcb035_desc
                           NEXT FIELD CURRENT
                        END IF
                        #161221-00054#1 add end---
                     END IF
                  END IF
               END IF
            ELSE
               LET g_apcb_d[l_ac].apcb035 = ''
            END IF
            LET g_apcb_d[l_ac].l_apcb035_desc = s_desc_show1(g_apcb_d[l_ac].apcb035,s_desc_get_acc_desc('2002',g_apcb_d[l_ac].apcb035))
            LET g_apcb_d_t.l_apcb035_desc = g_apcb_d[l_ac].l_apcb035_desc
            DISPLAY BY NAME g_apcb_d[l_ac].apcb035,g_apcb_d[l_ac].l_apcb035_desc
         
         ON ACTION controlp INFIELD l_apcb035_desc
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_apcb_d[l_ac].l_apcb035_desc
            #161221-00054#1 add ------
            #agli060设置的渠道限制条件
            CALL s_voucher_get_glak_sql(g_apcb_d[1].apcbld,'11',l_wc) RETURNING l_glak_sql
            LET g_qryparam.where = l_glak_sql
            #161221-00054#1 add end---
            CALL q_oocq002_2002()
            LET g_apcb_d[l_ac].apcb035        = g_qryparam.return1
            LET g_apcb_d[l_ac].l_apcb035_desc = g_apcb_d[l_ac].apcb035
            DISPLAY BY NAME g_apcb_d[l_ac].apcb035 ,g_apcb_d[l_ac].l_apcb035_desc
            NEXT FIELD l_apcb035_desc
         
         
         
         #自由核算項一
         BEFORE FIELD l_apcb037_desc
            CALL s_fin_get_glae009(l_glad.glad0171) RETURNING l_glae009
            LET g_apcb_d[l_ac].l_apcb037_desc = g_apcb_d[l_ac].apcb037  #150205-00012#1
            
         AFTER FIELD l_apcb037_desc
            IF NOT cl_null(g_apcb_d[l_ac].l_apcb037_desc) THEN
               IF ( g_apcb_d[l_ac].l_apcb037_desc != g_apcb_d_t.l_apcb037_desc OR g_apcb_d_t.l_apcb037_desc IS NULL ) THEN
                  LET g_apcb_d[l_ac].apcb037 = g_apcb_d[l_ac].l_apcb037_desc
                  IF l_glaa121 = 'N' THEN     #141218-00011#6
                     IF (g_apcb_d[l_ac].apcb037 != g_apcb_d_t.apcb037 OR g_apcb_d_t.apcb037 IS NULL) THEN
                        CALL s_voucher_free_account_chk(l_glad.glad0171,g_apcb_d[l_ac].l_apcb037_desc,l_glad.glad0172) RETURNING g_errno
                        IF NOT cl_null(g_errno) THEN
                           LET g_apcb_d[l_ac].apcb037        = g_apcb_d_t.apcb037
                           LET g_apcb_d[l_ac].l_apcb037_desc = g_apcb_d_t.l_apcb037_desc
                           DISPLAY BY NAME g_apcb_d[l_ac].apcb037,g_apcb_d[l_ac].l_apcb037_desc
                           NEXT FIELD CURRENT
                        END IF
                     END IF
                  END IF
               END IF
            ELSE
               LET g_apcb_d[l_ac].apcb037 = ''
            END IF
            LET g_apcb_d[l_ac].l_apcb037_desc = s_desc_show1(g_apcb_d[l_ac].apcb037,s_fin_get_accting_desc(l_glad.glad0171,g_apcb_d[l_ac].apcb037))
            LET g_apcb_d_t.l_apcb037_desc = g_apcb_d[l_ac].l_apcb037_desc
            DISPLAY BY NAME g_apcb_d[l_ac].apcb037,g_apcb_d[l_ac].l_apcb037_desc

         ON ACTION controlp INFIELD l_apcb037_desc
            IF NOT cl_null(l_glae009) THEN
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.default1 = g_apcb_d[l_ac].l_apcb037_desc
               IF l_glae009 = 'q_glaf002' THEN    
                  LET g_qryparam.where = "glaf001 = '",l_glad.glad0171,"'" #自由核算項類型
               END IF 
               CALL q_agli041(l_glae009) 
               LET g_apcb_d[l_ac].apcb037        = g_qryparam.return1
               LET g_apcb_d[l_ac].l_apcb037_desc = g_apcb_d[l_ac].apcb037
               DISPLAY BY NAME g_apcb_d[l_ac].apcb037 ,g_apcb_d[l_ac].l_apcb037_desc
               NEXT FIELD l_apcb037_desc
            END IF
         
         
         
         #自由核算項二
         BEFORE FIELD l_apcb038_desc
            CALL s_fin_get_glae009(l_glad.glad0181) RETURNING l_glae009
            LET g_apcb_d[l_ac].l_apcb038_desc = g_apcb_d[l_ac].apcb038  #150205-00012#1
         
         AFTER FIELD l_apcb038_desc
            IF NOT cl_null(g_apcb_d[l_ac].l_apcb038_desc) THEN
               IF ( g_apcb_d[l_ac].l_apcb038_desc != g_apcb_d_t.l_apcb038_desc OR g_apcb_d_t.l_apcb038_desc IS NULL ) THEN
                  LET g_apcb_d[l_ac].apcb038 = g_apcb_d[l_ac].l_apcb038_desc
                  IF l_glaa121 = 'N' THEN     #141218-00011#6
                     IF (g_apcb_d[l_ac].apcb038 != g_apcb_d_t.apcb038 OR g_apcb_d_t.apcb038 IS NULL) THEN
                        CALL s_voucher_free_account_chk(l_glad.glad0181,g_apcb_d[l_ac].l_apcb038_desc,l_glad.glad0182) RETURNING g_errno
                        IF NOT cl_null(g_errno) THEN
                           LET g_apcb_d[l_ac].apcb038        = g_apcb_d_t.apcb038
                           LET g_apcb_d[l_ac].l_apcb038_desc = g_apcb_d_t.l_apcb038_desc
                           DISPLAY BY NAME g_apcb_d[l_ac].apcb038,g_apcb_d[l_ac].l_apcb038_desc
                           NEXT FIELD CURRENT
                        END IF
                     END IF
                  END IF
               END IF
            ELSE
               LET g_apcb_d[l_ac].apcb038 = ''
            END IF
            LET g_apcb_d[l_ac].l_apcb038_desc = s_desc_show1(g_apcb_d[l_ac].apcb038,s_fin_get_accting_desc(l_glad.glad0181,g_apcb_d[l_ac].apcb038))
            LET g_apcb_d_t.l_apcb038_desc = g_apcb_d[l_ac].l_apcb038_desc
            DISPLAY BY NAME g_apcb_d[l_ac].apcb038,g_apcb_d[l_ac].l_apcb038_desc

         ON ACTION controlp INFIELD l_apcb038_desc
            IF NOT cl_null(l_glae009) THEN
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.default1 = g_apcb_d[l_ac].l_apcb038_desc
               IF l_glae009 = 'q_glaf002' THEN    
                  LET g_qryparam.where = "glaf001 = '",l_glad.glad0181,"'" #自由核算項類型
               END IF 
               CALL q_agli041(l_glae009) 
               LET g_apcb_d[l_ac].apcb038        = g_qryparam.return1
               LET g_apcb_d[l_ac].l_apcb038_desc = g_apcb_d[l_ac].apcb038
               DISPLAY BY NAME g_apcb_d[l_ac].apcb038 ,g_apcb_d[l_ac].l_apcb038_desc
               NEXT FIELD l_apcb038_desc
            END IF    
         
         #自由核算項三
         BEFORE FIELD l_apcb039_desc
            CALL s_fin_get_glae009(l_glad.glad0191) RETURNING l_glae009
            LET g_apcb_d[l_ac].l_apcb039_desc = g_apcb_d[l_ac].apcb039  #150205-00012#1
         
         AFTER FIELD l_apcb039_desc
            IF NOT cl_null(g_apcb_d[l_ac].l_apcb039_desc)  THEN
               IF ( g_apcb_d[l_ac].l_apcb039_desc != g_apcb_d_t.l_apcb039_desc OR g_apcb_d_t.l_apcb039_desc IS NULL ) THEN
                  LET g_apcb_d[l_ac].apcb039 = g_apcb_d[l_ac].l_apcb039_desc
                  IF l_glaa121 = 'N' THEN     #141218-00011#6
                     IF (g_apcb_d[l_ac].apcb039 != g_apcb_d_t.apcb039 OR g_apcb_d_t.apcb039 IS NULL) THEN
                        CALL s_voucher_free_account_chk(l_glad.glad0191,g_apcb_d[l_ac].l_apcb039_desc,l_glad.glad0192) RETURNING g_errno
                        IF NOT cl_null(g_errno) THEN
                           LET g_apcb_d[l_ac].apcb039        = g_apcb_d_t.apcb039
                           LET g_apcb_d[l_ac].l_apcb039_desc = g_apcb_d_t.l_apcb039_desc
                           DISPLAY BY NAME g_apcb_d[l_ac].apcb039,g_apcb_d[l_ac].l_apcb039_desc
                           NEXT FIELD CURRENT
                        END IF
                     END IF
                  END IF
               END IF
            ELSE
               LET g_apcb_d[l_ac].apcb039 = ''
            END IF
            LET g_apcb_d[l_ac].l_apcb039_desc = s_desc_show1(g_apcb_d[l_ac].apcb039,s_fin_get_accting_desc(l_glad.glad0191,g_apcb_d[l_ac].apcb039))
            LET g_apcb_d_t.l_apcb039_desc = g_apcb_d[l_ac].l_apcb039_desc
            DISPLAY BY NAME g_apcb_d[l_ac].apcb039,g_apcb_d[l_ac].l_apcb039_desc

         ON ACTION controlp INFIELD l_apcb039_desc
            IF NOT cl_null(l_glae009) THEN
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.default1 = g_apcb_d[l_ac].l_apcb039_desc
               IF l_glae009 = 'q_glaf002' THEN    
                  LET g_qryparam.where = "glaf001 = '",l_glad.glad0191,"'" #自由核算項類型
               END IF 
               CALL q_agli041(l_glae009) 
               LET g_apcb_d[l_ac].apcb039        = g_qryparam.return1
               LET g_apcb_d[l_ac].l_apcb039_desc = g_apcb_d[l_ac].apcb039
               DISPLAY BY NAME g_apcb_d[l_ac].apcb039 ,g_apcb_d[l_ac].l_apcb039_desc
               NEXT FIELD l_apcb039_desc
            END IF
            
         #自由核算項四
         BEFORE FIELD l_apcb040_desc
            CALL s_fin_get_glae009(l_glad.glad0201) RETURNING l_glae009
            LET g_apcb_d[l_ac].l_apcb040_desc = g_apcb_d[l_ac].apcb040  #150205-00012#1
         
         AFTER FIELD l_apcb040_desc
            IF NOT cl_null(g_apcb_d[l_ac].l_apcb040_desc) THEN
               IF ( g_apcb_d[l_ac].l_apcb040_desc != g_apcb_d_t.l_apcb040_desc OR g_apcb_d_t.l_apcb040_desc IS NULL ) THEN
                  LET g_apcb_d[l_ac].apcb040 = g_apcb_d[l_ac].l_apcb040_desc
                  IF l_glaa121 = 'N' THEN     #141218-00011#6
                     IF (g_apcb_d[l_ac].apcb040 != g_apcb_d_t.apcb040 OR g_apcb_d_t.apcb040 IS NULL) THEN
                        CALL s_voucher_free_account_chk(l_glad.glad0201,g_apcb_d[l_ac].l_apcb040_desc,l_glad.glad0202) RETURNING g_errno
                        IF NOT cl_null(g_errno) THEN
                           LET g_apcb_d[l_ac].apcb040        = g_apcb_d_t.apcb040
                           LET g_apcb_d[l_ac].l_apcb040_desc = g_apcb_d_t.l_apcb040_desc
                           DISPLAY BY NAME g_apcb_d[l_ac].apcb040,g_apcb_d[l_ac].l_apcb040_desc
                           NEXT FIELD CURRENT
                        END IF
                     END IF
                  END IF
               END IF
            ELSE
               LET g_apcb_d[l_ac].apcb040 = ''
            END IF
            LET g_apcb_d[l_ac].l_apcb040_desc = s_desc_show1(g_apcb_d[l_ac].apcb040,s_fin_get_accting_desc(l_glad.glad0201,g_apcb_d[l_ac].apcb040))
            LET g_apcb_d_t.l_apcb040_desc = g_apcb_d[l_ac].l_apcb040_desc
            DISPLAY BY NAME g_apcb_d[l_ac].apcb040,g_apcb_d[l_ac].l_apcb040_desc

         ON ACTION controlp INFIELD l_apcb040_desc
            IF NOT cl_null(l_glae009) THEN
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.default1 = g_apcb_d[l_ac].l_apcb040_desc
               IF l_glae009 = 'q_glaf002' THEN    
                  LET g_qryparam.where = "glaf001 = '",l_glad.glad0201,"'" #自由核算項類型
               END IF 
               CALL q_agli041(l_glae009) 
               LET g_apcb_d[l_ac].apcb040        = g_qryparam.return1
               LET g_apcb_d[l_ac].l_apcb040_desc = g_apcb_d[l_ac].apcb040
               DISPLAY BY NAME g_apcb_d[l_ac].apcb040 ,g_apcb_d[l_ac].l_apcb040_desc
               NEXT FIELD l_apcb040_desc
            END IF    
         
         #自由核算項五
         BEFORE FIELD l_apcb041_desc
            CALL s_fin_get_glae009(l_glad.glad0211) RETURNING l_glae009
            LET g_apcb_d[l_ac].l_apcb041_desc = g_apcb_d[l_ac].apcb041  #150205-00012#1
         
         AFTER FIELD l_apcb041_desc 
            IF NOT cl_null(g_apcb_d[l_ac].l_apcb041_desc) THEN
               IF ( g_apcb_d[l_ac].l_apcb041_desc != g_apcb_d_t.l_apcb041_desc OR g_apcb_d_t.l_apcb041_desc IS NULL ) THEN
                  LET g_apcb_d[l_ac].apcb041 = g_apcb_d[l_ac].l_apcb041_desc
                  IF l_glaa121 = 'N' THEN     #141218-00011#6
                     IF (g_apcb_d[l_ac].apcb041 != g_apcb_d_t.apcb041 OR g_apcb_d_t.apcb041 IS NULL) THEN
                        CALL s_voucher_free_account_chk(l_glad.glad0211,g_apcb_d[l_ac].l_apcb041_desc,l_glad.glad0212) RETURNING g_errno
                        IF NOT cl_null(g_errno) THEN
                           LET g_apcb_d[l_ac].apcb041        = g_apcb_d_t.apcb041
                           LET g_apcb_d[l_ac].l_apcb041_desc = g_apcb_d_t.l_apcb041_desc
                           DISPLAY BY NAME g_apcb_d[l_ac].apcb041,g_apcb_d[l_ac].l_apcb041_desc
                           NEXT FIELD CURRENT
                        END IF
                     END IF
                  END IF
               END IF
            ELSE
               LET g_apcb_d[l_ac].apcb041 = ''
            END IF
            LET g_apcb_d[l_ac].l_apcb041_desc = s_desc_show1(g_apcb_d[l_ac].apcb041,s_fin_get_accting_desc(l_glad.glad0211,g_apcb_d[l_ac].apcb041))
            LET g_apcb_d_t.l_apcb041_desc = g_apcb_d[l_ac].l_apcb041_desc
            DISPLAY BY NAME g_apcb_d[l_ac].apcb041,g_apcb_d[l_ac].l_apcb041_desc

         ON ACTION controlp INFIELD l_apcb041_desc
            IF NOT cl_null(l_glae009) THEN
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.default1 = g_apcb_d[l_ac].l_apcb041_desc
               IF l_glae009 = 'q_glaf002' THEN    
                  LET g_qryparam.where = "glaf001 = '",l_glad.glad0211,"'" #自由核算項類型
               END IF 
               CALL q_agli041(l_glae009) 
               LET g_apcb_d[l_ac].apcb041        = g_qryparam.return1
               LET g_apcb_d[l_ac].l_apcb041_desc = g_apcb_d[l_ac].apcb041
               DISPLAY BY NAME g_apcb_d[l_ac].apcb041 ,g_apcb_d[l_ac].l_apcb041_desc
               NEXT FIELD l_apcb041_desc
            END IF             

         #自由核算項六
         BEFORE FIELD l_apcb042_desc
            CALL s_fin_get_glae009(l_glad.glad0221) RETURNING l_glae009
            LET g_apcb_d[l_ac].l_apcb042_desc = g_apcb_d[l_ac].apcb042  #150205-00012#1
         
         AFTER FIELD l_apcb042_desc
            IF NOT cl_null(g_apcb_d[l_ac].l_apcb042_desc) THEN
               IF ( g_apcb_d[l_ac].l_apcb042_desc != g_apcb_d_t.l_apcb042_desc OR g_apcb_d_t.l_apcb042_desc IS NULL ) THEN
                  LET g_apcb_d[l_ac].apcb042 = g_apcb_d[l_ac].l_apcb042_desc
                  IF l_glaa121 = 'N' THEN     #141218-00011#6
                     IF (g_apcb_d[l_ac].apcb042 != g_apcb_d_t.apcb042 OR g_apcb_d_t.apcb042 IS NULL) THEN
                        CALL s_voucher_free_account_chk(l_glad.glad0221,g_apcb_d[l_ac].l_apcb042_desc,l_glad.glad0222) RETURNING g_errno
                        IF NOT cl_null(g_errno) THEN
                           LET g_apcb_d[l_ac].apcb042        = g_apcb_d_t.apcb042
                           LET g_apcb_d[l_ac].l_apcb042_desc = g_apcb_d_t.l_apcb042_desc
                           DISPLAY BY NAME g_apcb_d[l_ac].apcb042,g_apcb_d[l_ac].l_apcb042_desc
                           NEXT FIELD CURRENT
                        END IF
                     END IF
                  END IF
               END IF
            ELSE
               LET g_apcb_d[l_ac].apcb042 = ''
            END IF
            LET g_apcb_d[l_ac].l_apcb042_desc = s_desc_show1(g_apcb_d[l_ac].apcb042,s_fin_get_accting_desc(l_glad.glad0221,g_apcb_d[l_ac].apcb042))
            LET g_apcb_d_t.l_apcb042_desc = g_apcb_d[l_ac].l_apcb042_desc
            DISPLAY BY NAME g_apcb_d[l_ac].apcb042,g_apcb_d[l_ac].l_apcb042_desc

         ON ACTION controlp INFIELD l_apcb042_desc
            IF NOT cl_null(l_glae009) THEN
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.default1 = g_apcb_d[l_ac].l_apcb042_desc
               IF l_glae009 = 'q_glaf002' THEN    
                  LET g_qryparam.where = "glaf001 = '",l_glad.glad0221,"'" #自由核算項類型
               END IF 
               CALL q_agli041(l_glae009) 
               LET g_apcb_d[l_ac].apcb042        = g_qryparam.return1
               LET g_apcb_d[l_ac].l_apcb042_desc = g_apcb_d[l_ac].apcb042
               DISPLAY BY NAME g_apcb_d[l_ac].apcb042 ,g_apcb_d[l_ac].l_apcb042_desc
               NEXT FIELD l_apcb042_desc
            END IF
         
         #自由核算項七
         BEFORE FIELD l_apcb043_desc
            CALL s_fin_get_glae009(l_glad.glad0231) RETURNING l_glae009
            LET g_apcb_d[l_ac].l_apcb043_desc = g_apcb_d[l_ac].apcb043  #150205-00012#1
         
         AFTER FIELD l_apcb043_desc
            IF NOT cl_null(g_apcb_d[l_ac].l_apcb043_desc) THEN
               IF ( g_apcb_d[l_ac].l_apcb043_desc != g_apcb_d_t.l_apcb043_desc OR g_apcb_d_t.l_apcb043_desc IS NULL ) THEN
                  LET g_apcb_d[l_ac].apcb043 = g_apcb_d[l_ac].l_apcb043_desc
                  IF l_glaa121 = 'N' THEN     #141218-00011#6
                     IF (g_apcb_d[l_ac].apcb043 != g_apcb_d_t.apcb043 OR g_apcb_d_t.apcb043 IS NULL) THEN
                        CALL s_voucher_free_account_chk(l_glad.glad0231,g_apcb_d[l_ac].l_apcb043_desc,l_glad.glad0232) RETURNING g_errno
                        IF NOT cl_null(g_errno) THEN
                           LET g_apcb_d[l_ac].apcb043        = g_apcb_d_t.apcb043
                           LET g_apcb_d[l_ac].l_apcb043_desc = g_apcb_d_t.l_apcb043_desc
                           DISPLAY BY NAME g_apcb_d[l_ac].apcb043,g_apcb_d[l_ac].l_apcb043_desc
                           NEXT FIELD CURRENT
                        END IF
                     END IF
                  END IF
               END IF
            ELSE
               LET g_apcb_d[l_ac].apcb043 = ''
            END IF
            LET g_apcb_d[l_ac].l_apcb043_desc = s_desc_show1(g_apcb_d[l_ac].apcb043,s_fin_get_accting_desc(l_glad.glad0231,g_apcb_d[l_ac].apcb043))
            LET g_apcb_d_t.l_apcb043_desc = g_apcb_d[l_ac].l_apcb043_desc
            DISPLAY BY NAME g_apcb_d[l_ac].apcb043,g_apcb_d[l_ac].l_apcb043_desc

         ON ACTION controlp INFIELD l_apcb043_desc
            IF NOT cl_null(l_glae009) THEN
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.default1 = g_apcb_d[l_ac].l_apcb043_desc
               IF l_glae009 = 'q_glaf002' THEN    
                  LET g_qryparam.where = "glaf001 = '",l_glad.glad0231,"'" #自由核算項類型
               END IF 
               CALL q_agli041(l_glae009) 
               LET g_apcb_d[l_ac].apcb043        = g_qryparam.return1
               LET g_apcb_d[l_ac].l_apcb043_desc = g_apcb_d[l_ac].apcb043
               DISPLAY BY NAME g_apcb_d[l_ac].apcb043 ,g_apcb_d[l_ac].l_apcb043_desc
               NEXT FIELD l_apcb043_desc
            END IF    
         
         #自由核算項八
         BEFORE FIELD l_apcb044_desc
            CALL s_fin_get_glae009(l_glad.glad0241) RETURNING l_glae009
            LET g_apcb_d[l_ac].l_apcb044_desc = g_apcb_d[l_ac].apcb044  #150205-00012#1
         
         AFTER FIELD l_apcb044_desc
            IF NOT cl_null(g_apcb_d[l_ac].l_apcb044_desc) THEN
               IF ( g_apcb_d[l_ac].l_apcb044_desc != g_apcb_d_t.l_apcb044_desc OR g_apcb_d_t.l_apcb044_desc IS NULL ) THEN
                  LET g_apcb_d[l_ac].apcb044 = g_apcb_d[l_ac].l_apcb044_desc
                  IF l_glaa121 = 'N' THEN     #141218-00011#6
                     IF (g_apcb_d[l_ac].apcb044 != g_apcb_d_t.apcb044 OR g_apcb_d_t.apcb044 IS NULL) THEN
                        CALL s_voucher_free_account_chk(l_glad.glad0241,g_apcb_d[l_ac].l_apcb044_desc,l_glad.glad0242) RETURNING g_errno
                        IF NOT cl_null(g_errno) THEN
                           LET g_apcb_d[l_ac].apcb044        = g_apcb_d_t.apcb044
                           LET g_apcb_d[l_ac].l_apcb044_desc = g_apcb_d_t.l_apcb044_desc
                           DISPLAY BY NAME g_apcb_d[l_ac].apcb044,g_apcb_d[l_ac].l_apcb044_desc
                           NEXT FIELD CURRENT
                        END IF
                     END IF
                  END IF
               END IF
            ELSE
               LET g_apcb_d[l_ac].apcb044 = ''
            END IF
            LET g_apcb_d[l_ac].l_apcb044_desc = s_desc_show1(g_apcb_d[l_ac].apcb044,s_fin_get_accting_desc(l_glad.glad0241,g_apcb_d[l_ac].apcb044))
            LET g_apcb_d_t.l_apcb044_desc = g_apcb_d[l_ac].l_apcb044_desc
            DISPLAY BY NAME g_apcb_d[l_ac].apcb044,g_apcb_d[l_ac].l_apcb044_desc

         ON ACTION controlp INFIELD l_apcb044_desc
            IF NOT cl_null(l_glae009) THEN
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.default1 = g_apcb_d[l_ac].l_apcb044_desc
               IF l_glae009 = 'q_glaf002' THEN    
                  LET g_qryparam.where = "glaf001 = '",l_glad.glad0241,"'" #自由核算項類型
               END IF 
               CALL q_agli041(l_glae009) 
               LET g_apcb_d[l_ac].apcb044        = g_qryparam.return1
               LET g_apcb_d[l_ac].l_apcb044_desc = g_apcb_d[l_ac].apcb044
               DISPLAY BY NAME g_apcb_d[l_ac].apcb044 ,g_apcb_d[l_ac].l_apcb044_desc
               NEXT FIELD l_apcb044_desc
            END IF
            
         #自由核算項九
         BEFORE FIELD l_apcb045_desc
            CALL s_fin_get_glae009(l_glad.glad0251) RETURNING l_glae009
            LET g_apcb_d[l_ac].l_apcb045_desc = g_apcb_d[l_ac].apcb045  #150205-00012#1
         
         AFTER FIELD l_apcb045_desc
            IF NOT cl_null(g_apcb_d[l_ac].l_apcb045_desc) THEN
               IF ( g_apcb_d[l_ac].l_apcb045_desc != g_apcb_d_t.l_apcb045_desc OR g_apcb_d_t.l_apcb045_desc IS NULL ) THEN
                  LET g_apcb_d[l_ac].apcb045 = g_apcb_d[l_ac].l_apcb045_desc
                  IF l_glaa121 = 'N' THEN     #141218-00011#6
                     IF (g_apcb_d[l_ac].apcb045 != g_apcb_d_t.apcb045 OR g_apcb_d_t.apcb045 IS NULL) THEN
                        CALL s_voucher_free_account_chk(l_glad.glad0251,g_apcb_d[l_ac].l_apcb045_desc,l_glad.glad0252) RETURNING g_errno
                        IF NOT cl_null(g_errno) THEN
                           LET g_apcb_d[l_ac].apcb045        = g_apcb_d_t.apcb045
                           LET g_apcb_d[l_ac].l_apcb045_desc = g_apcb_d_t.l_apcb045_desc
                           DISPLAY BY NAME g_apcb_d[l_ac].apcb045,g_apcb_d[l_ac].l_apcb045_desc
                           NEXT FIELD CURRENT
                        END IF
                     END IF
                  END IF
               END IF
            ELSE
               LET g_apcb_d[l_ac].apcb045 = ''
            END IF
            LET g_apcb_d[l_ac].l_apcb045_desc = s_desc_show1(g_apcb_d[l_ac].apcb045,s_fin_get_accting_desc(l_glad.glad0251,g_apcb_d[l_ac].apcb045))
            LET g_apcb_d_t.l_apcb045_desc = g_apcb_d[l_ac].l_apcb045_desc
            DISPLAY BY NAME g_apcb_d[l_ac].apcb045,g_apcb_d[l_ac].l_apcb045_desc

         ON ACTION controlp INFIELD l_apcb045_desc
            IF NOT cl_null(l_glae009) THEN
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.default1 = g_apcb_d[l_ac].l_apcb045_desc
               IF l_glae009 = 'q_glaf002' THEN    
                  LET g_qryparam.where = "glaf001 = '",l_glad.glad0251,"'" #自由核算項類型
               END IF 
               CALL q_agli041(l_glae009) 
               LET g_apcb_d[l_ac].apcb045        = g_qryparam.return1
               LET g_apcb_d[l_ac].l_apcb045_desc = g_apcb_d[l_ac].apcb045
               DISPLAY BY NAME g_apcb_d[l_ac].apcb045 ,g_apcb_d[l_ac].l_apcb045_desc
               NEXT FIELD l_apcb045_desc
            END IF    
         
         #自由核算項十
         BEFORE FIELD l_apcb046_desc
            CALL s_fin_get_glae009(l_glad.glad0261) RETURNING l_glae009
            LET g_apcb_d[l_ac].l_apcb046_desc = g_apcb_d[l_ac].apcb046  #150205-00012#1
         
         AFTER FIELD l_apcb046_desc
            IF NOT cl_null(g_apcb_d[l_ac].l_apcb046_desc)  THEN
               IF ( g_apcb_d[l_ac].l_apcb046_desc != g_apcb_d_t.l_apcb046_desc OR g_apcb_d_t.l_apcb046_desc IS NULL ) THEN
                  LET g_apcb_d[l_ac].apcb046 = g_apcb_d[l_ac].l_apcb046_desc
                  IF l_glaa121 = 'N' THEN     #141218-00011#6
                     IF (g_apcb_d[l_ac].apcb046 != g_apcb_d_t.apcb046 OR g_apcb_d_t.apcb046 IS NULL) THEN
                        CALL s_voucher_free_account_chk(l_glad.glad0261,g_apcb_d[l_ac].l_apcb046_desc,l_glad.glad0262) RETURNING g_errno
                        IF NOT cl_null(g_errno) THEN
                           LET g_apcb_d[l_ac].apcb046        = g_apcb_d_t.apcb046
                           LET g_apcb_d[l_ac].l_apcb046_desc = g_apcb_d_t.l_apcb046_desc
                           DISPLAY BY NAME g_apcb_d[l_ac].apcb046,g_apcb_d[l_ac].l_apcb046_desc
                           NEXT FIELD CURRENT
                        END IF
                     END IF
                  END IF
               END IF
            ELSE
               LET g_apcb_d[l_ac].apcb046 = ''
            END IF
            LET g_apcb_d[l_ac].l_apcb046_desc = s_desc_show1(g_apcb_d[l_ac].apcb046,s_fin_get_accting_desc(l_glad.glad0261,g_apcb_d[l_ac].apcb046))
            LET g_apcb_d_t.l_apcb046_desc = g_apcb_d[l_ac].l_apcb046_desc
            DISPLAY BY NAME g_apcb_d[l_ac].apcb046,g_apcb_d[l_ac].l_apcb046_desc

         ON ACTION controlp INFIELD l_apcb046_desc
            IF NOT cl_null(l_glae009) THEN
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.default1 = g_apcb_d[l_ac].l_apcb046_desc
               IF l_glae009 = 'q_glaf002' THEN    
                  LET g_qryparam.where = "glaf001 = '",l_glad.glad0261,"'" #自由核算項類型
               END IF 
               CALL q_agli041(l_glae009) 
               LET g_apcb_d[l_ac].apcb046        = g_qryparam.return1
               LET g_apcb_d[l_ac].l_apcb046_desc = g_apcb_d[l_ac].apcb046
               DISPLAY BY NAME g_apcb_d[l_ac].apcb046 ,g_apcb_d[l_ac].l_apcb046_desc
               NEXT FIELD l_apcb046_desc
            END IF
       
       ON ACTION accept   #150206-00013#3  
          ACCEPT DIALOG   #150206-00013#3  
                  
       AFTER INPUT
           ##150210-00009#1--Mark
           ##141202-00061-15--(S)
           #CALL s_aooi200_get_slip(l_apcadocno) RETURNING g_sub_success,l_ap_slip               
           #CALL s_fin_get_doc_para(l_apcald,l_glaacomp,l_ap_slip,'D-FIN-0030') RETURNING l_dfin0030
           #IF l_glaa121 = 'Y' AND l_dfin0030 = 'Y'THEN
           #   CALL s_transaction_begin()
           #   CALL s_pre_voucher_ins('AP','P10',g_apcb_d[l_ac].apcbld , g_apcb_d[l_ac].apcbdocno,l_apcadocdt,'1')
           #        RETURNING g_sub_success
           #   IF g_sub_success THEN 
           #      CALL s_transaction_end('Y','0')
           #   ELSE
           #      CALL s_transaction_end('N','0')
           #   END IF
           #END IF
           ##141202-00061-15--(E)  
           #150210-00009#1--Mark
            LET g_apcb_d4.* = g_apcb_d.*      
            
   END INPUT
   
END DIALOG

################################################################################
# Descriptions...: 
# Usage..........: CALL aapt300_08_construct
# Date & Author..: 14/10/06 By Belle
# Modify.........:
################################################################################
DIALOG aapt300_08_construct()
DEFINE g_wc_t300_08  STRING
#161111-00042#3-----s
DEFINE l_ld   LIKE glaa_t.glaald
DEFINE l_comp LIKE ooef_t.ooef001
#161111-00042#3-----e

   CONSTRUCT g_wc_t300_08 ON apcb021,apcb029,apcb010,apcb011,
                             apcb024,apcb036,apcb012,apcb015,
                             apcb016,apcb034,apcb035
       
        FROM s_detail1_aapt300_08[1].l_apcb021_desc,s_detail1_aapt300_08[1].l_apcb029_desc,s_detail1_aapt300_08[1].l_apcb010_desc,s_detail1_aapt300_08[1].l_apcb011_desc,
             s_detail1_aapt300_08[1].l_apcb024_desc,s_detail1_aapt300_08[1].l_apcb036_desc,s_detail1_aapt300_08[1].l_apcb012_desc,s_detail1_aapt300_08[1].l_apcb015_desc,
             s_detail1_aapt300_08[1].l_apcb016_desc,s_detail1_aapt300_08[1].l_apcb034_desc,s_detail1_aapt300_08[1].l_apcb035_desc
             
      #費用會計科目     
      ON ACTION controlp INFIELD l_apcb021_desc
         INITIALIZE g_qryparam.* TO NULL
         LET g_qryparam.state = 'c'
         LET g_qryparam.reqry = FALSE
         LET g_qryparam.where = "glac003 <>'1' "  #glac003(科目類型)
         #161111-00042#3-----s
			LET l_comp = NULL
			SELECT ooef017 INTO l_comp FROM ooef_t WHERE ooefent = g_enterprise AND ooef001 = g_site
			LET l_ld = NULL
         SELECT glaald INTO l_ld FROM glaa_t WHERE glaaent = g_enterprise AND glaacomp = l_comp AND glaa014 = 'Y'
         LET g_qryparam.where = g_qryparam.where,
                                " AND glac002 IN (SELECT glad001 FROM glad_t,glac_t WHERE glad001= glac002 ",
                                " AND gladld='",l_ld,"' AND gladent=",g_enterprise,
                                " AND glacent = gladent ",
                                " AND gladstus = 'Y' )"
			#161111-00042#3-----e
         CALL aglt310_04()                               
         DISPLAY g_qryparam.return1 TO apcb021
         DISPLAY g_qryparam.return1 TO l_apcb021_desc
         NEXT FIELD l_apcb021_desc     
         
         #應付帳款科目               
         ON ACTION controlp INFIELD l_apcb029_desc
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " glac003 <>'1' "  #glac001(會計科目參照表)/glac003(科目類型)
			   #161111-00042#3-----s
			   LET l_comp = NULL
			   SELECT ooef017 INTO l_comp FROM ooef_t WHERE ooefent = g_enterprise AND ooef001 = g_site
			   LET l_ld = NULL
            SELECT glaald INTO l_ld FROM glaa_t WHERE glaaent = g_enterprise AND glaacomp = l_comp AND glaa014 = 'Y'
            LET g_qryparam.where = g_qryparam.where,
                                   " AND glac002 IN (SELECT glad001 FROM glad_t,glac_t WHERE glad001= glac002 ",
                                   " AND gladld='",l_ld,"' AND gladent=",g_enterprise,
                                   " AND glacent = gladent ",
                                   " AND gladstus = 'Y' )"
			   #161111-00042#3-----e
            CALL aglt310_04()                               
            DISPLAY g_qryparam.return1 TO apcb029
            DISPLAY g_qryparam.return1 TO l_apcb029_desc
            NEXT FIELD l_apcb029_desc     
         
         
        ##業務人員
        #ON ACTION controlp INFIELD l_apcb051_desc
        #   INITIALIZE g_qryparam.* TO NULL
        #   LET g_qryparam.state = 'c'
        #   LET g_qryparam.reqry = FALSE
        #   LET g_qryparam.default1 = g_apcb_d[l_ac].apcb051
        #   CALL q_ooag001_8()                               
        #   LET g_apcb_d[l_ac].apcb051 = g_qryparam.return1    
        #   LET g_apcb_d[l_ac].l_apcb051_desc= g_apcb_d[l_ac].apcb051
        #   DISPLAY BY NAME g_apcb_d[l_ac].apcb051,g_apcb_d[l_ac].l_apcb051_desc
        #   NEXT FIELD l_apcb051_desc   
            
         #業務部門
         ON ACTION controlp INFIELD l_apcb010_desc
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = g_today
            CALL q_ooeg001_4()                             
            DISPLAY g_qryparam.return1 TO apcb010
            DISPLAY g_qryparam.return1 TO l_apcb010_desc
            NEXT FIELD l_apcb010_desc   
            
         #責任中心
         ON ACTION controlp INFIELD l_apcb011_desc
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = g_today
            LET g_qryparam.where = " ooeg003 IN ('1','2','3')"
            CALL q_ooeg001_4()    
            DISPLAY g_qryparam.return1 TO apcb011
            DISPLAY g_qryparam.return1 TO l_apcb011_desc
            NEXT FIELD l_apcb011_desc
         
         #區域 
         ON ACTION controlp INFIELD l_apcb024_desc
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_oocq002_287()
            DISPLAY g_qryparam.return1 TO apcb024
            DISPLAY g_qryparam.return1 TO l_apcb024_desc
            NEXT FIELD l_apcb024_desc
            
         #產品類別 
         ON ACTION controlp INFIELD l_apcb012_desc
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_rtax001()                          
            DISPLAY g_qryparam.return1 TO apcb012
            DISPLAY g_qryparam.return1 TO l_apcb012_desc
            NEXT FIELD l_apcb012_desc   
      
      
         #WBS
         ON ACTION controlp INFIELD l_apcb016_desc
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = "pjbb012='1'"
            CALL q_pjbb002()
            DISPLAY g_qryparam.return1 TO apcb016
            DISPLAY g_qryparam.return1 TO l_apcb016_desc
            NEXT FIELD l_apcb016_desc
            
         #專案代號
         ON ACTION controlp INFIELD l_apcb015_desc
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_pjba001()
            DISPLAY g_qryparam.return1 TO apcb015
            DISPLAY g_qryparam.return1 TO l_apcb015_desc
            NEXT FIELD l_apcb015_desc
         
         #客群
         ON ACTION controlp INFIELD l_apcb036_desc
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_oocq002_281()
            DISPLAY g_qryparam.return1 TO apcb036
            DISPLAY g_qryparam.return1 TO l_apcb036_desc
            NEXT FIELD l_apcb036_desc
         
         #渠道
         ON ACTION controlp INFIELD l_apcb034_desc
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            CALL q_oojd001_2()
            DISPLAY g_qryparam.return1 TO apcb034
            DISPLAY g_qryparam.return1 TO l_apcb034_desc
            NEXT FIELD l_apcb034_desc
            
         #品牌
         ON ACTION controlp INFIELD l_apcb035_desc
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_oocq002_2002()
            DISPLAY g_qryparam.return1 TO apcb035
            DISPLAY g_qryparam.return1 TO l_apcb035_desc
            NEXT FIELD l_apcb035_desc
            
   END CONSTRUCT

END DIALOG

 
{</section>}
 
{<section id="aapt300_08.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 單身填充
# Usage..........: CALL aapt300_08_b_fill(p_ent,p_ld,p_docno)
# Date & Author..: 14/10/01 By Belle
# Modify.........:
################################################################################
PUBLIC FUNCTION aapt300_08_b_fill(p_ent,p_ld,p_docno)
DEFINE p_ent          LIKE apca_t.apcaent     
DEFINE p_ld           LIKE apca_t.apcald      #帳套
DEFINE p_docno        LIKE apca_t.apcadocno   #單據編號
DEFINE l_sql          STRING
DEFINE l_glad         RECORD
                      glad0171    LIKE  glad_t.glad0171, 
                      glad0172    LIKE  glad_t.glad0172,
                      glad0181    LIKE  glad_t.glad0181,
                      glad0182    LIKE  glad_t.glad0182,
                      glad0191    LIKE  glad_t.glad0191,
                      glad0192    LIKE  glad_t.glad0192,
                      glad0201    LIKE  glad_t.glad0201,
                      glad0202    LIKE  glad_t.glad0202,
                      glad0211    LIKE  glad_t.glad0211,
                      glad0212    LIKE  glad_t.glad0212,
                      glad0221    LIKE  glad_t.glad0221,
                      glad0222    LIKE  glad_t.glad0222,
                      glad0231    LIKE  glad_t.glad0231,
                      glad0232    LIKE  glad_t.glad0232,
                      glad0241    LIKE  glad_t.glad0241,
                      glad0242    LIKE  glad_t.glad0242,
                      glad0251    LIKE  glad_t.glad0251,
                      glad0252    LIKE  glad_t.glad0252,
                      glad0261    LIKE  glad_t.glad0261,
                      glad0262    LIKE  glad_t.glad0262
                  END RECORD
#160107-00003#8 add --start--
DEFINE l_glad_029 RECORD
                      glad0171    LIKE  glad_t.glad0171, 
                      glad0172    LIKE  glad_t.glad0172,
                      glad0181    LIKE  glad_t.glad0181,
                      glad0182    LIKE  glad_t.glad0182,
                      glad0191    LIKE  glad_t.glad0191,
                      glad0192    LIKE  glad_t.glad0192,
                      glad0201    LIKE  glad_t.glad0201,
                      glad0202    LIKE  glad_t.glad0202,
                      glad0211    LIKE  glad_t.glad0211,
                      glad0212    LIKE  glad_t.glad0212,
                      glad0221    LIKE  glad_t.glad0221,
                      glad0222    LIKE  glad_t.glad0222,
                      glad0231    LIKE  glad_t.glad0231,
                      glad0232    LIKE  glad_t.glad0232,
                      glad0241    LIKE  glad_t.glad0241,
                      glad0242    LIKE  glad_t.glad0242,
                      glad0251    LIKE  glad_t.glad0251,
                      glad0252    LIKE  glad_t.glad0252,
                      glad0261    LIKE  glad_t.glad0261,
                      glad0262    LIKE  glad_t.glad0262
                  END RECORD
#160107-00003#8 add --end--
#160129-00015#5 add(S)
#多語言SQL
DEFINE l_get_sql   RECORD
       apcb010     STRING,
       apcb011     STRING,
       apcb012     STRING,
       apcb015     STRING,
       apcb016     STRING,
       apcb017     STRING, #160902-00034#1
       apcb021     STRING,
       apcb024     STRING,
       apcb029     STRING,
       apcb033     STRING,
       apcb034     STRING,
       apcb035     STRING,
       apcb036     STRING,
       #160509-00004#110--add--str--lujh
       apcb054     STRING,
       apcb055     STRING,
       #160509-00004#110--add--end--lujh
       apcb051     STRING     
                   END RECORD
#160129-00015#5 add(E)
DEFINE l_apca059 LIKE apca_t.apca059 #預算編號       #160902-00034#1 
DEFINE l_bgaa008 LIKE bgaa_t.bgaa008 #預算細項參照表 #160902-00034#1
   
   CALL aapt300_08_clear_detail()

   LET l_ac = 1   
   #160129-00015#5 mark(S)
   #LET l_sql= " SELECT apcbdocno,apcbld,apcbseq,apcb047,  ",
   #           "        apcb021,'',apcb029,'',apcb051,'',apcb010,'',apcb011,'',apcb024,'',",
   #           "        apcb012,'',apcb015,'',apcb016,'',apcb033,   apcb034,'',",
   #           "        apcb035,'',apcb036,'',",
   #           "        apcb037,'',apcb038,'',apcb039,'',apcb040,'',apcb041,'',",
   #           "        apcb042,'',apcb043,'',apcb044,'',apcb045,'',apcb046,'' ",
   #           "   FROM apcb_t ",
   #           "  WHERE apcbent = ? AND apcbld = ? AND apcbdocno = ?",
   #           "  ORDER BY apcbseq"
   #160129-00015#5 mark(E)
   
   #160129-00015#5 add(S)
   INITIALIZE l_get_sql.* TO NULL   
   #業務人員
   CALL s_fin_get_person_sql('ta1','apcbent','apcb051') RETURNING l_get_sql.apcb051
   #業務部門
   CALL s_fin_get_department_sql('ta2','apcbent','apcb010') RETURNING l_get_sql.apcb010
   #責任中心
   CALL s_fin_get_department_sql('ta3','apcbent','apcb011') RETURNING l_get_sql.apcb011
   #區域
   CALL s_fin_get_acc_sql('ta4','apcbent','287','apcb024') RETURNING l_get_sql.apcb024
   #產品類型
   CALL s_fin_get_rtaxl003_sql('ta5','apcbent','apcb012') RETURNING l_get_sql.apcb012
   #專案代號
   CALL s_fin_get_project_sql('ta6','apcbent','apcb015') RETURNING l_get_sql.apcb015
   #WBS編號
   CALL s_fin_get_wbs_sql('ta7','apcbent','apcb015','apcb016') RETURNING l_get_sql.apcb016
   #渠道
   CALL s_fin_get_oojdl003_sql('ta8','apcbent','apcb034') RETURNING l_get_sql.apcb034
   #品牌
   CALL s_fin_get_acc_sql('ta9','apcbent','2002','apcb035') RETURNING l_get_sql.apcb035
   #客群
   CALL s_fin_get_acc_sql('ta10','apcbent','281','apcb036') RETURNING l_get_sql.apcb036
   #費用會計科目
   CALL s_fin_get_account_sql('ta11','ta12','apcbent','apcbld','apcb021') RETURNING l_get_sql.apcb021
   #應付帳款科目
   CALL s_fin_get_account_sql('ta13','ta14','apcbent','apcbld','apcb029') RETURNING l_get_sql.apcb029
   #160902-00034#1 ---s---
   #取得預算細項參照表 預算細項
   SELECT apca059 INTO l_apca059 FROM apca_t WHERE apcaent = g_enterprise AND apcadocno = p_docno AND apcald = p_ld
   SELECT bgaa008 INTO l_bgaa008 FROM bgaa_t WHERE bgaaent = g_enterprise AND bgaa001 = l_apca059
   LET l_get_sql.apcb017 = "(SELECT bgael003 FROM bgael_t WHERE bgaelent = '",g_enterprise,"' AND bgael006 = '",l_bgaa008,"' AND bgael001 = apcb017 AND bgael002 = '",g_dlang,"')" 
   #160902-00034#1 ---e---
   #160509-00004#110--add--str--lujh
   LET l_get_sql.apcb054 = "(SELECT pmaal004 FROM pmaal_t WHERE pmaalent = '",g_enterprise,"' AND pmaal001 = apcb054 AND pmaal002 = '",g_dlang,"')"
   LET l_get_sql.apcb055 = "(SELECT pmaal004 FROM pmaal_t WHERE pmaalent = '",g_enterprise,"' AND pmaal001 = apcb055 AND pmaal002 = '",g_dlang,"')"
   #160509-00004#110--add--end--lujh
   
   LET l_sql= " SELECT apcbdocno,apcbld,apcbseq,apcb047,  ",
              "        apcb021,",l_get_sql.apcb021,",apcb029,",l_get_sql.apcb029,",apcb051,",l_get_sql.apcb051,",apcb010,",l_get_sql.apcb010,",apcb011,",l_get_sql.apcb011,",apcb024,",l_get_sql.apcb024,",",
              "        apcb012,",l_get_sql.apcb012,",apcb015,",l_get_sql.apcb015,",apcb016,",l_get_sql.apcb016,",apcb017,",l_get_sql.apcb017,",apcb033,apcb034,",l_get_sql.apcb034,",", #160902-00034#1 add apcb017
              "        apcb035,",l_get_sql.apcb035,",apcb036,",l_get_sql.apcb036,",",
              #160509-00004#110--add--str--lujh
              "        apcb054,",l_get_sql.apcb054,",",
              "        apcb055,",l_get_sql.apcb055,",",
              #160509-00004#110--add--end--lujh
              "        apcb037,'',apcb038,'',apcb039,'',apcb040,'',apcb041,'',",
              "        apcb042,'',apcb043,'',apcb044,'',apcb045,'',apcb046,'' ",
              "   FROM apcb_t ",
              "  WHERE apcbent = ? AND apcbld = ? AND apcbdocno = ?",
              "  ORDER BY apcbseq"
   #160129-00015#5 add(E)
   PREPARE apcb_pre_1 FROM l_sql
   DECLARE apcb_cur_1 CURSOR FOR apcb_pre_1
   FOREACH apcb_cur_1 USING p_ent,p_ld,p_docno INTO g_apcb_d[l_ac].*     
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "foreach:"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         EXIT FOREACH
      END IF
     
      CALL s_fin_sel_glad(g_apcb_d[l_ac].apcbld,g_apcb_d[l_ac].apcb021,'glad0171|glad0172|glad0181|glad0182|glad0191|glad0192|glad0201|glad0202|glad0211|glad0212|glad0221|glad0222|glad0231|glad0232|glad0241|glad0242|glad0251|glad0252|glad0261|glad0262') 
           RETURNING g_errno,l_glad.*
      #160107-00003#8 add --start--
      CALL s_fin_sel_glad(g_apcb_d[l_ac].apcbld,g_apcb_d[l_ac].apcb029,'glad0171|glad0172|glad0181|glad0182|glad0191|glad0192|glad0201|glad0202|glad0211|glad0212|glad0221|glad0222|glad0231|glad0232|glad0241|glad0242|glad0251|glad0252|glad0261|glad0262') 
           RETURNING g_errno,l_glad_029.*
      IF cl_null(l_glad.glad0171) THEN LET l_glad.glad0171 = l_glad_029.glad0171 END IF
      IF cl_null(l_glad.glad0172) THEN LET l_glad.glad0172 = l_glad_029.glad0172 END IF
      IF cl_null(l_glad.glad0181) THEN LET l_glad.glad0181 = l_glad_029.glad0181 END IF
      IF cl_null(l_glad.glad0182) THEN LET l_glad.glad0182 = l_glad_029.glad0182 END IF
      IF cl_null(l_glad.glad0191) THEN LET l_glad.glad0191 = l_glad_029.glad0191 END IF
      IF cl_null(l_glad.glad0192) THEN LET l_glad.glad0192 = l_glad_029.glad0192 END IF
      IF cl_null(l_glad.glad0201) THEN LET l_glad.glad0201 = l_glad_029.glad0201 END IF
      IF cl_null(l_glad.glad0202) THEN LET l_glad.glad0202 = l_glad_029.glad0202 END IF
      IF cl_null(l_glad.glad0211) THEN LET l_glad.glad0211 = l_glad_029.glad0211 END IF
      IF cl_null(l_glad.glad0212) THEN LET l_glad.glad0212 = l_glad_029.glad0212 END IF
      IF cl_null(l_glad.glad0221) THEN LET l_glad.glad0221 = l_glad_029.glad0221 END IF
      IF cl_null(l_glad.glad0222) THEN LET l_glad.glad0222 = l_glad_029.glad0222 END IF
      IF cl_null(l_glad.glad0231) THEN LET l_glad.glad0231 = l_glad_029.glad0231 END IF
      IF cl_null(l_glad.glad0232) THEN LET l_glad.glad0232 = l_glad_029.glad0232 END IF
      IF cl_null(l_glad.glad0241) THEN LET l_glad.glad0241 = l_glad_029.glad0241 END IF
      IF cl_null(l_glad.glad0242) THEN LET l_glad.glad0242 = l_glad_029.glad0242 END IF
      IF cl_null(l_glad.glad0251) THEN LET l_glad.glad0251 = l_glad_029.glad0251 END IF
      IF cl_null(l_glad.glad0252) THEN LET l_glad.glad0252 = l_glad_029.glad0252 END IF
      IF cl_null(l_glad.glad0261) THEN LET l_glad.glad0261 = l_glad_029.glad0261 END IF
      IF cl_null(l_glad.glad0262) THEN LET l_glad.glad0262 = l_glad_029.glad0262 END IF
      #160107-00003#8 add --end--
      
      #160129-00015#5 mark(S)
      ##業務人員
      #LET g_apcb_d[l_ac].l_apcb051_desc = s_desc_show1(g_apcb_d[l_ac].apcb051,s_desc_get_person_desc(g_apcb_d[l_ac].apcb051))   #160129-00015#5
      ##業務部門
      #LET g_apcb_d[l_ac].l_apcb010_desc = s_desc_show1(g_apcb_d[l_ac].apcb010,s_desc_get_department_desc(g_apcb_d[l_ac].apcb010))
      ##責任中心
      #LET g_apcb_d[l_ac].l_apcb011_desc = s_desc_show1(g_apcb_d[l_ac].apcb011,s_desc_get_department_desc(g_apcb_d[l_ac].apcb011))
      ##產品類型
      #LET g_apcb_d[l_ac].l_apcb012_desc = s_desc_show1(g_apcb_d[l_ac].apcb012,s_desc_get_rtaxl003_desc(g_apcb_d[l_ac].apcb012))
      ##專案代號
      #LET g_apcb_d[l_ac].l_apcb015_desc = s_desc_show1(g_apcb_d[l_ac].apcb015,s_desc_get_project_desc(g_apcb_d[l_ac].apcb015))
      #
      #LET g_apcb_d[l_ac].l_apcb024_desc = s_desc_show1(g_apcb_d[l_ac].apcb024,s_desc_get_acc_desc('287',g_apcb_d[l_ac].apcb024))
      #LET g_apcb_d[l_ac].l_apcb034_desc = s_desc_show1(g_apcb_d[l_ac].apcb034, s_desc_get_oojdl003_desc(g_apcb_d[l_ac].apcb034))
      #LET g_apcb_d[l_ac].l_apcb035_desc = s_desc_show1(g_apcb_d[l_ac].apcb035,s_desc_get_acc_desc('2002',g_apcb_d[l_ac].apcb035))
      #LET g_apcb_d[l_ac].l_apcb036_desc = s_desc_show1(g_apcb_d[l_ac].apcb036,s_desc_get_acc_desc('281',g_apcb_d[l_ac].apcb036))
      ##費用會計科目
      #LET g_apcb_d[l_ac].l_apcb021_desc = s_desc_show1(g_apcb_d[l_ac].apcb021,s_desc_get_account_desc(g_apcb_d[l_ac].apcbld,g_apcb_d[l_ac].apcb021))
      ##應付帳款科目
      #LET g_apcb_d[l_ac].l_apcb029_desc = s_desc_show1(g_apcb_d[l_ac].apcb029,s_desc_get_account_desc(g_apcb_d[l_ac].apcbld,g_apcb_d[l_ac].apcb029))      
      #160129-00015#5 mark(E)
      
      #160129-00015#5 add(S)
      #業務人員
      LET g_apcb_d[l_ac].l_apcb051_desc = s_desc_show1(g_apcb_d[l_ac].apcb051,g_apcb_d[l_ac].l_apcb051_desc)
      #業務部門
      LET g_apcb_d[l_ac].l_apcb010_desc = s_desc_show1(g_apcb_d[l_ac].apcb010,g_apcb_d[l_ac].l_apcb010_desc)
      #責任中心
      LET g_apcb_d[l_ac].l_apcb011_desc = s_desc_show1(g_apcb_d[l_ac].apcb011,g_apcb_d[l_ac].l_apcb011_desc)
      #產品類型
      LET g_apcb_d[l_ac].l_apcb012_desc = s_desc_show1(g_apcb_d[l_ac].apcb012,g_apcb_d[l_ac].l_apcb012_desc)
      #專案代號
      LET g_apcb_d[l_ac].l_apcb015_desc = s_desc_show1(g_apcb_d[l_ac].apcb015,g_apcb_d[l_ac].l_apcb015_desc)
      LET g_apcb_d[l_ac].l_apcb016_desc = s_desc_show1(g_apcb_d[l_ac].apcb016,g_apcb_d[l_ac].l_apcb016_desc)
      LET g_apcb_d[l_ac].l_apcb024_desc = s_desc_show1(g_apcb_d[l_ac].apcb024,g_apcb_d[l_ac].l_apcb024_desc)
      LET g_apcb_d[l_ac].l_apcb034_desc = s_desc_show1(g_apcb_d[l_ac].apcb034,g_apcb_d[l_ac].l_apcb034_desc)
      LET g_apcb_d[l_ac].l_apcb035_desc = s_desc_show1(g_apcb_d[l_ac].apcb035,g_apcb_d[l_ac].l_apcb035_desc)
      LET g_apcb_d[l_ac].l_apcb036_desc = s_desc_show1(g_apcb_d[l_ac].apcb036,g_apcb_d[l_ac].l_apcb036_desc)
      #費用會計科目
      LET g_apcb_d[l_ac].l_apcb021_desc = s_desc_show1(g_apcb_d[l_ac].apcb021,g_apcb_d[l_ac].l_apcb021_desc)
      #應付帳款科目
      LET g_apcb_d[l_ac].l_apcb029_desc = s_desc_show1(g_apcb_d[l_ac].apcb029,g_apcb_d[l_ac].l_apcb029_desc)
      #160129-00015#5 add(E)
      #160902-00034#1---s---
      IF NOT cl_null(g_apcb_d[l_ac].apcb017) THEN
         LET g_apcb_d[l_ac].l_apcb017_desc = s_desc_show1(g_apcb_d[l_ac].apcb017,g_apcb_d[l_ac].l_apcb017_desc)
      END IF
       #160902-00034#1---e---
      #160509-00004#110--add--str--lujh
      IF NOT cl_null(g_apcb_d[l_ac].apcb054) THEN 
         LET g_apcb_d[l_ac].l_apcb054_desc = s_desc_show1(g_apcb_d[l_ac].apcb054,g_apcb_d[l_ac].l_apcb054_desc)
      END IF
      
      IF NOT cl_null(g_apcb_d[l_ac].apcb055) THEN 
         LET g_apcb_d[l_ac].l_apcb055_desc = s_desc_show1(g_apcb_d[l_ac].apcb055,g_apcb_d[l_ac].l_apcb055_desc)
      END IF
      #160509-00004#110--add--end--lujh
      
      IF NOT cl_null(g_apcb_d[l_ac].apcb037) THEN
         LET g_apcb_d[l_ac].l_apcb037_desc = s_desc_show1(g_apcb_d[l_ac].apcb037,s_fin_get_accting_desc(l_glad.glad0171,g_apcb_d[l_ac].apcb037))
      END IF
      IF NOT cl_null(g_apcb_d[l_ac].apcb038) THEN
         LET g_apcb_d[l_ac].l_apcb038_desc = s_desc_show1(g_apcb_d[l_ac].apcb038,s_fin_get_accting_desc(l_glad.glad0181,g_apcb_d[l_ac].apcb038))
      END IF
      IF NOT cl_null(g_apcb_d[l_ac].apcb039) THEN
         LET g_apcb_d[l_ac].l_apcb039_desc = s_desc_show1(g_apcb_d[l_ac].apcb039,s_fin_get_accting_desc(l_glad.glad0191,g_apcb_d[l_ac].apcb039))
      END IF
      IF NOT cl_null(g_apcb_d[l_ac].apcb040) THEN
         LET g_apcb_d[l_ac].l_apcb040_desc = s_desc_show1(g_apcb_d[l_ac].apcb040,s_fin_get_accting_desc(l_glad.glad0201,g_apcb_d[l_ac].apcb040))
      END IF
      IF NOT cl_null(g_apcb_d[l_ac].apcb041) THEN
         LET g_apcb_d[l_ac].l_apcb041_desc = s_desc_show1(g_apcb_d[l_ac].apcb041,s_fin_get_accting_desc(l_glad.glad0211,g_apcb_d[l_ac].apcb041))
      END IF
      IF NOT cl_null(g_apcb_d[l_ac].apcb042) THEN   
         LET g_apcb_d[l_ac].l_apcb042_desc = s_desc_show1(g_apcb_d[l_ac].apcb042,s_fin_get_accting_desc(l_glad.glad0221,g_apcb_d[l_ac].apcb042))
      END IF
      IF NOT cl_null(g_apcb_d[l_ac].apcb043) THEN
         LET g_apcb_d[l_ac].l_apcb043_desc = s_desc_show1(g_apcb_d[l_ac].apcb043,s_fin_get_accting_desc(l_glad.glad0231,g_apcb_d[l_ac].apcb043))
      END IF
      IF NOT cl_null(g_apcb_d[l_ac].apcb044) THEN   
         LET g_apcb_d[l_ac].l_apcb044_desc = s_desc_show1(g_apcb_d[l_ac].apcb044,s_fin_get_accting_desc(l_glad.glad0241,g_apcb_d[l_ac].apcb044))
      END IF
      IF NOT cl_null(g_apcb_d[l_ac].apcb045) THEN   
         LET g_apcb_d[l_ac].l_apcb045_desc = s_desc_show1(g_apcb_d[l_ac].apcb045,s_fin_get_accting_desc(l_glad.glad0251,g_apcb_d[l_ac].apcb045))
      END IF
      IF NOT cl_null(g_apcb_d[l_ac].apcb046) THEN   
         LET g_apcb_d[l_ac].l_apcb046_desc = s_desc_show1(g_apcb_d[l_ac].apcb046,s_fin_get_accting_desc(l_glad.glad0261,g_apcb_d[l_ac].apcb046))
      END IF
     
      LET l_ac = l_ac + 1
      
   END FOREACH
   CALL g_apcb_d.deleteElement(l_ac)
   
   LET g_rec_b04 = l_ac - 1
   LET g_apcb_d4.* = g_apcb_d.*
   FREE apcb_pre_1

END FUNCTION

PUBLIC FUNCTION aapt300_08_clear_detail()
   CALL g_apcb_d.clear()
END FUNCTION

 
{</section>}
 
