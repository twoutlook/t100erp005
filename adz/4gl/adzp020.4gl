#+ 程式版本......: T6 Version 1.00.00 Build-0317 at 12/09/21
#
#+ 程式代碼......: adzp020
#+ 設計人員......: cch
#+ 功能描述......: 針對單一表格資料的分鏡檔進行解析,擷取其中的資料匯入資料庫 

IMPORT JAVA java.lang.Character
IMPORT JAVA java.lang.Integer
IMPORT JAVA java.lang.String

IMPORT os
IMPORT util
SCHEMA ds

GLOBALS "../../cfg/top_global.inc"

#分鏡匯入介面檔 type 宣告
PRIVATE TYPE type_g_dzeh_d        RECORD
   dzeh001 LIKE dzeh_t.dzeh001, 
   dzeh002 LIKE dzeh_t.dzeh002, 
   dzeh003 LIKE dzeh_t.dzeh003, 
   dzeh004 LIKE dzeh_t.dzeh004, 
   dzeh005 LIKE dzeh_t.dzeh005, 
   dzeh006 LIKE dzeh_t.dzeh006, 
   dzeh007 LIKE dzeh_t.dzeh007, 
   dzeh008 LIKE dzeh_t.dzeh008, 
   dzeh009 LIKE dzeh_t.dzeh009, 
   dzeh010 LIKE dzeh_t.dzeh010, 
   dzeh011 LIKE dzeh_t.dzeh011, 
   dzeh012 LIKE dzeh_t.dzeh012, 
   dzeh013 LIKE dzeh_t.dzeh013, 
   dzeh014 LIKE dzeh_t.dzeh014, 
   dzeh015 LIKE dzeh_t.dzeh015, 
   dzeh016 LIKE dzeh_t.dzeh016, 
   dzeh017 LIKE dzeh_t.dzeh017, 
   dzeh018 LIKE dzeh_t.dzeh018, 
   dzeh019 LIKE dzeh_t.dzeh019, 
   dzeh020 LIKE dzeh_t.dzeh020 
       END RECORD
       
DEFINE g_dzeh_d       DYNAMIC ARRAY OF type_g_dzeh_d   #存放表格資料的RECORD ARRAY
DEFINE g_sco_file     LIKE    type_t.chr100            #分鏡檔檔案路徑
DEFINE g_xmlContent   STRING                           #分鏡的xml格式字串
DEFINE g_dom_doc      om.DomDocument                   #Dom文件   
DEFINE g_dom_root     om.DomNode                       #Dom的根節點

DEFINE g_table_id     LIKE    dzeh_t.dzeh006           #表格代碼
DEFINE g_table_name   LIKE    dzeh_t.dzeh007           #表格名稱
DEFINE g_process_id   LIKE    dzeh_t.dzeh001           #PROCESS ID
DEFINE g_seqence_id   LIKE    dzeh_t.dzeh004           #處理序號

#定義分鏡檔中使用的tag名稱常數
CONSTANT g_table_tag  = "EntityRole"                   #表格node的tag  
CONSTANT g_column_tag = "Col"                          #欄位node的tag

MAIN
   #測試轉換中文之用
   #DEFINE l_ch_out base.Channel #Genero寫入的檔案物件變數

   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log

   LET g_bgjob = "Y"

   #依模組進行系統初始化設定(系統設定)
   CALL cl_ap_init("adz","")

   #切換至使用者所需要的資料庫 (營運中心)  #to do
   DISCONNECT CURRENT #todo
   CONNECT TO "ds" #todo
   DISPLAY 'connect:ds->',STATUS

   #如果外部參數為null,則出現使用此隻程式的說明
   IF ARG_VAL(2) IS NULL THEN
      DISPLAY "Execution example:\n",
              "ex： r.r    adzp020   ooaa_t\n",
              "     r.r    adzp020   [sco file name]\n",
              "The path of sco file must be located in $TEMPDIR."
      EXIT PROGRAM
   END IF
   
   #指定分鏡檔檔案路徑
   LET g_sco_file = os.path.join(FGL_GETENV("TEMPDIR"),ARG_VAL(2)||".sco")
   
   ##讀取分鏡檔並逐行處理分鏡檔內容,產生XML格式的字串g_xmlContent - 呼叫函式
   CALL adzp020_read_sco_file(g_sco_file)

   #從分鏡的xml格式字串來建立Dom文件
   LET g_dom_doc = om.DomDocument.createFromString(g_xmlContent)
   #由Dom文件取得根節點
   LET g_dom_root = g_dom_doc.getDocumentElement()

   #擷取表格欄位資料 - 呼叫函式
   CALL adzp020_get_table_colume_data(g_table_tag)

   #新增分鏡檔內的表格欄位資料到資料庫(dzeh_t)中 - 呼叫函式
   CALL adzp020_update_data_to_db()

   #測試轉換中文之用
   #DISPLAY adzp020_matches_str("2.\u27284 ?\u26696 ?\u39006 ?\u22411 ?\u65306 ?B\u39006 ?\par")
   #DISPLAY adzp020_convert_utf("u20013 ?")
   #DISPLAY adzp020_matches_str("2.\\u27284 ?\\u26696 ?\\u39006 ?\\u22411 ?\\u65306 ?B\\u39006 ?\par")
   #DISPLAY adzp020_matches_str("\\u21478 ?\\u22806 ?,[\\u30334 ?\\u20998 ?\\u27604 ?\\u27396 ?\\u20301 ?]\\u21482 ?\\u26377 ?\\u22312 ?[\\u27396 ?\\u20301 ?\\u22411 ?\\u24907 ?]\\u28858 ?\"Number\"\\u26178 ?\\u25165 ?\\u21487 ?\\u20197 ?\\u35519 ?\\u25972 ?.\\par")

   #測試轉換中文之用
   #LET l_ch_out = base.Channel.create()
   #CALL l_ch_out.setDelimiter("")
   #CALL l_ch_out.openFile(os.path.join(FGL_GETENV("TEMPDIR"),ARG_VAL(2)||".xml"),"w")
   #CALL l_ch_out.write(g_xmlContent)
   #CALL l_ch_out.close()
   EXIT PROGRAM
END MAIN

#+擷取表格欄位資料
FUNCTION adzp020_get_table_colume_data(p_tag)
   DEFINE l_cnt         LIKE type_t.num5
   DEFINE p_tag         LIKE type_t.chr30
   DEFINE l_node_set    om.NodeList
   DEFINE l_node        om.DomNode
   DEFINE l_yn          LIKE type_t.chr1

   LET l_node_set = g_dom_root.selectByTagName(p_tag)

   #針對table的節點,進行資料的抓取
   IF p_tag = g_table_tag THEN

      #確認表格資料唯一
      IF l_node_set.getLength() = 1 THEN
         LET l_node = l_node_set.item(1)

         #設定表格代碼
         LET g_table_id   = l_node.getAttribute("displayName")

         #設定表格名稱
         LET g_table_name = l_node.getAttribute("physicalName")

         #呼叫亂數產生器
         CALL util.Math.srand()
         #設定Process ID,對表格內每個欄位皆相同
         LET g_process_id = sadzi140_db_gen_random_name()

         #設定處理序號,對表格內每個欄位皆相同
         LET g_seqence_id = sadzi140_vcs_get_new_seqence("DZEH_SEQ",FALSE,FALSE,FALSE,TRUE,4)

         #擷取欄位資料
         CALL adzp020_get_table_colume_data(g_column_tag)
      ELSE
         #針對表格的資料不唯一要做防呆提醒
      END IF

   END IF

   #針對column的節點,進行資料的抓取
   IF p_tag = g_column_tag THEN

      #擷取每個欄位的屬性質
      FOR l_cnt = 1 TO l_node_set.getLength()
      
         LET l_node = l_node_set.item(l_cnt)

         #亂數id
         LET g_dzeh_d[l_cnt].dzeh001  = g_process_id

         #處理狀態
         LET g_dzeh_d[l_cnt].dzeh002  = NULL

         #處理結果說明
         LET g_dzeh_d[l_cnt].dzeh003  = NULL

         #處理序號
         LET g_dzeh_d[l_cnt].dzeh004  = g_seqence_id
         
         #欄位序號
         LET g_dzeh_d[l_cnt].dzeh005  = l_cnt
         
         #表格代碼
         LET g_dzeh_d[l_cnt].dzeh006  = g_table_id CLIPPED
         
         #表格名稱
         LET g_dzeh_d[l_cnt].dzeh007  = g_table_name CLIPPED
         
         #欄位代碼
         LET g_dzeh_d[l_cnt].dzeh008  = l_node.getAttribute("physicalName") CLIPPED
         
         #欄位名稱
         LET g_dzeh_d[l_cnt].dzeh009  = l_node.getAttribute("displayName") CLIPPED

         #轉換TRUE/FALSE為Y/N
         IF l_node.getAttribute("key") = "TRUE" THEN LET l_yn = "Y" ELSE LET l_yn = "N" END IF
         #KEY值
         LET g_dzeh_d[l_cnt].dzeh010  = l_yn

         #轉換TRUE/FALSE為Y/N
         IF l_node.getAttribute("index") = "TRUE" THEN LET l_yn = "Y" ELSE LET l_yn = "N" END IF
         #索引
         LET g_dzeh_d[l_cnt].dzeh011  = l_yn
         
         #資料型態
         LET g_dzeh_d[l_cnt].dzeh012  = adzp020_token_str(l_node.getAttribute("dataType"),1) CLIPPED
         
         #資料長度
         LET g_dzeh_d[l_cnt].dzeh013  = adzp020_token_str(l_node.getAttribute("dataType"),3) CLIPPED
         
         #欄位說明
         LET g_dzeh_d[l_cnt].dzeh014  = l_node.getAttribute("colComment") CLIPPED
         
         #以下為擴充欄位的資料
         LET g_dzeh_d[l_cnt].dzeh015 = NULL
         LET g_dzeh_d[l_cnt].dzeh016 = NULL
         LET g_dzeh_d[l_cnt].dzeh017 = NULL
         LET g_dzeh_d[l_cnt].dzeh018 = NULL
         LET g_dzeh_d[l_cnt].dzeh019 = NULL
         LET g_dzeh_d[l_cnt].dzeh020 = NULL

         #DISPLAY g_dzeh_d[l_cnt].dzeh001,"[",l_cnt,"]"
         #DISPLAY g_dzeh_d[l_cnt].dzeh002,"[",l_cnt,"]"
         #DISPLAY g_dzeh_d[l_cnt].dzeh003,"[",l_cnt,"]"
         #DISPLAY g_dzeh_d[l_cnt].dzeh004,"[",l_cnt,"]"
         #DISPLAY g_dzeh_d[l_cnt].dzeh005,"[",l_cnt,"]"
         #DISPLAY g_dzeh_d[l_cnt].dzeh006,"[",l_cnt,"]"
         #DISPLAY g_dzeh_d[l_cnt].dzeh007,"[",l_cnt,"]"
         #DISPLAY g_dzeh_d[l_cnt].dzeh008,"[",l_cnt,"]"
         #DISPLAY g_dzeh_d[l_cnt].dzeh009,"[",l_cnt,"]"
         #DISPLAY g_dzeh_d[l_cnt].dzeh010,"[",l_cnt,"]"
         #DISPLAY g_dzeh_d[l_cnt].dzeh011,"[",l_cnt,"]"
         #DISPLAY g_dzeh_d[l_cnt].dzeh012,"[",l_cnt,"]"
         #DISPLAY g_dzeh_d[l_cnt].dzeh013,"[",l_cnt,"]"
         #DISPLAY g_dzeh_d[l_cnt].dzeh014,"[",l_cnt,"]"
         #DISPLAY "#####################################"

      END FOR
      
   END IF
   
END FUNCTION

#+ 新增分鏡檔內的表格欄位資料到資料庫(dzeh_t)中
PRIVATE FUNCTION adzp020_update_data_to_db()
   DEFINE l_cnt    LIKE type_t.num5
   DEFINE l_sql    STRING
   #DISPLAY "WRITING DATA"

   LET l_sql = "INSERT INTO dzeh_t(
                dzeh001,dzeh002,dzeh003,dzeh004,dzeh005,
                dzeh006,dzeh007,dzeh008,dzeh009,dzeh010,
                dzeh011,dzeh012,dzeh013,dzeh014,dzeh015,
                dzeh016,dzeh017,dzeh018,dzeh019,dzeh020) 
         VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)"

   PREPARE insert_column_date FROM l_sql
   
   BEGIN WORK

   FOR l_cnt = 1 TO g_dzeh_d.getLength()
      TRY

         EXECUTE insert_column_date USING g_dzeh_d[l_cnt].dzeh001,g_dzeh_d[l_cnt].dzeh002,
                                          g_dzeh_d[l_cnt].dzeh003,g_dzeh_d[l_cnt].dzeh004,
                                          g_dzeh_d[l_cnt].dzeh005,g_dzeh_d[l_cnt].dzeh006,
                                          g_dzeh_d[l_cnt].dzeh007,g_dzeh_d[l_cnt].dzeh008,
                                          g_dzeh_d[l_cnt].dzeh009,g_dzeh_d[l_cnt].dzeh010,
                                          g_dzeh_d[l_cnt].dzeh011,g_dzeh_d[l_cnt].dzeh012,
                                          g_dzeh_d[l_cnt].dzeh013,g_dzeh_d[l_cnt].dzeh014,
                                          g_dzeh_d[l_cnt].dzeh015,g_dzeh_d[l_cnt].dzeh016,
                                          g_dzeh_d[l_cnt].dzeh017,g_dzeh_d[l_cnt].dzeh018,
                                          g_dzeh_d[l_cnt].dzeh019,g_dzeh_d[l_cnt].dzeh020
      
         #INSERT INTO dzeh_t(
                      #dzeh001,dzeh002,dzeh003,dzeh004,dzeh005,
                      #dzeh006,dzeh007,dzeh008,dzeh009,dzeh010,
                      #dzeh011,dzeh012,dzeh013,dzeh014,dzeh015,
                      #dzeh016,dzeh017,dzeh018,dzeh019,dzeh020) 
               #VALUES(
                     #g_dzeh_d[l_cnt].dzeh001,g_dzeh_d[l_cnt].dzeh002,
                     #g_dzeh_d[l_cnt].dzeh003,g_dzeh_d[l_cnt].dzeh004,
                     #g_dzeh_d[l_cnt].dzeh005,g_dzeh_d[l_cnt].dzeh006,
                     #g_dzeh_d[l_cnt].dzeh007,g_dzeh_d[l_cnt].dzeh008,
                     #g_dzeh_d[l_cnt].dzeh009,g_dzeh_d[l_cnt].dzeh010,
                     #g_dzeh_d[l_cnt].dzeh011,g_dzeh_d[l_cnt].dzeh012,
                     #g_dzeh_d[l_cnt].dzeh013,g_dzeh_d[l_cnt].dzeh014,
                     #g_dzeh_d[l_cnt].dzeh015,g_dzeh_d[l_cnt].dzeh016,
                     #g_dzeh_d[l_cnt].dzeh017,g_dzeh_d[l_cnt].dzeh018,
                     #g_dzeh_d[l_cnt].dzeh019,g_dzeh_d[l_cnt].dzeh020)
      CATCH             
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "dzeh_t"
            LET g_errparam.popup = FALSE
            CALL cl_err()
            ROLLBACK WORK
         END IF
      END TRY
   END FOR

   COMMIT WORK
   
END FUNCTION


#+ token需要回傳的的字串
PRIVATE FUNCTION adzp020_token_str(p_str,p_cnt)
   DEFINE p_str      LIKE type_t.chr200
   DEFINE p_cnt      LIKE type_t.num5
   DEFINE l_tok      base.StringTokenizer
   DEFINE ls_tmp     LIKE type_t.chr100
   DEFINE l_cnt      LIKE type_t.num5
   DEFINE l_return   LIKE type_t.chr100
   
   LET l_tok = base.StringTokenizer.create(p_str,".()")

   LET l_cnt = 1
   
   WHILE l_tok.hasMoreTokens()

      LET ls_tmp = l_tok.nextToken()

      #DISPLAY l_cnt,".",ls_tmp,":TOKEN"

      IF l_cnt = p_cnt THEN
         LET l_return = ls_tmp
         EXIT WHILE
      END IF
      
      LET l_cnt = l_cnt + 1

      

   END WHILE

   RETURN l_return

END FUNCTION


#+讀取分鏡檔並逐行處理分鏡檔內容
PRIVATE FUNCTION adzp020_read_sco_file(p_file)
   DEFINE p_file      STRING         #分鏡檔的檔案路徑
   DEFINE l_lineStr   STRING         #分鏡檔的每行字串
   DEFINE l_ch_in     base.Channel   #Genero讀取的檔案物件變數


   #DISPLAY "START PROCESSING"
   #建立Genero讀取的檔案物件
   LET l_ch_in = base.Channel.create()
   #指定來源的的檔案路徑
   CALL l_ch_in.openFile(p_file,"r")
   
   WHILE TRUE
      #分鏡檔每行讀出
      LET l_lineStr = l_ch_in.readLine()
   
      IF l_ch_in.isEof() THEN EXIT WHILE END IF

      #為轉成xml的標準格式需要做的處理
      IF l_lineStr.getIndexOf("SoftScore",1)! = 0 THEN
         LET l_lineStr = "<?xml version=\"1.0\" encoding=\"UTF-8\"?>"
      END IF

      #將字串內有Unicode 10進位內碼挑出,配合adzp020_convert_utf(p_utfstr)方法轉換成中文
      IF l_lineStr.getIndexOf("\\u",1)!=0 THEN
         LET l_lineStr = adzp020_matches_str(l_lineStr)
      END IF

      #每行後面加上換行符號
      LET g_xmlContent = g_xmlContent,l_lineStr,"\n"

      #此WHILE的結束條件
      IF l_lineStr.getIndexOf("</ScenarioNode>",1)!=0 THEN
         EXIT WHILE
      END IF
      
   END WHILE

   CALL l_ch_in.close()
   
END FUNCTION


#+將Unicode 10進位內碼挑出來處理
PRIVATE FUNCTION adzp020_matches_str(ps_line) 
   DEFINE ps_line      STRING              #傳入的每行字串
   DEFINE l_sub_str    LIKE type_t.chr10   #子字串
   DEFINE l_begin      LIKE type_t.num5    #開始偵測的位置索引
   DEFINE l_end        LIKE type_t.num5    #結束偵測的位置索引
   DEFINE ls_tmp       java.lang.String    #JAVA的String變數
   DEFINE l_buf_line   base.StringBuffer   #JAVA的StringBuffer變數

   LET l_buf_line = base.StringBuffer.create()

   #用來取代用的StringBuffer
   CALL l_buf_line.append(ps_line)

   #DISPLAY ps_line

   #使用迴圈,每次搜尋8個字元,有符合Unicode 10進位內碼就挑出
   FOR l_begin = 1 TO ps_line.getLength() - 7
   
      #結束偵測的位置索引 = 開始偵測的位置索引 + 7
      LET l_end = l_begin + 7

      #每取出8個字元來偵測
      LET l_sub_str = ps_line.subString(l_begin,l_end)

      #使用JAVA的String變數
      LET ls_tmp = String.create(l_sub_str)

      #使JAVA的正規表示法挑出Unicode 10進位內碼
      IF ls_tmp.matches("[u]{1}[0-9]{5}[ ]{1}[?]{1}") THEN

         #Unicode 10進位內碼轉中文並取代原來的字串
         CALL l_buf_line.replaceAt(l_begin,8,adzp020_convert_utf(l_sub_str))
      END IF
     
   END FOR

   #取代額外不需要的字串
   CALL l_buf_line.replace("@@@@@","",0)
   CALL l_buf_line.replace("\\","",0)
   CALL l_buf_line.replace("par","\n",0)
   
   RETURN l_buf_line.toString()
END FUNCTION


#+Unicode 10進位內碼轉中文
PRIVATE FUNCTION adzp020_convert_utf(p_utfstr) 
   DEFINE p_utfstr   STRING            #傳入的Unicode 10進位內碼 = [u]{1}[0-9]{5}[ ]{1}[?]{1}
   DEFINE utfstr     java.lang.String  #JAVA的String變數

   #使用JAVA的原生函式來轉換Unicode 10進位內碼為中文
   LET utfstr = String.create(p_utfstr)
   LET utfstr = utfstr.substring( 1, 6) #擷取數字部分
   LET utfstr = Integer.toHexString(Integer.parseInt(utfstr))
   LET utfstr = String.valueOf(Character.toChars(Integer.parseInt(utfstr,16)))

   #必須使輸入和轉出的的字串的長度相等,所以加入額外字串,之後取代字串才能正確取代
   LET p_utfstr = "@@@@@",utfstr.toString()
   RETURN p_utfstr
END FUNCTION
      




