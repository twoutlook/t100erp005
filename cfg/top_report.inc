SCHEMA ds

GLOBALS
   
  #報表參數設定.
   DEFINE g_user_name     LIKE oofa_t.oofa011      #製表者(名稱)
   DEFINE g_rep_code      LIKE gzgf_t.gzgf001      #報表元件代號
   DEFINE g_rep_code_desc LIKE gzdel_t.gzdel003    #報表元件代號說明
   DEFINE g_date_fmt      LIKE type_t.chr10        #GR報表日期格式 workaround
   DEFINE g_doc_key       STRING                   #BPM簽核單據的key值
   DEFINE g_rep_docno     STRING                   #報表單據編號
   DEFINE g_rep_ISO       STRING                   #ISO文號  #150611-00032#2 表尾功能add
   DEFINE g_mail_subject  VARCHAR(300)             #信件主旨 #150709-00023#1 add
   DEFINE g_mail_context  STRING                   #郵件內文 #150709-00023#1 add
   DEFINE g_code_value    STRING                   #條碼內容 #161214-00061#1 add

  #報表列印次數
   DEFINE g_print_cnt_sql STRING                   #更新列印次數SQL

  #報表中斷flag
  DEFINE g_rep_flag       LIKE type_t.num5         #151201-00015#1 add
  
  #報表背景列印次數
  DEFINE g_bg_cnt         LIKE type_t.num5         #170104-00023#1 add

  #報表背景作業功能 
   DEFINE g_template      LIKE type_t.chr20        #報表背景執行需選擇樣板
   DEFINE g_rep_user      LIKE gzgd_t.gzgd005      #報表背景執行需選擇用戶
   DEFINE g_rep_clas      LIKE gzgd_t.gzgd004      #報表背景執行需選擇角色
   DEFINE g_bg4rp         STRING                   #背景作業產生的報表名稱
   DEFINE g_4rp_name      LIKE gzgd_t.gzgd007      #背景作業時選擇的樣板名稱

  #定義 XtraGrid 共用變數
   DEFINE g_rep_tmpname   DYNAMIC ARRAY OF STRING  #XtraGrid Temp Table Name
   DEFINE g_rep_ins_prep  DYNAMIC ARRAY OF STRING  #定義報表TEMP TABLE的INSERT SQL PREPARE句
   DEFINE g_rep_success   LIKE type_t.chr1         #判斷XtraGrid insert temptable成功否
   DEFINE g_rep_db        LIKE gzda_t.gzda001      #XtraGrid報表的資料庫
   DEFINE g_rep_print_cnt LIKE type_t.num5         #計算XG報表列印次數
   DEFINE g_xg_fieldname  DYNAMIC ARRAY OF STRING  #XtraGrid 動態欄位說明
   DEFINE g_xg_rep_title  STRING                   #XtraGrid 動態報表名稱   #160217-00006#1 add
   DEFINE g_xgrid RECORD
                  title1          LIKE gzgh_t.gzgh004,  #報表標題1
                  title2          LIKE gzgh_t.gzgh005,  #報表標題2
                  rep_code        LIKE gzgf_t.gzgf001,  #報表元件代號
                  condition       LIKE gzgh_t.gzgh008,  #報表尾資訊(列印條件)
                  headerinfo1     LIKE gzgh_t.gzgh017,  #報表首其它資訊(1)
                  headerinfo2     LIKE gzgh_t.gzgh018,  #報表首其它資訊(2)
                  headerinfo3     LIKE gzgh_t.gzgh019,  #報表首其它資訊(3)
                  headerinfo4     LIKE gzgh_t.gzgh020,  #報表首其它資訊(4)
                  headerinfo5     LIKE gzgh_t.gzgh021,  #報表首其它資訊(5)
                  footerinfo1     LIKE gzgh_t.gzgh022,  #報表尾其它資訊(1)
                  footerinfo2     LIKE gzgh_t.gzgh023,  #報表尾其它資訊(2)
                  footerinfo3     LIKE gzgh_t.gzgh024,  #報表尾其它資訊(3)
                  footerinfo4     LIKE gzgh_t.gzgh025,  #報表尾其它資訊(4)
                  footerinfo5     LIKE gzgh_t.gzgh026,  #報表尾其它資訊(5)
                  sql             LIKE gzgh_t.gzgh012,  #自訂義SQL
                  dynamic_title   LIKE gzgh_t.gzgh027,  #動態標題
                  visible_column  LIKE gzgh_t.gzgh016   #隱藏欄位
                  END RECORD

  #定義Genero Report頁首變數
   DEFINE g_grPageHeader RECORD
                  title0101       STRING,                #報表標題[01,01]
                  title0102       STRING,                #報表標題[01,02]
                  title0103       STRING,                #報表標題[01,03]
                  title0104       STRING,                #報表標題[01,04]
                  title0201       STRING,                #報表標題[02,01]
                  title0202       STRING,                #報表標題[02,02]
                  title0203       STRING,                #報表標題[02,03]
                  title0204       STRING,                #報表標題[02,04]
                  title0301       STRING,                #報表標題[03,01]
                  title0302       STRING,                #報表標題[03,02]
                  title0303       STRING,                #報表標題[03,03]
                  title0304       STRING,                #報表標題[03,04]
                  title0401       STRING,                #報表標題[04,01]
                  title0402       STRING,                #報表標題[04,02]
                  title0403       STRING,                #報表標題[04,03]
                  title0404       STRING,                #報表標題[04,04]
                  title0501       STRING,                #報表標題[05,01]
                  title0502       STRING,                #報表標題[05,02]
                  title0503       STRING,                #報表標題[05,03]
                  title0504       STRING,                #報表標題[05,04]

                  title0601       STRING,                #報表標題[06,01]
                  title0602       STRING,                #報表標題[06,02]
                  title0603       STRING,                #報表標題[06,03]
                  title0604       STRING,                #報表標題[06,04]
                  title0701       STRING,                #報表標題[07,01]
                  title0702       STRING,                #報表標題[07,02]
                  title0703       STRING,                #報表標題[07,03]
                  title0704       STRING,                #報表標題[07,04]
                  title0801       STRING,                #報表標題[08,01]
                  title0802       STRING,                #報表標題[08,02]
                  title0803       STRING,                #報表標題[08,03]
                  title0804       STRING,                #報表標題[08,04]
                  title0901       STRING,                #報表標題[09,01]
                  title0902       STRING,                #報表標題[09,02]
                  title0903       STRING,                #報表標題[09,03]
                  title0904       STRING,                #報表標題[09,04]
                  title1001       STRING,                #報表標題[10,01]
                  title1002       STRING,                #報表標題[10,02]
                  title1003       STRING,                #報表標題[10,03]
                  title1004       STRING,                #報表標題[10,04]
   
                  head_loc        STRING,                #列印表頭位置
                  pri_con         STRING,                #是否印出列印條件

                  logo            LIKE type_t.blob,      #公司logo圖檔,Location
                  logoPos         LIKE type_t.num5,      #logo圖檔位置(靠左,靠右,置中)
                  logoWid         LIKE type_t.num5,      #logo圖檔寬度

                  apr_loc         STRING,                #列印簽核位置
                  sign_show       LIKE type_t.chr1,      #簽核是否顯示   
                  sign_type       LIKE type_t.chr1       #簽核flag,t:TIPTOP簽核,b:BPM簽核
                  END RECORD

#150611-00032#2 表尾功能 add(s)
  #定義Genero Report頁尾變數
   DEFINE g_grPageFooter RECORD
                  title0101       STRING,                #報表標題[01,01]
                  title0102       STRING,                #報表標題[01,02]
                  title0103       STRING,                #報表標題[01,03]
                  title0104       STRING,                #報表標題[01,04]
                  title0201       STRING,                #報表標題[02,01]
                  title0202       STRING,                #報表標題[02,02]
                  title0203       STRING,                #報表標題[02,03]
                  title0204       STRING,                #報表標題[02,04]
                  title0301       STRING,                #報表標題[03,01]
                  title0302       STRING,                #報表標題[03,02]
                  title0303       STRING,                #報表標題[03,03]
                  title0304       STRING                 #報表標題[03,04]
                  END RECORD
#150611-00032#2 表尾功能 add(e)

  #定義Genero Report簽核變數
   DEFINE g_grSign RECORD
                  sign_img01      LIKE type_t.blob,      #簽核圖檔01
                  sign_img02      LIKE type_t.blob,      #簽核圖檔02
                  sign_img03      LIKE type_t.blob,      #簽核圖檔03
                  sign_img04      LIKE type_t.blob,      #簽核圖檔04
                  sign_img05      LIKE type_t.blob,      #簽核圖檔05
                  sign_img06      LIKE type_t.blob,      #簽核圖檔06
                  sign_img07      LIKE type_t.blob,      #簽核圖檔07
                  sign_img08      LIKE type_t.blob,      #簽核圖檔08
                  sign_img09      LIKE type_t.blob,      #簽核圖檔09
                  sign_img10      LIKE type_t.blob,      #簽核圖檔10
                  sign_img11      LIKE type_t.blob,      #簽核圖檔11
                  sign_img12      LIKE type_t.blob,      #簽核圖檔12
                  sign_width      LIKE type_t.num15_3,   #簽核欄位寬度
                  apr_str01       LIKE type_t.chr50,     #簽核字串1
                  apr_str02       LIKE type_t.chr50,     #簽核字串2
                  apr_str03       LIKE type_t.chr50,     #簽核字串3
                  apr_str04       LIKE type_t.chr50,     #簽核字串4
                  apr_str05       LIKE type_t.chr50,     #簽核字串5
                  apr_str06       LIKE type_t.chr50,     #簽核字串6
                  apr_str07       LIKE type_t.chr50,     #簽核字串7
                  apr_str08       LIKE type_t.chr50,     #簽核字串8
                  apr_str09       LIKE type_t.chr50,     #簽核字串9
                  apr_str10       LIKE type_t.chr50,     #簽核字串10
                  apr_str11       LIKE type_t.chr50,     #簽核字串11
                  apr_str12       LIKE type_t.chr50      #簽核字串12
                  END RECORD

  #定義Genero Report數值欄位格式
   DEFINE g_grNumFmt RECORD
                  default         STRING,                #預設格式(有小數)
                  seq             STRING,                #預設格式(整數)
                  N001            STRING,                #一般小整數
                  N003            STRING,                #一般數值
                  N004            STRING,                #項次
                  N101            STRING,                #數量
                  N102            STRING,                #重量
                  N103            STRING,                #單位用量/底數/單耗
                  N201            STRING,                #單價
                  N202            STRING,                #金額
                  N203            STRING,                #匯率
                  N204            STRING,                #成本
                  N205            STRING,                #成本金額
                  N301            STRING,                #轉換率/百分比/比率
                  N302            STRING,                #稅率
                  N303            STRING,                #因數
                  N304            STRING,                #允收水準
                  N305            STRING,                #利率
                  N401            STRING,                #年度
                  N402            STRING,                #期別
                  N403            STRING,                #時數/分數
                  N601            STRING                 #積分     
                  END RECORD
END GLOBALS

