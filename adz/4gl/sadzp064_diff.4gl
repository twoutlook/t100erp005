#+ 程式代碼......: sadzp064_diff
#+ 設計人員......: Hiko
# Prog. Version..: 
#
# Program name   : sadzp064_diff.4gl
# Description    : 合併add-point來進行diff
# Modify         : 20161018 161017-00009 by Hiko : 新建程式:此程式主要是從adzq991抄寫過來.

IMPORT os
IMPORT util

GLOBALS "../../cfg/top_global.inc"

TYPE T_FILE DYNAMIC ARRAY OF RECORD #儲存diff的解析結果.
            line       STRING, #程式內容
            diff       CHAR(1),#差異標示:Y,+
            identifier STRING  #add-point/section
            END RECORD

TYPE T_DIFF_4gl DYNAMIC ARRAY OF RECORD
            no         STRING, #為了變顏色,所以改成字串型態.
            sel        LIKE type_t.chr1,
            left       STRING,
            l_diff     CHAR(1),#+:左邊多的;x:左右不同
            right      STRING,
            r_diff     CHAR(1),#+:右邊多的;x:左右不同
            identifier STRING, #add-point/section名稱
            fill_gap   CHAR(1),#補缺漏:Y
            orig_line  STRING  #單行複製:舊資料
            END RECORD

TYPE T_DIFF_NO DYNAMIC ARRAY OF RECORD
               diff_no    STRING, #差異行號
               left_no    INTEGER,#來源實際行號
               right_no   INTEGER,#目標實際行號
               identifier STRING
               END RECORD
#備註:從adzq991_diff_start2抄寫過來.
PUBLIC FUNCTION sadzp064_diff_4gl(p_left_file, p_right_file, p_diff_file)
   DEFINE p_left_file  STRING, #新版程式檔案路徑 #FILE
          p_right_file STRING, #舊版程式檔案路徑 #FILE
          p_diff_file  STRING  #diff檔路徑:$TEMPDIR底下 #FILE
   DEFINE la_left_file       T_FILE,
          la_right_file      T_FILE,
          la_diff            T_DIFF_4gl,
          la_diff_color      T_DIFF_4gl,
          la_diff_temp       T_DIFF_4gl,
          la_diff_temp_color T_DIFF_4gl,
          jobj_diff          util.JSONObject,
          li_i               INTEGER,
          lb_result          BOOLEAN,
          ls_err_msg         STRING,
          ls_cmd             STRING, #shell指令
          lch_diff           base.Channel,
          ls_line            STRING,            
          lc_char            CHAR(1),
          ls_diff_info       STRING, #為了取得比對資訊所保留的上一行字串
          lc_diff_flag       CHAR(1),#比對結果識別符號(a,c,d)
          li_flag_idx        INTEGER,
          #----------------------------------------
          ls_diff_left       STRING, #比對結果左邊數字字串
          li_left_from       INTEGER,#由數字字串拆解出來的左側差異起始行號
          li_left_to         INTEGER,#由數字字串拆解出來的左側差異截止行號
          li_left_cnt        INTEGER,#由數字字串拆解出來的左側差異行號數
          li_left_increment  INTEGER,#左邊遞增差異空白行的索引
          #----------------------------------------
          ls_diff_right      STRING, #比對結果右邊數字字串
          li_right_from      INTEGER,#由數字字串拆解出來的右側差異起始行號
          li_right_to        INTEGER,#由數字字串拆解出來的右側差異截止行號
          li_right_cnt       INTEGER,#由數字字串拆解出來的右側差異行號數
          li_right_increment INTEGER,#右邊遞增差異空白行的索引
          #----------------------------------------
          li_insert_idx      INTEGER,#插入索引值
          li_update_idx      INTEGER,#異動索引值
          li_n               INTEGER,
          li_diff_c_cnt      INTEGER,#diff標示為c時, 要計算哪幾筆資料是要變黃色
          lb_line_is_diff    BOOLEAN,#左右字串確實不相同
          ls_temp_identifier STRING,
          lc_diff            CHAR,
          la_diff_no         T_DIFF_NO,
          la_diff_no_temp    T_DIFF_NO,
          la_diff_no_temp2   T_DIFF_NO,#為了操作上可以正確判斷'導覽行數'所增加的變數.
          li_no_idx          INTEGER,
          lb_set_no          BOOLEAN,#在diff結果為'c'的情況下, 差異行數只需要設定一次即可.
          li_no_gap          INTEGER,#每個識別碼所對應的差異行數都要變成從第1行開始算起, 所以要計算出差量. 
          jobj_separate      util.JSONObject,#識別碼的分隔行數暫存紀錄
          jobj_unique_no     util.JSONObject,#行數唯一暫存紀錄
          li_left_add_cnt    INTEGER,#為了取得正確的識別碼,所以要記錄左側額外增加的空白行數.
          li_right_add_cnt   INTEGER,#為了取得正確的識別碼,所以要記錄右側額外增加的空白行數.
          li_new_no          INTEGER #為了避免最後一筆diff_no被重複記錄下來.

   LET jobj_diff = util.JSONObject.create()

   #先組合左右兩邊
   LET la_left_file = sadzp064_diff_get_file(p_left_file)
   LET la_right_file = sadzp064_diff_get_file(p_right_file)

   IF la_left_file.getLength()=0 OR la_right_file.getLength()=0 THEN
      DISPLAY "INFO : 程式內容是空的, 中斷比對."
      RETURN jobj_diff
   END IF

   CALL os.Path.exists(p_left_file) RETURNING lb_result
   IF lb_result THEN 
      DISPLAY "p_right_file=",p_right_file
      CALL os.Path.exists(p_right_file) RETURNING lb_result
      IF NOT lb_result THEN
         LET ls_err_msg = p_right_file
      END IF
   ELSE
      LET ls_err_msg = p_left_file
   END IF 

   IF NOT lb_result THEN
      DISPLAY "INFO : 找不到上述檔案, 中斷比對."
      DISPLAY cl_replace_err_msg(cl_getmsg("adz-00804", g_lang), ls_err_msg)
      RETURN jobj_diff
   END IF

   DISPLAY "p_diff_file=",p_diff_file
   CALL os.Path.delete(p_diff_file) RETURNING lb_result
   IF NOT lb_result THEN
      DISPLAY "INFO : 無法刪除 ",p_diff_file," !"
   ELSE
      DISPLAY "INFO : 刪除 ",p_diff_file," 成功!"
   END IF

   LET ls_cmd = "diff '",p_left_file,"' '",p_right_file,"' > '",p_diff_file,"'"
   DISPLAY ls_cmd
   RUN ls_cmd
   
   LET li_no_idx = 0 #為了簡化程式複雜度, 這個變數的設定和adzq991不同. 
   LET lch_diff = base.Channel.create()
   CALL lch_diff.openFile(p_diff_file, "r")
   
   WHILE TRUE
      CALL lch_diff.readLine() RETURNING ls_line
      IF lch_diff.isEof() THEN
         EXIT WHILE
      END IF
 
      LET lc_char = ls_line.getCharAt(1)
      IF lc_char MATCHES "[0-9]" THEN
         LET ls_diff_info = ls_line

         #a : 表示右邊多餘左邊
         #c : 表示同一行開始左右內容不同,右邊多於左邊.
         #d : 表示左邊多於右邊
         
         LET lc_diff_flag = 'a'
         LET li_flag_idx = ls_diff_info.getIndexOf(lc_diff_flag, 1)
         IF li_flag_idx=0 THEN
            LET lc_diff_flag = 'c'
            LET li_flag_idx = ls_diff_info.getIndexOf(lc_diff_flag, 1)
         END IF

         IF li_flag_idx=0 THEN
            LET lc_diff_flag = 'd'
            LET li_flag_idx = ls_diff_info.getIndexOf(lc_diff_flag, 1)
         END IF

         IF li_flag_idx>0 THEN #到了這邊其實應該就找到了, 這只是防呆.
            #1.先處理左邊的數字.
            LET ls_diff_left = ls_diff_info.subString(1, li_flag_idx-1)
            CALL sadzp064_diff_get_diff_no(ls_diff_left) RETURNING li_left_from,li_left_to
            #2.再處理右邊的數字.
            LET ls_diff_right = ls_diff_info.subString(li_flag_idx+1, ls_diff_info.getLength())
            CALL sadzp064_diff_get_diff_no(ls_diff_right) RETURNING li_right_from,li_right_to
            LET li_left_cnt = li_left_to-li_left_from+1
            LET li_right_cnt = li_right_to-li_right_from+1

            CASE lc_diff_flag
               WHEN 'a' #右邊多餘左邊
                  FOR li_n=1 TO li_right_cnt
                     LET li_insert_idx = li_left_from+li_left_increment+li_n
                     CALL la_left_file.insertElement(li_insert_idx) #左側檔案補上空白行
                     LET li_left_add_cnt = li_left_add_cnt + 1
                     LET la_left_file[li_insert_idx].identifier = la_right_file[li_insert_idx].identifier

                     #新的判斷:若右側去除前後空白的結果不是NULL才要變顏色.
                     IF NOT cl_null(la_right_file[li_insert_idx].line) THEN
                        LET la_left_file[li_insert_idx].diff = '+'
                        
                        LET li_no_idx = li_no_idx + 1
                        LET la_diff_no[li_no_idx].left_no = li_left_from 
                        LET la_diff_no[li_no_idx].right_no = li_right_from
                        LET la_diff_no[li_no_idx].diff_no = li_left_from+li_left_increment+1
                        LET la_diff_no[li_no_idx].identifier = la_right_file[li_right_from+li_right_add_cnt].identifier #要位移曾經補上的資料筆數.
                     END IF
                  END FOR      

                  LET li_left_increment = li_left_increment + li_right_cnt #左側遞增行數
               WHEN 'c' #兩邊有差異
                  #只要是'c',則兩邊(from+遞增行數)所在的行數都設定diff='x'.
                  #先判斷左右兩側有幾筆資料是不需要補空白.
                  CASE
                     WHEN li_left_cnt>li_right_cnt
                        LET li_diff_c_cnt = li_right_cnt
                     WHEN li_left_cnt=li_right_cnt
                        LET li_diff_c_cnt = li_left_cnt
                     WHEN li_left_cnt<li_right_cnt
                        LET li_diff_c_cnt = li_left_cnt
                  END CASE
 
                  LET lb_set_no = FALSE #此一種比較結果只需要設定一次快速導覽的行數即可.

                  LET li_n=0 #處理左右兩側不需要補空白的資料:第一筆是自己, 所以預設從0開始.
                  WHILE li_n<li_diff_c_cnt
                     LET li_update_idx = li_left_from+li_left_increment+li_n
                     #去除空白還有差異的, 才是真正有差異.
                     LET lb_line_is_diff = sadzp064_diff_line_is_diff(la_left_file[li_update_idx].line, la_right_file[li_update_idx].line)
                     IF lb_line_is_diff THEN
                        IF NOT lb_set_no THEN
                           LET li_no_idx = li_no_idx + 1
                           LET la_diff_no[li_no_idx].left_no = li_left_from 
                           LET la_diff_no[li_no_idx].right_no = li_right_from 
                           LET la_diff_no[li_no_idx].diff_no = li_update_idx
                           LET la_diff_no[li_no_idx].identifier = la_right_file[li_update_idx].identifier
                           LET lb_set_no = TRUE
                        END IF

                        LET la_left_file[li_update_idx].diff = 'x'
                        LET la_right_file[li_update_idx].diff = 'x'

                        #進階判斷:若右側是空白行,則當作補空白.
                        IF cl_null(la_right_file[li_update_idx].line) THEN
                           LET la_left_file[li_update_idx].diff = ''
                           LET la_right_file[li_update_idx].diff = '+'
                        END IF
                     END IF

                     LET li_n = li_n + 1
                  END WHILE
                  
                  #處理左側需要補空白的資料.
                  IF li_left_cnt<li_right_cnt THEN
                     FOR li_n=1 TO (li_right_cnt-li_left_cnt) #前面已經做完li_left_cnt的設定, 所以這裡要扣除.
                        LET li_insert_idx = li_left_to+li_left_increment+li_n
                        CALL la_left_file.insertElement(li_insert_idx) #左側檔案補上空白行
                        LET li_left_add_cnt = li_left_add_cnt + 1
                        LET la_left_file[li_insert_idx].identifier = la_right_file[li_insert_idx].identifier

                        #新的判斷:若右側去除前後空白的結果不是NULL才要變顏色.
                        IF NOT cl_null(la_right_file[li_insert_idx].line) THEN
                           LET la_left_file[li_insert_idx].diff = '+'

                           IF NOT lb_set_no THEN
                              LET li_no_idx = li_no_idx + 1
                              LET la_diff_no[li_no_idx].left_no = li_left_from 
                              LET la_diff_no[li_no_idx].right_no = li_right_from 
                              LET la_diff_no[li_no_idx].diff_no = li_insert_idx
                              LET la_diff_no[li_no_idx].identifier = la_right_file[li_insert_idx].identifier
                              LET lb_set_no = TRUE
                           END IF
                        END IF
                     END FOR

                     LET li_left_increment = li_left_increment + (li_right_cnt-li_left_cnt) #左側遞增行數
                  END IF

                  #處理右側需要補空白的資料.
                  IF li_left_cnt>li_right_cnt THEN
                     FOR li_n=1 TO (li_left_cnt-li_right_cnt) ##前面已經做完li_right_cnt的設定, 所以這裡要扣除.
                        LET li_insert_idx = li_right_to+li_right_increment+li_n
                        CALL la_right_file.insertElement(li_insert_idx) #右側檔案補上空白行
                        LET li_right_add_cnt = li_right_add_cnt + 1
                        LET la_right_file[li_insert_idx].identifier = la_left_file[li_insert_idx].identifier

                        #新的判斷:若左側去除前後空白的結果不是NULL才要變顏色.
                        IF NOT cl_null(la_left_file[li_insert_idx].line) THEN
                           LET la_right_file[li_insert_idx].diff = '+'

                           IF NOT lb_set_no THEN
                              LET li_no_idx = li_no_idx + 1
                              LET la_diff_no[li_no_idx].left_no = li_left_from 
                              LET la_diff_no[li_no_idx].right_no = li_right_from
                              LET la_diff_no[li_no_idx].diff_no = li_insert_idx
                              LET la_diff_no[li_no_idx].identifier = la_left_file[li_insert_idx].identifier
                              LET lb_set_no = TRUE
                           END IF
                        END IF
                     END FOR      
                     
                     LET li_right_increment = li_right_increment + (li_left_cnt-li_right_cnt) #右側遞增行數
                  END IF
               WHEN 'd' #左邊多餘右邊
                  FOR li_n=1 TO li_left_cnt
                     LET li_insert_idx = li_right_from+li_right_increment+li_n
                     CALL la_right_file.insertElement(li_insert_idx) #右側檔案補上空白行
                     LET li_right_add_cnt = li_right_add_cnt + 1
                     LET la_right_file[li_insert_idx].identifier = la_left_file[li_insert_idx].identifier

                     #新的判斷:若左側去除前後空白的結果不是NULL才要變顏色.
                     IF NOT cl_null(la_left_file[li_insert_idx].line) THEN
                        LET la_right_file[li_insert_idx].diff = '+'

                        LET li_no_idx = li_no_idx + 1
                        LET la_diff_no[li_no_idx].left_no = li_left_from 
                        LET la_diff_no[li_no_idx].right_no = li_right_from 
                        LET la_diff_no[li_no_idx].diff_no = li_right_from+li_right_increment+1 
                        LET la_diff_no[li_no_idx].identifier = la_left_file[li_left_from+li_left_add_cnt].identifier #要位移曾經補上的資料筆數.
                     END IF
                  END FOR      

                  LET li_right_increment = li_right_increment + li_left_cnt #右側遞增行數
            END CASE
         END IF #li_flag_idx>0
      END IF #lc_char MATCHES "[0-9]"
   END WHILE

   CALL lch_diff.close()

   #display "la_left_file.getLength()=",la_left_file.getLength()
   #display "la_right_file.getLength()=",la_right_file.getLength()
   #將處理後的兩個陣列寫入la_diff內.
   FOR li_n=1 TO la_right_file.getLength()
      LET la_diff[li_n].no = li_n
      LET la_diff[li_n].sel = 'N'
      LET la_diff[li_n].left = la_left_file[li_n].line
      LET la_diff[li_n].l_diff = la_left_file[li_n].diff
      LET la_diff[li_n].right = la_right_file[li_n].line
      LET la_diff[li_n].r_diff = la_right_file[li_n].diff
      LET la_diff[li_n].identifier = la_right_file[li_n].identifier

      #設定diff結果的背景顏色:x.淡黃色;+:淡綠色.
      IF la_diff[li_n].l_diff='x' THEN
         LET la_diff_color[li_n].left = "yellow reverse"
      ELSE
         IF la_diff[li_n].l_diff='+' THEN
            LET la_diff_color[li_n].left = "lightGreen reverse"
         END IF
      END IF
      
      IF la_diff[li_n].r_diff='x' THEN
         LET la_diff_color[li_n].right = "yellow reverse"
      ELSE
         IF la_diff[li_n].r_diff='+' THEN
            LET la_diff_color[li_n].right = "lightGreen reverse"
         END IF
      END IF
   END FOR   

   #依據識別碼拆解程式內容, 並逐一儲存於JSONObject內.
   LET jobj_separate = util.JSONObject.create()
   LET li_i = 1
   LET ls_temp_identifier = ""
   LET lc_diff = 'N'
   FOR li_n=1 TO la_diff.getLength()
      IF la_diff[li_n].identifier<>ls_temp_identifier THEN
         IF NOT cl_null(ls_temp_identifier) THEN
            #display "識別碼不同:la_diff[li_n].identifier=",la_diff[li_n].identifier
            #display "識別碼不同:ls_temp_identifier=",ls_temp_identifier
            CALL la_diff_temp.deleteElement(li_i) #最後一筆是識別碼, 所以要刪除最後一筆.
            CALL la_diff_temp_color.deleteElement(li_i)
            CALL jobj_diff.put(ls_temp_identifier, la_diff_temp)
            CALL jobj_diff.put(ls_temp_identifier||"_color", la_diff_temp_color)
            CALL jobj_diff.put(ls_temp_identifier||"_diff", lc_diff)
            #儲存每個識別碼的區隔行數.
            #範例:apt001(2~30),apt002(31~40)
            #此例即儲存:'apt002',31.
            #到了重新設定每個add-point快速導覽行號的時候, 就是將31變成1, 然後每個畫面上的差異行數都要扣除此差量.
            CALL jobj_separate.put(la_diff[li_n].identifier, la_diff[li_n].no)          

            LET li_i = 1
            LET ls_temp_identifier = ""
            LET lc_diff = 'N'
            CALL la_diff_temp.clear()
            CALL la_diff_temp_color.clear()
         END IF
      END IF

      LET la_diff_temp[li_i].* = la_diff[li_n].*
      LET la_diff_temp_color[li_i].* = la_diff_color[li_n].*
      #若沒有不同,則回到前端要建議還原成標準.
      IF lc_diff='N' THEN
         IF NOT cl_null(la_diff[li_n].l_diff) OR
            NOT cl_null(la_diff[li_n].r_diff) THEN
            LET lc_diff = 'Y'
         END IF
      END IF

      IF li_n=la_diff.getLength() THEN #到了這裡就直接寫入了..
         #最後一筆就不需要再紀錄分隔行數, 因為只有一個add-point也不需要重算行數.
         CALL jobj_diff.put(la_diff[li_n].identifier, la_diff_temp)
         CALL jobj_diff.put(la_diff[li_n].identifier||"_color", la_diff_temp_color)
         CALL jobj_diff.put(la_diff[li_n].identifier||"_diff", lc_diff)
      ELSE
         LET li_i = li_i + 1
      END IF

      LET ls_temp_identifier = la_diff[li_n].identifier
   END FOR   

   #拆解diff_no並重設差異行數.
   LET jobj_unique_no = util.JSONObject.create()
   LET li_i = 1
   LET li_no_gap = 0
   LET ls_temp_identifier = ""
   FOR li_n=1 TO la_diff_no.getLength()
      IF la_diff_no[li_n].identifier<>ls_temp_identifier THEN
         IF NOT cl_null(ls_temp_identifier) THEN
            CALL jobj_diff.put(ls_temp_identifier||"_diff_no", la_diff_no_temp)
            CALL util.JSON.parse(util.JSON.stringify(la_diff_no_temp), la_diff_no_temp2)
            CALL jobj_diff.put(ls_temp_identifier||"_temp_no", la_diff_no_temp2)

            IF jobj_separate.has(la_diff_no[li_n].identifier) THEN
               LET li_no_gap = jobj_separate.get(la_diff_no[li_n].identifier) - 1 #重新取得每個識別碼的初始差量.
            END IF

            LET jobj_unique_no = util.JSONObject.create()
            LET li_i = 1
            LET ls_temp_identifier = ""
            CALL la_diff_no_temp.clear()
            CALL la_diff_no_temp2.clear()
         END IF
      END IF
      
      LET li_new_no = la_diff_no[li_n].diff_no - li_no_gap #減去差量後重設差異行數.
      IF NOT jobj_unique_no.has(li_new_no) THEN #不存在才處理.
         CALL jobj_unique_no.put(li_new_no, li_i) #主要是key, value隨意給.
         LET la_diff_no_temp[li_i].* = la_diff_no[li_n].*
         LET la_diff_no_temp[li_i].diff_no = li_new_no
         LET li_i = li_i + 1 #給下一筆使用.
      END IF

      IF li_n=la_diff_no.getLength() THEN
         CALL jobj_diff.put(la_diff_no[li_n].identifier||"_diff_no", la_diff_no_temp)
         CALL util.JSON.parse(util.JSON.stringify(la_diff_no_temp), la_diff_no_temp2)
         CALL jobj_diff.put(ls_temp_identifier||"_temp_no", la_diff_no_temp2)
      END IF

      LET ls_temp_identifier = la_diff_no[li_n].identifier
   END FOR   

   #display "sadzp064_diff result : jobj_diff.getLength()=",jobj_diff.getLength()

   RETURN jobj_diff
END FUNCTION

#+ 取得比對雙方的程式內容陣列
#備註:從adzq991_get_file抄寫過來.
FUNCTION sadzp064_diff_get_file(p_file_path)
   DEFINE p_file_path STRING
   DEFINE lch_file      base.Channel,
          li_i          INTEGER,
          ls_line       STRING,
          li_idx        SMALLINT,
          ls_identifier STRING,
          la_file       T_FILE 

   display "sadzp064_diff_get_file:p_file_path=",p_file_path
   LET lch_file = base.Channel.create()
   CALL lch_file.openFile(p_file_path, "r")
   LET li_i = 1   
   WHILE TRUE
      LET ls_line = lch_file.readLine()
      IF lch_file.isEof() THEN
         EXIT WHILE
      END IF
      
      LET li_idx = ls_line.getIndexOf("#name_identifier:", 1) #識別字串長度為17.
      IF li_idx>0 THEN
         LET ls_identifier = ls_line.subString(li_idx+17, ls_line.getLength())
         LET ls_identifier = ls_identifier.trim() 
         #識別字串是額外做出來的, 所以呈現的時候就變成空白.
         LET ls_line = ""
      END IF

      LET la_file[li_i].identifier = ls_identifier
      LET la_file[li_i].line = ls_line
      LET li_i = li_i + 1 
   END WHILE
   CALL lch_file.close()

   RETURN la_file
END FUNCTION

#+ 逐行比較4gl程式, 判斷去除空白後是否不同.
#備註:從adzq991_line_is_diff抄寫過來.
PUBLIC FUNCTION sadzp064_diff_line_is_diff(p_left, p_right)
   DEFINE p_left  STRING,
          p_right STRING
   DEFINE lb_diff BOOLEAN

   LET lb_diff = TRUE
   LET p_left = p_left.trim()
   LET p_right = p_right.trim()
   IF p_left.getLength()=0 AND p_right.getLength()=0 THEN
      LET lb_diff = FALSE #若兩邊剛好都是空白, 就當作相同.
   ELSE
      IF p_left=p_right THEN
         LET lb_diff = FALSE #前後去除空白後,字串完全相同就是真的相同了
      ELSE #不同的話就繼續判斷是否是註解.
         IF p_left.getCharAt(1)='#' AND p_right.getCharAt(1)='#' THEN
            LET lb_diff = FALSE #若兩邊剛好都是註解, 就當作相同.
         END IF
      END IF 
   END IF 

   RETURN lb_diff
END FUNCTION

#+ 取得比對資訊的起迄差異行數
#備註:從adzq991_get_diff_no抄寫過來.
FUNCTION sadzp064_diff_get_diff_no(p_diff_info)
   DEFINE p_diff_info STRING
   DEFINE li_idx  INTEGER,
          li_from INTEGER,
          li_to   INTEGER

   #找看看有沒有逗號隔開的數字, 表示有多行差異.
   LET li_idx = p_diff_info.getIndexOf(',', 1)
   IF li_idx>0 THEN
      LET li_from = p_diff_info.subString(1, li_idx-1)
      LET li_to   = p_diff_info.subString(li_idx+1, p_diff_info.getLength())
   ELSE
      LET li_from = p_diff_info
      LET li_to   = p_diff_info
   END IF

   RETURN li_from,li_to
END FUNCTION
