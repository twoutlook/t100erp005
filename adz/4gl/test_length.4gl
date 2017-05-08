

SCHEMA ds


DEFINE ga_itgg_d       DYNAMIC ARRAY OF RECORD
         oocm001  LIKE oocm_t.oocm001,  #varchar2(10)
         oocm002  LIKE oocm_t.oocm002,   #varchar2(10)

         oocmownid LIKE oocm_t.oocmownid,  #varchar2(10)
         oocmowndp LIKE oocm_t.oocmowndp  #varchar2(10)
                           END RECORD


MAIN 

   CLOSE WINDOW SCREEN
   OPEN WINDOW w_test_clob WITH FORM "test_length" 
   CURRENT WINDOW IS w_test_clob 

   CALL test_clob_init()
    #進入選單 Menu (='N')
   CALL test_clob_ui_dialog()

   #畫面關閉
   CLOSE WINDOW w_test_clob



END MAIN 


PRIVATE FUNCTION test_clob_init()
   DEFINE ls_sql  STRING 
   DEFINE li_cnt SMALLINT 
   CONNECT TO "ds"
   #LOCATE ga_itgg_d[1].itgg002 IN FILE #在真正取得資料前,先設定陣列第一筆clob資料的LOCATE.
   #LOCATE ga_itgg_d[2].itgg002 IN FILE 
   LET li_cnt = 1
   DECLARE itgg_cs CURSOR FOR
     #SELECT  oocm001,oocm002 FROM oocm_t
     SELECT  oocm001,oocm002,oocmownid,oocmowndp FROM oocm_t
     
     WHERE 1=1
   
   FOREACH itgg_cs INTO ga_itgg_d[li_cnt].*
      #LOCATE ga_itgg_d[li_cnt+1].itgg002 IN FILE
      LET li_cnt =  li_cnt+1   
   END FOREACH


   CALL ga_itgg_d.deleteElement(li_cnt)
   

END FUNCTION 

PRIVATE FUNCTION test_clob_ui_dialog()
    DEFINE l_ac SMALLINT 
    DEFINE l_n  SMALLINT 
    
     INPUT ARRAY ga_itgg_d FROM ds1.*
           ATTRIBUTE(COUNT = 10,MAXCOUNT = 100,WITHOUT DEFAULTS, 
                  INSERT ROW = TRUE ,
                  DELETE ROW = TRUE,
                  APPEND ROW = TRUE)

        BEFORE ROW
            #LET l_cmd = ''
            LET l_ac = ARR_CURR()
            #LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()

                  
        BEFORE INSERT
           DISPLAY "BEFORE INSERT"

        AFTER INSERT  
           DISPLAY "AFTER INSERT"

        BEFORE FIELD oocm001
           DISPLAY "BEFORE FIELD itgg001"
        AFTER FIELD oocm001
           DISPLAY "AFTER FIELD itgg001"
        BEFORE FIELD oocm002
           DISPLAY "BEFORE FIELD itgg002"
        AFTER FIELD oocm002
           DISPLAY "AFTER FIELD itgg002"
        BEFORE FIELD oocmownid
           DISPLAY "BEFORE FIELD oocmownid"
        AFTER FIELD oocmownid
           DISPLAY "AFTER FIELD oocmownid"
        BEFORE FIELD oocmowndp
           DISPLAY "BEFORE FIELD oocmowndp"
        AFTER FIELD oocmowndp
           DISPLAY "AFTER FIELD oocmowndp"   
        ON ROW CHANGE 

           DISPLAY "ON ROW CHANGE"
           
        END INPUT    

END FUNCTION 




