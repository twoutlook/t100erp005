#+ 程式版本......: T6 Version 1.00.00 Build-0317 at 2013/08/16
#
#+ 程式代碼......: adzp165
#+ 設計人員......: cch
#+ 功能描述......: 解析分鏡檔內SA的規格,SA分鏡規格匯入介面檔(dzem_t)
#                  2015/02/02 by madey mark掉 CONNECT TO,吃cl_tool_init的預設連線即可
#                  2015/06/02 by madey 修正sco檔帶括號時無法解析的bug
#                  2015/06/11 by madey 修正彈窗挑選檔案時，視窗壓在最下面
#                  20160513 160506-00024 by madey :1.增加一塊說明工具的注意事項
#                                                  2.匯入時有SA資料的就跳過, 沒有的才新增.
#                                                  3.匯入時增加SA規格預設給SD規格的功能, 要有權限才可以.
#                                                  4.增加刪除SA規格資料的功
#                                                  5.停用參數二，訊息一律顯示

IMPORT JAVA ConvertRTFintoString  #用於讀出rtf格式的純文字,JAVA檔案放於/u1/t10dit/utl/java/bin和/u1/t10dit/utl/java/src
IMPORT JAVA java.lang.Character   #用於將utf的10進位內碼轉為中文之用
IMPORT JAVA java.lang.Integer     #用於將utf的10進位內碼轉為中文之用
IMPORT JAVA java.lang.String      #java的字串

IMPORT os

SCHEMA ds

GLOBALS "../../cfg/top_global.inc"

#Begin: 160506-00024
&include "../4gl/sadzp200_type.inc" 
#End: 160506-00024

PRIVATE TYPE type_g_dzem_d        RECORD #dzem_t SA分鏡規格匯入介面檔
   dzem001   LIKE dzem_t.dzem001, 
   dzem002   LIKE dzem_t.dzem002, 
   dzem003   LIKE dzem_t.dzem003, 
   dzem099   LIKE dzem_t.dzem099, 
   dzemownid LIKE dzem_t.dzemownid,
   dzemowndp LIKE dzem_t.dzemowndp,
   dzemcrtid LIKE dzem_t.dzemcrtid,
   dzemcrtdp LIKE dzem_t.dzemcrtdp,
   dzemcrtdt LIKE dzem_t.dzemcrtdt,
   dzemmodid LIKE dzem_t.dzemmodid,
   dzemmoddt LIKE dzem_t.dzemmoddt
       END RECORD 

DEFINE g_file_path_str   STRING,                          #分鏡檔檔案路徑
       g_xml_str         STRING,                          #分鏡的xml格式字串
       g_dom_doc         om.DomDocument,                  #Dom文件   
       g_dom_root        om.DomNode,                      #Dom的根節點
      #g_sco_id          LIKE gzza_t.gzza001,             #分鏡檔代號(不含.sco)
       g_sco_id          STRING,                          #20150602
       g_dzem001         LIKE dzem_t.dzem001,             #暫存用的
       g_dzem002         LIKE dzem_t.dzem002,             #暫存用的
       g_dzem_d          DYNAMIC ARRAY OF type_g_dzem_d   #SA分鏡規格匯入介面檔
      #g_show_hint       LIKE type_t.chr20                #判斷是否顯示結束後的提示 #160506-00024 mark

#定義分鏡檔中使用的tag名稱和固定不變的字串
CONSTANT G_SCENE_TAG        = "Scene",  #分鏡的tag             
         G_ROLE_TAG         = "Role",   #元件的tag
         G_ITEM_TAG         = "item",   #規格所在tag
         G_MAIN_WIN_STR     = "MAIN",   #程式目的
         G_DATA_PROSESS_STR = "PROCESS" #資料處理       

DEFINE ms_enable_softscore    STRING  #設計器是否准許分鏡系統串接
DEFINE mb_enable_softscore    BOOLEAN #是否啟動匯入 SCO 檔
DEFINE g_gzza001    STRING                   #程式代號
DEFINE g_parameter  STRING                   #執行模式: 1.清除規格異常資料 / 2.清除程式異常資料 / 3.刪除程式(重新r.a) / 4.客製退回標準 / 5.還原客製合併 / 6.退回前一版
DEFINE g_dgenv      LIKE dzaf_t.dzaf010      #環境變數DGENV (s:標準/ c:客
DEFINE g_god_mode   BOOLEAN 
DEFINE gb_sd        BOOLEAN                  #160506-00024 是否自動將資料代給SD規格
DEFINE g_gzzal003   STRING                  #程式名稱


MAIN
   DEFINE lw_window   ui.Window,
          lf_form     ui.Form,
          ls_cfg_path STRING,
          ls_4st_path STRING,
          ls_img_path STRING
   DEFINE ls_msg     STRING
  

   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log

   #CLOSE WINDOW SCREEN 
   
   #依模組進行系統初始化設定(系統設定)
   CALL cl_tool_init()
   
  ##切換至使用者所需要的資料庫 (營運中心)  #to do
  #DISCONNECT CURRENT #to do
  #CONNECT TO "ds" #to do              #20150202
  #DISPLAY 'connect:ds->',STATUS

   #Begin: 160506-00024
   #開啟畫面
   OPEN WINDOW w_adzp165 WITH FORM cl_ap_formpath("adz",g_code)
   CLOSE WINDOW screen

   CALL cl_ui_wintitle(1) #工具抬頭名稱
   
   CALL cl_load_4ad_interface(NULL)
   
   LET lw_window = ui.Window.getCurrent()
   LET ls_img_path = os.Path.join(os.Path.join(FGL_GETENV("RES"), "img"), "ui")
   CALL lw_window.setImage(os.Path.join(os.Path.join(ls_img_path, "logo"), "dsc_logo.ico"))

   LET ls_cfg_path = os.Path.join(FGL_GETENV("ERP"), "cfg")
   LET ls_4st_path = os.Path.join(os.Path.join(os.Path.join(ls_cfg_path, "4st"), g_lang), "designer.4st")
   CALL ui.Interface.loadStyles(ls_4st_path)

   CALL adzp165_init()

   CALL adzp165_ui_dialog() 
   #End: 160506-00024

   
 #Begin: 160506-00024 mark  搬到新function:adzp165_imp_sa_spec()
 ##DISPLAY "[Purpose]:Import SA specifications from sco file into dzem_t"
 ##
 ######## 1. 讀取分鏡檔並逐行處理分鏡檔內容、產生合法的XML格式的字串g_xml_str - 呼叫函式 ######
 ##CALL adzp165_read_sco_file(g_file_path_str)
 ##DISPLAY "Info: Read sco file and generate xml format......OK"
 ##
 ##TRY
 ##   #從分鏡的xml格式字串來建立Dom文件
 ##   LET g_dom_doc = om.DomDocument.createFromString(g_xml_str)
 ##   #由Dom文件取得根節點
 ##   LET g_dom_root = g_dom_doc.getDocumentElement()
 ##CATCH
 ##   IF STATUS THEN
 ##      #解析XML格式發生錯誤
 ##      DISPLAY "Info: Parse dom node of XML format......ERROR"
 ##      EXIT PROGRAM
 ##   END IF
 ##END TRY
 ##
 ###CALL g_dom_root.writeXml(g_file_path_str||"x") #測試用
 ##
 ######## 2. 擷取分鏡檔中的SA規格資訊並轉換RTF的格式為純文字
 ##CALL adzp165_parse_scene_nod_list(g_dom_root)
 ##DISPLAY "Info: Get SA specifications of sco file and convert RTF into text......OK"
 ##
 ######## 3. 增加資料到SA分鏡規格匯入介面檔(dzem_t),並於其中調整要放入資料庫的資料
 ##CALL adzp165_insert_data_to_dzem_t()
 ##DISPLAY "Info: Adjust data and then insert data into dzem_t......OK"
 ##
 ##DISPLAY "Info: Parse sco file and insert data into dzem_t......SUCCESS"
 ##
 ##DISPLAY "g_show_hint = ",g_show_hint
 ##
 ##IF g_show_hint = "hidden_hint" THEN
 ##
 ##ELSE
 ##   CALL cl_ask_pressanykey("adz-00221")
 ##END IF
 #End: 160506-00024 mark  搬到新function:adzp165_imp_sa_spec()

   #Begin: 160506-00024
   #畫面關閉
   CLOSE WINDOW w_adzp165
   #End: 160506-00024

END MAIN

#+初始化變數值
PRIVATE FUNCTION adzp165_init()


   LET g_dgenv = FGL_GETENV("DGENV") CLIPPED   #環境變數DGENV (s:標準/ c:客製)
   IF cl_null(g_dgenv) THEN LET g_dgenv = "s" END IF
   
  #LET g_show_hint = ARG_VAL(2) #160506-00024 mark

   #設計器是否准許分鏡系統串接
   CALL cl_get_para("","","A-SYS-0041") RETURNING ms_enable_softscore
   LET mb_enable_softscore    = IIF(NVL(ms_enable_softscore,"N")=="Y",TRUE,FALSE)  

   #Begin: 160506-00024 add
   IF NOT mb_enable_softscore THEN
      CALL cl_ask_pressanykey("adz-00624") #目前設計器不准許與分鏡系統串接!
      EXIT PROGRAM
   END IF
   #End: 160506-00024 add

 #Begin: 160506-00024 mark  搬到新function:adzp165_imp_sa_spec()
 ###開啟client端檔案選取視窗
 ##LET l_client_file_path_str = adzp165_client_browse_file()
 ##
 ##DISPLAY "Info: The path of sco file for client = ",l_client_file_path_str
 ##
 ###選擇的分鏡檔不符合預設的分鏡檔名稱,停止繼續執行下去
 ###IF NOT l_client_file_path_str MATCHES "*"||g_sco_id||".sco" THEN
 ##   #CALL cl_err_msg(l_client_file_path_str,"adz-00223",g_sco_id,1)
 ##   #DISPLAY "Selected a wrong file !"
 ##   #EXIT PROGRAM
 ###END IF
 ##
 ##LET l_file_name = os.Path.basename(l_client_file_path_str)
 ##LET l_file_name = l_file_name.trim()
 ##LET l_file_name = l_file_name.subString(1,l_file_name.getLength()-4)
 ##LET g_sco_id = l_file_name
 ##
 ##IF cl_null(g_sco_id) THEN
 ##   DISPLAY "Info: g_sco_id is NULL ......ERROR"
 ##   DISPLAY "[Purpose]:Import SA specifications from sco file into dzem_t"
 ##   EXIT PROGRAM
 ##END IF
 ##
 ##LET g_sco_id = adzp165_token_str(g_sco_id,1,"(") #20150602
 ##
 ###結合模組和檔名產生絕對檔案路徑
 ##LET g_file_path_str = os.path.JOIN(FGL_GETENV("TEMPDIR"),g_sco_id||".sco")
 ##
 ##DISPLAY "Info: The path of sco file = ",g_file_path_str   
 ##
 ###檢查分鏡檔是否存在,存在的話更名
 ##IF os.path.EXISTS(g_file_path_str) THEN
 ##   IF os.path.RENAME(g_file_path_str,g_file_path_str||".bak") THEN
 ##      DISPLAY "Info: Rename existent sco file! -->",g_file_path_str||".bak"
 ##   END IF
 ##END IF
 ##
 ###從前端傳檔案到SERVER端
 ##CALL fgl_getfile(l_client_file_path_str, g_file_path_str)
 ##
 ##
 ###檢查分鏡檔是否存在 - 防呆
 ##IF NOT os.path.EXISTS(g_file_path_str) THEN
 ##   DISPLAY "Info: Found no sco file......ERROR"
 ##   EXIT PROGRAM
 ##END IF
 #End: 160506-00024 mark 
   


END FUNCTION


#160506-00024 重寫新的
#+增加資料到SA分鏡規格匯入介面檔(dzem_t)
PRIVATE FUNCTION adzp165_insert_data_to_dzem_t()
   DEFINE  ln_cnt      LIKE type_t.num5,     #筆數
           ln_cnt2      LIKE type_t.num5, 
           l_user      LIKE dzem_t.dzemownid,
           l_dept      LIKE dzem_t.dzemowndp,
           l_date      LIKE dzem_t.dzemcrtdt,
           ls_err      STRING,
           ls_sql      STRING,
           l_prog_id   LIKE dzem_t.dzem001,
           lb_flag     BOOLEAN,
           l_dzem099   TEXT,
           l_dzem099_1 TEXT,
           ls_text     STRING
   DEFINE  ls_err_msg  STRING
          
   LET l_user = g_user
   LET l_dept = g_dept
   LET l_date = cl_get_current()

   LET l_prog_id = g_sco_id
   LET ln_cnt = 0

   TRY

     FOR ln_cnt = 1 TO g_dzem_d.getLength()

        IF UPSHIFT(g_dzem_d[ln_cnt].dzem001) MATCHES "TOPMENU*" THEN
           #去掉元件名稱有括弧的部分
           LET g_dzem_d[ln_cnt].dzem002 = adzp165_token_str(g_dzem_d[ln_cnt].dzem002,1,"(")
           #測試用
           #DISPLAY "g_dzem_d[ln_cnt].dzem001 = ",g_dzem_d[ln_cnt].dzem001
           #DISPLAY "g_dzem_d[ln_cnt].dzem002 = ",g_dzem_d[ln_cnt].dzem002
        END IF

        #設定識別碼類型
        IF g_dzem_d[ln_cnt].dzem002 = G_MAIN_WIN_STR THEN
           #整體規格的識別碼為ALL
           LET  g_dzem_d[ln_cnt].dzem002 = "ALL"
           #整體規格的識別碼類型為3
           LET  g_dzem_d[ln_cnt].dzem003 = "3"
        ELSE
           IF UPSHIFT(g_dzem_d[ln_cnt].dzem001) MATCHES "TOPMENU*" THEN
              #ACTION規格的識別碼類型為2
              LET  g_dzem_d[ln_cnt].dzem003 = "2"
           ELSE
              #除了整體規格和ACTION規格外,其他無論是否為欄位規格,識別碼類型皆為1
              LET  g_dzem_d[ln_cnt].dzem003 = "1"
           END IF  
        END IF
        
         
        #組合分鏡中[主視窗]和[資料處理]項目的SA規格資料  
        IF g_dzem_d[ln_cnt].dzem002 = "ALL" THEN
           LOCATE l_dzem099 IN FILE
           LOCATE l_dzem099_1 IN FILE
           
           
           LET l_dzem099 = g_dzem_d[ln_cnt].dzem099
           LET l_dzem099_1 = adzp165_get_the_spec_of_data_process(l_dzem099_1,g_dzem_d[ln_cnt].dzem001)

           LET ls_text = l_dzem099,
                         ASCII 10,"============================================================================================",ASCII 10,
                         l_dzem099_1#得到資料處理項目的規格資料
           
           #將主視窗的規格資料和到資料處理項目的規格資料組合
           LET g_dzem_d[ln_cnt].dzem099 = ls_text
                                               
        END IF

        #略過G_DATA_PROSESS_STR的資料不加入資料庫
        IF g_dzem_d[ln_cnt].dzem002 = G_DATA_PROSESS_STR THEN
           CONTINUE FOR
        END IF

        #去掉分鏡名稱有括弧的部分
        IF g_dzem_d[ln_cnt].dzem001 MATCHES l_prog_id||"*" THEN
           LET g_dzem001 = adzp165_token_str(g_dzem_d[ln_cnt].dzem001,1,"(")
        END IF

        LET g_dzem_d[ln_cnt].dzem001 = g_dzem001

        #測試用
        #DISPLAY g_dzem_d[ln_cnt].dzem001,"|",g_dzem_d[ln_cnt].dzem002,"|",g_dzem_d[ln_cnt].dzem003

        LET ln_cnt2=0
        #插入資料前先檢查key值有無重複
        SELECT COUNT(*) INTO ln_cnt2 FROM dzem_t 
           WHERE dzem001=g_dzem_d[ln_cnt].dzem001 AND dzem002=g_dzem_d[ln_cnt].dzem002

        #key值沒有重複再進行插入資料到dzem_t
        IF ln_cnt2=0 THEN
        
           LET ls_sql = 
              "INSERT INTO dzem_t(dzem001,dzem002,dzem003,dzem099,dzemownid,dzemowndp,dzemcrtid,dzemcrtdp,dzemcrtdt
              ) VALUES (?,?,?,?,?,?,?,?,?)"
           PREPARE insert_data_to_dzem_t FROM ls_sql 
           EXECUTE insert_data_to_dzem_t USING g_dzem_d[ln_cnt].dzem001,g_dzem_d[ln_cnt].dzem002,
                                               g_dzem_d[ln_cnt].dzem003,g_dzem_d[ln_cnt].dzem099,
                                               l_user,l_dept,l_user,l_dept,l_date 

        ELSE 
           DISPLAY "Info:Data exists,skip update!"," dzem001=",g_dzem_d[ln_cnt].dzem001," dzem002=",g_dzem_d[ln_cnt].dzem002
        END IF
        
        FREE l_dzem099
        FREE l_dzem099_1
                    
     END FOR
     RETURN TRUE,NULL


   CATCH
      LET ls_err_msg = "ERROR:",cl_getmsg(sqlca.sqlcode,g_lang),
                       ",insert dzem_t fail!", " dzem001=",g_dzem_d[ln_cnt].dzem001," dzem002=",g_dzem_d[ln_cnt].dzem002
      RETURN FALSE,ls_err_msg
      
   END TRY

END FUNCTION


#+ 為了之後的處理鎖住資料庫(dzem_t)的資料
PRIVATE FUNCTION adzp165_lock_dzem_t(p_prog_id)
   DEFINE l_forupd_sql STRING,
          p_prog_id    LIKE dzem_t.dzem001,
          l_dzem001    LIKE dzem_t.dzem001
   
   LET l_forupd_sql = "SELECT dzem001",
                      " FROM dzem_t WHERE dzem001 LIKE '",p_prog_id,"%' ",
                      " FOR UPDATE"
   LET l_forupd_sql = cl_forupd_sql(l_forupd_sql)
   DECLARE adzp165_dzem_lock_cur CURSOR FROM l_forupd_sql   #cursor lock for dzem_t

   ### 2.鎖住dzep_t的相關資料 ###
   OPEN adzp165_dzem_lock_cur

   #用於Oracle的lock偵測 
   IF STATUS THEN
      DISPLAY "l_forupd_sql = ",l_forupd_sql
      RETURN FALSE
   END IF

   FETCH adzp165_dzem_lock_cur INTO l_dzem001

   #用於Informix的lock偵測 
   IF SQLCA.sqlcode THEN
      DISPLAY "l_forupd_sql = ",l_forupd_sql
      RETURN FALSE
   END IF

   RETURN TRUE

END FUNCTION


#+ 做token，回傳指定順序的字串
PRIVATE FUNCTION adzp165_token_str(p_str,p_cnt,p_delim)
   DEFINE p_str      STRING,                 #要做token的字串
          p_cnt      LIKE type_t.num5,       #要回傳字串的順序
          p_delim    LIKE type_t.chr20,      #分隔符號
          l_tok      base.StringTokenizer,   #token的物件
          ls_tmp     STRING,                 #存放nextToken()的物件
          l_cnt      LIKE type_t.num5,       #筆數
          l_return   STRING                  #回傳值


   LET l_tok = base.StringTokenizer.create(p_str,p_delim)

   LET l_cnt = 1

   WHILE l_tok.hasMoreTokens()

      LET ls_tmp = l_tok.nextToken()

      #筆數和指定要回傳的順序相同,則回傳該字串
      IF l_cnt = p_cnt THEN
         LET l_return = ls_tmp
         EXIT WHILE
      END IF

      LET l_cnt = l_cnt + 1

   END WHILE

   RETURN l_return

END FUNCTION


#+找出<Scene>結構的NodeList
PRIVATE FUNCTION  adzp165_parse_scene_nod_list(p_dom)
   DEFINE l_node_list om.NodeList,
          p_dom       om.DomNode,
          l_dom       om.DomNode,
          ln_cnt      LIKE type_t.num5,
          ls_str      STRING,
          ls_flag     BOOLEAN    #看是否進行否解析

   LET l_node_list = p_dom.selectByTagName(G_SCENE_TAG) #<Scene>

   LET ls_flag = FALSE
   
   FOR ln_cnt = 1 TO l_node_list.getLength()

      LET l_dom  = l_node_list.item(ln_cnt)

      LET ls_str = l_dom.getAttribute("name")

      LET g_dzem001 = ls_str.trim()

      #忽略第一個合法的規格代號"g_sco_id*"前的分鏡,不進行解析
      IF g_dzem001 MATCHES g_sco_id||"*" THEN
         LET ls_flag = TRUE
      END IF

      #如果ls_flag=TRUE,在進行分鏡解析
      IF ls_flag THEN
         CALL adzp165_parse_role_nod_list(l_dom)
      END IF 
      
   END FOR

END FUNCTION

#+找出<Role>結構的NodeList
PRIVATE FUNCTION  adzp165_parse_role_nod_list(p_dom)
   DEFINE l_node_list om.NodeList,
          p_dom       om.DomNode,
          l_dom       om.DomNode,
          ln_cnt      LIKE type_t.num5,
          ls_str      STRING

   LET l_node_list = p_dom.selectByTagName(G_ROLE_TAG) #<Role>

   FOR ln_cnt = 1 TO l_node_list.getLength()
      LET l_dom  = l_node_list.item(ln_cnt)
      LET ls_str = l_dom.getAttribute("name")
      LET g_dzem002 = ls_str.trim()
      CALL adzp165_get_item_spec_date(l_dom)
   END FOR

END FUNCTION


#+遞迴找出<item>節點中的SA規格資料
PRIVATE FUNCTION  adzp165_get_item_spec_date(p_dom)
   DEFINE p_dom    om.DomNode,
          p_parent om.DomNode,
          list_atrr LIKE type_t.chr10,
          ls_str   STRING

   LET p_parent = p_dom.getParent()

   LET list_atrr = p_parent.getAttributeString("type","")

   #list_atrr = "5" 是邏輯處理的工作區 "6"是邏輯處理的凍結區
   IF p_dom.getTagName() = G_ITEM_TAG AND list_atrr = "5" THEN #<item>

      CALL g_dzem_d.appendElement()


      LOCATE g_dzem_d[g_dzem_d.getLength()].dzem099 IN FILE 

      LET g_dzem_d[g_dzem_d.getLength()].dzem001 = g_dzem001
      LET g_dzem_d[g_dzem_d.getLength()].dzem002 = g_dzem002

      #讀出rtf格式的純文字字串
      LET g_dzem_d[g_dzem_d.getLength()].dzem099 = adzp165_get_data_from_item_tag(p_dom,g_dzem_d[g_dzem_d.getLength()].dzem099)
      
   END IF

   LET p_dom = p_dom.getFirstChild()

   WHILE p_dom IS NOT NULL
     CALL adzp165_get_item_spec_date(p_dom)
     LET p_dom = p_dom.getNext()
   END WHILE

END FUNCTION


#+擷取<item>中的規格並處理
PRIVATE FUNCTION adzp165_get_data_from_item_tag(p_node,p_text)
   DEFINE p_node        om.DomNode,           #要操作的節點
          l_node        om.DomNode,           #要操作的節點
          l_text        STRING,               #規格內文
          l_str         STRING,
          input_str     java.lang.String,
          l_rtf_str     java.lang.String,
          l_str_buf     base.StringBuffer,    #StringBuffer
          l_convert     ConvertRTFintoString,
          p_text        TEXT


   LET l_node = p_node.getFirstChild()
   LET l_str_buf = base.StringBuffer.create()
   CALL l_str_buf.append(l_node.getAttributeValue(1))
   
   LET l_convert = ConvertRTFintoString.create()

   LET l_str = l_str_buf.toString()


   #將要轉換的RTF格式字串給自訂的JAVA物件讀出純文字字串
   LET l_rtf_str = l_convert.convertRTFtoString(l_str)

   LET l_text = l_rtf_str

   #去除掉掉左右空格
   LET p_text = l_text.trim()

   #回傳處理後的純文字字串
   RETURN p_text
END FUNCTION


#+得到[資料處理]項目的規格資料
PRIVATE FUNCTION adzp165_get_the_spec_of_data_process(ps_data_process,p_dzem001)
   DEFINE ln_cnt          LIKE type_t.num5,
          p_dzem001       LIKE dzem_t.dzem001,
          ps_data_process TEXT

   FOR  ln_cnt = 1 TO g_dzem_d.getLength()
      #找到[資料處理]項目的規格資料後就離開
      IF g_dzem_d[ln_cnt].dzem002 = G_DATA_PROSESS_STR AND g_dzem_d[ln_cnt].dzem001=p_dzem001 THEN
         LET ps_data_process = g_dzem_d[ln_cnt].dzem099
         EXIT FOR
      END IF
   END FOR
   
   RETURN ps_data_process
END FUNCTION


#+讀取分鏡檔並逐行處理分鏡檔內容
PRIVATE FUNCTION adzp165_read_sco_file(p_file)
   DEFINE p_file      STRING,            #分鏡檔的檔案路徑
          l_lineStr   STRING,            #分鏡檔的每行字串
          l_ch_in     base.Channel,      #Genero讀取的檔案物件變數
          l_replace   STRING,            #要置換的資料
          l_flag      BOOLEAN,           #判斷需要資料處理的時機
          l_str_buf   base.StringBuffer  #用來組合完整的xml結構字串給g_xml_str
   DEFINE ls_err_msg  STRING             #160506-00024

   #建立Genero讀取的檔案物件
   LET l_ch_in = base.Channel.create()


   TRY 
      #指定來源的的檔案路徑
      CALL l_ch_in.openFile(p_file,"r")
   CATCH
      IF STATUS THEN
         #對此分鏡檔的權限不足
         LET ls_err_msg =  "ERROR: No Read permission for sco file" #160506-00024
         RETURN FALSE,ls_err_msg  #160506-00024
      END IF 
   END TRY

   LET l_flag = FALSE

   LET l_str_buf = base.StringBuffer.create()

   WHILE TRUE
      #分鏡檔每行讀出
      LET l_lineStr = l_ch_in.readLine()

      IF l_ch_in.isEof() THEN EXIT WHILE END IF
      
      #因為只要處理前幾行的資料,所以處理完就不再判斷,增加效率
      IF l_flag = FALSE THEN
         #為轉成xml的標準格式需要做的處理
         IF l_lineStr.getIndexOf("SoftScore",1)! = 0 THEN
            LET l_replace = ""
            LET l_lineStr = l_replace
         END IF

         IF l_lineStr.getIndexOf("<ScenarioNode version=",1)! = 0 THEN
            LET l_replace = ""
            LET l_lineStr = l_replace
         END IF

         IF l_lineStr.getIndexOf("<Scenario versionNo=",1)! = 0 THEN
            LET l_replace = "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n","  <ScenarioNode version=\"x.xx.xxxx\">\n  ",l_lineStr
            LET l_lineStr = l_replace
            LET l_flag = TRUE
         END IF
      END IF

      #每行後面加上換行符號
      LET l_lineStr = l_lineStr,ASCII 10
      CALL l_str_buf.append(l_lineStr)

      #此WHILE的結束條件
      IF l_lineStr.getIndexOf("</ScenarioNode>",1)!=0 THEN
         EXIT WHILE
      END IF
      
   END WHILE

   LET g_xml_str = l_str_buf.toString()

   CALL l_ch_in.close()

   RETURN TRUE,NULL #160506-00024
   
END FUNCTION

#+ 開啟client端的檔案選擇視窗
FUNCTION adzp165_client_browse_file()
   DEFINE ls_file   STRING
   DEFINE ps_prog            STRING
   DEFINE ls_4ad_file        STRING
   DEFINE lwin_curr          ui.Window
   DEFINE lfrm_curr          ui.Form


 #Begin: 160506-00024 modify
 ##load 4ad
 #LET ls_4ad_file = os.Path.join(os.Path.join(FGL_GETENV("ADZ"),"4ad"),g_lang CLIPPED)
 #LET ls_4ad_file = os.Path.join(ls_4ad_file, g_prog CLIPPED ||".4ad")
 #CALL ui.interface.loadactiondefaults(ls_4ad_file)
 #LET ls_file=NULL
 #
 #MENU
 #   ON ACTION choice_sco_file
 #       IF  mb_enable_softscore THEN
 #          CALL ui.Interface.frontCall("standard",
 #                                      "openfile",
 #                                      ["C:", "SCO File", "*.sco", "adzp165 - Choose A Sco File"],
 #                                      [ls_file])
 #        ELSE
 #          CALL cl_ask_pressanykey("adz-00624") #目前設計器不准許與分鏡系統串接!
 #        END IF
 #      EXIT MENU
 #
 #   ON ACTION CLOSE
 #      LET ls_file = ''
 #      EXIT MENU
 #
 #END MENU

  CALL ui.Interface.frontCall("standard",
                              "openfile",
                              ["C:", "SCO File", "*.sco", "adzp165 - Choose A Sco File"],
                              [ls_file])
 #End: 160506-00024 modify


  RETURN ls_file
END FUNCTION

      
#160506-00024 add
PRIVATE FUNCTION adzp165_ui_dialog()
DEFINE ls_msg           STRING
DEFINE l_chk            BOOLEAN                   #檢查是否存在
DEFINE l_index          INTEGER                   #index
DEFINE lb_result        BOOLEAN

    LET g_action_choice = NULL

    #顯示說明 NOTE: 因為訊息內容超出現行azzi920欄位限制長度，所以要拆成多項
    CALL cl_getmsg('adz-00854', g_lang) RETURNING ls_msg

    LET ls_msg = ls_msg,"\n", cl_getmsg('adz-00855', g_lang)
    LET ls_msg = ls_msg,"\n", cl_getmsg('adz-00866', g_lang)
    LET ls_msg = ls_msg,"\n", cl_getmsg('adz-00856', g_lang)
    LET ls_msg = ls_msg,"\n", cl_getmsg('adz-00857', g_lang)
    LET ls_msg = ls_msg,"\n", cl_getmsg('adz-00858', g_lang)

    WHILE TRUE
#       DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
            INPUT g_parameter,gb_sd,g_gzza001 FROM cbo_options,chk_sd,gzza_t.gzza001
            ATTRIBUTE(UNBUFFERED)

                BEFORE INPUT 
                   #訊息要重新顯示
                   DISPLAY ls_msg TO lbl_memo
                   
                   #init
                   LET g_parameter = "1" #預設
                   LET gb_sd = FALSE
                   LET g_gzza001 = NULL
                   LET g_gzzal003 = NULL
                   CALL cl_set_comp_visible("chk_sd",TRUE)
                   CALL cl_set_comp_visible("lbl_ID,gzza_t.gzza001,gzzal_t.gzzal003",FALSE)
                   CALL g_dzem_d.CLEAR()
                
                ON CHANGE cbo_options
                    DISPLAY "g_parameter=",g_parameter
                    CASE g_parameter
                        WHEN "1"
                            CALL cl_set_comp_visible("chk_sd",TRUE)
                            CALL cl_set_comp_visible("lbl_ID,gzza_t.gzza001,gzzal_t.gzzal003",FALSE)

                        WHEN "2"
                            CALL cl_set_comp_visible("lbl_ID,gzza_t.gzza001,gzzal_t.gzzal003",TRUE)
                            CALL cl_set_comp_visible("chk_sd",FALSE)
                    END CASE

                ON ACTION controlp
                    LET g_qryparam.state = "i"
                    LET g_qryparam.reqry = TRUE
                    CALL q_dzem001() 
                    LET g_gzza001 = g_qryparam.return1
                    LET g_gzzal003 = g_qryparam.return2
                    DISPLAY g_gzza001,g_gzzal003  TO  gzza_t.gzza001,gzzal_t.gzzal003

                ON ACTION exe 
                
                    IF NOT cl_null(g_parameter) THEN
                       CASE g_parameter
                         WHEN "1"
                            CALL adzp165_imp_sa_spec()
                
                         WHEN "2"
                            IF NOT cl_null(g_gzza001) THEN
                               IF cl_ask_type1("adz-00145","") THEN
                                  CALL adzp165_delete_data_from_dzem(g_gzza001)
                               END IF
                            ELSE
                               CONTINUE INPUT
                            END IF
                       END CASE
                    END IF
                    EXIT INPUT #重新run一次 INPUT
                        
                #離開程式
                ON ACTION CLOSE
                    LET g_action_choice="exit"
                    EXIT INPUT

            END INPUT

        IF g_action_choice = "exit" THEN
            EXIT WHILE
        END IF
    END WHILE

END FUNCTION


#160506-00024 add
#+匯入分鏡檔to dzem_t 
PRIVATE FUNCTION adzp165_imp_sa_spec()
   DEFINE l_client_file_path_str STRING
   DEFINE l_file_name      STRING
   DEFINE ls_err_msg       STRING
   DEFINE lb_result        BOOLEAN

   #開啟client端檔案選取視窗
   LET l_client_file_path_str = adzp165_client_browse_file()
   IF NOT cl_null(l_client_file_path_str) THEN
      DISPLAY "Info: The path of sco file for client = ",l_client_file_path_str
      
      #選擇的分鏡檔不符合預設的分鏡檔名稱,停止繼續執行下去
      #IF NOT l_client_file_path_str MATCHES "*"||g_sco_id||".sco" THEN
         #CALL cl_err_msg(l_client_file_path_str,"adz-00223",g_sco_id,1)
         #DISPLAY "Selected a wrong file !"
         #EXIT PROGRAM
      #END IF
      
      LET l_file_name = os.Path.basename(l_client_file_path_str)
      LET l_file_name = l_file_name.trim()
      LET l_file_name = l_file_name.subString(1,l_file_name.getLength()-4)
      LET g_sco_id = l_file_name
      
      IF cl_null(g_sco_id) THEN
         LET ls_err_msg =  "ERROR: g_sco_id is NULL"
         GOTO _RTN_ERR
      END IF
      
      LET g_sco_id = adzp165_token_str(g_sco_id,1,"(") #20150602
      DISPLAY "Info: g_sco_id = ",g_sco_id
  
      
      #若有打勾直接匯入SD,則要檢查權限
      IF gb_sd THEN
         CALL adzp165_chk_sd_permission() RETURNING lb_result,ls_err_msg
         IF NOT lb_result THEN
            GOTO _RTN_ERR
         END IF
      END IF
      
      #結合模組和檔名產生絕對檔案路徑
      LET g_file_path_str = os.path.join(FGL_GETENV("TEMPDIR"),g_sco_id||".sco")
      
      DISPLAY "Info: The path of sco file = ",g_file_path_str   
      
      #檢查分鏡檔是否存在,存在的話更名
      IF os.path.exists(g_file_path_str) THEN
         IF os.path.rename(g_file_path_str,g_file_path_str||".bak") THEN
            DISPLAY "Info: Rename existent sco file! -->",g_file_path_str||".bak"
         END IF
      END IF
      
      #從前端傳檔案到SERVER端
      CALL fgl_getfile(l_client_file_path_str, g_file_path_str)
      
      
      #檢查分鏡檔是否存在 - 防呆
      IF NOT os.path.exists(g_file_path_str) THEN
         LET ls_err_msg =  "ERROR:sco file not found,path=",g_file_path_str
         GOTO _RTN_ERR
      END IF
      
      #開始匯入
      DISPLAY "[Purpose]:Import SA specifications from sco file into dzem_t"
      
      ###### 1. 讀取分鏡檔並逐行處理分鏡檔內容、產生合法的XML格式的字串g_xml_str - 呼叫函式 ######
      CALL adzp165_read_sco_file(g_file_path_str) RETURNING lb_result,ls_err_msg 
      IF NOT lb_result THEN
         GOTO _RTN_ERR
      END IF
      DISPLAY "Info: Read sco file and generate xml format......OK"
      
      TRY
         #從分鏡的xml格式字串來建立Dom文件
         LET g_dom_doc = om.DomDocument.createFromString(g_xml_str)
         #由Dom文件取得根節點
         LET g_dom_root = g_dom_doc.getDocumentElement()
      CATCH
         IF STATUS THEN
            #解析XML格式發生錯誤
            LET ls_err_msg = "ERROR: Parse dom node of XML format fail"
            GOTO _RTN_ERR
         END IF
      END TRY
      
      #CALL g_dom_root.writeXml(g_file_path_str||"x") #測試用
      
      ###### 2. 擷取分鏡檔中的SA規格資訊並轉換RTF的格式為純文字
      CALL adzp165_parse_scene_nod_list(g_dom_root)
      DISPLAY "Info: Get SA specifications of sco file and convert RTF into text......OK"
      
  ####Begin: 160506-00024 modify 
      BEGIN WORK 
      ###### 3. 增加資料到SA分鏡規格匯入介面檔(dzem_t),並於其中調整要放入資料庫的資料
      #CALL adzp165_insert_data_to_dzem_t()
      CALL adzp165_insert_data_to_dzem_t() RETURNING lb_result,ls_err_msg
      IF NOT lb_result THEN
         ROLLBACK WORK
         GOTO _RTN_ERR
      END IF
      DISPLAY "Info: Insert data into dzem_t......OK"
      
      ###### 4. 從 分鏡規格匯入介面檔(dzem_t) 到 SD規格檔(dzab_t, dzac_t, dzad_t)
      IF gb_sd THEN
         CALL adzp165_insert_data_to_desgin_data() RETURNING lb_result,ls_err_msg
         IF NOT lb_result THEN
            ROLLBACK WORK
            GOTO _RTN_ERR
         END IF
      END IF
      DISPLAY "Info: Insert data into dzab_t,dzac_t,dzad_t......OK"
      COMMIT WORK 
  ####End: 160506-00024 modify 
      
      
      #提示：匯入完成，請重新下載此程式的規格
      CALL cl_ask_pressanykey("adz-00221")
  END IF
  RETURN


  LABEL _RTN_ERR:
     INITIALIZE g_errparam TO NULL
     LET g_errparam.extend = ""
     LET g_errparam.code   = "adz-00022"
     LET g_errparam.replace[1]= ls_err_msg
     LET g_errparam.popup  = TRUE
     CALL cl_err()
     RETURN

END FUNCTION


#160506-00024 add
#+將SA規格(dzem_t)刪除
FUNCTION adzp165_delete_data_from_dzem(l_prog_id)
   DEFINE l_prog_id           LIKE dzem_t.dzem001
   DEFINE ls_err_msg          STRING
   DEFINE ls_sql              STRING


   TRY

      BEGIN WORK

      LET ls_sql = "DELETE  FROM dzem_t", " WHERE dzem001='",l_prog_id,"'"
      PREPARE dzem_del_prep FROM ls_sql
      EXECUTE dzem_del_prep 
      COMMIT WORK

      FREE    dzem_del_prep 
      CALL cl_ask_pressanykey("adz-00217")

   CATCH 
      LET ls_err_msg = cl_getmsg(sqlca.sqlcode,g_lang),",sql=",ls_SQL
      DISPLAY ls_err_msg
      ROLLBACK WORK
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = "adz-00022"
      LET g_errparam.replace[1] = ls_err_msg
      LET g_errparam.popup = TRUE
      CALL cl_err()
   END TRY

END FUNCTION


#160506-00024 add
#+將SA規格insert到設計資料相關表格
FUNCTION adzp165_insert_data_to_desgin_data()
   DEFINE l_prog_id           LIKE dzem_t.dzem001
   DEFINE ls_type             STRING
   DEFINE ls_err_msg          STRING
   DEFINE lo_DZAF_T           T_DZAF_T
   DEFINE ls_trigger          STRING
   DEFINE ls_sql              STRING
   DEFINE ls_where            STRING
   DEFINE la_dzem             DYNAMIC ARRAY OF RECORD 
              dzem001         LIKE dzem_t.dzem001,
              dzem002         LIKE dzem_t.dzem002,
              dzem003         LIKE dzem_t.dzem003,
              dzem099         LIKE dzem_t.dzem099
          END RECORD
   DEFINE li_idx              SMALLINT
   
   DEFINE l_dzaa001           LIKE dzaa_t.dzaa001
   DEFINE l_dzaa002           LIKE dzaa_t.dzaa002
   DEFINE l_dzaa003           LIKE dzaa_t.dzaa003
   DEFINE l_dzaa004           LIKE dzaa_t.dzaa004
   DEFINE l_dzaa005           LIKE dzaa_t.dzaa005
   DEFINE l_dzaa006           LIKE dzaa_t.dzaa006
   DEFINE l_dzaa009           LIKE dzaa_t.dzaa009

   DEFINE l_dzac001           LIKE dzac_t.dzac001
   DEFINE l_dzac002           LIKE dzac_t.dzac002
   DEFINE l_dzac003           LIKE dzac_t.dzac003
   DEFINE l_dzac004           LIKE dzac_t.dzac004
   DEFINE l_dzac012           LIKE dzac_t.dzac012
   DEFINE l_dzac099           LIKE dzac_t.dzac099

   DEFINE l_dzad001           LIKE dzad_t.dzad001
   DEFINE l_dzad002           LIKE dzad_t.dzad002
   DEFINE l_dzad003           LIKE dzad_t.dzad003
   DEFINE l_dzad005           LIKE dzad_t.dzad005
   DEFINE l_dzad099           LIKE dzad_t.dzad099

   DEFINE l_dzab001           LIKE dzab_t.dzab001
   DEFINE l_dzab002           LIKE dzab_t.dzab002
   DEFINE l_dzab003           LIKE dzab_t.dzab003
   DEFINE l_dzab004           LIKE dzab_t.dzab004
   DEFINE l_dzab099           LIKE dzab_t.dzab099


   LET l_prog_id =  g_sco_id

   #取得type
   LET ls_type = sadzp060_2_chk_spec_type(l_prog_id)

   #取得版次資料 
   CALL sadzp060_2_get_curr_ver_info(l_prog_id, ls_type, NULL) RETURNING lo_DZAF_T.*,ls_err_msg

   
   TRY

      #dzem_t
      LET ls_sql = "SELECT dzem001,dzem002,dzem003,dzem099",
                    " FROM dzem_t",
                   " WHERE dzem001='",l_prog_id,"'",
                   "   AND TRIM(dzem099) IS NOT NULL",
                   " ORDER BY dzem003,dzem002"
      PREPARE dzem_prep FROM ls_sql
      DECLARE dzem_curs CURSOR FOR dzem_prep

      #dzaa_t
      LET ls_sql = "SELECT dzaa004,dzaa006 FROM dzaa_t"
      LET ls_where = " WHERE  dzaa001=? AND dzaa002=? AND dzaa003=? AND dzaa009=? AND dzaa005=?"
      LET ls_sql = ls_sql , ls_where
      PREPARE get_dzaa_pre1 FROM ls_sql
      DECLARE get_dzaa_curs1 CURSOR FOR get_dzaa_pre1

      LET ls_sql = "SELECT dzaa004,dzaa006 FROM dzaa_t"
      LET ls_where = " WHERE  dzaa001=? AND dzaa002=? AND dzaa009=? AND dzaa005=?"
      LET ls_sql = ls_sql , ls_where
      PREPARE get_dzaa_pre2 FROM ls_sql
      DECLARE get_dzaa_curs2 CURSOR FOR get_dzaa_pre2

      LET l_dzaa001 =  lo_DZAF_T.dzaf001
      LET l_dzaa002 =  lo_DZAF_T.dzaf003
      LET l_dzaa009 =  lo_DZAF_T.dzaf010

      #dzab_t
      LET ls_sql = "SELECT dzab001,dzab002,dzab003,dzab004,dzab099 FROM dzab_t",
                   " INNER JOIN dzaa_t ON dzaa001=dzab001 AND dzaa003=dzab004 AND dzaa004=dzab002 AND dzaa006=dzab003"
      LET ls_where = " WHERE  dzaa001=? AND dzaa002=? AND dzaa003=? AND dzaa005=? AND dzaa009=?"
      LET ls_sql = ls_sql,ls_where
      PREPARE get_dzab_pre1 FROM ls_sql
      DECLARE get_dzab_curs1 CURSOR FOR get_dzab_pre1

      #dzac_t
      #規格設計器mapping的是dzac002而不是dzac003
      LET ls_sql = "SELECT dzac001,dzac003,dzac004,dzac012,dzac099 FROM dzac_t",
                   " INNER JOIN dzaa_t ON dzaa001=dzac001 AND dzaa003=dzac003 AND dzaa004=dzac004 AND dzaa006=dzac012"
      LET ls_where = " WHERE  dzaa001=? AND dzaa002=? AND dzaa005=? AND dzaa009=? AND dzac002=?"
      LET ls_sql = ls_sql,ls_where
      PREPARE get_dzac_pre1 FROM ls_sql
      DECLARE get_dzac_curs1 CURSOR FOR get_dzac_pre1

      #dzad_t
      LET ls_sql = "SELECT dzad001,dzad002,dzad003,dzad005,dzad099 FROM dzad_t",
                   " INNER JOIN dzaa_t ON dzaa001=dzad001 AND dzaa003=dzad002 AND dzaa004=dzad003 AND dzaa006=dzad005"
      LET ls_where = " WHERE  dzaa001=? AND dzaa002=? AND dzaa003=? AND dzaa005=? AND dzaa009=?"
      LET ls_sql = ls_sql,ls_where
      PREPARE get_dzad_pre1 FROM ls_sql
      DECLARE get_dzad_curs1 CURSOR FOR get_dzad_pre1


      LET li_idx = 1
      LOCATE la_dzem[li_idx].dzem099 IN FILE #在真正取得資料前,先設定陣列第一筆clob資料的LOCATE.不然FOREACH時會crash
      FOREACH dzem_curs INTO la_dzem[li_idx].*
         CASE la_dzem[li_idx].dzem003 CLIPPED
            WHEN "1" #欄位規格

            WHEN "2" #Action規格

            WHEN "3" #整體規格:固定為"ALL"
         END CASE
         LET li_idx = li_idx + 1
         LOCATE la_dzem[li_idx].dzem099 IN FILE #設定陣列第二筆以後clob資料的LOCATE.
      END FOREACH
      CALL la_dzem.deleteElement(li_idx)
 

      FOR li_idx = 1 TO la_dzem.getLength()
         CASE la_dzem[li_idx].dzem003 CLIPPED
            WHEN "1" #欄位規格
               LET l_dzaa005 = "1"
               LET l_dzac002 = la_dzem[li_idx].dzem002
                     
               LOCATE l_dzac099 IN FILE 
               FOREACH get_dzac_curs1 USING l_dzaa001,l_dzaa002,l_dzaa005,l_dzaa009 ,l_dzac002
                                       INTO l_dzac001,l_dzac003,l_dzac004,l_dzac012,l_dzac099
                 IF cl_null(l_dzac099) THEN
                    LET ls_trigger="update dzac099 where dzac001=",l_dzac001,",dzac002=",l_dzac002,",dzac003=",l_dzac003,",dzac004=",l_dzac004,",dzac012=",l_dzac012
                    DISPLAY ls_trigger
                    UPDATE dzac_t SET dzac099 = la_dzem[li_idx].dzem099 
                     WHERE dzac001=l_dzac001 AND dzac003=l_dzac003 AND dzac004=l_dzac004 AND dzac012=l_dzac012
                 END IF 
                 FREE l_dzac099 
                 LOCATE l_dzac099 IN FILE 
               END FOREACH

            WHEN "2" #Action規格
               LET l_dzaa003 = la_dzem[li_idx].dzem002
               LET l_dzaa005 = "2"
 
               LOCATE l_dzad099 IN FILE 
               FOREACH get_dzad_curs1 USING l_dzaa001,l_dzaa002,l_dzaa003,l_dzaa005,l_dzaa009 
                                       INTO l_dzad001,l_dzad002,l_dzad003,l_dzad005,l_dzad099
                 IF cl_null(l_dzad099) THEN
                    LET ls_trigger="update dzad099, where dzad001=",l_dzad001,",dzad002=",l_dzad002,",dzad003=",l_dzad003,",dzad005=",l_dzad005
                    DISPLAY ls_trigger
                    UPDATE dzad_t SET dzad099 = la_dzem[li_idx].dzem099 
                     WHERE dzad001=l_dzad001 AND dzad002=l_dzad002 AND dzad003=l_dzad003 AND dzad005=l_dzad005
                 END IF 
                 FREE l_dzad099
                 LOCATE l_dzad099 IN FILE 
               END FOREACH

            WHEN "3" #整體規格:固定為"ALL"
               LET l_dzaa003 = la_dzem[li_idx].dzem002
               LET l_dzaa005 = "3"

               LOCATE l_dzab099 IN FILE 
               FOREACH get_dzab_curs1 USING l_dzaa001,l_dzaa002,l_dzaa003,l_dzaa005,l_dzaa009
                                       INTO l_dzab001,l_dzab002,l_dzab003,l_dzab004,l_dzab099
                 IF cl_null(l_dzab099) THEN
                    LET ls_trigger="update dzab099, where dzab001=",l_dzab001,",dzab002=",l_dzab002,",dzab003=",l_dzab003,",dzab004=",l_dzab004
                    DISPLAY ls_trigger
                    UPDATE dzab_t SET dzab099 = la_dzem[li_idx].dzem099 
                     WHERE dzab001=l_dzab001 AND dzab002=l_dzab002 AND dzab003=l_dzab003 AND dzab004=l_dzab004
                 END IF 
                 FREE l_dzab099
                 LOCATE l_dzab099 IN FILE 
               END FOREACH
         END CASE
      END FOR
     
      RETURN TRUE,NULL

   CATCH 
      LET ls_err_msg = "ERROR:",cl_getmsg(sqlca.sqlcode,g_lang),",",ls_trigger
     #INITIALIZE g_errparam TO NULL
     #LET g_errparam.code = "adz-00022"
     #LET g_errparam.replace[1] = ls_err_msg
     #LET g_errparam.popup = TRUE
     #CALL cl_err()
      RETURN FALSE,ls_err_msg
   END TRY
   
END FUNCTION


#160506-00024 add
#-確認是否取得SD權限
PRIVATE FUNCTION adzp165_chk_sd_permission()
   DEFINE l_prog_id           LIKE dzem_t.dzem001
   DEFINE ls_type             STRING
   DEFINE lo_DZAF_T           T_DZAF_T
   DEFINE ls_err_msg          STRING

   LET l_prog_id =  g_sco_id

   #檢查註冊資料
   LET ls_type = sadzp060_2_chk_spec_type(l_prog_id)
   IF ls_type = "N" THEN
      #todo: 沒有註冊資料，不可能匯的進去
      LET ls_err_msg = cl_replace_err_msg(cl_getmsg("adz-00378", g_lang),l_prog_id)
      RETURN FALSE,ls_err_msg
   END IF

   #檢查簽出權限
   CALL sadzp060_2_have_checked_out(l_prog_id, ls_type, "SD",0) RETURNING ls_err_msg
   IF NOT cl_null(ls_err_msg) THEN  
      #todo: 沒有簽出權限,不給匯
      RETURN FALSE,ls_err_msg
   END IF

   #檢查版次資料 
   CALL sadzp060_2_get_curr_ver_info(l_prog_id, ls_type, NULL) RETURNING lo_DZAF_T.*,ls_err_msg
   IF NOT cl_null(ls_err_msg) THEN
      #todo: 沒有版次資料,不給匯
      RETURN FALSE,ls_err_msg
   END IF
   IF lo_DZAF_T.dzaf002 = 1 AND lo_DZAF_T.dzaf003 = 1 THEN
   ELSE
      LET ls_err_msg = cl_getmsg("adz-00865",g_lang)
      RETURN FALSE,ls_err_msg
   END IF

 
   RETURN TRUE,NULL

END FUNCTION


#160506-00024 原function重寫，此處備份舊的為_old()
#+增加資料到SA分鏡規格匯入介面檔(dzem_t)
#PRIVATE FUNCTION adzp165_insert_data_to_dzem_t_old()
#   DEFINE  ln_cnt      LIKE type_t.num5,     #筆數
#           ln_cnt2      LIKE type_t.num5, 
#           l_user      LIKE dzem_t.dzemownid,
#           l_dept      LIKE dzem_t.dzemowndp,
#           l_date      LIKE dzem_t.dzemcrtdt,
#           ls_err      STRING,
#           ls_sql      STRING,
#           l_prog_id   LIKE dzem_t.dzem001,
#           lb_flag     BOOLEAN,
#           l_dzem099   TEXT,
#           l_dzem099_1 TEXT,
#           ls_text     STRING
#          
#   LET l_user = g_user
#   LET l_dept = g_dept
#   LET l_date = cl_get_current()
#
#   LET l_prog_id = g_sco_id
#
#   
#   LET ln_cnt = 0
#
#   #判斷dzem_t中是否已有相關資料
#   SELECT COUNT(*) INTO ln_cnt FROM dzem_t WHERE dzem001 LIKE l_prog_id||"%"
#
#   LET lb_flag = FALSE
#
#   BEGIN WORK
#
#   TRY
#   
#      IF ln_cnt > 0 THEN
#         #預先鎖住資料庫中要刪除的資料
#         IF adzp165_lock_dzem_t(l_prog_id) THEN
#            LET ls_err = "delete_data_from_dzem_t"
#            DELETE FROM dzem_t WHERE dzem001 LIKE l_prog_id||"%"
#            #表示可以新增資料到資料庫
#            LET lb_flag = TRUE
#         ELSE
#            #解析XML格式發生錯誤
#            DISPLAY "Info: Lock dzem_t......ERROR"
#            EXIT PROGRAM
#         END IF
#      ELSE
#         #表示可以新增資料到資料庫
#         LET lb_flag = TRUE
#      END IF
#      
#      IF lb_flag THEN
#      
#          
#         FOR ln_cnt = 1 TO g_dzem_d.getLength()
#
#            IF UPSHIFT(g_dzem_d[ln_cnt].dzem001) MATCHES "TOPMENU*" THEN
#               #去掉元件名稱有括弧的部分
#               LET g_dzem_d[ln_cnt].dzem002 = adzp165_token_str(g_dzem_d[ln_cnt].dzem002,1,"(")
#               #測試用
#               #DISPLAY "g_dzem_d[ln_cnt].dzem001 = ",g_dzem_d[ln_cnt].dzem001
#               #DISPLAY "g_dzem_d[ln_cnt].dzem002 = ",g_dzem_d[ln_cnt].dzem002
#            END IF
#
#            #設定識別碼類型
#            IF g_dzem_d[ln_cnt].dzem002 = G_MAIN_WIN_STR THEN
#               #整體規格的識別碼為ALL
#               LET  g_dzem_d[ln_cnt].dzem002 = "ALL"
#               #整體規格的識別碼類型為3
#               LET  g_dzem_d[ln_cnt].dzem003 = "3"
#            ELSE
#               IF UPSHIFT(g_dzem_d[ln_cnt].dzem001) MATCHES "TOPMENU*" THEN
#                  #ACTION規格的識別碼類型為2
#                  LET  g_dzem_d[ln_cnt].dzem003 = "2"
#               ELSE
#                  #除了整體規格和ACTION規格外,其他無論是否為欄位規格,識別碼類型皆為1
#                  LET  g_dzem_d[ln_cnt].dzem003 = "1"
#               END IF  
#            END IF
#            
#             
#            #組合分鏡中[主視窗]和[資料處理]項目的SA規格資料  
#            IF g_dzem_d[ln_cnt].dzem002 = "ALL" THEN
#               LOCATE l_dzem099 IN FILE
#               LOCATE l_dzem099_1 IN FILE
#               
#               
#               LET l_dzem099 = g_dzem_d[ln_cnt].dzem099
#               LET l_dzem099_1 = adzp165_get_the_spec_of_data_process(l_dzem099_1,g_dzem_d[ln_cnt].dzem001)
#
#               LET ls_text = l_dzem099,
#                             ASCII 10,"============================================================================================",ASCII 10,
#                             l_dzem099_1#得到資料處理項目的規格資料
#               
#               #將主視窗的規格資料和到資料處理項目的規格資料組合
#               LET g_dzem_d[ln_cnt].dzem099 = ls_text
#                                                   
#            END IF
#
#            #略過G_DATA_PROSESS_STR的資料不加入資料庫
#            IF g_dzem_d[ln_cnt].dzem002 = G_DATA_PROSESS_STR THEN
#               CONTINUE FOR
#            END IF
#
#            #去掉分鏡名稱有括弧的部分
#            IF g_dzem_d[ln_cnt].dzem001 MATCHES l_prog_id||"*" THEN
#               LET g_dzem001 = adzp165_token_str(g_dzem_d[ln_cnt].dzem001,1,"(")
#            END IF
#
#            LET g_dzem_d[ln_cnt].dzem001 = g_dzem001
#
#            #測試用
#            #DISPLAY g_dzem_d[ln_cnt].dzem001,"|",g_dzem_d[ln_cnt].dzem002,"|",g_dzem_d[ln_cnt].dzem003
#
#            LET ln_cnt2=0
#            #插入資料前先檢查key值有無重複
#            SELECT COUNT(*) INTO ln_cnt2 FROM dzem_t 
#               WHERE dzem001=g_dzem_d[ln_cnt].dzem001 AND dzem002=g_dzem_d[ln_cnt].dzem002
#
#            #key值沒有重複再進行插入資料到dzem_t
#            IF ln_cnt2=0 THEN
#            
#               LET ls_sql = 
#                  "INSERT INTO dzem_t(dzem001,dzem002,dzem003,dzem099,dzemownid,dzemowndp,dzemcrtid,dzemcrtdp,dzemcrtdt
#                  ) VALUES (?,?,?,?,?,?,?,?,?)"
#
#               LET ls_err = "insert_data_to_dzem_t(",g_dzem_d[ln_cnt].dzem001,"|",g_dzem_d[ln_cnt].dzem002,")"
#
#               PREPARE insert_data_to_dzem_t FROM ls_sql 
#                                                                                                    
#
#               EXECUTE insert_data_to_dzem_t USING g_dzem_d[ln_cnt].dzem001,g_dzem_d[ln_cnt].dzem002,
#                                                               g_dzem_d[ln_cnt].dzem003,g_dzem_d[ln_cnt].dzem099,
#                                                               l_user,l_dept,l_user,l_dept,l_date 
#
#            END IF
#            
#            FREE l_dzem099
#            FREE l_dzem099_1
#                        
#         END FOR
#
#      END IF
#
#   CATCH
#
#      IF SQLCA.sqlcode THEN
#
#         IF SQLCA.sqlcode = -268 THEN
#            #Key值重複出現的訊息
#            DISPLAY "Info: ",ls_err,"-->Key value is not unique......ERROR"
#         ELSE
#            #非Key值重複出現的訊息
#            DISPLAY "Info: SQL_err for ",ls_err,"......ERROR"
#         END IF
#         #DISPLAY SQLERRMESSAGE
#         ROLLBACK WORK
#         EXIT PROGRAM
#      END IF
#      
#   END TRY
#
#   COMMIT WORK
#
#END FUNCTION
