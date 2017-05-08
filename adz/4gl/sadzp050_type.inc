
PRIVATE TYPE T_FRP_LIST_R RECORD
               fl_EXIST  VARCHAR(1), 
               fl_NAME   VARCHAR(60),
               fl_DESC   VARCHAR(1024)  
             END RECORD

PRIVATE TYPE T_TEMPLATE_LIST_R RECORD
               tl_COMPONENT VARCHAR(40),
               tl_NAME      VARCHAR(40),
               tl_DESC      VARCHAR(1024),
               tl_CUSTOMIZE VARCHAR(02),
               tl_ROLE      VARCHAR(20),
               tl_USER      VARCHAR(20),
               FRP_LIST     DYNAMIC ARRAY OF T_FRP_LIST_R
             END RECORD             

PRIVATE TYPE T_TEMPLATE_LIST_O RECORD
               tl_COMPONENT VARCHAR(40),
               tl_NAME      VARCHAR(40),
               tl_DESC      VARCHAR(1024),
               tl_CUSTOMIZE VARCHAR(02),
               tl_ROLE      VARCHAR(20),
               tl_USER      VARCHAR(20)
             END RECORD             

PRIVATE TYPE T_FRP_LIST_O RECORD
               fl_NAME   VARCHAR(60),
               fl_DESC   VARCHAR(1024)  
             END RECORD
